//
//  LogOutView.swift
//  FireDrill
//
//  Created by Annika Naveen (student LM) on 2/10/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct HomeView: View {
    
    @EnvironmentObject var userInfo : UserInfo
    @Binding var showAAV: Bool
    @State var user: UserViewModel
    @Binding var dailyWorkingTime: Double
    @Binding var curAssignments:[Assignment]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.showAAV = true
                    print(self.user.email)
                    print(self.dailyWorkingTime)
                }) {
                    Image(systemName: "plus.circle.fill").scaleEffect(4)
                }.foregroundColor(Color("highlight"))
            }
            AssignmentHView(dailyWorkingTime: self.dailyWorkingTime, curAssignments: self.curAssignments, weekWork: getWorkForWeek())
        }
        
        //                    Button(action: {
        //                        try! Auth.auth().signOut()
        //                        self.userInfo.configureFirebaseStateDidChange()
        //                    }) {
        //                        Text("Log Out")
        //                            .frame(width: 200)
        //                            .padding(.vertical, 15)
        //                            .background(Color.green)
        //                            .cornerRadius(8)
        //                            .foregroundColor(.white)
        //                    }
        //        }
    }
    
    
    
    // Calculates the days between 2 dates
    func daysBetween(_ start: Date, _ end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    // Gets all timePerDay for every assignment regardless of how much time there is per day or the priority
    func getAllTimePerDay(_ date: Date) -> [(Int, Double)] {
        
        // index = index of the assignment in the curAssignments array, dailyTime = timePerDay of each of those curAssignments
        var arr : [(index: Int, dailyTime: Double)] = [(index: -1, dailyTime: 0)]
        var addComponents = DateComponents()
        addComponents.day = 1
        let tomorrow = Calendar.current.date(byAdding: addComponents, to: Date())
        
        for i in 0..<curAssignments.count {
            if daysBetween(date, curAssignments[i].dueDate)+1>0&&curAssignments[i].timeLeft>0.01 {
                curAssignments[i].timePerDay = curAssignments[i].timeLeft/(Double(daysBetween(date, curAssignments[i].dueDate))+1)
                curAssignments[i].timePerDay = ((curAssignments[i].timePerDay*12).rounded(.up))/12    // intervals by 5 minutes
                arr+=[(index: i, dailyTime: curAssignments[i].timePerDay)]
            } else if curAssignments[i].dueDate==tomorrow {
                curAssignments[i].timePerDay = curAssignments[i].timeLeft
                arr+=[(index: i, dailyTime: curAssignments[i].timePerDay)]
            } else {
                curAssignments[i].complete()
            }
        }
        
        return arr
    }
    
    // When assigning work for a day, it decreases the time left whenever it's called
    func getWorkForDay(_ date : Date) -> [(Int, Double)] {
        
        // index = index of the assignment in the curAssignments array, dailyTime = timePerDay of each of those curAssignments
        var arr : [(index: Int, dailyTime: Double)] = getAllTimePerDay(date)  // Adds every single assigment with its intended time per day to the array
        var arrReturn : [(index: Int, dailyTime: Double)] = []
        
        // Doles out assignment time based on the working time for that day
        
        var totalTime : Double = 0
        if dailyWorkingTime <= arr[0].dailyTime {    // if the dailyWorkingTime is less than the daily time required for the first assignment
            totalTime = dailyWorkingTime    // fills the dailyWorkingTime completely with the one assignment due soonest
            arrReturn+=[(arr[0].index, arr[0].dailyTime)]
            curAssignments[arr[0].index].timeLeft-=dailyWorkingTime   // takes away that much time left for the first assignment
        } else {    // if there's time for this first assignment's daily time and possibly more
            var k = 0
            while totalTime+arr[k].dailyTime < dailyWorkingTime {   // adds in curAssignments' daily time until can't fit a full one
                arrReturn+=[(arr[k].index, arr[k].dailyTime)]
                totalTime+=arr[k].dailyTime
                curAssignments[arr[k].index].timeLeft-=arr[k].dailyTime    // subtracts the daily time from that assignment's time left
                k+=1
            }
            arrReturn+=[(arr[k].index, (Double(dailyWorkingTime)-totalTime))] // adds in enough of next assignment to fill up daily working time
            curAssignments[arr[k].index].timeLeft-=(Double(dailyWorkingTime)-totalTime)
        }
        
        // Sometimes with decimals, the curAssignments might have 0.000024 hours left or something like that so this just officially changes it to 0 if that happens
        for j in 0..<curAssignments.count {
            if curAssignments[j].timeLeft<0.01 {
                curAssignments[j].complete()
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
    
    func getWorkForWeek() -> [[(Int, Double)]] {
        
        // An array of arrays - ex. at [0], there will be an array of curAssignments and times for today; at [1] there will be an array of curAssignments and times for tomorrow
        var weekWork : [[(index: Int, dailyTime: Double)]] = [[(index: -1, dailyTime: 0)]]
        
        //var dayWork : [(index: Int, dailyTime: Double)] = []
        for i in 0..<7 {
            var addComponents = DateComponents()
            addComponents.day = i
            let futureDay = Calendar.current.date(byAdding: addComponents, to: Date())
            weekWork.append(getWorkForDay(futureDay!))
            
        }
        return weekWork
    }
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showAAV: .constant(true), user: UserViewModel(), dailyWorkingTime: Binding.constant(0), curAssignments: Binding.constant([]))
    }
}
