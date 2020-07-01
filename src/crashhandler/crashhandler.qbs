import qbs
import qbs.File
import qbs.TextFile
import QbsUtl

Product {
    name: "Crashhandler"
    targetName: "crashhandler"
    condition: false

    type: "dynamiclibrary"
    destinationDirectory: "./lib"

    Depends { name: "cpp" }
    Depends { name: "cppstdlib" }
    Depends { name: "Qt"; submodules: ["core", "widgets"] }

    cpp.includePaths: [
        "./",
        //"../"
    ]

    files: [
        "*.cpp",
        "*.h",
        "*.ui",
    ]

//    cpp.defines: {
//        var def = project.cppDefines;
//        return def;
//    }

//    cpp.cxxFlags: project.cxxFlags
//    cpp.cxxLanguageVersion: project.cxxLanguageVersion



//    cpp.systemIncludePaths: QbsUtl.concatPaths(
//        Qt.core.cpp.includePaths
//    )

//    cpp.rpaths: QbsUtl.bconcatPaths(
//        cppstdlib.path,
//        "$ORIGIN/../lib"
//    )

//    cpp.libraryPaths: QbsUtl.concatPaths(
//        project.buildDirectory + "/lib",
//        cuda.libraryPath,
//        cuda.libraryPath + "/stubs"
//        //"/opt/cuda-10.0/lib64"
//    )

//    cpp.dynamicLibraries: [
//    ]
}

