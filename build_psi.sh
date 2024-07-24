#!/bin/bash

set -e

build_volepsi() {
    if [ ! -d "volepsi" ]; then
        git clone https://github.com/Visa-Research/volepsi.git
    fi
    cd volepsi/thirdparty
    if [ ! -d "sparsehash-c11" ]; then
        git clone https://github.com/sparsehash/sparsehash-c11.git
    fi
    cd ..
    python3 build.py -DVOLE_PSI_ENABLE_BOOST=ON -DVOLE_PSI_ENABLE_CPSI=ON
    python3 build.py --install=$HOME/.local -DVOLE_PSI_ENABLE_BOOST=ON -DVOLE_PSI_ENABLE_CPSI=ON
    cd ..
}

build_psi_app() {
    mkdir -p build
    cd build

    # Check if config.h exists in the volePSI directory
    if [ ! -f "$HOME/.local/include/volePSI/config.h" ]; then
        echo "config.h not found. Creating one..."
        mkdir -p "$HOME/.local/include/volePSI"
        cat > "$HOME/.local/include/volePSI/config.h" << EOL
#pragma once
// compile the library with GMW
#define VOLE_PSI_ENABLE_GMW 1
// compile the library with circuit psi
#define VOLE_PSI_ENABLE_CPSI 1
// compile the library with OPPRF
#define VOLE_PSI_ENABLE_OPPRF 1
EOL
        echo "Created config.h in $HOME/.local/include/volePSI/"
    fi

    cmake -DCMAKE_PREFIX_PATH=$HOME/.local ..
    make
    cd ..
}

echo "Building VolePSI library..."
build_volepsi

echo "Building PSI setup..."
build_psi_app
