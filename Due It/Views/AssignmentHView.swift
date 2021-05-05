//
//  AssignmentHView.swift
//  Due It
//
//  Created by Alexander Bullard (student LM) on 4/30/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import SwiftUI

struct workDay: Identifiable{
    let id=UUID()
    var work: [workPiece]
}
struct workPiece: Identifiable{
    let id=UUID()
    var part:(index: Int, dailyTime: Double)
}
struct weekDay: Identifiable{
    let id=UUID()
    let day: Date
}
struct AssignmentHView: View {
    @Environment(\.calendar) var calendar
    @Binding var dailyWorkingTime : Double
    @Binding var curAssignments : [Assignment]
    @Binding var weekWork : [[(index: Int, dailyTime: Double)]]
    var workDays: [workDay] {
        var arr:[workDay]=[workDay]()
        var work:[workPiece]=[workPiece]()
        for i in 0..<weekWork.count{
            for j in 0..<weekWork[i].count{
                work.append(workPiece(part: weekWork[i][j]))
            }
            arr.append(workDay(work: work))
            work=[workPiece]()
        }
        return arr
    }
    var weekdays : [Date] {
        var arr : [Date] = []
        for i in 0..<7 {
            var addComponents = DateComponents()
            addComponents.day = i
            arr+=[Calendar.current.date(byAdding: addComponents, to: Date())!]
        }
        return arr
    }
    
    var body: some View {
        List(weekdays, id:\.self) { weekDay in
            Text(self.getDate(self.splitDate(weekDay)).prefix(3))
                .font(.largeTitle).padding(.init(top: 50, leading: 0, bottom: 50, trailing: 0))
            if self.curAssignments.count != 0 && self.indexOfWeek(weekDay)<self.workDays.count{
                List(self.workDays[self.indexOfWeek(weekDay)].work, id:\.id){ workPiece in
                    Button(action: {
                        print(self.weekWork)
                        print(self.workDays)
                    }){
                        if self.curAssignments.count != 0 && self.workDays[self.indexOfWeek(weekDay)].work.count != 0 {
                            Text("\(self.curAssignments[workPiece.part.index].name): \(String(format: "%.0f", workPiece.part.dailyTime.rounded(.down))) hrs \(String(format: "%.0f", (workPiece.part.dailyTime-workPiece.part.dailyTime.rounded(.down))*60)) min")
                        } else {
                            Text("")
                        }
                    }
                }
            }
        }
    }
    
    func indexOfWeek(_ date :Date) -> Int{        
        for i in 0..<weekdays.count{
            if self.calendar.compare(date, to: weekdays[i], toGranularity: .day) == .orderedSame{
                //print("\(date) = \(weekdays[i])")
                return i
            }
        }
        print("ERROR")
        return 0
    }
    
    // getDate method - Simon fix
    func getDate(_ strDate: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let theDate = dateFormatter.date(from: strDate)
        return theDate?.dayofTheWeek ?? ""
    }
    
    // Splits date from "2020-01-01 05:00:00 +0000" to simply "2020-01-01"
    func splitDate(_ date: Date) -> String {
        let words = date.description.components(separatedBy: " ")
        let firstWord = words[0]
        return firstWord
    }
    
}

struct AssignmentHView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentHView(dailyWorkingTime: Binding.constant(0), curAssignments: Binding.constant([]), weekWork: Binding.constant([[(index: 0, dailyTime: 0.2)]]))
    }
}

extension Date {
    
    var dayofTheWeek: String {
        let dayNumber = Calendar.current.component(.weekday, from: self)
        // day number starts from 1 but array count from 0
        return daysOfTheWeek[dayNumber - 1]
    }
    
    private var daysOfTheWeek: [String] {
        return  ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    }
}

