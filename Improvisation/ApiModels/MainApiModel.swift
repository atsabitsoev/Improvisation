//
//  MainApiModel.swift
//  Improvisation
//
//  Created by Ацамаз Бицоев on 06.10.2020.
//

import Foundation


struct MainApiModel: Decodable {
    var data: [ApiItem]
    var view: [ApiItemType]
}
