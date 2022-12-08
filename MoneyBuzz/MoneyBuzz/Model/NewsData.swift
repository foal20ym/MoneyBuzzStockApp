//
//  NewsData.swift
//  MoneyBuzz
//
//  Created by Consid  on 2022-11-24.

import Foundation

struct NewsData: Codable, Identifiable {
    let id = UUID()
    
    struct MetaData: Codable {
        let found: Int
        let returned: Int
        let limit: Int
        let page: Int
    }
    
    struct Data: Codable {
        let title: String
        let description: String
        let published_at: String
        let source: String
        
    }
    
    let metaData: MetaData
    let data: [Data]
    
    private enum CodingKeys: String, CodingKey {
        case metaData = "meta"
        case data = "data"
    }
}
