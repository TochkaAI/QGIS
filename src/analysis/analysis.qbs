import qbs
import QbsUtl

Product {
    name: "Analysis"
    targetName: "qgis_analysis"
    condition: true

    type: "dynamiclibrary"
    destinationDirectory: "./lib"

    Depends { name: "cpp" }
    Depends { name: "cppstdlib" }
    Depends { name: "headgen" }
    Depends { name: "sip" }
    Depends { name: "bison" }
    Depends { name: "flex" }
    Depends { name: "Nlohmann" }
    Depends { name: "LibDxfrw" }
    Depends { name: "Core" }
    Depends { name: "Qt"; submodules: ["core", "gui", "widgets", "network",
                                       "concurrent", "xml", "printsupport" ] }

    headgen.headerName: "qgis_analysis.h"
    headgen.templateHeaderPath: project.headgenTemplate

    sip.baseSipFile: "analysis.sip"
    sip.moduleSipName: "_analysis"
    sip.generatedFilesSubDir: "analysis"

    cpp.defines: project.cppDefines.concat([
        product.targetName + "_EXPORTS",
    ])

    cpp.cxxFlags: project.cxxFlags.concat(["-fPIC"])
    cpp.cxxLanguageVersion: project.cxxLanguageVersion

    property var exportIncludePaths: [
        ".",
        "interpolation",
        "mesh",
        "network",
        "processing",
        "raster",
        "vector",
        "vector/geometry_checker",
        headgen.generatedFilesDir,
        sip.generatedFilesDir,
        bison.generatedFilesDir,
        flex.generatedFilesDir,
    ]

    cpp.includePaths: exportIncludePaths.concat([])

    cpp.systemIncludePaths: QbsUtl.concatPaths(
        Qt.core.cpp.includePaths
       ,"/usr/include/gdal"
       ,"/usr/include/python3.8"
    )

    cpp.rpaths: QbsUtl.concatPaths(
        cppstdlib.path,
        "$ORIGIN/../lib"
    )

    cpp.libraryPaths: QbsUtl.concatPaths(
        project.buildDirectory + "/lib"
    )

    cpp.dynamicLibraries: project.dynamicLibraries

    //cpp.staticLibraries: [
    //    "/usr/lib/x86_64-linux-gnu/libfl.a",
    //]

    Group {
        name: "Bison (mesh)"
        bison.prefix: "mesh"
        files: ["mesh/qgsmeshcalcparser.yy"]
    }

    Group {
        name: "Bison (raster)"
        bison.prefix: "raster"
        files: ["raster/qgsrastercalcparser.yy"]
    }

    Group {
        name: "Flex (mesh)"
        flex.prefix: "mesh"
        files: ["mesh/qgsmeshcalclexer.ll"]
    }

    Group {
        name: "Flex (raster)"
        flex.prefix: "raster"
        files: ["raster/qgsrastercalclexer.ll"]
    }

    Group {
        name: "Sip"
        prefix: "../../python/analysis/"
        files: [
            "auto_generated/interpolation/*",
            "auto_generated/mesh/*",
            "auto_generated/network/*",
            "auto_generated/processing/*",
            "auto_generated/raster/*",
            "auto_generated/vector/*",
            "auto_generated/vector/geometry_checker/*",
            "auto_generated/*",
            "analysis.sip.in",
            "analysis_auto.sip",
        ]
        fileTags: ["sip_in"]
    }

    files: [
        "interpolation/*.cpp",
        "interpolation/*.h",
        "mesh/*.cpp",
        "mesh/*.h",
        "network/*.cpp",
        "network/*.h",
        "processing/*.cpp",
        "processing/*.h",
        "raster/*.cpp",
        "raster/*.h",
        "vector/geometry_checker/*.cpp",
        "vector/geometry_checker/*.h",
        "vector/*.cpp",
        "vector/*.h",
        "*.cpp",
        "*.h",
    ]

    excludeFiles: [
        "qgsexpressionsorter.cpp"
    ]

    Export {
        Depends { name: "cpp" }
        cpp.includePaths: product.exportIncludePaths
    }
}

