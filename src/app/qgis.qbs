import qbs
import QbsUtl

Product {
    name: "QGis"
    targetName: "qgis"
    condition: true

    type: "application"
    destinationDirectory: "./bin"

    Depends { name: "cpp" }
    Depends { name: "cppstdlib" }
    Depends { name: "Nlohmann" }
    Depends { name: "Core" }
    Depends { name: "Gui" }
    Depends { name: "App" }
    Depends { name: "Ui" }
    Depends { name: "I18n" }
    Depends { name: "QtUnixSignals" }
    Depends { name: "Qt"; submodules: [
        "core", "network", "gui", "widgets", "concurrent", "xml", "sql", "svg",
        "dbus", "3dcore", "3drender", "3dinput", "qml", "quick"] }

    cpp.defines: project.cppDefines.concat([])
    cpp.cxxFlags: project.cxxFlags.concat(["-fPIC"])
    cpp.cxxLanguageVersion: project.cxxLanguageVersion

    cpp.systemIncludePaths: QbsUtl.concatPaths(
        Qt.core.cpp.includePaths
       ,"/usr/include/gdal"
       ,"/usr/include/Qca-qt5/QtCrypto"
       ,"/usr/include/qt5keychain"
    )

    cpp.rpaths: QbsUtl.concatPaths(
        cppstdlib.path
       ,"$ORIGIN/../lib"
    )

    cpp.libraryPaths: QbsUtl.concatPaths(
        "/usr/lib/x86_64-linux-gnu"
       ,project.buildDirectory + "/lib"
    )

    cpp.dynamicLibraries: project.dynamicLibraries

    files: [
        "main.cpp",
    ]

//    excludeFiles: [
//        "main.cpp",
//        "mainwin.cpp",
//        "qtmain_android.cpp",
//    ]
}

