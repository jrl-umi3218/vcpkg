## # vcpkg_remove_pycache
##
## Remove __pycache__ subfolders in installed Python bindings
##
## ## Usage
## ```cmake
##  vcpkg_remove_pycache(NAME)
## ```
##
function(vcpkg_remove_pycache NAME)
  if(DEFINED VCPKG_DOWNLOAD_MODE)
    return()
  endif()
  file(
    GLOB_RECURSE INSTALLED_PYTHON
    LIST_DIRECTORIES TRUE
    ${CURRENT_PACKAGES_DIR}/lib/python*/site-packages/${NAME}/*/__pycache__
  )
  foreach(PYCACHE ${INSTALLED_PYTHON})
    if(${PYCACHE} MATCHES "__pycache__$")
      file(REMOVE_RECURSE ${PYCACHE})
    endif()
  endforeach()
endfunction()
