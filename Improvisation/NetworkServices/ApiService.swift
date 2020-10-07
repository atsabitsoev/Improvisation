//
//  ApiService.swift
//  Improvisation
//
//  Created by Ацамаз Бицоев on 06.10.2020.
//

import Alamofire


final class ApiService: ApiServiceProtocol {
    
    func getMainApiModel(_ handler: @escaping (MainApiModel?, String?) -> ()) {
        
        let url = "https://pryaniky.com/static/json/sample.json"
        AF
            .request(url)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                
                case .success:
                    guard let responseData = response.data else {
                        handler(nil, "Неизвестная ошибка")
                        return
                    }
                    do {
                        let mainApiModel = try JSONDecoder().decode(MainApiModel.self, from: responseData)
                        handler(mainApiModel, nil)
                    } catch {
                        handler(nil, error.localizedDescription)
                    }
                    
                    
                case .failure(let error):
                    let errorString = error.localizedDescription
                    print(errorString)
                    handler(nil, errorString)
                }
            }
    }
}


