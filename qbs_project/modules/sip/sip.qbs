/*****************************************************************************
  Модуль генерации header-файлов. Используется для сборки проектов изначально
  спроектированных под cmake- сборочную систему
*****************************************************************************/

import qbs
import qbs.File
import qbs.TextFile
import qbs.FileInfo
import qbs.ModUtils

Module {
    id: sip
    Depends { name: "cpp" }

    // Input
    property string baseSipFile: undefined
    property string moduleSipName: undefined
    //property string removeChunkDir: undefined
    //property string generatedFilesSubDir: "sip.gen"
    property string generatedFilesSubDir: undefined // core, gui, analysis

    // Output
    property string generatedFilesDir: {
        //return product.buildDirectory + "/" + generatedFilesSubDir;
        return project.buildDirectory + "/python/" + generatedFilesSubDir;
    }

    validate: {
        if (baseSipFile === undefined)
            throw new Error("Undefined 'baseSipFile' property");

        if (moduleSipName === undefined)
            throw new Error("Undefined 'moduleSipName' property");

        //if (removeChunkDir === undefined)
        //    throw new Error("Undefined 'removeChunkDir' property");

        if (generatedFilesSubDir === undefined)
            throw new Error("Undefined 'generatedFilesSubDir' property");

        if (!File.exists("/usr/bin/sip"))
            throw new Error("Sip generator not found. Possibly need \
                             to install packet 'python3-sip'");
    }

    FileTagger {
        patterns: "*.sip.in"
        fileTags: ["sip_in"]
    }

    FileTagger {
        patterns: "*.sip"
        fileTags: ["sip"]
    }

    Rule {
        inputs: ["sip_in"]
        outputFileTags: ["sip"]
        outputArtifacts: {
            //var removeChunkDir = ModUtils.moduleProperty(input, "removeChunkDir");
            //removeChunkDir = removeChunkDir.replace(/\.\.\\/g, "");

            var generatedFilesDir = product.sip.generatedFilesDir
            var generatedFilesSubDir = product.sip.generatedFilesSubDir

            //var removeChunkDir = product.sip.removeChunkDir;
            //removeChunkDir = project.sourceDirectory + "/" + removeChunkDir;

            var removeChunkDir = project.sourceDirectory + "/python/" + generatedFilesSubDir;

            //var inputFileDir = input.filePath.replace(input.fileName, "");
            var inputFileDir = FileInfo.path(input.filePath);
            var shortFileDir = inputFileDir.replace(removeChunkDir, "");

            return [{
                filePath: generatedFilesDir + "/" + shortFileDir + "/" + input.baseName + ".sip",
                fileTags: ["sip"],
            }];
        }

        prepare: {
            var cmd = new JavaScriptCommand();
            cmd.description = "prepare sip file";
            cmd.highlight = "codegen";
            cmd.sourceCode = function() {
                //console.info("input: " + input.filePath);
                //console.info("output: " + output.filePath);

                var inFile = new TextFile(input.filePath, TextFile.ReadOnly);
                var content = inFile.readAll();
                inFile.close();

                content = content.replace(/\${DEFAULTDOCSTRINGSIGNATURE}/g, "%DefaultDocstringSignature \"prepended\"");
                content = content.replace(/\${SIP_FINAL}/g, "final");
                content = content.replace(/@DOCSTRINGSTEMPLATE@/g, "");

                var outFile = new TextFile(output.filePath, TextFile.WriteOnly);
                outFile.write(content);
                outFile.close();
            };
            return cmd;
        }
    }

    Rule {
        multiplex: true
        inputs: ["sip"]
        outputFileTags: ["cpp", "hpp", "pyi"]
        outputArtifacts: {
            var baseSipFile = product.sip.baseSipFile;
            var moduleSipName = product.sip.moduleSipName
            var generatedFilesDir = product.sip.generatedFilesDir

            var baseSipName = FileInfo.baseName(baseSipFile);

            //console.info("sip_corepart: " + generatedFilesDir + "/sip" + moduleSipName + "part0.cpp")

            var sipCxxFlags = [
                "-Wno-deprecated-declarations",
                "-Wno-deprecated",
                "-Wno-unused-variable",
                "-Wno-switch",
                //"-Wno-unused-function",
                //"-Wno-unused-but-set-variable",
                //"-Wno-unused-parameter",
            ]

            return [{ // sip_corepart0.cpp
                filePath: generatedFilesDir + "/sip" + moduleSipName + "part0.cpp",
                fileTags: ["cpp"],
                cpp: {
                    cxxFlags: sipCxxFlags
                }
            },{
                filePath: generatedFilesDir + "/sip" + moduleSipName + "part1.cpp",
                fileTags: ["cpp"],
                cpp: {
                    cxxFlags: sipCxxFlags
                }
            },{
                filePath: generatedFilesDir + "/sip" + moduleSipName + "part2.cpp",
                fileTags: ["cpp"],
                cpp: {
                    cxxFlags: sipCxxFlags
                }
            },{
                filePath: generatedFilesDir + "/sip" + moduleSipName + "part3.cpp",
                fileTags: ["cpp"],
                cpp: {
                    cxxFlags: sipCxxFlags
                }
            },{
                filePath: generatedFilesDir + "/sip" + moduleSipName + "part4.cpp",
                fileTags: ["cpp"],
                cpp: {
                    cxxFlags: sipCxxFlags
                }
            },{
                filePath: generatedFilesDir + "/sip" + moduleSipName + "part5.cpp",
                fileTags: ["cpp"],
                cpp: {
                    cxxFlags: sipCxxFlags
                }
            },{ // sipAPI_core.h
                filePath: generatedFilesDir + "/sipAPI" + moduleSipName + ".h",
                fileTags: ["hpp"],
                cpp: {
                    cxxFlags: sipCxxFlags
                }
            },{ // core.pyi
                filePath: project.buildDirectory + "/python/" + baseSipName + ".pyi",
                fileTags: ["pyi"],
            }];
        }

        prepare: {
            var baseSipFile = product.sip.baseSipFile;
            var moduleSipName = product.sip.moduleSipName;
            var generatedFilesDir = product.sip.generatedFilesDir;

            var baseSipName = FileInfo.baseName(baseSipFile);

            // usr/bin/sip -w -e -x ANDROID -x ARM -x MOBILITY_LOCATION -n sip -t WS_X11 -t Qt_5_12_4 -g -o
            // -a /home/hkarel/CProjects/QGIS/build2/python/qgis.core.api
            // -n sip
            // -y /home/hkarel/CProjects/QGIS/build2/output/python/qgis/core.pyi
            // -j 6
            // -c /home/hkarel/CProjects/QGIS/build2/python/core
            // -I /home/hkarel/CProjects/QGIS/build2/python/core
            // -I /usr/share/sip/PyQt5
            // /home/hkarel/CProjects/QGIS/build2/python/core/core.sip

            var args = ["-w", "-e", "-g", "-o", "-j", "6", "-n", "sip"];
            args = args.concat(["-x", "ANDROID", "-x", "ARM", "-x", "MOBILITY_LOCATION"]);
            args = args.concat(["-t", "WS_X11", "-t", "Qt_5_12_4"])

            args.push("-c");
            args.push(generatedFilesDir);

            args.push("-I");
            args.push(generatedFilesDir);

            args.push("-I");
            args.push(project.buildDirectory + "/python");

            args.push("-I");
            args.push("/usr/share/sip/PyQt5");

            args.push("-y");
            //args.push(product.buildDirectory + "/" + baseSipName + ".pyi");
            args.push( project.buildDirectory + "/python/" + baseSipName + ".pyi");

            args.push(generatedFilesDir + "/" + baseSipFile);

            //File.makePath(generatedFilesDir);

            //console.info("sip: " + args)

            var cmd = new Command("/usr/bin/sip", args);
            //cmd.workingDirectory = generatedFilesDir;
            cmd.workingDirectory = project.buildDirectory + "/python";
            cmd.description = "sip code generation";
            cmd.highlight = "codegen";
            return cmd;
        }

    }
}
