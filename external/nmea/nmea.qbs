import qbs
import GccUtl

Product {
    name: "Nmea"
    targetName: "nmea"

    type: "staticlibrary"

    Depends { name: "cpp" }

    cpp.cxxFlags: project.cxxFlags

//    cpp.includePaths: [src]
    property var exportIncludePaths: [
        "./",
    ]
    cpp.includePaths: exportIncludePaths

    files: [
        "*.c",
        "*.h"
    ]

    Export {
        Depends { name: "cpp" }
        cpp.includePaths: product.exportIncludePaths
    }
}
