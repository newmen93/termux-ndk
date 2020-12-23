#!/bin/bash

cmake -G 'Unix Makefiles' \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    .

make
