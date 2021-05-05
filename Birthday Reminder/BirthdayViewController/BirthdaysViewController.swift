//
//  ViewController.swift
//  Birthday Reminder
//
//  Created by Media Davarkhah on 12/30/1399 AP.
//

import UIKit
//TODO: delegate pattern to update tableview

class BirthdaysViewController: UIViewController {
    
   
    let dbHelper = DataBaseHelper()
    var personList = [Person]()
    let vc = PopUpViewController()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPopUpSegue"{
            let popUp = segue.destination as! PopUpViewController
            popUp.popUpDelegate = self
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        personList = dbHelper.fetchAll()
        
    }

    
}

extension BirthdaysViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return personList.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell") as! PersonTableViewCell
        cell.configureCell(with: personList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "") { [self] (contextualAction, view, actionPerformed :@escaping (Bool) -> Void) in
            let personToDelete = personList[indexPath.row]
            //TODO: show an alert to make sure this wasn't a mistake
            let delete = UIAlertAction(title: "delete", style: .destructive) { (alert) in
                // delete selected row
                dbHelper.delete(personList[indexPath.row])
                personList.remove(at: indexPath.row)
                // remove it from the row
                tableView.deleteRows(at: [indexPath], with: .automatic)
                actionPerformed(true)
            }
            let cancel = UIAlertAction(title: "cancel", style: .default) { (alert) in
                dismiss(animated: true, completion: nil)
                actionPerformed(false)
            }
            let alert = UIAlertController(title: "Delete \(personToDelete.name ?? "person")", message: "Are you sure you want to delete \(personToDelete.name ?? "person")?", preferredStyle: .alert)
            
            alert.addAction(delete)
            alert.addAction(cancel)
            // show alert
            present(alert, animated: true, completion: nil)
    
            
        }
        deleteAction.image = UIImage(systemName: "xmark.bin")
        
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeAction
    }
    
}
extension BirthdaysViewController: PopUpViewControllerDelegate{
    // protocol stub
    func reloadData() {
        personList = dbHelper.fetchAll()
        tableView.reloadData()
        print("reloadData executed")
    }
}
