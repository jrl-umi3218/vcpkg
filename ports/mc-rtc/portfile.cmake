vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/jrl-umi3218/mc_rtc/releases/download/v1.5.1/mc_rtc-v1.5.1.tar.gz"
    FILENAME "mc_rtc-v1.5.1.tar.gz"
    SHA512 1160cc5e248dbadda136e1c29c3467e7be9a8257c29b8dc4a30315eeb6bf5fe3311a01617b0013bce802df43f85d96018eea9c7e06559a6bd7d2d06a56559f35
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    REF 1.5.1
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
      -DBUILD_TESTING:BOOL=OFF
      -DDISABLE_ROS:BOOL=ON
      -DPYTHON_BINDING:BOOL=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/mc_rtc)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

vcpkg_copy_tools(
  TOOL_NAMES
    mc_bin_perf
    mc_bin_to_flat
    mc_bin_to_log
    mc_bin_utils
    mc_json_to_yaml
    mc_log_ui
    mc_old_bin_to_flat
    mc_plot_logs
    mc_rtc_new_controller
    mc_rtc_new_fsm_controller
  AUTO_CLEAN
)
