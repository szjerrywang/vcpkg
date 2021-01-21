# vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO szjerrywang/quickfix
    REF v20210121
    SHA512 9e6d123bd6099849de74cb2ba20d572cc2b08d0a6e7c3180e95b0a3efc8f036545fdb7bcfc828cfa38dfe1a4524292b61ec6646d46489c97becee397704e815a
    HEAD_REF master
#    PATCHES 
#        00001-fix-build.patch
#        fix_wsl_symlink_error.patch
)

# file(GLOB_RECURSE SRC_FILES RELATIVE ${SOURCE_PATH} 
#	"${SOURCE_PATH}/src/*.cpp" 
#	"${SOURCE_PATH}/src/*.h"
#)

# list(REMOVE_ITEM SRC_FILES "src/C++/Utility.h")
# list(REMOVE_ITEM SRC_FILES "src/C++/pugixml.cpp")

# foreach(SRC_FILE IN LISTS SRC_FILES)
#    file(READ "${SOURCE_PATH}/${SRC_FILE}" _contents)
#	string(REPLACE "throw("  "QUICKFIX_THROW(" _contents "${_contents}")
#	string(REPLACE "throw (" "QUICKFIX_THROW(" _contents "${_contents}")
#    file(WRITE "${SOURCE_PATH}/${SRC_FILE}" "${_contents}")
# endforeach()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DHAVE_EMX=OFF
        -DHAVE_MYSQL=OFF
        -DHAVE_POSTGRESQL=OFF
        -DHAVE_PYTHON=OFF
        -DHAVE_PYTHON2=OFF
        -DHAVE_PYTHON3=OFF
        -DHAVE_SSL=ON
    PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets(CONFIG_PATH share/cmake/quickfix)

# vcpkg_fixup_cmake_targets(CONFIG_PATH share/unofficial-quickfix TARGET_PATH share/unofficial-quickfix)


file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

#configure_file(
#    ${CMAKE_CURRENT_LIST_DIR}/unofficial-quickfix-config.in.cmake
#    ${CURRENT_PACKAGES_DIR}/share/unofficial-quickfix/unofficial-quickfix-config.cmake
#    @ONLY
#)
#configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(INSTALL  ${CMAKE_CURRENT_LIST_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
