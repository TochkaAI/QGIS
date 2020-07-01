/*****************************************************************************
  Вспомогательный модуль генерации cpp-кода

*****************************************************************************/

import qbs
import qbs.File
import qbs.TextFile

Module {
    id: funchelp

    // Input
    property string generatedFilesSubDir: "funchelp.gen"

    // Output
    property string generatedFilesDir: {
        return product.buildDirectory + "/" + generatedFilesSubDir;
    }
    property string generatedTextsPath: {
        return product.funchelp.generatedFilesDir + "/qgsexpression_texts.cpp";
    }

    validate: {
        var processFunctionTemplate = project.sourceDirectory + "/scripts/process_function_template.py";
        if (!File.exists(processFunctionTemplate))
            throw new Error("Script not found: " + processFunctionTemplate);
    }

    //FileTagger {
    //    patterns:
    //    fileTags: ["headgen"]
    //}

    Rule {
        multiplex: true
        inputs: ["funchelp"]

        Artifact {
            filePath: product.funchelp.generatedTextsPath
            fileTags: ["cpp"]
        }

        prepare: {
            var generatedFilesDir = product.funchelp.generatedFilesDir;
            var generatedTextsPath = product.funchelp.generatedTextsPath;
            var processFunctionTemplate = project.sourceDirectory + "/scripts/process_function_template.py";

            var args = [];
            args.push(processFunctionTemplate);
            args.push(generatedTextsPath);

            File.makePath(generatedFilesDir);

            //console.info("funchelp: " + args)

            var cmd = new Command("/usr/bin/python3", args);
            cmd.workingDirectory = project.sourceDirectory;
            cmd.description = "funchelp code generation";
            cmd.highlight = "codegen";
            return cmd;
        }
    }
}
