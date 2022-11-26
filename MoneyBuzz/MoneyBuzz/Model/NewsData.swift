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
/*
 import Foundation
 
 struct NewsData: Codable {
 struct Meta: Codable {
 let found: Int
 let returned: Int
 let limit: Int
 let page: Int
 }
 
 struct Data: Codable {
 struct Entity: Codable {
 struct Highlight: Codable {
 let highlight: String
 let highlightedIn: String
 
 private enum CodingKeys: String, CodingKey {
 case highlight
 case highlightedIn = "highlighted_in"
 }
 }
 
 let symbol: String
 let name: String
 let exchange: String
 let exchangeLong: String
 let country: String
 let type: String
 let industry: String
 
 private enum CodingKeys: String, CodingKey {
 case symbol
 case name
 case exchange
 case exchangeLong = "exchange_long"
 case country
 case type
 case industry
 }
 }
 
 struct Similar: Codable {
 struct Entity: Codable {
 struct Highlight: Codable {
 let highlight: String
 let highlightedIn: String
 
 private enum CodingKeys: String, CodingKey {
 case highlight
 case highlightedIn = "highlighted_in"
 }
 }
 
 let symbol: String
 let name: String
 let exchange: String
 let exchangeLong: String
 let country: String
 let type: String
 let industry: String
 
 private enum CodingKeys: String, CodingKey {
 case symbol
 case name
 case exchange
 case exchangeLong = "exchange_long"
 case country
 case type
 case industry
 }
 }
 
 let uuid: String
 let title: String
 let description: String
 let keywords: String
 let snippet: String
 let language: String
 let publishedAt: String
 let source: String
 
 private enum CodingKeys: String, CodingKey {
 case uuid
 case title
 case description
 case keywords
 case snippet
 case language
 case publishedAt = "published_at"
 case source
 }
 }
 
 let uuid: String
 let title: String
 let description: String
 let keywords: String
 let snippet: String
 let language: String
 let publishedAt: String
 let source: String
 
 private enum CodingKeys: String, CodingKey {
 case uuid
 case title
 case description
 case keywords
 case snippet
 case language
 case publishedAt = "published_at"
 case source
 }
 }
 
 let meta: Meta
 let data: [Data]
 
 }*/
/*
 import Foundation
 
 struct NewsData: Codable {
 struct MetaData: Codable {
 let title: String
 let description: String
 let published_at: String
 let source: String
 
 }
 
 
 let data: [MetaData]
 
 }
 
 struct Meta: Codable {
 let found: Int
 let returned: Int
 let limit: Int
 let page: Int
 }
 
 */





