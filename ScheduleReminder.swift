//
//  ScheduleReminder.swift
//  ToDoAppAnderson
//
//  Created by Melissa Anderson on 10/30/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//

import Foundation
import UserNotifications
import UserNotificationsUI




class ScheduleReminderViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    
    var isGrantedNotificationAccess:Bool = false
    
    @IBAction func notification(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var scheduleReminder: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert,.sound,.badge],
            completionHandler: { (granted,error) in
                self.isGrantedNotificationAccess = granted
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func scheduleNotification(_ sender: UIButton) {
        if isGrantedNotificationAccess{
            let content = UNMutableNotificationContent()
            content.title = "Reminder To Do Item"
            content.subtitle = "From ToDo App"
            content.body = "Seize The Day!!"
            content.categoryIdentifier = "message"
            content.userInfo = ["customData": "customInfo"]
            content.sound = UNNotificationSound.default()
            
            var dateComponents = DateComponents()
            dateComponents.hour = 10
            dateComponents.minute = 30
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(
                identifier: "scheduleNoticication",
                content: content,
                trigger: trigger
            )
            UNUserNotificationCenter.current().add(
                request, withCompletionHandler: nil)
        }
        
        
        
        //MARK: - LOCAL NOTIFICATION FUNCTION
        func registerLocal() {
            let center = UNUserNotificationCenter.current()
            
            center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                if granted {
                    print("Yay")
                    
                }else{
                    print("Boo")
                }
                
            }
        }
       
//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "scheduleToDoSegue" {
//    _ = segue.destination as! ScheduleReminderViewController
//        
//        
        
        
    
        }
    }
