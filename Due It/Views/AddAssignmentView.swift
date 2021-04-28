//
//  AddAssignmentView.swift
//  Due It
//
//  Created by Annika Naveen (student LM) on 4/6/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import SwiftUI

struct AddAssignmentView: View {
    @Binding var curAssignments:[Assignment]
    @State var assignment: Assignment = Assignment()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    VStack(alignment: .center) {
                        TextField("Assignment Name", text: self.$assignment.name).autocapitalization(.words)
                        //if !assignment.validNameText.isEmpty {
                        //  Text(assignment.validNameText).font(.caption).foregroundColor(Color("highlight"))
                        //}
                    }
                    VStack(alignment: .center) {
                        TextField("Description", text: self.$assignment.description).autocapitalization(.words)
                    }
                    VStack(alignment: .center) {
                        TextField("Course", text: self.$assignment.course).autocapitalization(.words)
                    }
                    VStack(alignment: .leading) {
                        DatePicker("Due Date", selection: $assignment.dueDate, in: Date()...)
                    }
                    VStack(alignment: .leading) {   // I don't know how to store this time in estTime
                        TimeStepperView(estTime: assignment.estTime, type: .hour )
                        TimeStepperView(estTime: assignment.estTime, type: .minute)
                    }
                    VStack(alignment: .center) {
                        HStack {
                            Text("Low").padding(.leading, 15)
                            Spacer()
                            Text("Medium")
                            Spacer()
                            Text("High").padding(.trailing, 15)
                        }
                        Slider(value: self.$assignment.priority, in: 0...2, step: 1)
                    }
                    
                    Button(action:{
                        self.curAssignments.append(self.assignment)
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Text("save").foregroundColor(Color("highlight")).scaledToFill()
                    }
                    
                }.frame(width: UIScreen.main.bounds.width)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
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
