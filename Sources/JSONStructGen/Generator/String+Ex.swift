//
//  String+Ex.swift
//  JSONStructGen
//
//  Created by SaitoYuta on 2017/04/27.
//
//

import Foundation

extension String {
    var first: String {
        return String(characters.prefix(1))
    }
    func camelCased(upper: Bool) -> String {
        let camelCasedString = capitalized.replacingOccurrences(of: "_", with: "")
        if upper { return camelCasedString }
        return first.lowercased() + String(camelCasedString.characters.dropFirst())
    }
}
