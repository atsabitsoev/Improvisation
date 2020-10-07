//
//  MainViewController.swift
//  Improvisation
//
//  Created by Ацамаз Бицоев on 06.10.2020.
//

import Foundation

final class MainPresenter {
    
    private let apiService: ApiServiceProtocol
    weak private var mainViewDelegate: MainViewDelegate?
    
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    
    func setMainViewDelegate(_ delegate: MainViewDelegate) {
        mainViewDelegate = delegate
    }
    
    func selected
}
