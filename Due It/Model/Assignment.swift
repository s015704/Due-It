//
//  Assignment.swift
//  Due It
//
//  Created by Annika Naveen (student LM) on 4/6/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import Foundation

class Assignment {
    
    enum priorityLevel {case high, medium, low}
    
    var name : String
    var dueDate : String
    var description : String
    var course : String
    var estTime : Double
    var priority : priorityLevel
    var isCompleted : Bool
    
    init() {
        name = "Homework"
        dueDate = "Tomorrow"
        description = "Finish the Swift app"
        course = "Comp Sci!"
        estTime = 1
        priority = .high
        isCompleted = false
    }
    
    init(name : String, dueDate : String, description : String, course : String, estTime : Double, priority : priorityLevel, isCompleted : Bool) {
        self.name = name
        self.dueDate = dueDate
        self.description = description
        self.course = course
        self.estTime = estTime
        self.priority = priority
        self.isCompleted = isCompleted
    }
    
    func complete() {
        isCompleted = true
    }
}
