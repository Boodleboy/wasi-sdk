#!/bin/sh

# Build compiler
cmake \
  -G Ninja \
  -B build/toolchain \
  -S . \
  -DWASI_SDK_BUILD_TOOLCHAIN=ON \
  -DCMAKE_INSTALL_PREFIX=build/install

cmake \
  --build build/toolchain \
  --target install

# Build sysroot
cmake \
  -G Ninja \
  -B build/sysroot \
  -S . \
  -DCMAKE_INSTALL_PREFIX=build/install \
  -DCMAKE_TOOLCHAIN_FILE=build/install/share/cmake/wasi-sdk.cmake \
  -DCMAKE_C_COMPILER_WORKS=ON \
  -DCMAKE_CXX_COMPILER_WORKS=ON

cmake \
  --build build/sysroot \
  --target install

# Link separate resource-dirs together
ln -rs build/install/clang-resource-dir/lib build/install/lib/clang/21/lib
