import qbs
import qbs.TextFile

Product {
    name: "PackageBuild"

    Depends { name: "cpp" }
    Depends { name: "cppstdlib" }
    Depends { name: "Qt"; submodules: ["core", "network", "sql"] }

    /** Код оставлен для примера **
    Depends { name: "lib.opencv" }
    Depends { name: "lib.caffe" }

    lib.ffmpeg.version: project.ffmpegVersion
    lib.ffmpeg.dynamicLibraries: [
        "avdevice",
        "avfilter",
    ]

    lib.opencv.version: project.opencvVersion
    lib.opencv.dynamicLibraries: project.opencvDynamicLibraries

    lib.pylon.version: project.baslerPylonVersion
    lib.pylon.dynamicLibraries: project.pylonDynamicLibraries

    lib.caffe.prefix: project.caffePrefix
    lib.caffe.version: project.caffeVersion
    lib.caffe.dynamicLibraries: project.caffeDynamicLibraries
    Properties {
        condition: (qbs.architecture.startsWith("arm") === true)
        lib.caffe.dynamicLibraries: []
    } */

    Probe {
        id: productProbe
        property string projectBuildDirectory: project.buildDirectory
        property string cppstdlibPath: cppstdlib.path
        property var qt: Qt

        /** Код оставлен для примера **
        property var libs: [
            lib.ffmpeg,
            lib.opencv,
            lib.caffe
        ] */

        configure: {
            var file = new TextFile(projectBuildDirectory + "/package_build_info", TextFile.WriteOnly);
            try {
                /** Код оставлен для примера **
                for (var n in libs) {
                    var lib = libs[n];
                    for (var i in lib.dynamicLibraries) {
                        file.writeLine(lib.libraryPath + ("/lib{0}.so*").format(lib.dynamicLibraries[i]));
                    }
                }
                // Копируем все so-фалы для Pylon
                file.writeLine(libPylon.libraryPath + "/*.so*");
                */

                if (!cppstdlibPath.startsWith("/usr/lib", 0)) {
                    file.writeLine(cppstdlibPath + "/" + "libstdc++.so*");
                    file.writeLine(cppstdlibPath + "/" + "libgcc_s.so*");
                }

                var libFiles = []
                libFiles.push(qt.core.libFilePathRelease);
                libFiles.push(qt.network.libFilePathRelease);
                libFiles.push(qt.sql.libFilePathRelease);
                libFiles.push(qt.core.libPath + "/libicui18n.so.56");
                libFiles.push(qt.core.libPath + "/libicuuc.so.56");
                libFiles.push(qt.core.libPath + "/libicudata.so.56");

                for (var i in libFiles)
                    file.writeLine(libFiles[i].replace(/\.so\..*$/, ".so*"));
            }
            finally {
                file.close();
            }
        }
    }
}
