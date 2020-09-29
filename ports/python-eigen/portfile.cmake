find_program(PIP3 NAMES pip3 pip)
if(NOT PIP3)
  vcpkg_fail_port_install(
      ALWAYS
      MESSAGE "You must have pip3 or pip installed on this machine to install this port"
  )
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/Eigen3ToPython/releases/download/v1.0.2/Eigen3ToPython-v1.0.2.tar.gz"
    FILENAME "Eigen3ToPython-v1.0.2.tar.gz"
    SHA512 e38184ebf191b813e4b3e8cc0d9d5f1dab2c51eace24a0c2e878537db6cb36a0dc0d48c777fe235a096bd6a0730563f9e8167c4610616bdd1a57ecc67ad1e005
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.0.2
)

vcpkg_execute_required_process(
    COMMAND ${PIP3} install -r requirements.txt
    WORKING_DIRECTORY ${SOURCE_PATH}
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
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/python-eigen RENAME copyright)

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
