import qbs
import QbsUtl

Product {
    name: "Gui"
    targetName: "qgis_gui"
    condition: true

    type: "dynamiclibrary"
    destinationDirectory: "./lib"

    Depends { name: "cpp" }
    Depends { name: "cppstdlib" }
    Depends { name: "headgen" }
    Depends { name: "sip" }
    Depends { name: "Native" }
    Depends { name: "Nlohmann" }
    Depends { name: "Core" }
    Depends { name: "Ui" }
    Depends { name: "Qt"; submodules: [
        "core", "network", "widgets", "concurrent", "sql", "svg", "xml",
        "uitools", "printsupport", "qml", "quickwidgets"] }

    headgen.headerName: "qgis_gui.h"
    headgen.templateHeaderPath: project.headgenTemplate

    sip.baseSipFile: "gui.sip"
    sip.moduleSipName: "_gui"
    sip.generatedFilesSubDir: "gui"

    cpp.defines: project.cppDefines.concat([
        product.targetName + "_EXPORTS",
    ])

    cpp.cxxFlags: project.cxxFlags.concat(["-fPIC"])
    cpp.cxxLanguageVersion: project.cxxLanguageVersion

    property var exportIncludePaths: [
        ".",
        "attributeformconfig",
        "attributetable",
        "auth",
        "callouts",
        "devtools",
        "editorwidgets",
        "editorwidgets/core",
        "effects",
        "labeling",
        "layertree",
        "layout",
        "locator",
        "numericformats",
        "ogr",
        "processing",
        "processing/models",
        "providers/gdal",
        "providers/ogr",
        "raster",
        "symbology",
        "tableeditor",
        "vector",
        "vectortile",
        headgen.generatedFilesDir,
        sip.generatedFilesDir,
    ]

    cpp.includePaths: exportIncludePaths.concat([
        "../core",
    ])

    cpp.systemIncludePaths: QbsUtl.concatPaths(
        Qt.core.cpp.includePaths
       ,"/usr/include/gdal"
       ,"/usr/include/qwt"
       ,"/usr/include/Qca-qt5/QtCrypto"
//       ,"/usr/include/spatialindex"
       ,"/usr/include/qt5keychain"
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
        name: "Sip"
        prefix: "../../python/gui/"
        files: [
            "auto_generated/attributetable/*",
            "auto_generated/auth/*",
            "auto_generated/callouts/*",
            "auto_generated/devtools/*",
            "auto_generated/editorwidgets/*",
            "auto_generated/editorwidgets/core/*",
            "auto_generated/effects/*",
            "auto_generated/labeling/*",
            "auto_generated/layertree/*",
            "auto_generated/layout/*",
            "auto_generated/locator/*",
            "auto_generated/numericformats/*",
            "auto_generated/processing/*",
            "auto_generated/processing/models/*",
            "auto_generated/raster/*",
            "auto_generated/symbology/*",
            "auto_generated/tableeditor/*",
            "auto_generated/vector/*",
            "auto_generated/*",
            "gui.sip.in",
            "gui_auto.sip",
            "qgsfiledropedit.sip",
            "qgssourceselectdialog.sip",
        ]
        fileTags: ["sip_in"]
    }

    files: [
        "attributeformconfig/*",
        "attributetable/*",
        "auth/*",
        "callouts/*",
        "devtools/*",
        "editorwidgets/*",
        "editorwidgets/core/*",
        "effects/*",
        "labeling/*",
        "layertree/*",
        "layout/*",
        "locator/*",
        "numericformats/*",
        "ogr/*",
        "processing/*",
        "processing/models/*",
        "providers/gdal/*",
        "providers/ogr/*",
        "raster/*",
        "symbology/*",
        "tableeditor/*",
        "vector/*",
        "vectortile/*",
        "*.cpp",
        "*.h",
    ]

    excludeFiles: [
        //"qgsexpressionsorter.cpp"
        //"qgsfilesourcelineedit.h",
    ]

    Export {
        Depends { name: "cpp" }
        //cpp.defines: product.exportDefines
        cpp.includePaths: product.exportIncludePaths
    }
}

