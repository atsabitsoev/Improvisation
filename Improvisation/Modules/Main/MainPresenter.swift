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
    
    func viewDidLoad() {
        
        fetchMainApiModel()
    }
    
    func setMainViewDelegate(_ delegate: MainViewDelegate) {
        mainViewDelegate = delegate
    }
    
    func actionDone(item: CellItem) {
        let message = getAlertMessage(from: item)
        mainViewDelegate?.alert(title: "Событие инициировано", message: message)
    }
    
    
    private func fetchMainApiModel() {
        apiService.getMainApiModel { [weak self] (mainApiModel, errorString) in
            guard let self = self else { return }
            guard let mainApiModel = mainApiModel else {
                self.mainViewDelegate?.alert(title: "Ошибка", message: errorString ?? "Что-то пошло не так...")
                return
            }
            
            let apiItems = mainApiModel.view.compactMap { (apiItemType) -> ApiItem? in
                return mainApiModel.data.first { (apiItem) -> Bool in
                    switch apiItem {
                    case .hzItem:
                        return apiItemType == .hz
                    case .pictureItem:
                        return apiItemType == .picture
                    case .selectorItem:
                        return apiItemType == .selector
                    case .unknown:
                        return false
                    }
                }
            }
            
            let cellItems = self.getCellItems(from: apiItems)
            
            self.mainViewDelegate?.setNewItems(cellItems)
        }
    }
    
    private func getCellItems(from apiItems: [ApiItem]) -> [CellItem] {
        let cellItems = apiItems.compactMap { (apiItem) -> CellItem? in
            switch apiItem {
            case .hzItem(name: let name, data: let hzData):
                return CellItem.hzCellItem(
                    name: name.rawValue,
                    item: HzCellItem(text: hzData.text)
                )
            case .pictureItem(name: let name, data: let pictureData):
                return CellItem.pictureCellItem(
                    name: name.rawValue,
                    item: PictureCellItem(text: pictureData.text,
                                          url: pictureData.url
                    )
                )
            case .selectorItem(name: let name, data: let selectorData):
                let variants = selectorData.variants.map { (apiVariant) -> SelectorCellItem.SelectorVariantItem in
                    return SelectorCellItem.SelectorVariantItem(id: apiVariant.id, text: apiVariant.text)
                }
                return CellItem.selectorCellItem(name: name.rawValue, item: SelectorCellItem(selectedId: selectorData.selectedId, variants: variants))
            case .unknown:
                return nil
            }
        }
        return cellItems
    }
    
    private func getAlertMessage(from item: CellItem) -> String {
        var name: String = ""
        var additionalMessage = ""
        switch item {
        case .selectorCellItem(name: let selectorName, item: let selectorCellItem):
            name = selectorName
            additionalMessage = "Выбранный id в селекторе: \(selectorCellItem.selectedId)"
        case .hzCellItem(name: let hzName, item: _):
            name = hzName
        case .pictureCellItem(name: let pictureName, item: _):
            name = pictureName
        }
        let message = additionalMessage.isEmpty ? "Объект с названием \(name)" : "Объект с названием \(name)" + "\n" + additionalMessage
        return message
    }
}
