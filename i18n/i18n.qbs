import qbs
import QbsUtl

Product {
    name: "I18n"
    condition: true

    type: "staticlibrary"
    destinationDirectory: project.buildDirectory + "/i18n"

    Depends { name: "Qt"; submodules: ["core"] }

    files: ["*.ts"]
}

