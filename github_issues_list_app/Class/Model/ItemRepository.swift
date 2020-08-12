//
//  ItemRepository.swift
//  github_issues_list_app
//
//  Created by kyuma.morita on 2020/08/11.
//  Copyright © 2020 kyuma.morita. All rights reserved.
//

import Foundation
import Alamofire

// ドメイン知識なので、Model・Domain層に置く
class ItemRepository {
    func fetch(completion: @escaping ([TopViewModel.CellData]) -> Void) {
        let url: String = "http://localhost:3000/issues/index"
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let issue = try? JSONDecoder().decode([TopViewModel.CellData].self, from: data)
                completion(issue!)
            case .failure(let error):
                print("error happened!!")
                print(error)
            }
        }
    }
}
