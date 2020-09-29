## # vcpkg_pip_install_requirements
##
## Use pip to install requirements in the port directory
##
## ## Usage
## ```cmake
##  vcpkg_pip_install_requirements()
## ```
##
function(vcpkg_pip_install_requirements)
  if(DEFINED VCPKG_DOWNLOAD_MODE)
    return()
  endif()
  if(NOT EXISTS "${CURRENT_PORT_DIR}/requirements.txt")
    return()
  endif()
  find_program(PIP3 NAMES pip3 pip)
  if(NOT PIP3)
    vcpkg_fail_port_install(
        ALWAYS
        MESSAGE "You must have pip3 or pip installed on this machine to install this port"
    )
  endif()
  vcpkg_execute_required_process(
      COMMAND ${PIP3} install --user -r requirements.txt
      WORKING_DIRECTORY ${CURRENT_PORT_DIR}
  )
endfunction()
