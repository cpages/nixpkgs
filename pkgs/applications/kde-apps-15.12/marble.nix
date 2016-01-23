{ kdeApp
, lib
, cmake
, qtwebkit
, qtscript
}:

kdeApp {
  name = "marble";
  nativeBuildInputs = [
    cmake
  ];
  buildInputs = [
    qtwebkit
    qtscript
  ];
  meta = {
    license = with lib.licenses; [ lgpl2Plus ];
    maintainers = [ lib.maintainers.page ];
  };
}
