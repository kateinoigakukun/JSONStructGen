import Foundation
import SwiftyJSON

class StructParser {

    var json: JSON
    let structName: String
    var properties: [Property] = []

    var header: String {
        let br = "\n"
        return "//" + br
             + "//  \(fileName)" + br
             + "//" + br
             + "//  Generated by JSONStructGen" + br + br
    }

    var fileName: String {
        return "\(structName).swift"
    }

    init(structName: String, json: JSON) {
        self.structName = structName.camelCased(upper: true)
        self.json = json
        parseJSON(json: json)
    }

    private func parseJSON(json: JSON) {
        switch json.type {
        case .bool, .null,
             .string, .number,
             .unknown, .array:
            fatalError()
        case .dictionary:
            self.properties = dictionaryParse(dictionary: json)
        }
    }
    func generate() -> String {

        let br = "\n"
        var code = ""
        code += "struct \(structName) {" + br
        properties.forEach { property in
            code += "   var \(property.key): \(property.value.typeName)" + br
        }
        code += "}"
        return code
    }

    private func arrayParse(array: JSON, key: String) -> Node {
        if array.type != .array { fatalError() }
        
        let array = array.arrayValue.map { (json: JSON) -> Node in
            switch json.type {
            case .array:
                return arrayParse(array: json, key: key)
            case .bool:
                return Node.boolean(json.boolValue)
            case .dictionary:
                return Node.custom(StructParser(structName: key, json: json))
            case .null:
                return Node.null
            case .number:
                return Node.number(json.intValue)
            case .string:
                return Node.string(json.stringValue)
            case .unknown: fatalError()
            }
        }

        return Node.array(array)
    }

    private func dictionaryParse(dictionary: JSON) -> [Property] {
        if dictionary.type != .dictionary { fatalError() }

        let properties = dictionary.dictionaryValue.map { (key: String, value: JSON) -> Property in
            switch value.type {
            case .array:
                return Property(key: key, value: arrayParse(array: value, key: key))
            case .bool:
                return Property(key: key, value: Node.boolean(value.boolValue))
            case .dictionary:
                return Property(key: key, value: Node.custom(StructParser(structName: key, json: value)))
            case .null:
                return Property(key: key, value: Node.null)
            case .number:
                return Property(key: key, value: Node.number(value.intValue))
            case .string:
                return Property(key: key, value: Node.string(value.stringValue))
            case .unknown: fatalError()
            }
        }

        return properties
    }
}

extension StructParser {
    var childParsers: [StructParser] {
        var child = properties.flatMap { (property: Property) -> StructParser? in
            switch property.value {
            case .custom(let parser):
                return parser
            case .array(let node):
                guard let firstNode = node.first else { return nil }
                guard case let .custom(type) = firstNode else {
                    return nil
                }
                return type
            default: return nil
            }
        }

        child.forEach {
            child += $0.childParsers
        }

        return child
    }
}
