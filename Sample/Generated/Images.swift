//
//  Images.swift
//
//  Generated by JSONStructGen

class Images {
   var recommendedUrl: String
   var facebook: Facebook
   var twitter: Twitter
}

//   HimotokiMiddleware

import Himotoki
extension Images: Decodable {
   static func decode(_ e: Extractor) throws -> Images {
       return self.init(
           recommendedUrl: e <| "recommended_url",
           facebook: e <| "facebook",
           twitter: e <| "twitter"
       )
   }
}