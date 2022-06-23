//
//  Feeds.swift
//  Smoothie
//
//  Created by User on 21/06/22.
//

import Foundation
// Feeds Response Model when we fetched information
struct Feeds : Decodable
{
    let item_type : String
    let data: String
    let description: String
}

struct FeedsData : Decodable
{
    let data: [Feeds]
}

enum FeedType : String   {
    case video = "video"
    case url = "url"
    case image = "image"
    case text = "text"
}
