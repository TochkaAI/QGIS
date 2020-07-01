import qbs
import QbsUtl

Product {
    name: "App"
    targetName: "qgis_app"
    condition: true

    type: "dynamiclibrary"
    destinationDirectory: "./lib"

    Depends { name: "cpp" }
    Depends { name: "cppstdlib" }
    Depends { name: "headgen" }
    Depends { name: "Native" }
    Depends { name: "Nlohmann" }
    Depends { name: "Nmea" }
    Depends { name: "LibDxfrw" }
    Depends { name: "Core" }
    Depends { name: "Gui" }
    Depends { name: "Ui" }
    Depends { name: "_3d" }
    Depends { name: "Analysis" }
    Depends { name: "Qt3dExtraHeaders" }
    Depends { name: "QtUnixSignals" }
    Depends { name: "Qt"; submodules: [
        "core", "network", "gui", "widgets", "concurrent", "xml", "sql", "svg",
        "uitools", "3dcore", "3dinput", "printsupport"] }

    headgen.headerName: "qgis_app.h"
    headgen.templateHeaderPath: project.headgenTemplate

    cpp.defines: project.cppDefines.concat([
        product.targetName + "_EXPORTS",
    ])

    cpp.cxxFlags: project.cxxFlags.concat(["-fPIC"])
    cpp.cxxLanguageVersion: project.cxxLanguageVersion

    property var exportIncludePaths: [
        ".",
        "3d",
        "browser",
        "decorations",
        "devtools",
        "devtools/networklogger",
        "devtools/profiler",
        "dwg",
        "georeferencer",
        "gps",
        "labeling",
        "layout",
        "locator",
        "mesh",
        "pluginmanager",
        "vectortile",
        "vertextool",
        headgen.generatedFilesDir,
    ]

    cpp.includePaths: exportIncludePaths.concat([
        //"../core",
        "../plugins",
    ])

    cpp.systemIncludePaths: QbsUtl.concatPaths(
        Qt.core.cpp.includePaths
       ,"/usr/include/gdal"
       ,"/usr/include/qwt"
       ,"/usr/include/Qca-qt5/QtCrypto"
       ,"/usr/include/qt5keychain"
////       ,"/usr/include/spatialindex"
    )

    cpp.rpaths: QbsUtl.concatPaths(
        cppstdlib.path
       ,"$ORIGIN/../lib"
    )

    cpp.libraryPaths: QbsUtl.concatPaths(
        project.buildDirectory + "/lib"
    )

    cpp.dynamicLibraries: project.dynamicLibraries

    files: [
        "3d/*",
        "browser/*",
        "decorations/*",
        "devtools/*",
        "devtools/networklogger/*",
        "devtools/profiler/*",
        "dwg/*",
        "georeferencer/*",
        "gps/*",
        "labeling/*",
        "layout/*",
        "locator/*",
        "mesh/*",
        "pluginmanager/*",
        "vectortile/*",
        "vertextool/*",
        "*.cpp",
        "*.h",
    ]

    excludeFiles: [
        "main.cpp",
        "mainwin.cpp",
        "qtmain_android.cpp",
    ]

    Export {
        Depends { name: "cpp" }
        //cpp.defines: product.exportDefines
        cpp.includePaths: product.exportIncludePaths
    }
}

