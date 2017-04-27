//
//  Himotoki.swift
//  JSONStructGen
//
//  Created by SaitoYuta on 2017/04/27.
//
//

import Foundation

struct HimotokiMiddleware: Middleware {
    func generate(parser: StructParser) -> String {
        var code = ""
        let br = "\n"
        code += "import Himotoki" + br
        code += "extension \(parser.structName): Decodable {" + br
        code += "   static func decode(_ e: Extractor) throws -> \(parser.structName) {" + br
        code += "       return self.init(" + br
        let initializer = parser.properties.map { (property: Property) -> String in
            switch property.value {
            case .array:
                return "           \(property.key): e <|| \"\(property.rawKey)\""
            case .null:
                return "           \(property.key): e <|? \"\(property.rawKey)\""
            default:
                return "           \(property.key): e <| \"\(property.rawKey)\""
            }
        }.joined(separator: "," + br)
        code += initializer + br
        code += "       )" + br
        code += "   }" + br
        code += "}"
        
        
        return code
    }
}

