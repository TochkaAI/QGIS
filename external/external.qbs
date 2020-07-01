import qbs
import QbsUtl
import "external_base.qbs" as ExtBase

Project {
    name: "External"

    ExtBase {
        id: astyle
        name: "Astyle"
        targetName: "astyle"

        property var exportIncludePaths: [
            "astyle",
        ]
        cpp.includePaths: exportIncludePaths

        files: [
            "astyle/*.сpp",
            "astyle/*.h",
        ]

        Export {
            Depends { name: "cpp" }
            cpp.includePaths: product.exportIncludePaths
        }
    }

    ExtBase {
        id: inja
        name: "Inja"
        targetName: "inja"

        property var exportIncludePaths: [
            "inja",
        ]
        cpp.includePaths: exportIncludePaths

        files: [
            "inja/*.сpp",
            "inja/*.h",
        ]

        Export {
            Depends { name: "cpp" }
            cpp.includePaths: product.exportIncludePaths
        }
    }

    ExtBase {
        id: kdbush
        name: "Kdbush"
        targetName: "kdbush"

        property var exportIncludePaths: [
            "kdbush/include",
        ]
        cpp.includePaths: exportIncludePaths

        files: [
            "kdbush/include/*.hpp"
        ]

        Export {
            Depends { name: "cpp" }
            cpp.includePaths: product.exportIncludePaths
        }
    }

    ExtBase {
        id: dxfrw
        name: "LibDxfrw"
        targetName: "dxfrw"

        Depends { name: "Core" }

        cpp.cxxFlags: base.concat([
            "-Wno-duplicated-branches",
        ])

        property var exportIncludePaths: [
            "libdxfrw",
        ]
        cpp.includePaths: exportIncludePaths.concat([
            "../src/core",
        ])

        files: [
            "libdxfrw/intern/*.cpp",
            "libdxfrw/intern/*.h",
            "libdxfrw/*.cpp",
            "libdxfrw/*.h"
        ]

        Export {
            Depends { name: "cpp" }
            cpp.includePaths: product.exportIncludePaths
        }
    }

    ExtBase {
        id: mdal
        name: "Mdal"
        targetName: "mdal"

        cpp.defines: base.concat([
             "HAVE_HDF5",
             "HAVE_GDAL",
             "HAVE_NETCDF",
             "HAVE_XML",
        ])

        property var exportIncludePaths: [
            "mdal",
            "mdal/api",
        ]
        cpp.includePaths: exportIncludePaths.concat([
            "/usr/include/hdf5/serial",
            "/usr/include/libxml2",
            "/usr/include/gdal",
            project.buildDirectory,
        ])

        files: [
            "mdal/api/*.h",
            "mdal/frmts/*.cpp",
            "mdal/frmts/*.hpp",
            "mdal/*.cpp",
            "mdal/*.hpp"
        ]

        Export {
            Depends { name: "cpp" }
            cpp.includePaths: product.exportIncludePaths
        }
    }

    ExtBase {
        id: mesh_optimizer
        name: "MeshOptimizer"
        targetName: "mesh_optimizer"

        property var exportIncludePaths: [
            "meshOptimizer",
        ]
        cpp.includePaths: exportIncludePaths.concat([])

        files: [
            "meshOptimizer/simplifier.cpp",
            "meshOptimizer/meshoptimizer.h",
        ]

        Export {
            Depends { name: "cpp" }
            cpp.includePaths: product.exportIncludePaths
        }
    }

    ExtBase {
        id: nlohmann
        name: "Nlohmann"
        targetName: "nlohmann"

        property var exportIncludePaths: [
            ".",
            "nlohmann",
        ]
        cpp.includePaths: exportIncludePaths

        files: [
            "nlohmann/detail/conversions/*.hpp",
            "nlohmann/detail/input/*.hpp",
            "nlohmann/detail/iterators/*.hpp",
            "nlohmann/detail/meta/*.hpp",
            "nlohmann/detail/output/*.hpp",
            "nlohmann/detail/*.hpp",
            "nlohmann/*.hpp",
        ]

        Export {
            Depends { name: "cpp" }
            cpp.includePaths: product.exportIncludePaths
        }
    }

    ExtBase {
        id: nmea
        name: "Nmea"
        targetName: "nmea"

        property var exportIncludePaths: [
            "nmea",
        ]
        cpp.includePaths: exportIncludePaths

        files: [
            "nmea/*c",
            "nmea/*h",
        ]

        Export {
            Depends { name: "cpp" }
            cpp.includePaths: product.exportIncludePaths
        }
    }

//    ExtBase {
//        id: o2
//        name: "O2"
//        targetName: "o2"

//        property var exportIncludePaths: [
//            "o2",
//        ]
//        cpp.includePaths: exportIncludePaths

//        files: [
//            "o2/src/*.cpp",
//            "o2/src/*.h",
//        ]

//        Export {
//            Depends { name: "cpp" }
//            cpp.includePaths: product.exportIncludePaths
//        }
//    }

    // opencl-clhpp

    ExtBase {
        id: poly2tri
        name: "Poly2tri"
        targetName: "poly2tri"

        property var exportIncludePaths: [
            "poly2tri",
            //"../../external"
        ]
        cpp.includePaths: exportIncludePaths

        files: [
            "poly2tri/common/*.cc",
            "poly2tri/common/*.h",
            "poly2tri/sweep/*.cc",
            "poly2tri/sweep/*.h",
            "poly2tri/*.cc",
            "poly2tri/*.h"
        ]

        Export {
            Depends { name: "cpp" }
            cpp.includePaths: product.exportIncludePaths
        }
    }

    ExtBase {
        id: qt3dextra_headers
        name: "Qt3dExtraHeaders"
        targetName: "qt3dextra_header"

        Depends { name: "Qt"; submodules: ["concurrent", "gui", "widgets"] }

        property var exportIncludePaths: [
            "qt3dextra-headers",
        ]
        cpp.includePaths: exportIncludePaths

        cpp.systemIncludePaths : base.concat([])

        files: [
            "qt3dextra-headers/*.h"
        ]

        Export {
            Depends { name: "cpp" }
            cpp.includePaths: product.exportIncludePaths
        }
    }

    ExtBase {
        id: qt_unix_signals
        name: "QtUnixSignals"
        targetName: "qt_unix_signals"

        property var exportIncludePaths: [
            "qt-unix-signals",
        ]
        cpp.includePaths: exportIncludePaths

        cpp.systemIncludePaths : base.concat([])

        files: [
            "qt-unix-signals/sigwatch.cpp",
            "qt-unix-signals/sigwatch.h",
        ]

        Export {
            Depends { name: "cpp" }
            cpp.includePaths: product.exportIncludePaths
        }
    }

    ExtBase {
        id: qwtpolar
        name: "QwtPolar"
        targetName: "qwtpolar"

        Depends { name: "Qt"; submodules: ["concurrent", "gui", "widgets", "printsupport"] }

        property var exportIncludePaths: [
            "qwtpolar",
        ]
        cpp.includePaths: exportIncludePaths

        cpp.systemIncludePaths : base.concat([
            "/usr/include/qwt",
        ])

        files: [
            "qwtpolar-1.1.1/*.cpp",
            "qwtpolar-1.1.1/*.h"
        ]

        Export {
            Depends { name: "cpp" }
            cpp.includePaths: product.exportIncludePaths
        }
    }

    ExtBase {
        id: rtree
        name: "Rtree"
        targetName: "rtree"

        property var exportIncludePaths: [
            "rtree/include",
        ]
        cpp.includePaths: exportIncludePaths

        files: [
            "rtree/include/RTree.h",
        ]

        Export {
            Depends { name: "cpp" }
            cpp.includePaths: product.exportIncludePaths
        }
    }

} // Project
