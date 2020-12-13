//
//  FunVideoListModel.swift
//  hololive
//
//  Created by kinositayuu on 2020/10/27.
//

import Foundation

struct FunVideoListModel: Codable {
    
    let currentPage: Int
    let data: [FunVideoListItemModel]
    let from: Int
    let lastPage: Int
    let total: Int
    
    private enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data = "data"
        case from = "from"
        case lastPage = "last_page"
        case total = "total"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currentPage = try values.decode(Int.self, forKey: .currentPage)
        data = try values.decode([FunVideoListItemModel].self, forKey: .data)
        from = try values.decode(Int.self, forKey: .from)
        lastPage = try values.decode(Int.self, forKey: .lastPage)
        total = try values.decode(Int.self, forKey: .total)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(currentPage, forKey: .currentPage)
        try container.encode(data, forKey: .data)
        try container.encode(from, forKey: .from)
        try container.encode(lastPage, forKey: .lastPage)
        try container.encode(total, forKey: .total)
    }
    
}

struct FunVideoListItemModel: Codable,Identifiable {
    
    let id: Int
    let videoId: String
    let title: String
    let thumbnailUrl: String
    let description: String
    let videoCreated: String
    let hidden: Int
    let videoServiceId: Int
    let createdAt: String
    let updatedAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case videoId = "video_id"
        case title = "title"
        case thumbnailUrl = "thumbnail_url"
        case description = "description"
        case videoCreated = "video_created"
        case hidden = "hidden"
        case videoServiceId = "video_service_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        videoId = try values.decode(String.self, forKey: .videoId)
        title = try values.decode(String.self, forKey: .title)
        thumbnailUrl = try values.decode(String.self, forKey: .thumbnailUrl)
        description = try values.decode(String.self, forKey: .description)
        videoCreated = try values.decode(String.self, forKey: .videoCreated)
        hidden = try values.decode(Int.self, forKey: .hidden)
        videoServiceId = try values.decode(Int.self, forKey: .videoServiceId)
        createdAt = try values.decode(String.self, forKey: .createdAt)
        updatedAt = try values.decode(String.self, forKey: .updatedAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(videoId, forKey: .videoId)
        try container.encode(title, forKey: .title)
        try container.encode(thumbnailUrl, forKey: .thumbnailUrl)
        try container.encode(description, forKey: .description)
        try container.encode(videoCreated, forKey: .videoCreated)
        try container.encode(hidden, forKey: .hidden)
        try container.encode(videoServiceId, forKey: .videoServiceId)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
    }
    
}
