//
//  PopUpViewController.swift
//  Birthday Reminder
//
//  Created by Media Davarkhah on 12/30/1399 AP.
//

import UIKit
import Photos
import CoreData
class PopUpViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateOfBirth: UIDatePicker!
    @IBOutlet weak var tag1: UIButton!
    @IBOutlet weak var tag2: UIButton!
    @IBOutlet weak var tag3: UIButton!
    @IBOutlet weak var tag4: UIButton!
    
    enum Tags: String{
        case tag1
        case tag2
        case tag3
        case tag4
    }
    enum TagSelected{
        case tag1
        case tag2
        case tag3
        case tag4
        
    }
    var lastSelectedTag: Tags = .tag1
    var selectedTag: String = "tag1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tag1.setBackgroundImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        popUpView.layer.cornerRadius = 10
        pictureView.tintColor = Colors.tag1
        pictureView.isUserInteractionEnabled = true
    

        pictureView.layer.masksToBounds = false
       
        pictureView.layer.cornerRadius = pictureView.frame.size.width / 2
        pictureView.clipsToBounds = true
        
        pictureView.isUserInteractionEnabled = true
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addPhoto))
        singleTap.numberOfTapsRequired = 1
        pictureView.addGestureRecognizer(singleTap)

       
    }
    
    fileprivate func presentPhotoPickerController() {
        DispatchQueue.main.async {
            
        let myPickerController = UIImagePickerController()
        myPickerController.allowsEditing = true
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        
        
        
        self.present(myPickerController, animated: true)
            
        }
    }
    
    @objc func addPhoto(_ sender: UIButton) {
        
        
            DispatchQueue.main.async {
                PHPhotoLibrary.requestAuthorization { (status) in
                    switch status{
                    case .authorized:
                        self.presentPhotoPickerController()
                        
                    case .notDetermined:
                        if status == .authorized {
                            self.presentPhotoPickerController()                        }
                    
                    case .restricted:
                        let alert = UIAlertController(title: "Photo Library Resticted ", message: "Photo Library access is restricted and cannot be accessed" , preferredStyle: .alert )
                        
                        let okAction = UIAlertAction(title: "ok", style: .default)
                        
                        alert.addAction(okAction)
                        
                        self.present(alert,animated: true)
                    
                    case .denied:
                        let alert = UIAlertController(title: "Photo Library Denied ", message: "Photo Library access was previously denied. please Update your  setting if you wish to change this. " , preferredStyle: .alert )
                        
                        let goToSettingsAction = UIAlertAction(title: "Go to Settings", style: .default){(action) in
                            // has to be in main thread
                            DispatchQueue.main.async {
                                
                                let url = URL(string: UIApplication.openSettingsURLString)!
                                UIApplication.shared.open(url,options: [:])
                               
                            }
                        }// goToSettingsAction
                        
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                        alert.addAction(goToSettingsAction)
                        alert.addAction(cancelAction)
                        DispatchQueue.main.async {
                             self.present(alert,animated: true)
                        }
                       
                        //                        alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
                        
                    case .limited:
                        return
                    @unknown default:
                        return
                    } // switch
                }
                
            }// PHPhotoLibrary.requestAuthorization
        
        
        
    } // if statement
    // end of addPhoto function
    
    

    @IBAction func checkButtonTapped(_ sender: Any) {
        checkButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        // save
        guard !nameTextField.text!.isEmpty else {
            // TODO: show an alert
            return
        }
        let name = nameTextField.text!
        let person = Person(context: context)
        person.name = name
    
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
        
        person.dateOfBirth = dateOfBirth.date
        
        
        
        // TODO: calculate days left and extract it to a method
       // print(person.dateOfBirth)
        
        person.tag = lastSelectedTag.rawValue
        
       // TODO: save the image
//        guard let data = pictureView.image?.pngData() else {
//            do{
//                try context.save()
//            }
//            catch{
//                // TODO: alert
//            }
//            return
//        }
//        
//        DataBaseHelper.shareInstance.saveImage(data: data)
//            
        do{
           try context.save()
        }
        catch{
            // TODO: alert
        }
        
        
       dismiss(animated: true, completion: nil)
      
        print(person.dateOfBirth as Any)
    }
    
    
    @IBAction func xButtonTapped(_ sender: Any) {
        
        xButton.setBackgroundImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
    
   
    
//    @objc func tagTapped(selectedTag: String){
//        
//        switch lastSelectedTag {
//        case .tag1:
//            tag1.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
//        case .tag2:
//            tag2.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
//        case .tag3:
//            tag3.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
//        case .tag4:
//            tag4.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
//        }
//        
//        switch selectedTag{
//        case "tag1":
//            tag1.setBackgroundImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
//            lastSelectedTag = .tag1
//        case "tag2":
//            tag2.setBackgroundImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
//            lastSelectedTag = .tag2
//        case "tag3":
//            tag3.setBackgroundImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
//            lastSelectedTag = .tag3
//        case "tag4":
//            tag4.setBackgroundImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
//            lastSelectedTag = .tag4
//        default:
//            return
//        }
//        
//        
//    }
    

    @IBAction func tag1Tapped(_ sender: Any) {


        switch lastSelectedTag {
        case .tag1:
            return
        case .tag2:
            tag2.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
        case .tag3:
            return
        case .tag4:
            tag4.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
        }

        tag1.setBackgroundImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        lastSelectedTag = .tag1
        pictureView.tintColor = Colors.tag1
    }
    @IBAction func tag2Tapped(_ sender: Any) {


        switch lastSelectedTag {
        case .tag1:
            tag1.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
        case .tag2:
           return
        case .tag3:
            tag3.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
        case .tag4:
            tag4.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
        }
        tag2.setBackgroundImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        lastSelectedTag = .tag2
        pictureView.tintColor = Colors.tag2
    }
    @IBAction func tag3Tapped(_ sender: Any) {


        switch lastSelectedTag {
        case .tag1:
            tag1.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
        case .tag2:
            tag2.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
        case .tag3:
            return
        case .tag4:
            tag4.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
        }
        tag3.setBackgroundImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        lastSelectedTag = .tag3
        pictureView.tintColor = Colors.tag3
        

    }
    @IBAction func tag4Tapped(_ sender: Any) {

        switch lastSelectedTag {
        case .tag1:
            tag1.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
        case .tag2:
            tag2.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
        case .tag3:
            tag3.setBackgroundImage(UIImage(systemName: "square.fill"), for: .normal)
       
        case .tag4:
            return
        }

        tag4.setBackgroundImage(UIImage(systemName: "checkmark.seal.fill"), for: .normal)
        lastSelectedTag = .tag4
        pictureView.tintColor = Colors.tag4
    }

    

}
extension PopUpViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            
            self.pictureView.image = image
            
            
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            self.pictureView.image = image
        }
        
        presentedViewController?.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}
