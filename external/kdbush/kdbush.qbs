import qbs
import GccUtl

Product {
    name: "Kdbush"
    targetName: "kdbush"

    type: "staticlibrary"

    Depends { name: "cpp" }

    cpp.cxxFlags: project.cxxFlags

//    cpp.includePaths: [src]
//    property var exportIncludePaths: [
//        "./",
//        "./include"
//    ]
//    cpp.includePaths: exportIncludePaths

    files: [
        "./include/kdbush.hpp"
    ]

    Export {
        Depends { name: "cpp" }
        cpp.includePaths: ["include"]
    }
}
