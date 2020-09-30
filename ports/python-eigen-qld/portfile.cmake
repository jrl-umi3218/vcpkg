include(vcpkg_amend_python_path)
vcpkg_amend_python_path()

include(vcpkg_pip_install_requirements)
vcpkg_pip_install_requirements()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/eigen-qld/releases/download/v1.2.1/eigen-qld-v1.2.1.tar.gz"
    FILENAME "eigen-qld-v1.2.1.tar.gz"
    SHA512 bef56ae88a457d9bc602d50780dcf283f972cbcd13f409207e9be85354523f1d7dcc7bdc32893d21d5c7ede0d0c699a341c16d5e9ac789c0108cf00dfa3ab0fb
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.2.1
    PATCHES
      fix-qld_fortran-import.patch
      python-standalone.patch
)

vcpkg_add_to_path("${MINGW_BIN}")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
      -DBUILD_TESTING:BOOL=OFF
      -DPYTHON_BINDING_FORCE_PYTHON3:BOOL=ON
      -DPIP_INSTALL_PREFIX=${CURRENT_PACKAGES_DIR}
    OPTIONS_DEBUG
      -DPYTHON_BINDING:BOOL=OFF
)

vcpkg_install_cmake()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

include(vcpkg_remove_pycache)
vcpkg_remove_pycache(eigen-qld)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
