//
//  ToDo.swift
//  ToDoAppAnderson
//
//  Created by Melissa Anderson on 10/18/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//

import UIKit

// must write two functions to fix this error for nscoding
class ToDo: NSObject, NSCoding{
    var title = ""
    var date = Date()
    var image: UIImage? // optional image
    var category = 0
    var dueDate = Date()
    var completion = false
    var priority = 0.0
    
    
    let titleKey = "title"
    let dateKey = "date"
    let imageKey = "image"
    let categoryKey = "category"
    let dueDateKey = "dueDate"
    let completionKey = "completion"
    let priorityKey = "priority"
    
    
    // archive our own classes .. by making a function to do this
    var dateString:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        return dateFormatter.string(from: dueDate)
    }
    
    
    override init(){
        super.init()
    }
    
    
    init(title: String, category: Int, dueDate: Date, completion: Bool, priority: Double){
        // self is the scope of this class
        self.title = title
        self.category = category
        self.dueDate = dueDate
        self.completion = completion
        self.priority = priority
        
        
    }
    
    required init?(coder aDecoder: NSCoder){
        self.title = aDecoder.decodeObject(forKey: titleKey)as! String
        self.date = aDecoder.decodeObject(forKey: dateKey)as! Date
        self.image = aDecoder.decodeObject(forKey: imageKey)as? UIImage
        self.category = aDecoder.decodeInteger(forKey: categoryKey)
        self.dueDate = aDecoder.decodeObject(forKey: dueDateKey)as! Date
        self.completion = aDecoder.decodeBool(forKey: completionKey)
        self.priority = aDecoder.decodeDouble(forKey: priorityKey)
        
        
    }
    func encode( with aCoder: NSCoder){
        aCoder.encode(title, forKey:titleKey)
        aCoder.encode(date, forKey: dateKey)
        aCoder.encode(image, forKey: imageKey)
        aCoder.encode(category, forKey: categoryKey)
        aCoder.encode(dueDate, forKey: dueDateKey)
        aCoder.encode(completion, forKey: completionKey)
        aCoder.encode(priority, forKey: priorityKey)
        
    }
    
    
    
    
}
