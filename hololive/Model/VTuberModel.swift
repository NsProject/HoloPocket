//
//  VTuberModel.swift
//  hololive
//
//  Created by kinositayuu on 2020/10/01.
//

import Foundation


struct VTuberModel: Codable,Identifiable {

    let id: Int
    let name: String
    let channelId: String
    let niconicoId: String?
    let iconUrl: String
    let twitterId: String
    let liveHashtag: String?
    let playlistId: String
    let subChannelId: String?
    let subPlaylistId: String?
    let belongId: Int
    let status: Int
    let hidden: Int
    let createdAt: String
    let updatedAt: String

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case channelId = "channel_id"
        case niconicoId = "niconico_id"
        case iconUrl = "icon_url"
        case twitterId = "twitter_id"
        case liveHashtag = "live_hashtag"
        case playlistId = "playlist_id"
        case subChannelId = "sub_channel_id"
        case subPlaylistId = "sub_playlist_id"
        case belongId = "belong_id"
        case status = "status"
        case hidden = "hidden"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        channelId = try values.decode(String.self, forKey: .channelId)
        niconicoId = try? values.decode(String.self, forKey: .niconicoId)
        iconUrl = try values.decode(String.self, forKey: .iconUrl)
        twitterId = try values.decode(String.self, forKey: .twitterId)
        liveHashtag = try? values.decode(String.self, forKey: .liveHashtag)
        playlistId = try values.decode(String.self, forKey: .playlistId)
        subChannelId = try? values.decode(String.self, forKey: .subChannelId)
        subPlaylistId = try? values.decode(String.self, forKey: .subPlaylistId)
        belongId = try values.decode(Int.self, forKey: .belongId)
        status = try values.decode(Int.self, forKey: .status)
        hidden = try values.decode(Int.self, forKey: .hidden)
        createdAt = try values.decode(String.self, forKey: .createdAt)
        updatedAt = try values.decode(String.self, forKey: .updatedAt)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(channelId, forKey: .channelId)
        try container.encode(niconicoId, forKey: .niconicoId)
        try container.encode(iconUrl, forKey: .iconUrl)
        try container.encode(twitterId, forKey: .twitterId)
        try container.encode(liveHashtag, forKey: .liveHashtag)
        try container.encode(playlistId, forKey: .playlistId)
        try container.encode(subChannelId, forKey: .subChannelId)
        try container.encode(subPlaylistId, forKey: .subPlaylistId)
        try container.encode(belongId, forKey: .belongId)
        try container.encode(status, forKey: .status)
        try container.encode(hidden, forKey: .hidden)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
    }

}
