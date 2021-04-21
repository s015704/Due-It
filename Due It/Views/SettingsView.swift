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
    
    //@EnvironmentObject var userInfo: UserInfo
    //@Binding var user: UserViewModel
    
    var body: some View {
        /*
         ZStack{
         Rectangle()
         .fill(Color("background"))
         .frame(width: 10000, height: 10000)
         VStack{
         HStack{
         Text("User Name: ").autocapitalization(.none).padding(.leading, -100).foregroundColor(Color("highlight")).font(.largeTitle)
         Text(self.$user.fullname).autocapitalization(.none)
         }
         HStack{
         Text("User Email: ").autocapitalization(.none).padding(.leading, -100)
         Text(self.$user.email).autocapitalization(.none)
         }
         
         Button(action: {
         try! Auth.auth().signOut()
         self.userInfo.configureFirebaseStateDidChange()
         }) {
         Text("Log Out")
         .frame(width: 200)
         .padding(.vertical, 15)
         .background(Color("auxillary2"))
         .cornerRadius(8)
         .foregroundColor(.white)
         }
         }
         */
        Text("hi")
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
