//
//  ToDoTableViewCell.swift
//  ToDoAppAnderson
//
//  Created by Melissa Anderson on 10/18/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var toDoTitleLabel: UILabel!
    @IBOutlet weak var toDoTextLabel: UILabel!
    @IBOutlet weak var toDoDateLabel: UILabel!
    @IBOutlet weak var toDoDate1Label: UILabel!
    
    
    
    
    weak var toDo: ToDo!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setupCell(_ toDo: ToDo){
        self.toDo = toDo
        toDoTitleLabel.text = toDo.title
        toDoDateLabel.text = toDo.dateString
        toDoDate1Label.text = toDo.dateString
        
        
        
        
    }
    
}
