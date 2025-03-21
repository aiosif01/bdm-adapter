# BioDynaMo-preCICE Adapter

Adapter for coupling BioDynaMo with fluid simulations via preCICE.

## Project Structure

```
.
├── CMakeLists.txt           # Build configuration
├── build.sh                 # Build script
├── config
│   └── precice-config.xml   # preCICE coupling configuration
├── include
│   └── bdm_adapter.h        # Adapter header
├── install.sh               # Installation script
├── setup.py                 # Setup script
├── src
│   ├── bdm_adapter.cpp      # Adapter implementation
│   └── main.cc              # Example usage
└── test
    └── adapter_test.cc      # Unit tests
```

## Quick Start

1. Install dependencies:
   - BioDynaMo (https://biodynamo.org)
   - preCICE (https://precice.org)

2. Build the adapter:
   ```bash
   ./install.sh
   ```

3. Run the example:
   ```bash
   ./build/bdm_precice_sim
   ```

## Usage

```cpp
#include "bdm_adapter.h"

// Initialize BioDynaMo simulation
Simulation simulation(argc, argv);

// Setup cells with your desired behaviors

// Create adapter
precice_adapter::Adapter adapter(simulation, "config/precice-config.xml");
adapter.Initialize();

// Run coupled simulation
while (adapter.IsCouplingOngoing()) {
  // Advance BioDynaMo simulation
  simulation.GetScheduler()->Simulate(1);
  
  // Exchange data with preCICE
  adapter.WriteData("CellForces");
  adapter.Advance(dt);
  adapter.ReadData("FluidVelocity");
}
```

## Configuration

The coupling is configured in `config/precice-config.xml`. Modify this file to
match your specific coupling needs.

## Testing

Run the tests with:
```bash
./install.sh --test
```
