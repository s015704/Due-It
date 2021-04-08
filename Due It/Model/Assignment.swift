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
        name = ""
        dueDate = ""
        description = ""
        course = ""
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
    
    func isEmpty(_field:String) -> Bool {
        return _field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var validNameText: String {
        if !isEmpty(_field: name) {
            return ""
        } else {
            return "Enter the assignment name"
        }
    }
    
    var validCourseText: String {
        if !isEmpty(_field: course) {
            return ""
        } else {
            return "Enter a course"
        }
    }
}
