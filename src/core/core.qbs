import qbs
import QbsUtl

Product {
    name: "Core"
    targetName: "qgis_core"
    condition: true

    type: ["dynamiclibrary", "sip"]
    destinationDirectory: "./lib"

    Depends { name: "cpp" }
    Depends { name: "cppstdlib" }
    Depends { name: "headgen" }
    Depends { name: "funchelp" }
    Depends { name: "sip" }
    Depends { name: "bison" }
    Depends { name: "flex" }
    Depends { name: "protobuf" }
  //Depends { name: "Crashhandler "}
    Depends { name: "Kdbush" }
    Depends { name: "Mdal" }
    Depends { name: "MeshOptimizer" }
    Depends { name: "Nlohmann" }
    Depends { name: "Nmea" }
    Depends { name: "Poly2tri" }
    Depends { name: "Rtree" }
    Depends { name: "Qt"; submodules: [
        "core", "network", "widgets", "concurrent", "sql", "svg", "xml",
        "printsupport", "3dcore", "3drender", "3dinput", "positioning"] }

    headgen.headerName: "qgis_core.h"
    headgen.templateHeaderPath: project.headgenTemplate

    sip.baseSipFile: "core.sip"
    sip.moduleSipName: "_core"
    sip.generatedFilesSubDir: "core"

    cpp.defines: project.cppDefines.concat([
        product.targetName + "_EXPORTS",
    ])

    cpp.cxxFlags: project.cxxFlags.concat(["-fPIC"])
    cpp.cxxLanguageVersion: project.cxxLanguageVersion

    property var exportIncludePaths: [
        ".",
        "3d",
        "annotations",
        "auth",
        "callouts",
        "classification",
        "diagram",
        "dxf",
        "effects",
        "expression",
        "fieldformatter",
        "geocms/geonode",
        "geometry",
        "gps",
        "labeling",
        "layertree",
        "layout",
        "locator",
        "mesh",
        "metadata",
        "numericformats",
        "pal",
        "processing",
        "processing/models",
        "providers/gdal",
        "providers/memory",
        "providers/meshmemory",
        "providers/ogr",
        "raster",
        "symbology",
        "scalebar",
        "textrenderer",
        "vectortile",
        "validity",
        project.buildDirectory,
        headgen.generatedFilesDir,
        sip.generatedFilesDir,
        bison.generatedFilesDir,
        flex.generatedFilesDir,
        protobuf.generatedFilesDir,
    ]

    cpp.includePaths: exportIncludePaths.concat([
        "../crashhandler",
    ])

    cpp.systemIncludePaths: QbsUtl.concatPaths(
        Qt.core.cpp.includePaths
       ,"/usr/include/gdal"
       ,"/usr/include/Qca-qt5/QtCrypto"
       ,"/usr/include/spatialindex"
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

    //cpp.staticLibraries: [
    //    "/usr/lib/x86_64-linux-gnu/libfl.a",
    //]

    Group {
        name: "Bison (exp)"
        files: ["qgsexpressionparser.yy"]
        bison.prefix: "exp_"
    }

    Group {
        name: "Bison (sqlstatement)"
        files: ["qgssqlstatementparser.yy"]
        bison.prefix: "sqlstatement_"
    }

    Group {
        name: "Flex (exp)"
        files: ["qgsexpressionlexer.ll"]
        flex.prefix: "exp_"
    }

    Group {
        name: "Flex (sqlstatement)"
        files: ["qgssqlstatementlexer.ll"]
        flex.prefix: "sqlstatement_"
    }

    Group {
        name: "FunctionHelp"
        files: ["../../resources/function_help/json/*"]
        fileTags: ["funchelp"]
    }

    Group {
        name: "Resources"
        prefix: "../../images/"
        files: ["images.qrc"]
    }

    Group {
        name: "Sip"
        prefix: "../../python/core/"
        files: [
            "auto_generated/3d/*",
            "auto_generated/annotations/*",
            "auto_generated/auth/*",
            "auto_generated/callouts/*",
            "auto_generated/classification/*",
            "auto_generated/diagram/*",
            "auto_generated/dxf/*",
            "auto_generated/effects/*",
            "auto_generated/expression/*",
            "auto_generated/fieldformatter/*",
            "auto_generated/geocms/*",
            "auto_generated/geocms/geonode/*",
            "auto_generated/geometry/*",
            "auto_generated/geonode/*",
            "auto_generated/gps/*",
            "auto_generated/labeling/*",
            "auto_generated/layertree/*",
            "auto_generated/layout/*",
            "auto_generated/locator/*",
            "auto_generated/mesh/*",
            "auto_generated/metadata/*",
            "auto_generated/numericformats/*",
            "auto_generated/processing/*",
            "auto_generated/processing/models/*",
            "auto_generated/providers/*",
            "auto_generated/providers/memory/*",
            "auto_generated/raster/*",
            "auto_generated/scalebar/*",
            "auto_generated/symbology/*",
            "auto_generated/textrenderer/*",
            "auto_generated/validity/*",
            "auto_generated/vectortile/*",
            "auto_generated/*",
            "conversions.sip",
            "core.sip.in",
            "core_auto.sip",
            "qgsexception.sip",
            "std.sip",
            "typedefs.sip",
        ]
        fileTags: ["sip_in"]
    }

//    Group {
//        name: "Translations"
//        prefix: "../../i18n/"
//        files: ["*.ts"]
//    }

    files: [
        "3d/*",
        "annotations/*",
        "auth/*",
        "callouts/*",
        "classification/*",
        "diagram/*",
        "dxf/*",
        "effects/*",
        "expression/*",
        "fieldformatter/*",
        "geocms/geonode/*",
        "geometry/*",
        "gps/*",
        "labeling/*",
        "layertree/*",
        "layout/*",
        "locator/*",
        "mesh/*",
        "metadata/*",
        "numericformats/*",
        "pal/*",
        "processing/models/*",
        "processing/*",
        "providers/gdal/*",
        "providers/memory/*",
        "providers/meshmemory/*",
        "providers/ogr/*",
        "raster/*",
        "scalebar/*",
        "simplify/*",
        "symbology/*",
        "textrenderer/*",
        "validity/*",
        "vectortile/*",
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

