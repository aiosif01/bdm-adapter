#include "bdm_adapter.h"

namespace bdm {

// Optional: Cell behavior that reacts to fluid forces
struct FluidForceResponse : public Behavior {
  BDM_BEHAVIOR_HEADER(FluidForceResponse, Behavior, 1);
  
  Double3 fluid_velocity_ = {0, 0, 0};
  
  void SetFluidVelocity(const Double3& vel) { fluid_velocity_ = vel; }
  
  void Run(Agent* agent) override {
    auto* cell = dynamic_cast<Cell*>(agent);
    if (cell) {
      // Apply fluid velocity influence to cell movement
      Double3 cell_velocity = cell->GetMovementDirection();
      Double3 combined_velocity = {
        cell_velocity[0] + fluid_velocity_[0] * 0.1,
        cell_velocity[1] + fluid_velocity_[1] * 0.1,
        cell_velocity[2] + fluid_velocity_[2] * 0.1
      };
      cell->SetMovementDirection(combined_velocity);
    }
  }
};

inline int Simulate(int argc, const char** argv) {
  Simulation simulation(argc, argv);
  
  // Create initial cells
  auto* rm = simulation.GetResourceManager();
  auto construct = [](const Double3& position) {
    Cell* cell = new Cell(position);
    cell->AddBehavior(new FluidForceResponse());
    return cell;
  };
  
  ModelInitializer::Grid3D(20, 20, 20, 10, construct);
  
  // Initialize preCICE adapter
  precice_adapter::Adapter adapter(simulation, "config/precice-config.xml");
  adapter.Initialize();
  
  // Time stepping
  double dt = 0.01;
  int steps = 0;
  
  // Run simulation with coupling
  while (adapter.IsCouplingOngoing() && steps < 1000) {
    // Get time step size from preCICE
    double precice_dt = std::min(dt, adapter.GetMaxTimeStepSize());
    
    // Advance BioDynaMo simulation
    simulation.GetScheduler()->Simulate(1);
    
    // Write cell forces to preCICE
    adapter.WriteData("CellForces");
    
    // Advance coupling
    adapter.Advance(precice_dt);
    
    // Read fluid velocities from preCICE
    adapter.ReadData("FluidVelocity");
    
    steps++;
  }
  
  std::cout << "Simulation completed after " << steps << " steps\n";
  return 0;
}

}  // namespace bdm

int main(int argc, const char** argv) {
  return bdm::Simulate(argc, argv);
}