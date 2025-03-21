#ifndef BDM_ADAPTER_H
#define BDM_ADAPTER_H

#include "biodynamo.h"
#include <precice/precice.hpp>
#include <memory>
#include <string>
#include <vector>
#include <array>

namespace bdm {
namespace precice_adapter {

class Adapter {
 private:
  Simulation* simulation_;
  std::string config_file_;
  std::string participant_name_;
  std::unique_ptr<precice::Participant> precice_;
  
  std::string mesh_name_;
  std::vector<int> vertex_ids_;
  std::vector<double> positions_;
  std::vector<double> forces_;
  
  bool initialized_ = false;
  
  void SetupMesh();
  void UpdateVertexPositions();

 public:
  Adapter(Simulation* sim, const std::string& config_file, 
          const std::string& participant_name = "BioDynaMo");
  ~Adapter();

  void Initialize();
  bool Advance(double dt);
  
  void ReadData(const std::string& data_name);
  void WriteData(const std::string& data_name);
  
  bool IsCouplingOngoing() const;
  double GetMaxTimeStepSize() const;
};

}  // namespace precice_adapter
}  // namespace bdm

#endif  // BDM_ADAPTER_H