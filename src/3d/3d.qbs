import qbs
import QbsUtl

Product {
    name: "_3d"
    targetName: "qgis_3d"
    condition: true

    type: "dynamiclibrary"
    destinationDirectory: "./lib"

    Depends { name: "cpp" }
    Depends { name: "cppstdlib" }
    Depends { name: "headgen" }
    Depends { name: "sip" }
    Depends { name: "Nlohmann" }
    Depends { name: "Core" }
    Depends { name: "Qt3dExtraHeaders" }
    Depends { name: "Qt"; submodules: [
        "core", "network", "gui", "widgets", "concurrent", "xml", "printsupport",
        "svg", "3dcore", "3dinput", "3dextras" ] }

    headgen.headerName: "qgis_3d.h"
    headgen.templateHeaderPath: project.headgenTemplate

    sip.baseSipFile: "3d.sip"
    sip.moduleSipName: "_3d"
    sip.generatedFilesSubDir: "3d"

    cpp.defines: project.cppDefines.concat([
        product.targetName + "_EXPORTS",
    ])

    cpp.cxxFlags: project.cxxFlags
    cpp.cxxLanguageVersion: project.cxxLanguageVersion

    property var exportIncludePaths: [
        ".",
        "chunks",
        "mesh",
        "processing",
        "shaders",
        "symbols",
        "terrain",
        headgen.generatedFilesDir,
    ]
    cpp.includePaths: exportIncludePaths.concat([
        //"../core",
        //"../core/geometry",
    ]);

    cpp.systemIncludePaths: QbsUtl.concatPaths(
        Qt.core.cpp.includePaths
       ,"/usr/include/gdal"
       ,"/usr/include/Qca-qt5/QtCrypto"
       ,"/usr/include/python3.8"
    )

    cpp.rpaths: QbsUtl.concatPaths(
        cppstdlib.path
       ,"$ORIGIN/../lib"
    )

    cpp.libraryPaths: QbsUtl.concatPaths(
        project.buildDirectory + "/lib"
    )

    cpp.dynamicLibraries: project.dynamicLibraries

    Group {
        name:  "Resources"
        prefix: "../../resources/3d/textures/"
        files:  ["textures.qrc"]
    }

    Group {
        name: "Sip"
        prefix: "../../python/3d/"
        files: [
            "auto_generated/processing/*",
            "auto_generated/symbols/*",
            "auto_generated/*",
            "3d.sip.in",
            "3d_auto.sip",
        ]
        fileTags: ["sip_in"]
    }

    files: [
        "chunks/*.cpp",
        "chunks/*.h",
        "mesh/*.cpp",
        "mesh/*.h",
        "processing/*.cpp",
        "processing/*.h",
        "shaders/*.cpp",
        "shaders/*.h",
        "symbols/*.cpp",
        "symbols/*.h",
        "terrain/*.cpp",
        "terrain/*.h",
//        "terrain/qgsdemterraingenerator.cpp",
//        "terrain/qgsdemterraintilegeometry_p.cpp",
//        "terrain/qgsdemterraintileloader_p.cpp",
//        "terrain/qgsflatterraingenerator.cpp",
//        "terrain/qgsonlineterraingenerator.cpp",
//        "terrain/qgsterraindownloader.cpp",
//        "terrain/qgsterrainentity_p.cpp",
//        "terrain/qgsterraingenerator.cpp",
//        "terrain/qgsterraintexturegenerator_p.cpp",
//        "terrain/qgsterraintextureimage_p.cpp",
//        "terrain/qgsterraintileloader_p.cpp",
//        "terrain/qgsdemterraintilegeometry_p.h",
//        "terrain/qgsdemterraintileloader_p.h",
//        "terrain/qgsterrainentity_p.h",
//        "terrain/qgsterraintexturegenerator_p.h",
//        "terrain/qgsterraintextureimage_p.h",
//        "terrain/qgsterraintileentity_p.h",
        "*.cpp",
        "*.h",
    ]

    excludeFiles: [
        "qgschunkedentity_p.h",
        "terrain/quantizedmeshgeometry.*",
        "terrain/quantizedmeshterraingenerator.*",
    ]

    Export {
        Depends { name: "cpp" }
        cpp.includePaths: product.exportIncludePaths
    }
}

