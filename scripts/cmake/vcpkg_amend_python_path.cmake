## # vcpkg_amend_python_path
##
## Add the ${CURRENT_PACKAGES_DIR}/lib/python3.X/site-packages to PYTHONPATH
##
## ## Usage
## ```cmake
##  vcpkg_amend_python_path()
## ```
##
function(vcpkg_amend_python_path)
  if(DEFINED VCPKG_DOWNLOAD_MODE)
    return()
  endif()
  if(WIN32)
    set(PYTHON3 python3)
  else()
    find_program(PYTHON3 NAMES python3 python)
    if(NOT PYTHON3)
      vcpkg_fail_port_install(
        ALWAYS
        MESSAGE "You must have python3 or python installed on this machine to install this port"
      )
    endif()
  endif()
  execute_process(
    COMMAND ${PYTHON3} -c "import sys; print(\"python{}.{}\".format(sys.version_info.major, sys.version_info.minor));"
    OUTPUT_VARIABLE PYTHON3_VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  set(ENV{PYTHONPATH} "${CURRENT_INSTALLED_DIR}/lib/${PYTHON3_VERSION}/site-packages${VCPKG_HOST_PATH_SEPARATOR}$ENV{PYTHONPATH}")
endfunction()
