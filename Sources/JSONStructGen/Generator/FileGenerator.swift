//
//  FileGenerator.swift
//  JSONStructGen
//
//  Created by SaitoYuta on 2017/04/26.
//
//

import Foundation
import SwiftyJSON

class FileGenerator {
    var inputFilePath: URL
    var outputFilePath: URL
    var middleware: [Middleware]

    init(input: URL, output: URL, middleware: [Middleware] = []) {
        if #available(OSX 10.11, *) {
            inputFilePath = input
            outputFilePath = output
            self.middleware = middleware
            
        } else {
            fatalError("Shoud be greater than 10.11")
        }
    }

    func process() {
        let rootParser = StructParser(structName: "Root", json: readFile())
        let subParsers = rootParser.childParsers
        let allParsers = [rootParser] + subParsers

        allParsers.forEach { parser in

            var code = ""
            code += parser.header
            code += parser.generate()
            code += middleware.reduce("") { code, middleware in
                let header = middleware.header
                return header + code + "\n" + middleware.generate(parser: parser)
            }

            try! code.write(to: outputFilePath.appendingPathComponent(parser.fileName),
                            atomically: true, encoding: .utf16)
        }
    }


    func readFile() -> JSON {
        guard let data = try? String(contentsOf: inputFilePath) else {
            fatalError("file is empty")
        }
        return JSON(parseJSON: data)
        
    }
}
