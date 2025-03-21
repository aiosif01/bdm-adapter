#!/bin/bash
set -e

# Source BioDynaMo environment
[[ -z $BDM_INSTALL_DIR ]] && source "$(dirname $(which biodynamo))/env.sh"

# Check preCICE installation
if ! pkg-config --exists libprecice; then
  echo "preCICE not found, installing..."
  apt-get update && apt-get install -y libprecice-dev || {
    echo "Failed to install preCICE via apt. Try manual installation: https://precice.org/installation-source-installation.html"
    exit 1
  }
fi

# Create build directory
mkdir -p build
cd build

# Configure
cmake ..

# Build
make -j$(nproc)

# Run tests if requested
if [[ "$1" == "--test" ]]; then
  ./runUnitTests
fi

echo "Build complete. Run with: ./build/bdm_precice_sim"