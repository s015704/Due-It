//
//  LogOutView.swift
//  FireDrill
//
//  Created by Workflow Team on 3/11/21.
//  Copyright © Workflow. All rights reserved.
//  Displays our List of List of Assignments

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct HomeView: View {
    
    @Binding var showAAV: Bool
    @Binding var dailyWorkingTime: Double
    @Binding var curAssignments : [Assignment]
    @Binding var weekWork:[[(index: Int, dailyTime: Double)]]
    @EnvironmentObject var userInfo : UserInfo
    @Environment(\.calendar) var calendar

    var body: some View {
        ZStack{
            
            VStack{
                Group {
                    if curAssignments.count == 0 {
                        AssignmentHView(dailyWorkingTime: self.$dailyWorkingTime, curAssignments: self.$curAssignments, weekWork: Binding.constant([[(0,0)]]))
                    } else {
                        AssignmentHView(dailyWorkingTime: self.$dailyWorkingTime, curAssignments: self.$curAssignments, weekWork:
                            $weekWork)
                    }
                }
                
                HStack {
                    Button(action: {
                        self.showAAV = true
                    }) {
                        Image(systemName: "plus.circle.fill").scaleEffect(3)
                    }.foregroundColor(Color("Auxillary3")).padding(30)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showAAV: .constant(true), dailyWorkingTime: Binding.constant(0), curAssignments: Binding.constant([]), weekWork: Binding.constant([[(index: Int, dailyTime: Double)]]()) )
    }
}
