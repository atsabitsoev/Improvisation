//
//  CellItemType.swift
//  Improvisation
//
//  Created by Ацамаз Бицоев on 07.10.2020.
//

enum CellItem {
    case hzCellItem(name: String, item: HzCellItem)
    case pictureCellItem(name: String, item: PictureCellItem)
    case selectorCellItem(name: String, item: SelectorCellItem)
}
