/*****************************************************************************
  Модуль генерации header-файлов. Используется для сборки проектов изначально
  спроектированных под cmake- сборочную систему
*****************************************************************************/

import qbs
import qbs.TextFile

Module {
    id: headgen

    // Input
    property string headerName: undefined
    property string templateHeaderPath: undefined
    property string generatedFilesSubDir: "head.gen"

    // Output
    property string generatedFilesDir: {
        return product.buildDirectory + "/" + generatedFilesSubDir;
    }
    property string generatedHeaderPath: {
        return product.headgen.generatedFilesDir + "/" + headerName;
    }

    PropertyOptions {
        name: "headerName"
        description: "Наименование генерируемого header-файла"
    }
    PropertyOptions {
        name: "templateHeaderPath"
        description: "Полное наименование шаблона header-файла"
    }
    PropertyOptions {
        name: "generatedFilesDir"
        description: "Директория расположения сгенерированного header-файла"
    }
    PropertyOptions {
        name: "generatedHeaderPath"
        description: "Полное наименование сгенерированного header-файла"
    }

    validate: {
        if (headerName === undefined)
            throw new Error("Undefined 'headerName' property");

        if (templateHeaderPath === undefined)
            throw new Error("Undefined 'templateHeaderPath' property");
    }

    Group {
        name: "HeaderGen"
        files: [product.headgen.templateHeaderPath]
        fileTags: ["headgen"]
    }
    //FileTagger {
    //    patterns:
    //    fileTags: ["headgen"]
    //}

    Rule {
        inputs: ["headgen"]
        //outputFileTags: ["hpp"]
        //outputArtifacts: {
        //    return [{
        //        filePath: product.headgen.generatedHeaderPath,
        //        fileTags: ["hpp"],
        //    }];
        //}

        Artifact {
            filePath: product.headgen.generatedHeaderPath
            fileTags: ["hpp"]
        }

        prepare: {
            var cmd = new JavaScriptCommand();
            cmd.description = "header generation (" + product.headgen.headerName + ")";
            cmd.highlight = "codegen";
            cmd.sourceCode = function() {
                var productName = product.name
                var productTargetName = product.targetName

                var inFile = new TextFile(input.filePath, TextFile.ReadOnly);
                var content = inFile.readAll();
                inFile.close();

                content = content.replace(/%PRODUCT_NAME%/g, productName.toUpperCase());
                content = content.replace(/%TARGET_NAME%/g,  productTargetName);

                var outFile = new TextFile(product.headgen.generatedHeaderPath, TextFile.WriteOnly);
                outFile.write(content);
                outFile.close();
            };
            return cmd;
        }
    }
}
