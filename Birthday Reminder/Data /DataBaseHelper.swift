//
//  DataFetcher.swift
//  Birthday Reminder
//
//  Created by Media Davarkhah on 1/8/1400 AP.
//
import UIKit
import CoreData
import Photos

class DataBaseHelper {
    
    let notifcationsHandler = LocalNotifications()
    
    static let shareInstance = DataBaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    
    func addPerson(_ name:String,_ dateOfBirth: Date,_ imageData : UIImage,_ tag: String){
        
        let person = Person(context: context)
        person.name = name
        person.dateOfBirth = dateOfBirth
        notifcationsHandler.makeNotification(with: "Today is \(person.name!) birthday", with: "got their present?"  , with: person.dateOfBirth!)
     
      
        
        let daysleft = DateHandler.daysUntil(birthday: dateOfBirth)
        
        
        person.daysTillBirth = Int64(daysleft)
        person.imageData = imageData.pngData() as Data?
        person.tag = tag
       
        
        do {
            try context.save()
        }
        catch{
            print("an error has occured!")
        }
        
    }
    
    func fetchAll()->[Person]{
        
        var personList = [Person]()
       
        let request = Person.fetchRequest() as NSFetchRequest<Person>
        request.returnsObjectsAsFaults = false
       
        do {
            personList = try context.fetch(request)
        }
        catch{
            print("couldn't fetch data")
            return personList
        }
        
        return personList
    }
    
    func delete(_ person: Person){
        // delete
        context.delete(person)
        do{
          try context.save()
        }
        catch{
            
        }
    }
}


