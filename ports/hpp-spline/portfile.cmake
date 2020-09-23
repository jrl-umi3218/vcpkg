vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/gergondet/hpp-spline/releases/download/v4.8.2-debian.1/hpp-spline-v.4.8.2-debian.1.tar.gz"
    FILENAME "hpp-spline-v.4.8.2-debian.1.tar.gz"
    SHA512 f79d1713ef32244daac1f3529d4b52cbdf95babf7dd589cde3259060a4ec35f2df1ec80594bd9f1eb048c37a0f611fa984a96712c0f095755f40bc3132abf1ce
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 4.8.2
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DBUILD_TESTING:BOOL=OFF
      -DBUILD_PYTHON_INTERFACE:BOOL=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/hpp-spline)

file(WRITE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright "")
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
