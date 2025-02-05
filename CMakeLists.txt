cmake_minimum_required(VERSION 3.15)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake")

project(comp8600-final-project)

OPTION(USE_D2D_WSI "Build the project using Direct to Display swapchain" OFF)

find_package(Vulkan REQUIRED)

IF(WIN32)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DVK_USE_PLATFORM_WIN32_KHR")
ELSE(WIN32)
  find_package(Threads REQUIRED)
IF(USE_D2D_WSI)
  MESSAGE(STATUS "Vulkan: Using direct to display extension -D_DIRECT2DISPLAY...")
  add_definitions(-D_DIRECT2DISPLAY)
ELSE(USE_D2D_WSI)
  message(STATUS "Vulkan: Using default WSI -DVK_USE_PLATFORM_XCB_KHR...")
  find_package(XCB REQUIRED)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DVK_USE_PLATFORM_XCB_KHR")
ENDIF(USE_D2D_WSI)
ENDIF(WIN32)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DNOMINMAX -D_USE_MATH_DEFINES")

add_definitions(-D_CRT_SECURE_NO_WARNINGS)
set(CMAKE_CXX_STANDARD 11)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

function(ExternalTarget folder target)
  set_property(TARGET ${target} PROPERTY FOLDER ${folder})
endfunction(ExternalTarget)

function(InternalTarget folder target)
  ExternalTarget("${folder}" ${target})
  if (MSVC)
    get_target_property(targetSources ${target} SOURCES)
    foreach(sourceFile IN ITEMS ${targetSources})
        if (IS_ABSOLUTE "${sourceFile}")
          file(RELATIVE_PATH sourceFile "${CMAKE_CURRENT_SOURCE_DIR}" "${sourceFile}")
        endif()
        get_filename_component(sourceDir "${sourceFile}" PATH)
        string(REPLACE "/" "\\" sourceDir "${sourceDir}")
        source_group("${sourceDir}" FILES "${sourceFile}")
    endforeach()
  endif()
endfunction(InternalTarget)

IF(WIN32)
  # Nothing here (yet)
ELSE(WIN32)
    link_libraries(${XCB_LIBRARIES} ${VULKAN_LIB})
ENDIF(WIN32)

if(WIN32)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
else(WIN32)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
endif(WIN32)


add_subdirectory(external)
add_subdirectory(src)
