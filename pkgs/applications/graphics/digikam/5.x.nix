{ stdenv, fetchurl, automoc4, boost, shared_desktop_ontologies, cmake
, eigen, lcms, gettext, jasper, kdelibs, lensfun
, libgphoto2, libjpeg, libkdcraw, libkexiv2, libkipi, libpgf, libtiff
, libusb1, liblqr1, marble, mysql, opencv, perl, phonon, pkgconfig
, qca2, qimageblitz, qjson, qt5, soprano, extra-cmake-modules
, qtxmlpatterns, qtsvg, qtwebkit, kconfig, kwindowsystem, kxmlgui
, ki18n, kio, kservice, kiconthemes, knotifyconfig, knotifications
, kitemmodels, akonadi, lcms2, exiv2, kdoctools
}:

stdenv.mkDerivation rec {
  name = "digikam-5.0.0";

  src = fetchurl {
    url = "http://download.kde.org/unstable/digikam/${name}-beta2.tar.bz2";
    sha256 = "0gpml7f714p56gz5is6amnmqlhw9ipicl812vp812gbf7j4c9xhl";
  };

  nativeBuildInputs = [ automoc4 cmake gettext perl pkgconfig ];

  buildInputs = [
    boost eigen jasper kdelibs lcms lensfun libgphoto2
    libjpeg libkdcraw libkexiv2 libkipi liblqr1 libpgf libtiff marble
    mysql.lib opencv phonon qca2 qimageblitz qjson qt5.qtbase
    shared_desktop_ontologies soprano extra-cmake-modules
    qtxmlpatterns qtsvg qtwebkit kconfig kwindowsystem kxmlgui
    ki18n kio kservice kiconthemes knotifyconfig knotifications
    kitemmodels akonadi lcms2 exiv2 kdoctools
  ];

  # Make digikam find some FindXXXX.cmake
  KDEDIRS="${marble}:${qjson}";

  # Help digiKam find libusb, otherwise gphoto2 support is disabled
  cmakeFlags = [
    "-DLIBUSB_LIBRARIES=${libusb1}/lib"
    "-DLIBUSB_INCLUDE_DIR=${libusb1}/include/libusb-1.0"
    "-DDIGIKAMSC_COMPILE_LIBKFACE=ON"
  ];

  enableParallelBuilding = true;

  meta = {
    description = "Photo Management Program";
    license = stdenv.lib.licenses.gpl2;
    homepage = http://www.digikam.org;
    maintainers = with stdenv.lib.maintainers; [ goibhniu viric urkud ];
    inherit (kdelibs.meta) platforms;
  };
}
