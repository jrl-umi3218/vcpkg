vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/gergondet/libfranka/releases/download/0.8.0-vcpkg/libfranka-0.8.0.tar.gz"
    FILENAME "libfranka-0.8.0.tar.gz"
    SHA512 3baa8438ef4b59b5db84024a7d1701a47a70547735eb40be4620d4563dd2591240886d58f1a39dc49be8863bab677acc42b4bef9de41311545afa9628b2dbe0a
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 0.8.0
    PATCHES
      "macos-keepidle.patch"
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DBUILD_DOCUMENTATION:BOOL=OFF
      -DBUILD_EXAMPLES:BOOL=OFF
      -DBUILD_TESTS:BOOL=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/Franka TARGET_PATH share/Franka)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libfranka RENAME copyright)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
