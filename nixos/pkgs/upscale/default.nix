{ pkgs ? import <nixpkgs> { } }:
pkgs.stdenv.mkDerivation rec {
  name = "upscaler";
  version = "0.0.1";

  sourceRoot = ".";

  # This is weird, for whatever reason fetchfromGithub seems to ignore the
  # submodules aspect.  
  srcs = [
    (pkgs.fetchFromGitHub {
      name = "upscayl-ncnn";
      owner = "upscayl";
      repo = "upscayl-ncnn";
      rev = "b2b8b9a5cbfbc3e783432e6ffb2fcc7a79a6c3f8";
      hash = "sha256-hfLBM/3trECu2tGiqa/KI0MFGupVmj6XczEvMb8K/Bs=";
      # deepClone = true;
      # fetchSubmodules = true;
    })
    (pkgs.fetchFromGitHub {
      name = "ncnn";
      owner = "tencent";
      repo = "ncnn";
      rev = "6125c9f47cd14b589de0521350668cf9d3d37e3c";
      hash = "sha256-98VGHnsVRgIGs3d8RqU4mtPIYJ4LCHNkVxjVdUthTbE=";
    })
    (pkgs.fetchFromGitHub {
      name = "libwebp";
      owner = "webmproject";
      repo = "libwebp";
      rev = "8ea81561d2fdd382da60f57958741a7c23a18eb6";
      hash = "sha256-cEImY0i2Y/P8f90Ju1pQJLN4d7upfXrkdk+vzyhI6Rk=";
    })
    (pkgs.fetchFromGitHub {
      name = "glslang";
      owner = "KhronosGroup";
      repo = "glslang";
      rev = "4afd69177258d0636f78d2c4efb823ab6382a187";
      hash = "sha256-TAu0CqyzDJSgWh/5i99lf6BDMoHFNtVy12NJdjYDrGw=";
    })
  ];

  models = pkgs.fetchzip {
    # Choose the newst release from https://github.com/xinntao/Real-ESRGAN/releases to update
    url = "https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.5.0/realesrgan-ncnn-vulkan-20220424-ubuntu.zip";
    stripRoot = false;
    sha256 = "sha256-1YiPzv1eGnHrazJFRvl37+C1F2xnoEbN0UQYkxLT+JQ=";
  };

  nativeBuildInputs = with pkgs;[
    cmake
    gcc9
    vulkan-headers
    vulkan-loader
    vulkan-validation-layers
    glslang
    openssh
  ];

  # This is just smashing all of the submodules back into their right place
  postUnpack = ''
    # chmod -R 777 upscayl-ncnn
    cp -R ncnn upscayl-ncnn/src/
    cp -R libwebp upscayl-ncnn/src/
    cp -R glslang upscayl-ncnn/src/ncnn/
    cd upscayl-ncnn
    mkdir build
    cd src
  '';

  # dontUseCmakeConfigure = true;

  # env = {
  #   CC = "gcc-9";
  #   CXX = "g++-9";
  #   VULKAN_SDK = "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";
  # };

  # buildPhase = ''
  #   mkdir build
  #   cd build
  #   cmake ../src
  #   make
  # '';

  installPhase = ''
    mkdir -p $out/bin $out/bin/models
    cp upscayl-bin $out/bin/
    cp  -r ${models}/models/* $out/bin/models
  '';
}



