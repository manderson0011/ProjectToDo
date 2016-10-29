//
//  ImageViewController.swift
//  ToDoAppAnderson
//
//  Created by Melissa Anderson on 10/19/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var ImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = ToDoStore.shared.selectedImage {
            ImageView.image = image
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func close(_ sender: AnyObject) {
        ToDoStore.shared.selectedImage = nil
        dismiss(animated: true, completion: nil)
    }
    
}

