//
//  ViewController.swift
//  Birthday Reminder
//
//  Created by Media Davarkhah on 12/30/1399 AP.
//

import UIKit

class BirthdaysViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
// 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
      
    }

    
}

extension BirthdaysViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell")
        
        return cell!
    }
    
    
    
}
