//
//  SelectorCellItem.swift
//  Improvisation
//
//  Created by Ацамаз Бицоев on 07.10.2020.
//

import Foundation

struct SelectorCellItem {
    
    struct SelectorVariantItem {
        var id: Int
        var text: String
    }
    
    
    var selectedId: Int
    var variants: [SelectorVariantItem]
}
