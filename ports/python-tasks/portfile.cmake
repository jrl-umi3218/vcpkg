include(vcpkg_amend_python_path)
vcpkg_amend_python_path()

include(vcpkg_pip_install_requirements)
vcpkg_pip_install_requirements()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/Tasks/releases/download/v1.3.0/Tasks-v1.3.0.tar.gz"
    FILENAME "Tasks-v1.3.0.tar.gz"
    SHA512 138e97b2b89cd6554b304066d9bb209fe8d7e1f7c3a72f01e35750985dca562bc3c3f5e84a57f4e284439bd9957af75893ec41c9166d25036b1846de473fb3b8
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.3.0
    PATCHES
      python-standalone.patch
      set-cmake-cxx-standard.patch
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

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

include(vcpkg_remove_pycache)
vcpkg_remove_pycache(tasks)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
