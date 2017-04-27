//
//  Node.swift
//  JSONStructGen
//
//  Created by SaitoYuta on 2017/04/26.
//
//

import Foundation

indirect enum Node {
    case string(String)
    case number(Int)
    case boolean(Bool)
    case null
    case array([Node])
    case custom(StructParser)
}
extension Node {
    var typeName: String {
        switch self {
        case .string:
            return "String"
        case .number:
            return "Int"
        case .boolean:
            return "Bool"
        case .null:
            return "Optional<Any>"
        case .array(let node):
            guard let nodeType = node.first?.typeName else {
                fatalError("Array has no element")
            }
            return "Array<\(nodeType)>"
        case .custom(let structParser):
            return structParser.structName
        }
    }
}
