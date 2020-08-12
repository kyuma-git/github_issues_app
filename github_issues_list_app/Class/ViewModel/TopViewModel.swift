//
//  CellDataEntity.swift
//  github_issues_list_app
//
//  Created by kyuma.morita on 2020/08/11.
//  Copyright © 2020 kyuma.morita. All rights reserved.
//

import Foundation

// UIと関係しない表示ロジックをここに置く
class TopViewModel {
    // Cellに渡すデータ項目を定義
    struct CellData: Decodable {
        let title: String
        let state: String
        let body: String
        let html_url: String
    }
}
