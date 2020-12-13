//
//  LiveModel.swift
//  hololive
//
//  Created by kinositayuu on 2020/10/12.
//

import Foundation

struct LiveModel: Codable,Identifiable {

    let id: Int
    let liveId: String
    let title: String
    let thumbnailUrl: String
    let description: String
    let channelId: String
    let liveCreated: String
    let scheduledStarttime: String?
    let actualStarttime: String?
    let actualEndtime: String?
    let liveStatus: Int
    let hidden: Int
    let videoServiceId: Int
    let createdAt: String
    let updatedAt: String
    let vtuber: VTuberModel

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case liveId = "live_id"
        case title = "title"
        case thumbnailUrl = "thumbnail_url"
        case description = "description"
        case channelId = "channel_id"
        case liveCreated = "live_created"
        case scheduledStarttime = "scheduled_starttime"
        case actualStarttime = "actual_starttime"
        case actualEndtime = "actual_endtime"
        case liveStatus = "live_status"
        case hidden = "hidden"
        case videoServiceId = "video_service_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case vtuber = "vtuber"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        liveId = try values.decode(String.self, forKey: .liveId)
        title = try values.decode(String.self, forKey: .title)
        thumbnailUrl = try values.decode(String.self, forKey: .thumbnailUrl)
        description = try values.decode(String.self, forKey: .description)
        channelId = try values.decode(String.self, forKey: .channelId)
        liveCreated = try values.decode(String.self, forKey: .liveCreated)
        scheduledStarttime = try? values.decode(String.self, forKey: .scheduledStarttime)
        actualStarttime = try? values.decode(String.self, forKey: .actualStarttime)
        actualEndtime = try? values.decode(String.self, forKey: .actualEndtime)
        liveStatus = try values.decode(Int.self, forKey: .liveStatus)
        hidden = try values.decode(Int.self, forKey: .hidden)
        videoServiceId = try values.decode(Int.self, forKey: .videoServiceId)
        createdAt = try values.decode(String.self, forKey: .createdAt)
        updatedAt = try values.decode(String.self, forKey: .updatedAt)
        vtuber = try values.decode(VTuberModel.self, forKey: .vtuber)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(liveId, forKey: .liveId)
        try container.encode(title, forKey: .title)
        try container.encode(thumbnailUrl, forKey: .thumbnailUrl)
        try container.encode(description, forKey: .description)
        try container.encode(channelId, forKey: .channelId)
        try container.encode(liveCreated, forKey: .liveCreated)
        try container.encode(scheduledStarttime, forKey: .scheduledStarttime)
        try container.encode(actualStarttime, forKey: .actualStarttime)
        try container.encode(actualEndtime, forKey: .actualEndtime)
        try container.encode(liveStatus, forKey: .liveStatus)
        try container.encode(hidden, forKey: .hidden)
        try container.encode(videoServiceId, forKey: .videoServiceId)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(vtuber, forKey: .vtuber)
    }

}
