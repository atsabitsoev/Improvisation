//
//  SelectorData.swift
//  Improvisation
//
//  Created by Ацамаз Бицоев on 06.10.2020.
//

import Foundation


struct SelectorData: Decodable {
    var selectedId: Int
    var variants: [SelectorVariant]
}

struct SelectorVariant: Decodable {
    var id: Int
    var text: String
}
