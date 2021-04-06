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
    
    var body: some View {
        
        @State var showSheet = false
        
       // VStack {
            //AddButtonView()
            
            
            
            //            Button(action: {
            //                try! Auth.auth().signOut()
            //                self.userInfo.configureFirebaseStateDidChange()
            //            }) {
            //                Text("Log Out")
            //                    .frame(width: 200)
            //                    .padding(.vertical, 15)
            //                    .background(Color.green)
            //                    .cornerRadius(8)
            //                    .foregroundColor(.white)
            //            }
        //}
    }
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
