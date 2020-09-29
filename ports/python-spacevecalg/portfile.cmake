include(vcpkg_amend_python_path)
vcpkg_amend_python_path()

include(vcpkg_pip_install_requirements)
vcpkg_pip_install_requirements()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/SpaceVecAlg/releases/download/v1.1.1/SpaceVecAlg-v1.1.1.tar.gz"
    FILENAME "SpaceVecAlg-v1.1.1.tar.gz"
    SHA512 7d8dcdfa4ec2706ca93eedf9d9af177dbc907bf3687607bde2409b73b3fadd5aa6056883ea00f43b8d4ca4c14fddb35687501edf4609299eb7d2ffad55617fe0
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.1.1
    PATCHES
      python-standalone.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DBUILD_TESTING:BOOL=OFF
      -DPYTHON_BINDING_FORCE_PYTHON3:BOOL=ON
      -DPIP_INSTALL_PREFIX=${CURRENT_INSTALLED_DIR}
    OPTIONS_DEBUG
      -DPYTHON_BINDING:BOOL=OFF
      -DPYTHON_BINDING_FORCE_PYTHON3:BOOL=OFF
)

vcpkg_install_cmake()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/python-spacevecalg RENAME copyright)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
