//
//  ViewController.swift
//  github_issues_list_app
//
//  Created by kyuma.morita on 2020/07/23.
//  Copyright © 2020 kyuma.morita. All rights reserved.
//

import UIKit

struct CellData: Decodable {
    let title: String
    let state: String
    let body: String
    let html_url: String
}

//struct IssueResult: Decodable {
//    let results: [CellData]
//}

class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    let api = ItemRepository()
 
    private var tableDataSources: [CellData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(self)
        tableView.delegate = self
        tableView.dataSource = self
//
        fetch()
    }

    func fetch() {
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
//        tableView.deselectRow(at: indexPath, animated: true)
//        performSegue(withIdentifier: "toNextViewController", sender: nil)
    }
}

// extensionでViewControllerクラスをUITableViewDataSourceプロトコルに適合（準拠宣言）させている
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        print(tableDataSources[indexPath.row].title)
        cell.textLabel?.text = tableDataSources[indexPath.row].title
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(tableDataSources.count)
        return tableDataSources.count
    }
}

import Alamofire

//private let session: Session = {
//    let manager = ServerTrustManager(evaluators: ["http://localhost:3000/": DisabledTrustEvaluator()])
//    let configuration = URLSessionConfiguration.af.default
//
//    return Session(configuration: configuration, serverTrustManager: manager)
//}()

class ItemRepository {
    func fetch(completion: @escaping ([CellData]) -> Void) {
        let url: String = "http://localhost:3000/issues/index"
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
//            debugPrint(response)
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let issue = try? JSONDecoder().decode([CellData].self, from: data)
                completion(issue!)
            case .failure(let error):
                print("error happened!!")
                print(error)
            }
        }
    }
}
