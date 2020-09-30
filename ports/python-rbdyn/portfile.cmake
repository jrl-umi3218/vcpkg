include(vcpkg_pip_install_requirements)
vcpkg_pip_install_requirements()

include(vcpkg_amend_python_path)
vcpkg_amend_python_path()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/RBDyn/releases/download/v1.3.0/RBDyn-v1.3.0.tar.gz"
    FILENAME "RBDyn-v1.3.0.tar.gz"
    SHA512 4cdf5df0216ed0315ed20bd9b54a2fcc0a91cce85c4bc7b7acfa41c25ac24233801dc0b4de872c8fbcd77ef507dd43ffd3d1e597a3d41edff7ddd36e1d71360e
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.3.0
    PATCHES
      python-standalone.patch
)

if(WIN32)
  set(PYTHON_BINDING_OPTION "")
else()
  set(PYTHON_BINDING_OPTION "-DPYTHON_BINDING_FORCE_PYTHON3:BOOL=ON")
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DBUILD_TESTING:BOOL=OFF
      ${PYTHON_BINDING_OPTION}
      -DPIP_INSTALL_PREFIX=${CURRENT_PACKAGES_DIR}
    OPTIONS_DEBUG
      -DPYTHON_BINDING:BOOL=OFF
)

vcpkg_install_cmake()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/python-rbdyn RENAME copyright)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)

include(vcpkg_remove_pycache)
vcpkg_remove_pycache(rbdyn)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
