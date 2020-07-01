import qbs
import qbs.File
import qbs.TextFile
import "qbs/imports/QbsUtl/qbsutl.js" as QbsUtl

Project {
    name: "QGIS"

    minimumQbsVersion: "1.15.1"
    qbsSearchPaths: ["qbs", "qbs_project"]

    readonly property var projectVersion: projectProbe.projectVersion
    readonly property string projectGitRevision: projectProbe.projectGitRevision
    readonly property string headgenTemplate: projectProbe.headgenTemplate

    Probe {
        id: projectProbe
        property var projectVersion;
        property string projectGitRevision;
        property string headgenTemplate;

        readonly property string projectBuildDirectory:  project.buildDirectory
        readonly property string projectSourceDirectory: project.sourceDirectory

        configure: {
            projectVersion = QbsUtl.getVersions(projectSourceDirectory + "/VERSION");
            projectGitRevision = QbsUtl.gitRevision(projectSourceDirectory);
            //if (File.exists(projectBuildDirectory + "/package_build_info"))
            //    File.remove(projectBuildDirectory + "/package_build_info")

            headgenTemplate = projectSourceDirectory + "/qbs_project/headgen.tmpl";

            File.makePath(projectBuildDirectory);

            var qgsvers = new TextFile(projectBuildDirectory + "/qgsversion.h" , TextFile.WriteOnly);
            qgsvers.write("// Dummy file, required for compatibility with CMAKE build system\n");
            qgsvers.close();

            var mdalcfg = new TextFile(projectBuildDirectory + "/mdal_config.hpp" , TextFile.WriteOnly);
            mdalcfg.write("// Dummy file, required for compatibility with CMAKE build system\n");
            mdalcfg.close();
        }
    }


    property var cppDefines: {
        var def = [
//            "KDIFF3_VERSION_STRING=\"" + projectVersion[0] + "\"",
//            "KDIFF3_VERSION_MAJOR=" + projectVersion[1],
//            "KDIFF3_VERSION_MINOR=" + projectVersion[2],
//            "KDIFF3_VERSION_PATCH=" + projectVersion[3],
            "PROJ_VERSION_MAJOR=6", // Версия библиотеки proj
            "ACCEPT_USE_OF_DEPRECATED_PROJ_API_H",
            "TEST_DATA_DIR=\"tests\/testdata\"",
            "QGSVERSION=\"" + projectGitRevision + "\"",
            "QGS_GIT_REMOTE_URL=\"https://github.com/qgis/QGIS.git\"",

        ];

        if (qbs.buildVariant === "release") {
            def.push("NDEBUG");
        }
        else {
            def.push("QGISDEBUG");
        }

        return def;
    }

    property var cxxFlags: {
        var cxx = [
            "-Wall",
            "-Wextra",
            "-Wno-trigraphs",
            "-Wduplicated-cond",
            "-Wduplicated-branches",
            "-Wno-empty-body",
            "-Wno-misleading-indentation",
            "-Wno-redundant-move",
            "-Wno-duplicated-branches", // Это потом удалить
            //"-Wshadow",
            //"-Wno-non-virtual-dtor",
            //"-Wno-long-long",
            //"-pedantic",
        ];
        if (qbs.buildVariant === "debug")
            cxx.push("-ggdb3");
        else
            cxx.push("-s");

        //if (project.conversionWarnEnabled)
        //    cxx.push("-Wconversion");

        return cxx;
    }
    property string cxxLanguageVersion: "c++14"

    property var dynamicLibraries: [
        "pthread",
        "OpenCL",
        "exiv2",
        "gdal",
        "gsl",
        "qwt-qt5",
        "qca-qt5",
        "gslcblas",
        "qscintilla2_qt5",
        "qt5keychain",
        "protobuf-lite",
        "spatialindex",
        "zip",
        "python3.8",
        //"fl",
    ]

    references: [
        "src/3d/3d.qbs",
        "src/app/app.qbs",
        "src/app/qgis.qbs",
        "src/core/core.qbs",
        "src/gui/gui.qbs",
        "src/analysis/analysis.qbs",
        "src/crashhandler/crashhandler.qbs",
        "external/external.qbs",
        "src/native/native.qbs",
        "src/python/python.qbs",
        "src/ui/ui.qbs",
        "i18n/i18n.qbs",
        //"src/server/server.qbs",
    ]
}

/*
--- Нужные пакеты ---
protobuf-compiler
libprotobuf-dev
libgdal-dev
opencl-clhpp-headers
ocl-icd-opencl-dev
flex
libfl-dev // flex dev
bison
libbison-dev
libzip-dev
poppler-utils
libqt5serialport5-dev
qtpositioning5-dev
libqt5webkit5-dev
qttools5-dev
libqca-qt5-2-dev
libqca-qt5-2-plugins
libgsl-dev
pyqt5-dev-tools
pyqt5.qsci-dev
libexiv2-dev
python3-sip
python3-sip-dev
python3-pyqt5
python3-pyqt5.qtsql
python3-pyqt5.qtwebkit
python3-pyqt5.qsci
python3-owslib
python3-jinja2
libspatialindex-dev
qt5keychain-dev
opencl-c-headers
libqscintilla2-qt5-dev
libqwt-qt5-dev
qtdeclarative5-private-dev
libpython3.8-dev
qt3d5-dev  (включает пакет libqt53drender5)
*/
