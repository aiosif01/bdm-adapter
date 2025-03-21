#!/usr/bin/env python3
import os
import shutil
import subprocess
from pathlib import Path

def create_project_structure():
    """Create the project directory structure"""
    dirs = ['include', 'src', 'test', 'config', 'build']
    for d in dirs:
        Path(d).mkdir(exist_ok=True)

def copy_files():
    """Copy template files to project structure"""
    # Content is expected to be in the same directory as this script
    source_dir = Path(__file__).parent
    
    # Copy template files
    file_map = {
        'include/bdm_adapter.h': 'bdm-adapter-h',
        'src/bdm_adapter.cpp': 'bdm-adapter-cpp',
        'src/main.cc': 'example-usage',
        'test/adapter_test.cc': 'adapter-test',
        'config/precice-config.xml': 'precice-config',
        'CMakeLists.txt': 'cmake-file',
        'build.sh': 'build-script',
        'install.sh': 'install-script'
    }
    
    for dest, source in file_map.items():
        source_file = source_dir / source
        dest_file = Path(dest)
        
        if source_file.exists():
            dest_file.parent.mkdir(exist_ok=True)
            shutil.copy2(source_file, dest_file)
            print(f"Copied {source} to {dest}")
        else:
            print(f"Warning: {source} not found")
    
    # Make scripts executable
    os.chmod('build.sh', 0o755)
    os.chmod('install.sh', 0o755)

def check_dependencies():
    """Check for required dependencies"""
    try:
        # Check BioDynaMo
        bdm_check = subprocess.run(['which', 'biodynamo'], 
                                 stdout=subprocess.PIPE, 
                                 stderr=subprocess.PIPE)
        
        if bdm_check.returncode != 0:
            print("BioDynaMo not found. Please install BioDynaMo first.")
            print("Visit: https://biodynamo.org/docs/userguide/installation/")
            return False
        
        # Check preCICE
        precice_check = subprocess.run(['pkg-config', '--exists', 'libprecice'], 
                                     stdout=subprocess.PIPE, 
                                     stderr=subprocess.PIPE)
        
        if precice_check.returncode != 0:
            print("preCICE not found. Will be installed by install.sh")
            
        return True
        
    except Exception as e:
        print(f"Error checking dependencies: {e}")
        return False

if __name__ == "__main__":
    print("Setting up BioDynaMo-preCICE adapter project...")
    
    if check_dependencies():
        create_project_structure()
        copy_files()
        
        print("\nSetup complete!")
        print("To build the adapter, run:")
        print("  ./install.sh")
        print("To run the test simulation:")
        print("  ./build/bdm_precice_sim")
    else:
        print("\nSetup failed. Please install the required dependencies.")