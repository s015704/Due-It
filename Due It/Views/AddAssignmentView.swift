//
//  AddAssignmentView.swift
//  Due It
//
//  Created by Workflow Team on 4/6/21.
//  Copyright © Workflow. All rights reserved.
//This is our interface for adding assignments to your calander, algorithm works once save is clicked

import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct AddAssignmentView: View {
    @Binding var curAssignments:[Assignment]
    @Binding var dailyWorkingTime: Double
    @Binding var weekWork:[[(index: Int, dailyTime: Double)]]
    @State var assignment: Assignment = Assignment()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.calendar) var calendar/* = Calendar(identifier: .gregorian)*/
    //calendar.timeZone = TimeZone(identifier: "America/New_York")
    @State private var estHours : Double = 0
    @State private var estMinutes : Double = 0
    private var nextYear : Date {
        var components = DateComponents()
        components.year = 1
        return Calendar.current.date(byAdding: components, to: Date())!
    }
    @State var warningEstTime : Bool = false
    @State var warningName : Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .center) {
                    
                    VStack {
                        Text("Details")
                            .font(.headline)
                            .padding(.bottom, 5)
                        TextField("Assignment Name", text: self.$assignment.name)
                            .autocapitalization(.words)
                        if warningName {
                            Text(assignment.validNameText)
                                .font(.caption)
                                .foregroundColor(Color("Auxillary3"))
                        }
                        TextField("Description", text: self.$assignment.description)
                        TextField("Course", text: self.$assignment.course)
                            .autocapitalization(.words)
                    }.padding(.top, 15)
                    
                    VStack {
                        Text("Due Date")
                            .font(.headline)
                        DatePicker("", selection: $assignment.dueDate, in: Date()...nextYear, displayedComponents: [.date]).padding(.trailing, 25)
                    }.padding(.top, 15)
                    
                    VStack {
                        Text("Estimated Completion Time")
                            .font(.headline)
                            .padding(.bottom, 5)
                        Stepper(value: $estHours, in: 0...24, step: 1) {
                            Text("Hours: \(estHours, specifier: "%g")")
                        }.padding([.leading, .trailing], 45)
                        Stepper(value: $estMinutes, in: 0...60, step: 5) {
                            Text("Minutes: \(estMinutes, specifier: "%g")")
                        }.padding([.leading, .trailing], 45)
                        if warningEstTime {
                            Text("You must enter an amount of time")
                                .font(.caption)
                                .foregroundColor(Color("Auxillary3"))
                        }
                    }.padding(.top, 15)
                    
                    VStack {
                        Text("Priority Level")
                            .font(.headline)
                            .padding(.bottom, 5)
                        HStack {
                            Text("Low").padding(.leading, 15)
                            Spacer()
                            Text("Medium")
                            Spacer()
                            Text("High").padding(.trailing, 15)
                        }
                    }.padding(.top, 15)
                    
                    Slider(value: self.$assignment.priority, in: 0...2, step: 1)
                    
                }.frame(width: UIScreen.main.bounds.width-80)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
                Button(action:{
                    
                    if (self.estHours != 0 || self.estMinutes != 0) && self.assignment.validNameText.isEmpty{
                        self.assignment.estTime = self.estHours+self.estMinutes/60
                        self.assignment.timeLeft = self.assignment.estTime
                        self.assignment.timeForNextDay = self.assignment.timeLeft
                        self.curAssignments.append(self.assignment)
                        self.getWorkForWeek()
                        self.presentationMode.wrappedValue.dismiss()
                        
                        print(self.curAssignments)
                    }
                    else{
                        if self.estHours == 0 && self.estMinutes == 0 {
                            self.warningEstTime = true
                        }
                        if !self.assignment.validNameText.isEmpty {
                            self.warningName = true
                        }
                    }
                }){
                    Text("SAVE")
                        .frame(width: 120, height: 50)
                        .background(Color("Auxillary2"))
                        .cornerRadius(25)
                        .clipShape(Rectangle())
                        .font(.title)
                        .foregroundColor(Color.black)
                }
                Spacer()
            }.padding(.top)
                .navigationBarTitle("Add Assignment", displayMode: .inline)
                .navigationBarItems(trailing: Button("Close") {
                    self.presentationMode.wrappedValue.dismiss()
                })
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
    
    public func getWorkForWeek() -> () {
        
        // An array of arrays - ex. at [0], there will be an array of curAssignments and times for today; at [1] there will be an array of curAssignments and times for tomorrow
        var weekWork : [[(index: Int, dailyTime: Double)]] = []
        
        for i in 0..<7 {
            var addComponents = DateComponents()
            addComponents.day = i
            let futureDay = Calendar.current.date(byAdding: addComponents, to: Date())
            weekWork.append(getWorkForDay(futureDay!))
        }
                
        self.weekWork=weekWork

        for i in 0..<curAssignments.count {
            curAssignments[i].timeForNextDay=curAssignments[i].timeLeft
        }
    }
    
}



struct AddAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AddAssignmentView(curAssignments: Binding.constant([Assignment]()), dailyWorkingTime: Binding.constant(0), weekWork: Binding.constant([[]]))
    }
}


