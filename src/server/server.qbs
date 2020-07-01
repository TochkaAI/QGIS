import qbs
import qbs.File
import qbs.TextFile
import QbsUtl

Product {
    name: "Server"
    targetName: "server"
    condition: true

    type: "dynamiclibrary"
    destinationDirectory: "./bin"

    Depends { name: "cpp" }
    Depends { name: "cppstdlib" }
//    Depends { name: "Native" }
//    Depends { name: "Nlohmann" }
    Depends { name: "Core" }
    Depends { name: "Qt"; submodules: [
        "core", "network"] }
//    Depends { name: "Qt"; submodules: [
//        "core", "network", "widgets", "concurrent", "sql", "svg", "xml",
//        "uitools", "printsupport", "qml"] }

    property var exportDefines: [
        "GUI_EXPORT=",
    ]
    cpp.defines: project.cppDefines.concat(exportDefines)

    cpp.cxxFlags: project.cxxFlags
    cpp.cxxLanguageVersion: project.cxxLanguageVersion

    cpp.includePaths:[
        ".",
        "services",
    ]

    cpp.systemIncludePaths: QbsUtl.concatPaths(
        Qt.core.cpp.includePaths
//       ,"/usr/include/gdal"
//       ,"/usr/include/qwt"
//       ,"/usr/include/Qca-qt5/QtCrypto"
////       ,"/usr/include/spatialindex"
//       ,"/usr/include/qt5keychain"
    )

    cpp.rpaths: QbsUtl.concatPaths(
        cppstdlib.path
       ,"$ORIGIN/../lib"
    )

    cpp.libraryPaths: QbsUtl.concatPaths(
        project.buildDirectory + "/lib"
    )

    files: [
        "services/*.cpp",
        "services/*.h",
        "*.cpp",
        "*.h",
    ]
}

