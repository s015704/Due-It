//
//  SettingsView.swift
//  Due It
//
//  Created by Annika Naveen (student LM) on 3/23/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct SettingsView: View {
    
    @EnvironmentObject var userInfo: UserInfo
    @State var user: UserViewModel
    @Binding var dailyWorkingTime : Double
    
    var body: some View {
        
        //ZStack{
        //Rectangle()
        //.fill(Color("background"))
        // .frame(width: 10000, height: 10000)
        //VStack{
        //HStack{
        //Text("User Name: ").autocapitalization(.none).padding(.leading, -100).foregroundColor(Color("highlight")).font(.largeTitle)
        
        //}
        //HStack{
        //Text("User Email: ").autocapitalization(.none).padding(.leading, -100)
        //Text(self.user.email).autocapitalization(.none)
        //}
        VStack {
            Text(self.user.fullname).autocapitalization(.none)
            
            Stepper(value: $dailyWorkingTime, in: 0...24, step: 0.25) {
                Text("Available Daily Working Time: \(dailyWorkingTime, specifier: "%g")")
                    .font(.headline)
            }.padding([.leading, .trailing], 30)
            
            Button(action: {
                try! Auth.auth().signOut()
                self.userInfo.configureFirebaseStateDidChange()
            }) {
                Text("Log Out")
                    .frame(width: 200)
                    .padding(.vertical, 15)
                    .background(Color("Auxillary2"))
                    .cornerRadius(8)
                    .foregroundColor(.black)
            }
        }
    }
    
}
//}
//}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(user: UserViewModel(), dailyWorkingTime: Binding.constant(0.0))
    }
}
