#!/bin/bash
set -e

# Source BioDynaMo environment
export PATH=/home/ale/biodynamo-v1.05.124/bin:$PATH
source /home/ale/biodynamo-v1.05.124/bin/thisbdm.sh

# Print debug info
echo "BDM_INSTALL_DIR: $BDM_INSTALL_DIR"
echo "Looking for common BioDynamoUse.cmake locations..."
for path in "$BDM_INSTALL_DIR/lib/cmake/biodynamo/BioDynamoUse.cmake" \
            "$BDM_INSTALL_DIR/share/cmake/biodynamo/BioDynamoUse.cmake" \
            "$BDM_INSTALL_DIR/share/cmake/BioDynamoUse.cmake" \
            "$BDM_INSTALL_DIR/lib/cmake/BioDynamoUse.cmake" \
            "$BDM_INSTALL_DIR/cmake/BioDynamoUse.cmake"; do
  if [ -f "$path" ]; then
    echo "Found: $path"
    BDM_USE_FILE="$path"
  fi
done

# Clean build directory
rm -rf build
mkdir -p build
cd build

if [ -z "$BDM_USE_FILE" ]; then
  echo "Trying alternative approach - direct cmake includes"
  # Try direct include paths instead of BioDynamoUse.cmake
  cmake -DCMAKE_PREFIX_PATH="$BDM_INSTALL_DIR" ..
else
  cmake -DBDM_USE_FILE="$BDM_USE_FILE" ..
fi

# Build
make -j$(nproc)