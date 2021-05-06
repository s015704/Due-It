//
//  Assignment.swift
//  Due It
//
//  Created by Annika Naveen (student LM) on 4/6/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import Foundation

class Assignment {
    
    let id = UUID()
    var name : String
    var dueDate : Date
    var description : String
    var course : String
    var estTime : Double
    var timeLeft : Double
    var timePerDay : Double
    var priority : Double
    var isCompleted : Bool
    var workDoneToday : Bool
    var timeForNextDay : Double
    
    init() {
        name = ""
        dueDate = Date()
        description = ""
        course = ""
        estTime = 0
        timeLeft = 0
        timePerDay = 0
        priority = 1
        isCompleted = false
        workDoneToday=false
        timeForNextDay=0
    }
    
    init(name : String, dueDate : Date, description : String, course : String, estTime : Double, priority : Double, isCompleted : Bool, workDoneToday: Bool, timeForNextDay: Double) {
        self.name = name
        self.dueDate = dueDate
        self.description = description
        self.course = course
        self.estTime = estTime
        self.timeLeft = Double(estTime)
        self.timePerDay = 0
        self.priority = priority
        self.isCompleted = isCompleted
        self.workDoneToday = workDoneToday
        self.timeForNextDay = timeForNextDay
    }
    
    func isEmpty(_field:String) -> Bool {
        return _field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var validNameText: String {
        if !isEmpty(_field: name) {
            return ""
        } else {
            return "You must enter a name for the assignment"
        }
    }
    
}
