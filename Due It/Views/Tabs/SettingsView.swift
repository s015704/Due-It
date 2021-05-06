//
//  SettingsView.swift
//  Due It
//
//  Created by Workflow Team on 3/11/21.
//  Copyright © Workflow. All rights reserved.
//  You can adjust Daily working time and log out here.

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct SettingsView: View {
    @Environment(\.calendar) var calendar
    @EnvironmentObject var userInfo: UserInfo
    @State var user: UserViewModel
    @Binding var dailyWorkingTime : Double
    @Binding var weekWork : [[(index: Int, dailyTime: Double)]]
    @Binding var curAssignments : [Assignment]
    
    var body: some View {
        
      
        VStack {
            Image("logo")
            Text(self.user.fullname).autocapitalization(.none)
            
            Stepper(value: $dailyWorkingTime, in: 0...24, step: 0.25) {
                Text("Available Daily Working Time:               \(dailyWorkingTime, specifier: "%g") hrs")
                    .font(.body).font(.system(size: 25))
            }.padding([.leading, .trailing], 30)
            
            Button(action: {
                self.getWorkForWeek()
            }) {
                Text("Update Daily Time")
                    .frame(width: 200)
                    .padding(.vertical, 15)
                    .background(Color("Auxillary2"))
                    .cornerRadius(8)
                    .foregroundColor(.black)
            }.padding(.bottom, 20)
            
            Button(action: {
                try! Auth.auth().signOut()
                self.userInfo.configureFirebaseStateDidChange()
            }) {
                Text("Log Out")
                    .frame(width: 200)
                    .padding(.vertical, 15)
                    .background(Color("Auxillary1"))
                    .cornerRadius(8)
                    .foregroundColor(.black)
            }
        }
    }
    
    
    // Calculates the days between 2 dates
    func daysBetween(_ start: Date, _ end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    // Gets all timePerDay for every assignment regardless of how much time there is per day or the priority
    func getAllTimePerDay(_ date: Date) -> [(Int, Double)] {
        
        // index = index of the assignment in the curAssignments array, dailyTime = timePerDay of each of those curAssignments
        var arr : [(index: Int, dailyTime: Double)] = []
        var addComponents = DateComponents()
        addComponents.day = 1
        addComponents.hour = -4
        let tomorrow = Calendar.current.date(byAdding: addComponents, to: Date())
        
        
        for i in 0..<curAssignments.count {
            if daysBetween(date, curAssignments[i].dueDate)<13&&daysBetween(date, curAssignments[i].dueDate)>=0&&curAssignments[i].timeForNextDay>0.01 {
                curAssignments[i].timePerDay = curAssignments[i].timeForNextDay/(Double(daysBetween(date, curAssignments[i].dueDate))+1)
                curAssignments[i].timePerDay = ((curAssignments[i].timePerDay*12).rounded(.up))/12    // intervals by 5 minutes
                arr+=[(index: i, dailyTime: curAssignments[i].timePerDay)]
            } else if self.calendar.compare(curAssignments[i].dueDate, to: tomorrow!, toGranularity: .day) == .orderedSame&&curAssignments[i].timeForNextDay>0.01{
                curAssignments[i].timePerDay = curAssignments[i].timeForNextDay
                arr+=[(index: i, dailyTime: curAssignments[i].timePerDay)]
            } else {
            }
        }
        return arr
    }
    
    // When assigning work for a day, it decreases the time left whenever it's called
    func getWorkForDay(_ date : Date) -> [(Int, Double)] {
        
        // index = index of the assignment in the curAssignments array, dailyTime = timePerDay of each of those curAssignments
        let arr : [(index: Int, dailyTime: Double)] = getAllTimePerDay(date)  // Adds every single assigment with its intended time per day to the array
        var arrReturn : [(index: Int, dailyTime: Double)] = []
        
        print(arr)
        // Doles out assignment time based on the working time for that day
        var totalTime : Double = 0
        if arr.count != 0{

            if dailyWorkingTime <= arr[0].dailyTime {    // if the dailyWorkingTime is less than the daily time required for the first assignment
                totalTime = dailyWorkingTime    // fills the dailyWorkingTime completely with the one assignment due soonest
                arrReturn+=[(arr[0].index, arr[0].dailyTime)]
                if curAssignments[0].workDoneToday == false{
                curAssignments[arr[0].index].timeForNextDay-=dailyWorkingTime
                    //curAssignments[arr[0].index].workDoneToday=true
                }// takes away that much time left for the first assignment !!!!!!
            } else {    // if there's time for this first assignment's daily time and possibly more
                var k = 0
                while k<arr.count && totalTime+arr[k].dailyTime <= dailyWorkingTime {   // adds in curAssignments' daily time until can't fit a full one
                    arrReturn+=[(arr[k].index, arr[k].dailyTime)]
                    totalTime+=arr[k].dailyTime
                    if curAssignments[k].workDoneToday == false{
                    curAssignments[arr[k].index].timeForNextDay-=arr[k].dailyTime
                     //curAssignments[arr[k].index].workDoneToday=true
                    }     // subtracts the daily time from that assignment's time left
                    k+=1
                }
                if k<arr.count{
                    arrReturn+=[(arr[k].index, (Double(dailyWorkingTime)-totalTime))] // adds in enough of next assignment to fill up daily working time
                    if curAssignments[k].workDoneToday == false{
                    curAssignments[arr[k].index].timeForNextDay-=(Double(dailyWorkingTime)-totalTime)
                       //  curAssignments[arr[k].index].workDoneToday=true
                    }
                }
            }
            
            // Sometimes with decimals, the curAssignments might have 0.000024 hours left or something like that so this just officially changes it to 0 if that happens
            for j in 0..<curAssignments.count {
                if curAssignments[j].timeLeft<0.01 {
                    //curAssignments.remove(at: j)
                }
            }
        }
        var sum : Double = 0
        for j in 0..<arrReturn.count {
            sum += arrReturn[j].dailyTime
        }
        if sum > dailyWorkingTime {
            // something about error
        }
        return arrReturn
    }
    
    public func getWorkForWeek() -> () /*[[(Int, Double)]]*/ {
        
        // An array of arrays - ex. at [0], there will be an array of curAssignments and times for today; at [1] there will be an array of curAssignments and times for tomorrow
        var weekWork : [[(index: Int, dailyTime: Double)]] = []
        
        //var dayWork : [(index: Int, dailyTime: Double)] = []
        for i in 0..<7 {
            var addComponents = DateComponents()
            addComponents.day = i
            let futureDay = Calendar.current.date(byAdding: addComponents, to: Date())
            //  let n = getWorkForDay(futureDay!)
            // if n[0].0 != -1 {
            weekWork.append(getWorkForDay(futureDay!))
            //}
            
        }
        

        print(weekWork)
        
        self.weekWork=weekWork

        for i in 0..<curAssignments.count {
            curAssignments[i].timeForNextDay=curAssignments[i].timeLeft
        }
    }
    
}
//}
//}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(user: UserViewModel(), dailyWorkingTime: Binding.constant(0.0), weekWork: Binding.constant([[]]), curAssignments: Binding.constant([]))
    }
}
