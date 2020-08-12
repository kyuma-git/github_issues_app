//
//  ShowPageController.swift
//  github_issues_list_app
//
//  Created by kyuma.morita on 2020/07/27.
//  Copyright © 2020 kyuma.morita. All rights reserved.
//

import UIKit

class ShowPageViewController: UIViewController {
    
    @IBOutlet private weak var label: UILabel!
    private var labelText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = labelText
    }

    func setup(hoge: String) {
        labelText = hoge
    }
}
