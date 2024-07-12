#!/bin/bash

set -e

build_volepsi() {
    if [ ! -d "volepsi" ]; then
        git clone https://github.com/Visa-Research/volepsi.git
    fi
    cd volepsi
    python3 build.py -DVOLE_PSI_ENABLE_BOOST=ON
    python3 build.py --install=$HOME/.local
    cd ..
}


build_psi_app() {
    mkdir -p build
    cd build
    cmake -DCMAKE_PREFIX_PATH=$HOME/.local ..
    make
    cd ..
}

echo "Building Vole-PSI library..."
build_volepsi

echo "Building PSI setup..."
build_psi_app