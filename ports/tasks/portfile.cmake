vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/Tasks/releases/download/v1.3.1/Tasks-v1.3.1.tar.gz"
    FILENAME "Tasks-v1.3.1.tar.gz"
    SHA512 0d886495e09a1fa7da99664ad938fd730ecd0066494c3c203bf41d372ddbc8b87a17d188cdc4fc7942c82203115bc4cdc9caa14b5140f2bf79a279c426739779
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.3.1
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DBUILD_TESTING=OFF
      -DPYTHON_BINDING=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/Tasks)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
