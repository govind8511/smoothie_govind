//
//  FeedDataDecoder.swift
//  Smoothie
//
//  Created by User on 21/06/22.
//

import Foundation

struct FeedDataDecoder
{
    static func decodeFeedBundleJson() -> FeedsData {
        let feedJson = Bundle.main.path(forResource: "FeedData", ofType: "json")
        let feeds = try! Data(contentsOf: URL(fileURLWithPath: feedJson!), options: .alwaysMapped)
        return try! JSONDecoder().decode(FeedsData.self, from: feeds)
    }
}
