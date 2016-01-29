{ kdeApp
, lib
, cmake
, extra-cmake-modules
, shared_mime_info
}:

kdeApp {
  name = "akonadi";
  nativeBuildInputs = [
    cmake
  ];
  buildInputs = [
    extra-cmake-modules
    shared_mime_info
  ];
  meta = {
    license = with lib.licenses; [ lgpl2Plus ];
    maintainers = [ lib.maintainers.page ];
  };
}
