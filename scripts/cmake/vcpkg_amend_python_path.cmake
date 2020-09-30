## # vcpkg_amend_python_path
##
## Add the ${CURRENT_INSTALLED_DIR}/lib/python3.X/site-packages to PYTHONPATH
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
  set(PYTHON3 python3)
  execute_process(
    COMMAND ${PYTHON3} -c "import sys; print(\"python{}.{}\".format(sys.version_info.major, sys.version_info.minor));"
    OUTPUT_VARIABLE PYTHON3_VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  set(ENV{PYTHONPATH} "${CURRENT_INSTALLED_DIR}/lib/${PYTHON3_VERSION}/site-packages${VCPKG_HOST_PATH_SEPARATOR}$ENV{PYTHONPATH}")
  message("PYTHONPATH is now $ENV{PYTHONPATH}")
endfunction()
