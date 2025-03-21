#include "bdm_adapter.h"
#include <precice/Participant.hpp>
#include <array>

namespace bdm {
namespace precice_adapter {

Adapter::Adapter(Simulation* sim, const std::string& config_file, 
                 const std::string& participant_name)
    : simulation_(sim), 
      config_file_(config_file),
      participant_name_(participant_name),
      mesh_name_("BioDynamoMesh") {}

Adapter::~Adapter() {
  if (initialized_ && precice_) {
    precice_->finalize();
  }
}

void Adapter::Initialize() {
  if (initialized_) return;
  
  precice_ = std::make_unique<precice::Participant>(
      participant_name_, config_file_, 0, 1);
  
  SetupMesh();
  initialized_ = true;
}

void Adapter::SetupMesh() {
  positions_.clear();
  vertex_ids_.clear();
  
  auto* rm = simulation_->GetResourceManager();
  size_t num_agents = rm->GetNumAgents();
  
  positions_.reserve(num_agents * 3);
  vertex_ids_.reserve(num_agents);
  forces_.reserve(num_agents * 3);
  
  rm->ForEachAgent([this](Agent* agent) {
    auto* cell = dynamic_cast<Cell*>(agent);
    if (cell) {
      const auto& pos = cell->GetPosition();
      
      double position[3] = {pos[0], pos[1], pos[2]};
      int id = precice_->setMeshVertex(mesh_name_, position);
      vertex_ids_.push_back(id);
    }
    return false; // continue iteration
  });
}

void Adapter::UpdateVertexPositions() {
  positions_.clear();
  
  auto* rm = simulation_->GetResourceManager();
  size_t idx = 0;
  
  rm->ForEachAgent([this, &idx](Agent* agent) {
    auto* cell = dynamic_cast<Cell*>(agent);
    if (cell && idx < vertex_ids_.size()) {
      const auto& pos = cell->GetPosition();
      
      // We can't update positions in preCICE, need to create a new vertex each time
      double position[3] = {pos[0], pos[1], pos[2]};
      // Just set a new vertex - keep the old ID
      vertex_ids_[idx] = precice_->setMeshVertex(mesh_name_, position);
      idx++;
    }
    return false; // continue iteration
  });
}

bool Adapter::Advance(double dt) {
  if (!initialized_ || !precice_) return false;
  
  UpdateVertexPositions();
  
  precice_->advance(dt);
  
  return precice_->isCouplingOngoing();
}

void Adapter::ReadData(const std::string& data_name) {
  std::vector<double> data(vertex_ids_.size() * 3);
  
  double readTime = precice_->getMaxTimeStepSize();
  precice_->readData(data_name, mesh_name_, vertex_ids_.size(), vertex_ids_.data(), readTime, data.data());
  
  // Process read data for your specific coupling case
  // Example: map fluid velocities to cells
}

void Adapter::WriteData(const std::string& data_name) {
  forces_.clear();
  forces_.reserve(vertex_ids_.size() * 3);
  
  auto* rm = simulation_->GetResourceManager();
  size_t idx = 0;
  
  rm->ForEachAgent([this, &idx](Agent* agent) {
    auto* cell = dynamic_cast<Cell*>(agent);
    if (cell && idx < vertex_ids_.size()) {
      double mass = cell->GetMass();
      const auto& force = cell->GetTractorForce();
      
      forces_.push_back(force[0] * mass);
      forces_.push_back(force[1] * mass);
      forces_.push_back(force[2] * mass);
      
      idx++;
    }
    return false; // continue iteration
  });
  
  precice_->writeData(data_name, mesh_name_, vertex_ids_.size(), vertex_ids_.data(), forces_.data());
}

bool Adapter::IsCouplingOngoing() const {
  return initialized_ && precice_ && precice_->isCouplingOngoing();
}

double Adapter::GetMaxTimeStepSize() const {
  return initialized_ ? precice_->getMaxTimeStepSize() : 0.0;
}

}  // namespace precice_adapter
}  // namespace bdm