vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/sch-core/releases/download/v1.1.0/sch-core-v1.1.0.tar.gz"
    FILENAME "sch-core-v1.1.0.tar.gz"
    SHA512 18185d4cd97a71f16ba64f404ca0ea269587cc98d7c7e455530faeca87cae6640d76aab23e0dcf6ac434aae976df4e1d289372868ac54e68f755cde47a9db379
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.1.0
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DBUILD_TESTING=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/${PORT})

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
