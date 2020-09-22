vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/SpaceVecAlg/releases/download/v1.1.1/SpaceVecAlg-v1.1.1.tar.gz"
    FILENAME "SpaceVecAlg-v1.1.1.tar.gz"
    SHA512 7d8dcdfa4ec2706ca93eedf9d9af177dbc907bf3687607bde2409b73b3fadd5aa6056883ea00f43b8d4ca4c14fddb35687501edf4609299eb7d2ffad55617fe0
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.1.1
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DBUILD_TESTING=OFF
      -DPYTHON_BINDING=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/SpaceVecAlg)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/spacevecalg RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
