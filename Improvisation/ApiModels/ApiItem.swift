//
//  ApiItemData.swift
//  Improvisation
//
//  Created by Ацамаз Бицоев on 06.10.2020.
//

import Foundation


enum ApiItem: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        switch ApiItemType(rawValue: name) {
        case .hz:
            let hzData = try container.decode(HzData.self, forKey: .data)
            self = .hzItem(name: ApiItemType(rawValue: name) ?? ApiItemType.unknown, data: hzData)
        case .picture:
            let pictureData = try container.decode(PictureData.self, forKey: .data)
            self = .pictureItem(name: ApiItemType(rawValue: name) ?? ApiItemType.unknown, data: pictureData)
        case .selector:
            let selectorData = try container.decode(SelectorData.self, forKey: .data)
            self = .selectorItem(name: ApiItemType(rawValue: name) ?? ApiItemType.unknown, data: selectorData)
        default:
            self = .unknown
        }
    }
    
    case hzItem(name: ApiItemType, data: HzData)
    case pictureItem(name: ApiItemType, data: PictureData)
    case selectorItem(name: ApiItemType, data: SelectorData)
    case unknown
    
    enum CodingKeys: String, CodingKey {
        case name
        case data
    }
}
