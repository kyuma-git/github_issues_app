//
//  ViewController.swift
//  github_issues_list_app
//
//  Created by kyuma.morita on 2020/07/23.
//  Copyright © 2020 kyuma.morita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    let api = ItemRepository()
 
    private var tableDataSources: [CellData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadCellData()
    }

    private func loadCellData() {
        api.fetch(completion: { [weak self] e in
            self?.tableDataSources = e
            self?.tableView.reloadData()
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let controller = segue.destination as? ShowPageViewController,
            let index = tableView.indexPathForSelectedRow else { return }
        controller.setup(hoge: tableDataSources[index.row].title)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected! \(indexPath.row)")
    }
}

// extensionでViewControllerクラスをUITableViewDataSourceプロトコルに適合（準拠宣言）させている
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableDataSources[indexPath.row].title
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataSources.count
    }
}
