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

# Utility rule file for tidy-all.

# Include any custom commands dependencies for this target.
include CMakeFiles/tidy-all.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/tidy-all.dir/progress.make

CMakeFiles/tidy-all:
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/home/ale/bdm-adapter/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Run clang-tidy on selected files and attempt to fix any warning automatically"
	cd /home/ale/bdm-adapter && /home/ale/biodynamo-v1.05.124/share/util/run-clang-tidy.sh /usr/bin/clang-tidy /home/ale/bdm-adapter/build/clang_tidy_header_helper.cc /home/ale/bdm-adapter/build/compile_commands.json 1 `/home/ale/biodynamo-v1.05.124/share/util/get-all-src-files.sh /home/ale/bdm-adapter | grep -v -F -f /home/ale/bdm-adapter/.clang-tidy-ignore`

CMakeFiles/tidy-all.dir/codegen:
.PHONY : CMakeFiles/tidy-all.dir/codegen

tidy-all: CMakeFiles/tidy-all
tidy-all: CMakeFiles/tidy-all.dir/build.make
.PHONY : tidy-all

# Rule to build all files generated by this target.
CMakeFiles/tidy-all.dir/build: tidy-all
.PHONY : CMakeFiles/tidy-all.dir/build

CMakeFiles/tidy-all.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/tidy-all.dir/cmake_clean.cmake
.PHONY : CMakeFiles/tidy-all.dir/clean

CMakeFiles/tidy-all.dir/depend:
	cd /home/ale/bdm-adapter/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ale/bdm-adapter /home/ale/bdm-adapter /home/ale/bdm-adapter/build /home/ale/bdm-adapter/build /home/ale/bdm-adapter/build/CMakeFiles/tidy-all.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/tidy-all.dir/depend

