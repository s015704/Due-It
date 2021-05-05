//
//  AssignmentHView.swift
//  Due It
//
//  Created by Alexander Bullard (student LM) on 4/30/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import SwiftUI

struct AssignmentHView: View {
    
    @Binding var dailyWorkingTime : Double
    @Binding var curAssignments : [Assignment]
    @Binding var weekWork : [[(index: Int, dailyTime: Double)]]
    var today : [(index: Int, dailyTime: Double)] {
        weekWork[0]
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
        List {
            
            Text(getDate(splitDate(weekdays[0])))
                .font(.largeTitle)
            List(0..<weekWork[0].count) {i in
                Button(action: {
                    print(self.weekWork[0])
                }){
                    if self.curAssignments.count != 0 && self.today[0].index != -1 {
                        Text("\(self.curAssignments[self.today[0].index].name) \(self.today[0].dailyTime)")
                    } else {
                        Text("")
                    }
                }
            }
        }
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

