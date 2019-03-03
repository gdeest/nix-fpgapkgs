{ stdenv, fetchurl, patchelf, procps, makeWrapper,
  ncurses, zlib, libX11, libXrender, libxcb, libXext, libXtst,
  libXi, glib, freetype, gtk2, requireFile }:

stdenv.mkDerivation rec {
  name = "vivado-2018.3";

  buildInputs = [ patchelf procps ncurses makeWrapper zlib ];
  
  builder = ./builder.sh;
  inherit ncurses;
    
  src = requireFile {
    name = "Xilinx_Vivado_SDK_2018.3_1207_2324.tar.gz";
    message = "Cannot download Vivado SDK 2018.3 automatically.";
    sha256 = "ebe392b2e6777672e2c90cd022b8ee6744d69ece19fbe9c072d7d50f8f415a01";
  };

  # src = fetchurl {
  #   url = "http://localhost:9000/Xilinx_Vivado_SDK_2017.2_0616_1.tar.gz";
  #   sha256 = "32b98ffb8d0de79be4e053b0616639c76045a29f3bf9f921e4949bf32527eb1a";
  # };

  libPath = stdenv.lib.makeLibraryPath
    [ stdenv.cc.cc ncurses zlib libX11 libXrender libxcb libXext libXtst libXi glib
      freetype gtk2 ];
  
  meta = {
    description = "Xilinx Vivado";
    homepage = "https://www.xilinx.com/products/design-tools/vivado.html";
    license = stdenv.lib.licenses.unfree;
  };
}
