//
//  ApiServiceProtocol.swift
//  Improvisation
//
//  Created by Ацамаз Бицоев on 06.10.2020.
//

import Foundation

protocol ApiServiceProtocol {
    func getMainApiModel(_ handler: @escaping (MainApiModel?, String?) -> ())
}
