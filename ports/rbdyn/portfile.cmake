vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/RBDyn/releases/download/v1.3.0/RBDyn-v1.3.0.tar.gz"
    FILENAME "RBDyn-v1.3.0.tar.gz"
    SHA512 4cdf5df0216ed0315ed20bd9b54a2fcc0a91cce85c4bc7b7acfa41c25ac24233801dc0b4de872c8fbcd77ef507dd43ffd3d1e597a3d41edff7ddd36e1d71360e
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

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/RBDyn)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

make_directory(${CURRENT_PACKAGES_DIR}/tools/rbdyn)
file(
    RENAME
    ${CURRENT_PACKAGES_DIR}/bin/urdf_yaml_converter
    ${CURRENT_PACKAGES_DIR}/tools/rbdyn/urdf_yaml_converter)
vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/rbdyn)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
