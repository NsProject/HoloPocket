//
//  VTuberListModel.swift
//  hololive
//
//  Created by kinositayuu on 2020/10/01.
//

import Foundation

struct VTuberListModel: Codable {

    let currentPage: Int
    let data: [VTuberModel]
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
        data = try values.decode([VTuberModel].self, forKey: .data)
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
