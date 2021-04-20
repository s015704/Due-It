//
//  SettingsView.swift
//  Due It
//
//  Created by Annika Naveen (student LM) on 3/23/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {

            Button(action: {
                        try! Auth.auth().signOut()
                        self.userInfo.configureFirebaseStateDidChange()
                    }) {
                        Text("Log Out")
                            .frame(width: 200)
                            .padding(.vertical, 15)
                            .background(Color.green)
                            .cornerRadius(8)
                            .foregroundColor(.white)
                    }
        }
        
        
        
        
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
