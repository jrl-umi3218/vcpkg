include(vcpkg_find_fortran)
vcpkg_find_fortran(FORTRAN_CMAKE)

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/eigen-qld/releases/download/v1.2.1/eigen-qld-v1.2.1.tar.gz"
    FILENAME "eigen-qld-v1.2.1.tar.gz"
    SHA512 bef56ae88a457d9bc602d50780dcf283f972cbcd13f409207e9be85354523f1d7dcc7bdc32893d21d5c7ede0d0c699a341c16d5e9ac789c0108cf00dfa3ab0fb
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.2.1
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DBUILD_TESTING=OFF
      -DPYTHON_BINDING=OFF
      ${FORTRAN_CMAKE}
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/${PORT})

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
