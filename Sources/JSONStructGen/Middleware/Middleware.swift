//
//  Middleware.swift
//  JSONStructGen
//
//  Created by SaitoYuta on 2017/04/27.
//
//

import Foundation

protocol Middleware {
    var header: String { get }
    var middlewareName: String { get }
    func generate(parser: StructParser) -> String
}

extension Middleware {
    var middlewareName: String {
        return String(describing: type(of: self))
    }
    var header: String {
        let br = "\n"
        return    br
                + br
                + "//   \(self.middlewareName)"
                + br
    }
}
