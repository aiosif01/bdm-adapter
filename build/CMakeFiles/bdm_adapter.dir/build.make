# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.31

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ale/bdm-adapter

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ale/bdm-adapter/build

# Include any dependencies generated for this target.
include CMakeFiles/bdm_adapter.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/bdm_adapter.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/bdm_adapter.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/bdm_adapter.dir/flags.make

CMakeFiles/bdm_adapter.dir/codegen:
.PHONY : CMakeFiles/bdm_adapter.dir/codegen

CMakeFiles/bdm_adapter.dir/src/bdm_adapter.cpp.o: CMakeFiles/bdm_adapter.dir/flags.make
CMakeFiles/bdm_adapter.dir/src/bdm_adapter.cpp.o: /home/ale/bdm-adapter/src/bdm_adapter.cpp
CMakeFiles/bdm_adapter.dir/src/bdm_adapter.cpp.o: CMakeFiles/bdm_adapter.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/ale/bdm-adapter/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/bdm_adapter.dir/src/bdm_adapter.cpp.o"
	/usr/bin/mpicxx $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/bdm_adapter.dir/src/bdm_adapter.cpp.o -MF CMakeFiles/bdm_adapter.dir/src/bdm_adapter.cpp.o.d -o CMakeFiles/bdm_adapter.dir/src/bdm_adapter.cpp.o -c /home/ale/bdm-adapter/src/bdm_adapter.cpp

CMakeFiles/bdm_adapter.dir/src/bdm_adapter.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/bdm_adapter.dir/src/bdm_adapter.cpp.i"
	/usr/bin/mpicxx $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ale/bdm-adapter/src/bdm_adapter.cpp > CMakeFiles/bdm_adapter.dir/src/bdm_adapter.cpp.i

CMakeFiles/bdm_adapter.dir/src/bdm_adapter.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/bdm_adapter.dir/src/bdm_adapter.cpp.s"
	/usr/bin/mpicxx $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ale/bdm-adapter/src/bdm_adapter.cpp -o CMakeFiles/bdm_adapter.dir/src/bdm_adapter.cpp.s

# Object files for target bdm_adapter
bdm_adapter_OBJECTS = \
"CMakeFiles/bdm_adapter.dir/src/bdm_adapter.cpp.o"

# External object files for target bdm_adapter
bdm_adapter_EXTERNAL_OBJECTS =

libbdm_adapter.so: CMakeFiles/bdm_adapter.dir/src/bdm_adapter.cpp.o
libbdm_adapter.so: CMakeFiles/bdm_adapter.dir/build.make
libbdm_adapter.so: /usr/lib/x86_64-linux-gnu/libprecice.so.3.1.2
libbdm_adapter.so: CMakeFiles/bdm_adapter.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/ale/bdm-adapter/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared library libbdm_adapter.so"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/bdm_adapter.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/bdm_adapter.dir/build: libbdm_adapter.so
.PHONY : CMakeFiles/bdm_adapter.dir/build

CMakeFiles/bdm_adapter.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/bdm_adapter.dir/cmake_clean.cmake
.PHONY : CMakeFiles/bdm_adapter.dir/clean

CMakeFiles/bdm_adapter.dir/depend:
	cd /home/ale/bdm-adapter/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ale/bdm-adapter /home/ale/bdm-adapter /home/ale/bdm-adapter/build /home/ale/bdm-adapter/build /home/ale/bdm-adapter/build/CMakeFiles/bdm_adapter.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/bdm_adapter.dir/depend

