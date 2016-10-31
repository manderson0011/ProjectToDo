//
//  ToDoDetailViewController.swift
//  ToDoTakingAppAnderson
//
//  Created by Melissa Anderson on 10/18/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//

import UIKit
import UserNotifications


//links the fields to this class
class ToDoDetailViewController: UIViewController  {
    @IBOutlet weak var toDoTitleField: UITextField!
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var completionSwitch: UISwitch!
    
    
    
    var gestureRecognizer: UITapGestureRecognizer!
    
    var toDo = ToDo()
    
    override func viewDidLoad() {
        
        
        //covers if the toDo is edited or added to show completion
        completionSwitch.isOn = toDo.completion
        toDoTitleField.text = toDo.title
        
        
        
        //category edit to do item
        
        if let image = toDo.image {
            ImageView.image = image
            addGestureRecognizer()
        }else{
            ImageView.isHidden = true
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewImage))
        ImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    func viewImage() {
        if let image = ImageView.image {
            ToDoStore.shared.selectedImage = image
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageNavController")
            present(viewController, animated: true, completion: nil)
        }
    }
    fileprivate func showPicker(_ type: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        toDo.title = toDoTitleField.text!
        toDo.date = Date()
        toDo.image = ImageView.image
        toDo.category = categoryPicker.selectedRow(inComponent: 0)
        toDo.dueDate = myDatePicker.date
        toDo.completion = completionSwitch.isOn
        
    }
    
    // MARK: - IBActions
    @IBAction func choosePhoto(_ sender: AnyObject) {
        
        let alert = UIAlertController(title: "Picture", message: "Choose a picture type", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler:
            { (action) in self.showPicker(.camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler:
            { (action) in self.showPicker(.photoLibrary)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    //Mark: - Date Picker
    
    @IBAction func datePickerAction(_ sender: AnyObject) {
        
    }
    
}
// can copy this and use over and over
//Mark: - Image Picker
extension ToDoDetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        //copied from slack ->
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            let maxSize: CGFloat = 512
            let scale = maxSize/image.size.width
            let newHeight = image.size.height * scale
            
            UIGraphicsBeginImageContext(CGSize(width: maxSize, height: newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width: maxSize, height: newHeight))
            let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            ImageView.image = resizeImage
            
            ImageView.isHidden = false
            
            if gestureRecognizer != nil {
                ImageView.removeGestureRecognizer(gestureRecognizer)
            }
            addGestureRecognizer()
        }
        
        
    }
}

//Mark: - UIPickerView delegate and data source
extension ToDoDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "Home"
        }else if row == 1 {
            return "Work"
        }
        return "Misc"
    }
}


