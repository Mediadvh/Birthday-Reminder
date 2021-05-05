//
//  PersonTableViewCell.swift
//  Birthday Reminder
//
//  Created by Media Davarkhah on 1/23/1400 AP.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

   
    
    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var daysLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        picture.layer.masksToBounds = false
        picture.layer.cornerRadius = picture.frame.size.width / 2
       
        picture.clipsToBounds = true
        //contentView.backgroundColor = UIColor(named: person.tag!)

        
        // Initialization code
    }

    func configureCell(with person: Person){
        
        let tagColor = UIColor(named: person.tag ?? "tag1")
        nameLabel.text = person.name
        daysLabel.text = String("in \(person.daysTillBirth) days")
        picture.tintColor = tagColor

        
        daysLabel.textColor = tagColor
        daysLabel.text = String("in \(DateHandler.daysUntil(birthday: person.dateOfBirth!)) days 🥳")

        
        picture.layer.borderColor = tagColor?.cgColor
       
        picture.layer.borderWidth = 1
       
        if let data = person.imageData as Data?{
            picture.image = UIImage(data: data)
        }else{
            picture.image = UIImage(systemName: "person.circle.fill")
        }
     
        
        
        
     
        
        
        
    }

}
