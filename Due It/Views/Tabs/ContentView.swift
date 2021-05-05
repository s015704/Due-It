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
    @State var showAAV = false
    @State var user: UserViewModel = UserViewModel()
    @State var weekWork:[[(index: Int, dailyTime: Double)]] = [[(index: Int, dailyTime: Double)]]()
    @State var dailyWorkingTime: Double = 3
    @State var showCurAss=false
    @State var clickedDay=""
    @State var day=Date()
    
    var body: some View {
        
       Group {
            if userInfo.isUserAuthenticated == .undefined {
                Text("Loading")
            } else if userInfo.isUserAuthenticated == .signedOut {
                LogInView(user: self.$user)
            } else {
                TabView {

                    RootView(curAssignments: self.$user.curAssignments, showCurAss: $showCurAss, clickedDay: $clickedDay, day:$day ).sheet(isPresented: $showCurAss) {
                        AssignmentsOnDayView(clickedDay: self.clickedDay, day: self.day, curAssignments: self.$user.curAssignments)

                    }
                        .tabItem({
                            Image(systemName: "calendar")
                            Text("Calendar")
                        }).tag(0)
                    HomeView(showAAV: $showAAV, dailyWorkingTime: self.$dailyWorkingTime, curAssignments: self.$user.curAssignments, weekWork: self.$weekWork).sheet(isPresented: $showAAV) {
                        AddAssignmentView(curAssignments: self.$user.curAssignments, dailyWorkingTime: self.$dailyWorkingTime, weekWork: self.$weekWork)
                    }
                    .tabItem({
                        Image(systemName: "house")
                        Text("Assignments")
                    }).tag(1)
                    SettingsView(user: self.user, dailyWorkingTime: self.$dailyWorkingTime)
                        .tabItem({
                            Image(systemName: "gear")
                            Text("Settings")
                        }).tag(2)
                }
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
