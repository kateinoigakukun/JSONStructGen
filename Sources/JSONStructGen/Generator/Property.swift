//
//  Property.swift
//  JSONStructGen
//
//  Created by SaitoYuta on 2017/04/26.
//
//

import Foundation

struct Property {
    var key: String
    var rawKey: String
    var value: Node

    init(key: String, value: Node) {
        self.key = key.camelCased(upper: false)
        self.rawKey = key
        self.value = value
    }
}
