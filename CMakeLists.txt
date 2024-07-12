cmake_minimum_required(VERSION 3.22)
project(MyPSIProject)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


# Add executables
file(GLOB_RECURSE SRCS *.cpp)
add_executable(psi_app  ${SRCS})

# add_subdirectory(volepsi)

# Find volePSI package
find_package(volePSI REQUIRED)
# Include directories
target_include_directories(psi_app PRIVATE 
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${volePSI_INCLUDE_DIRS}
    $ENV{HOME}/.local/include
)

#include_directories(${volePSI_INCLUDE_DIRS})
#include_directories($HOME/.local/include)
# Link against volePSI
target_link_libraries(psi_app visa::volePSI)

# Include directories
#target_include_directories(psi_app PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)