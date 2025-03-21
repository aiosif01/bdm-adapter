cmake_minimum_required(VERSION 3.15)
project(bdm-precice-adapter)

# Try finding BioDynaMo directly
find_package(BioDynaMo QUIET)

if(NOT BioDynaMo_FOUND)
  # Set BDM path from environment if not already set
  if(NOT DEFINED BDM_INSTALL_DIR)
    set(BDM_INSTALL_DIR $ENV{BDM_INSTALL_DIR})
  endif()

  # Add BioDynaMo's lib and include directories
  include_directories(${BDM_INSTALL_DIR}/include)
  link_directories(${BDM_INSTALL_DIR}/lib)
  
  # Define biodynamo library target manually
  if(NOT TARGET biodynamo)
    add_library(biodynamo SHARED IMPORTED)
    set_target_properties(biodynamo PROPERTIES
      IMPORTED_LOCATION "${BDM_INSTALL_DIR}/lib/libbiodynamo${CMAKE_SHARED_LIBRARY_SUFFIX}")
  endif()
else()
  # Use BDM_USE_FILE if BioDynaMo was found
  if(EXISTS "${BDM_USE_FILE}")
    include(${BDM_USE_FILE})
  endif()
endif()

# Find preCICE
find_package(precice REQUIRED CONFIG)

# Adapter library
add_library(bdm_adapter SHARED
  src/bdm_adapter.cpp
)

target_include_directories(bdm_adapter PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}/include
)

target_link_libraries(bdm_adapter PUBLIC
  biodynamo
  precice::precice
)

# Skip test executable for now
# add_executable(test_adapter
#  ${CMAKE_CURRENT_SOURCE_DIR}/test_adapter.cc)
# 
# target_link_libraries(test_adapter
#  bdm_adapter
# )

# Copy configuration files
file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/config/
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/config/)