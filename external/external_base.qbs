import qbs
import GccUtl
import QbsUtl
//import ProbExt

Product {
    type: "staticlibrary"
    //destinationDirectory: "./lib"

    Depends { name: "cpp" }
    Depends { name: "cppstdlib" }
    Depends { name: "Qt"; submodules: ["core", "network"] }

    cpp.archiverName: GccUtl.ar(cpp.toolchainPathPrefix)
//    cpp.defines: [
//        "USE_IPV6=1",
//        "TCP_SERVER_USE_EPOLL",
//        "MIN_LOGGER_LEVEL=2",
//    ]

    cpp.cxxFlags: project.cxxFlags
    cpp.cxxLanguageVersion: project.cxxLanguageVersion

    cpp.systemIncludePaths: QbsUtl.concatPaths(
        Qt.core.cpp.includePaths
    )

}
