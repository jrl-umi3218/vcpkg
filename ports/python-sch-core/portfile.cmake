include(vcpkg_pip_install_requirements)
vcpkg_pip_install_requirements()

include(vcpkg_amend_python_path)
vcpkg_amend_python_path()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/sch-core-python/releases/download/v1.0.2/sch-core-python-v1.0.2.tar.gz"
    FILENAME "sch-core-python-v1.0.2.tar.gz"
    SHA512 a5329aca444d54f36e064c4513acf77f2fe19bb268c4038dce44bfb4bc19d45d059e73bb8957b38bc79b447e4b8c642de352c671e3bf05eb44cfe169de6f14c7
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.0.2
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

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/python-sch-core RENAME copyright)

include(vcpkg_remove_pycache)
vcpkg_remove_pycache(sch)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
