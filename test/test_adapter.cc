#include "biodynamo.h"
#include "bdm_adapter.h"
#include <iostream>

using namespace bdm;

int main(int argc, const char** argv) {
  // Initialize BioDynaMo
  Simulation simulation(argc, argv);
  
  // Create some test cells
  auto* rm = simulation.GetResourceManager();
  for (int i = 0; i < 5; i++) {
    Cell* cell = new Cell({i*10.0, i*10.0, i*10.0});
    rm->AddAgent(cell);
  }
  
  // Initialize adapter
  precice_adapter::Adapter adapter(simulation, "config/precice-config.xml");
  
  try {
    // Initialize preCICE connection
    adapter.Initialize();
    std::cout << "Adapter initialized successfully!" << std::endl;
    
    // Make sure we can advance
    if (adapter.IsCouplingOngoing()) {
      std::cout << "Coupling is active" << std::endl;
      adapter.WriteData("CellForces"); 
      adapter.Advance(0.1);
      std::cout << "Data written and advanced successfully" << std::endl;
    }
    
    return 0;
  } catch (const std::exception& e) {
    std::cerr << "Error: " << e.what() << std::endl;
    return 1;
  }
}