import qbs
import QbsUtl

Product {
    name: "Native"
    targetName: "qgis_native"
    condition: true

    type: "dynamiclibrary"
    destinationDirectory: "./lib"

    Depends { name: "cpp" }
    Depends { name: "headgen" }
    Depends { name: "Qt"; submodules: ["core", "gui"] }

    headgen.headerName: "qgis_native.h"
    headgen.templateHeaderPath: project.headgenTemplate

    cpp.defines: project.cppDefines.concat([
        product.targetName + "_EXPORTS",
    ])

    cpp.cxxFlags: project.cxxFlags.concat(["-fPIC"])
    cpp.cxxLanguageVersion: project.cxxLanguageVersion

    property var exportIncludePaths: [
        ".",
        "linux",
        headgen.generatedFilesDir,
    ]
    cpp.includePaths: exportIncludePaths.concat([
        //"mac",
        //"win",
    ]);

    cpp.systemIncludePaths: QbsUtl.concatPaths(
        Qt.core.cpp.includePaths
    )

    cpp.dynamicLibraries: [
        "pthread",
    ]

    Group {
        name: "Linux"
        condition: qbs.targetOS.contains("linux")
        files: [
            "linux/qgslinuxnative.cpp",
            "linux/qgslinuxnative.h",
        ]
    }

    files: [
        "qgsnative.cpp",
        "qgsnative.h",
    ]
//    excludeFiles: [
//        "qgsexpressionsorter.cpp"
//    ]

    Export {
        Depends { name: "cpp" }
        //cpp.defines: product.exportDefines
        cpp.includePaths: product.exportIncludePaths
    }
}

