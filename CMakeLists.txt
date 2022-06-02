cmake_minimum_required(VERSION 3.16)

project(ZXingQtCamReader VERSION 1.0 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt5 Qt6 COMPONENTS Core Gui Multimedia Quick REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Gui Multimedia Quick REQUIRED)

set(BUILD_UNIT_TESTS OFF)
set(BUILD_BLACKBOX_TESTS OFF)
set(BUILD_EXAMPLES OFF)
add_subdirectory(zxing-cpp)

#include(zxing-cpp/zxing.cmake)

zxing_add_package_stb()

#if (BUILD_READERS)
    add_executable (ZXingReader ZXingReader.cpp)

    target_link_libraries (ZXingReader ZXing::ZXing stb::stb)
    set_target_properties(ZXingReader PROPERTIES
        MACOSX_BUNDLE_GUI_IDENTIFIER ZXingReader
        MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
        MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
        MACOSX_BUNDLE TRUE
        WIN32_EXECUTABLE TRUE
    )

    add_test(NAME ZXingReaderTest COMMAND ZXingReader -fast -format qrcode "${CMAKE_SOURCE_DIR}/test/samples/qrcode-1/1.png")
#endif()

#if (BUILD_WRITERS)
    add_executable (ZXingWriter ZXingWriter.cpp)

    target_link_libraries (ZXingWriter ZXing::ZXing stb::stb)
    set_target_properties(ZXingWriter PROPERTIES
        MACOSX_BUNDLE_GUI_IDENTIFIER ZXingWriter
        MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
        MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
        MACOSX_BUNDLE TRUE
        WIN32_EXECUTABLE TRUE
    )

    add_test(NAME ZXingWriterTest COMMAND ZXingWriter qrcode "I have the best words." test.png)
#endif()


#if (BUILD_READERS)

    set(CMAKE_AUTOMOC ON)
    set(CMAKE_AUTORCC ON)

#    if (TARGET Qt5::Gui)
#        add_executable (ZXingQtReader ZXingQtReader.cpp ZXingQtReader.h)
#        target_link_libraries(ZXingQtReader ZXing::ZXing Qt5::Gui)
#    endif()

#    if (TARGET Qt5::Multimedia)
        qt_add_executable(ZXingQtCamReader ZXingQtCamReader.cpp ZXingQtReader.h)
        qt_add_qml_module(ZXingQtCamReader
            URI ZXingQtCamReader
            VERSION 1.0
            QML_FILES ZXingQtCamReader.qml
        )
        set_target_properties(ZXingQtCamReader PROPERTIES
            MACOSX_BUNDLE_GUI_IDENTIFIER ZXingQtCamReader
            MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
            MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
            MACOSX_BUNDLE TRUE
            WIN32_EXECUTABLE TRUE
        )
        target_compile_definitions(ZXingQtCamReader
            PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
        target_link_libraries(ZXingQtCamReader PRIVATE ZXing::ZXing Qt${QT_VERSION_MAJOR}::Gui Qt${QT_VERSION_MAJOR}::Multimedia Qt${QT_VERSION_MAJOR}::Quick)
#    endif()

#    find_package(OpenCV)
#    if (OpenCV_FOUND)
#        add_executable (ZXingOpenCV ZXingOpenCV.cpp)
#        target_include_directories (ZXingOpenCV PRIVATE ${OpenCV_INCLUDE_DIRS})
#        target_link_libraries (ZXingOpenCV ZXing::ZXing ${OpenCV_LIBS})
#    endif()
#endif()
if (ANDROID)
    include(/Users/leo/Library/Android/sdk/android_openssl/CMakeLists.txt)
endif()
