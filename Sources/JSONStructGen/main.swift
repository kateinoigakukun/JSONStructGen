import Commander
import Foundation

let main = command(Argument<String>("input"),
                   Argument<String>("output"),
                   Flag("himotoki"),
                   Flag("class")) {
                    input, output, himotoki, isClass in
                    if #available(OSX 10.11, *) {
                        let currentDir = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
                        let inputPath = URL(fileURLWithPath: input, relativeTo: currentDir)
                        let outputPath = URL(fileURLWithPath: output, relativeTo: currentDir)

                        let generator = FileGenerator(input: inputPath, output: outputPath)

                        if himotoki {
                            generator.middleware = [HimotokiMiddleware()]
                        }
                        generator.isClass = isClass
                        generator.process()
                    } else {
                        // Fallback on earlier versions
                    }
}


main.run()
