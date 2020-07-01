import qbs
import QbsUtl

Product {
    name: "Python"
    targetName: "qgis_python"
    condition: true

    type: "dynamiclibrary"
    destinationDirectory: "./lib"

    Depends { name: "cpp" }
    Depends { name: "cppstdlib" }
    Depends { name: "headgen" }
    Depends { name: "Core" }
    Depends { name: "Qt"; submodules: ["core", "network", "widgets"] }

    headgen.headerName: "qgis_python.h"
    headgen.templateHeaderPath: project.headgenTemplate

    cpp.defines: project.cppDefines.concat([
        product.targetName + "_EXPORTS",
    ])

    cpp.cxxFlags: project.cxxFlags.concat(["-fPIC"])
    cpp.cxxLanguageVersion: project.cxxLanguageVersion

    property var exportIncludePaths: [
        ".",
    ]
    cpp.includePaths: exportIncludePaths.concat([
        headgen.generatedFilesDir,
    ])

    cpp.systemIncludePaths: QbsUtl.concatPaths(
        Qt.core.cpp.includePaths
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

    files: [
        "*.cpp",
        "*.h",
    ]

    excludeFiles: [
        //"qgsexpressionsorter.cpp"
        //"qgsfilesourcelineedit.h",
    ]

    Export {
        Depends { name: "cpp" }
        cpp.defines: product.exportDefines
        cpp.includePaths: product.exportIncludePaths
    }
}

