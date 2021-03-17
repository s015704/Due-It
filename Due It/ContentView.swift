//
//  ContentView.swift
//  Due It
//
//  Created by Annika Naveen (student LM) on 3/11/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userInfo : UserInfo
    
    var body: some View {
        Group {
            if userInfo.isUserAuthenticated == .undefined {
                Text("Loading")
            } else if userInfo.isUserAuthenticated == .signedOut {
                LogInView()
            } else {
                HomeView()
            }
        }.onAppear() {
            self.userInfo.configureFirebaseStateDidChange()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
