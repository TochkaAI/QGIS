import qbs
import QbsUtl

Product {
    name: "Ui"
    targetName: "qgis_ui"
    condition: true

    type: "staticlibrary"

    Depends { name: "cpp" }
    Depends { name: "cppstdlib" }
    Depends { name: "Qt"; submodules: ["core", "gui", "widgets"] }

    cpp.cxxFlags: project.cxxFlags.concat(["-fPIC"])
    cpp.cxxLanguageVersion: project.cxxLanguageVersion

    property var exportIncludePaths: [
        ".",
        product.buildDirectory + "/qt.headers",
    ]

    cpp.includePaths: exportIncludePaths.concat([
        "3d",
        "attributeformconfig",
        "auth",
        "callouts",
        "editorwidgets",
        "effects",
        "georeferencer",
        "labeling",
        "layout",
        "mesh",
        "numericformats",
        "processing",
        "raster",
        "styledock",
        "symbollayer",
        "templates",
    ])

    cpp.systemIncludePaths: QbsUtl.concatPaths(
        Qt.core.cpp.includePaths
    )

    files: [
        "3d/*",
        "attributeformconfig/*",
        "auth/*",
        "callouts/*",
        "editorwidgets/*",
        "effects/*",
        "georeferencer/*",
        "labeling/*",
        "layout/*",
        "mesh/*",
        "numericformats/*",
        "processing/*",
        "raster/*",
        "styledock/*",
        "symbollayer/*",
        "templates/*",
        "*.ui",
    ]
    excludeFiles: [
        "raster/qgscolorrampshaderwidgetbase.ui",
        //"qgscolorrampshaderwidgetbase.ui",
    ]

    Export {
        Depends { name: "cpp" }
        //cpp.defines: product.exportDefines
        cpp.includePaths: product.exportIncludePaths
    }
}

