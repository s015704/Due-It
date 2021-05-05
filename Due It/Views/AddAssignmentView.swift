//
//  AddAssignmentView.swift
//  Due It
//
//  Created by Annika Naveen (student LM) on 4/6/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct AddAssignmentView: View {
    @Binding var curAssignments:[Assignment]
    @State var assignment: Assignment = Assignment()
    @Environment(\.presentationMode) var presentationMode
    @State private var estHours : Double = 0
    @State private var estMinutes : Double = 0

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
                        //if !assignment.validNameText.isEmpty {
                        //  Text(assignment.validNameText).font(.caption).foregroundColor(Color("highlight"))
                        //}
                        TextField("Description", text: self.$assignment.description)
                        TextField("Course", text: self.$assignment.course)
                            .autocapitalization(.words)
                    }.padding(.top, 15)
                    
                    VStack {
                        Text("Due Date")
                            .font(.headline)
                        DatePicker("", selection: $assignment.dueDate, displayedComponents: [.date]).padding(.trailing, 25)
                            .padding(.top, -10)
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
                        //TimeStepperView(assignment: assignment, type: .hour ) // I don't know how to store this time in estTime
                        //TimeStepperView(assignment: assignment, type: .minute)
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
                    self.assignment.estTime = self.estHours+self.estMinutes/60
                    self.assignment.timeLeft = self.assignment.estTime
                    self.curAssignments.append(self.assignment)
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    HStack {
                        Text("SAVE")
                            .font(.title)
                            .foregroundColor(Color("Auxillary3"))
                    }
                }
                Spacer()
            }.padding(.top)
                .navigationBarTitle("Add Assignment", displayMode: .inline)
                .navigationBarItems(trailing: Button("Close") {
                    self.presentationMode.wrappedValue.dismiss()
                })
        }
    }
}

struct AddAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AddAssignmentView(curAssignments: Binding.constant([Assignment]()))
    }
}

/* VStack(spacing: 20 ) {
Button(action: {
Auth.auth().createUser(withEmail: self.user.email, password: self.user.password, completion: { (user, error) in
self.userInfo.configureFirebaseStateDidChange()
self.presentationMode.wrappedValue.dismiss()
})
}) {
Text("Register")
.frame(width: 200)
.padding(.vertical, 15)
.background(Color.green)
.cornerRadius(8)
.foregroundColor(.white)
.opacity(user.isSignInComplete ? 1 : 0.75)
}
.disabled(!user.isSignInComplete)
Spacer()
}.padding()*/
