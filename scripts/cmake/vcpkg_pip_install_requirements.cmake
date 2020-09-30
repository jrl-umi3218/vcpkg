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
  if(WIN32)
    vcpkg_add_to_path("C:\\hostedtoolcache\\windows\\Python\\3.7.9\\x64\\")
    vcpkg_add_to_path("C:\\hostedtoolcache\\windows\\Python\\3.7.9\\x64\\Scripts")
    set(PIP3 pip)
  else()
    set(PIP3 pip3)
  endif()
  vcpkg_execute_required_process(
      COMMAND ${PIP3} install --user -r requirements.txt
      WORKING_DIRECTORY ${CURRENT_PORT_DIR}
  )
endfunction()
