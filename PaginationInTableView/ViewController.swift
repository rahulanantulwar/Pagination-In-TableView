//
//  ViewController.swift
//  PaginationInTableView
//
//  Created by Rahul Anantulwar on 1/4/19.
//  Copyright © 2019 Rahul Anantulwar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tbl: UITableView!
    var limit = 30
    let totalNumberOfRecords  = 150
    var arrRecords = [Int]()
    var index = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.delegate = self
        tbl.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        while index < limit {
            arrRecords.append(index)
            index = index + 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tbl.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = String(arrRecords[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == arrRecords.count - 1 {
            if arrRecords.count < totalNumberOfRecords {
                index = arrRecords.count
                limit = limit + 20
                while index < limit {
                    arrRecords.append(index)
                    index = index + 1
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
            }
           
        }
    }
    
    @objc func loadTable() {
        self.tbl.reloadData()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

