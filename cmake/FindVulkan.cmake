if(WIN32)
find_path(Vulkan_INCLUDE_DIR
  NAMES vulkan/vulkan.h
  PATHS
    "$ENV{VULKAN_SDK}/Include"
  )

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  find_library(Vulkan_LIBRARY
    NAMES vulkan-1
    PATHS
      "$ENV{VULKAN_SDK}/Lib"
      "$ENV{VULKAN_SDK}/Bin"
      )
elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
  find_library(Vulkan_LIBRARY
    NAMES vulkan-1
    PATHS
      "$ENV{VULKAN_SDK}/Lib32"
      "$ENV{VULKAN_SDK}/Bin32"
      NO_SYSTEM_ENVIRONMENT_PATH
      )
endif()
else()
  find_path(Vulkan_INCLUDE_DIR
    NAMES vulkan/vulkan.h
    PATHS
      "$ENV{VULKAN_SDK}/include")
  find_library(Vulkan_LIBRARY
    NAMES vulkan
    PATHS
      "$ENV{VULKAN_SDK}/lib")
endif()

set(Vulkan_LIBRARIES ${Vulkan_LIBRARY})
set(Vulkan_INCLUDE_DIRS ${Vulkan_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Vulkan
DEFAULT_MSG
Vulkan_LIBRARY Vulkan_INCLUDE_DIR)

mark_as_advanced(Vulkan_INCLUDE_DIR Vulkan_LIBRARY)

if(Vulkan_FOUND AND NOT TARGET Vulkan::Vulkan)
add_library(Vulkan::Vulkan UNKNOWN IMPORTED)
set_target_properties(Vulkan::Vulkan PROPERTIES
  IMPORTED_LOCATION "${Vulkan_LIBRARIES}"
  INTERFACE_INCLUDE_DIRECTORIES "${Vulkan_INCLUDE_DIRS}")
endif()