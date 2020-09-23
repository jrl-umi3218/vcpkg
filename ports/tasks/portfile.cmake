vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/Tasks/releases/download/v1.3.0/Tasks-v1.3.0.tar.gz"
    FILENAME "Tasks-v1.3.0.tar.gz"
    SHA512 138e97b2b89cd6554b304066d9bb209fe8d7e1f7c3a72f01e35750985dca562bc3c3f5e84a57f4e284439bd9957af75893ec41c9166d25036b1846de473fb3b8
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.3.0
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
