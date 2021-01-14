vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO lballabio/QuantLib
    REF QuantLib-v1.20
    SHA512 3929f339f5c626ae4e39ac476e1478600f1457240533a885743782e8abfcee0ef4e79518096f3bec21c952b6f812d40648a86b6a0e00ba87bd67644f8ed0ac56
    HEAD_REF master
    PATCHES
        make-linux-build.patch
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" USE_BOOST_DYNAMIC_LIBRARIES)

set(QL_MSVC_RUNTIME ${VCPKG_LIBRARY_LINKAGE})

#in linux, it should be ok to build dynamic library
#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

# TODO: Fix it in the upstream
#vcpkg_replace_string(
#    "${SOURCE_PATH}/ql/userconfig.hpp"
#    "//#    define QL_USE_STD_UNIQUE_PTR"
#    "#    define QL_USE_STD_UNIQUE_PTR"
#)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DUSE_BOOST_DYNAMIC_LIBRARIES=${USE_BOOST_DYNAMIC_LIBRARIES}
        -DMSVC_RUNTIME=${QL_MSVC_RUNTIME}
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
configure_file(${SOURCE_PATH}/LICENSE.TXT ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
