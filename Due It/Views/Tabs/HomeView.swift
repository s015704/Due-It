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
    
    var body: some View {
        Button(action: {
            self.showAAV = true
            print(self.user.email)
        }) {
            Image(systemName: "plus.circle.fill").scaleEffect(4)
        }.foregroundColor(Color("highlight"))
        
        
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
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showAAV: .constant(true), user: UserViewModel())
    }
}
