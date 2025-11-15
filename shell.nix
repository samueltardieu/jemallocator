{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Rust toolchain
    rustc
    cargo
    rustfmt
    clippy

    # C compiler and build tools
    gcc
    gnumake
    autoconf
    automake
    libtool

    # Git for submodules
    git

    # Additional utilities
    pkg-config
    
    # For shellcheck (used in CI)
    shellcheck
  ];

  # Fix jemalloc configure compatibility with modern GCC
  # The -Wno-error flag prevents warnings from being treated as errors,
  # which allows jemalloc's configure tests to complete successfully
  CFLAGS = "-Wno-error";
  
  # Environment variables that might be needed
  shellHook = ''
    echo "jemallocator development environment"
    echo "Rust version: $(rustc --version)"
    echo "Cargo version: $(cargo --version)"
    echo "GCC version: $(gcc --version | head -1)"
    echo ""
    echo "To build the project:"
    echo "  1. Initialize submodules: git submodule update --init --recursive"
    echo "  2. Build: cargo build"
    echo "  3. Test: cargo test"
  '';
}
