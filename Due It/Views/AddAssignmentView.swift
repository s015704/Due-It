//
//  AddAssignmentView.swift
//  Due It
//
//  Created by Annika Naveen (student LM) on 4/6/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import SwiftUI

struct AddAssignmentView: View {
    
    @State var assignment: Assignment = Assignment()
    
    var body: some View {
        NavigationView {
        VStack {
            Group {
                VStack(alignment: .leading) {
                    TextField("Assignment Name", text: self.$assignment.name).autocapitalization(.words)
                    if !assignment.validNameText.isEmpty {
                        Text(assignment.validNameText).font(.caption).foregroundColor(Color("highlight"))
                    }
                }
                VStack(alignment: .leading) {
                    TextField("Description", text: self.$assignment.description).autocapitalization(.words)
                }
                VStack(alignment: .leading) {
                    TextField("", text: self.$assignment.description).autocapitalization(.words)
                    if !assignment.validCourseText.isEmpty {
                        Text(assignment.validCourseText).font(.caption).foregroundColor(Color("highlight"))
                    }
                }
               
            }.frame(width: 300)
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
            .navigationBarTitle("Sign Up", displayMode: .inline)
            .navigationBarItems(trailing: Button("Dismiss") {
                //self.presentationMode.wrappedValue.dismiss()
            })
    }
}
}

struct AddAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AddAssignmentView()
    }
}
