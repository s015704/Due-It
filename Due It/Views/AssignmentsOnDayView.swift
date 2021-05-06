//
//  AssignmentsOnDayView.swift
//  Due It
//
//  Created by Workflow Team on 3/11/21.
//  Copyright © Workflow. All rights reserved.
//  This shows your assignments per day
import SwiftUI

struct AssignmentsOnDayView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.calendar) var calendar
    @State var clickedDay:String
    @State var day:Date
    @Binding var curAssignments:[Assignment]
    
    var body: some View {
        NavigationView{
            VStack{
                List(curAssignments, id: \.id) { ass in
                    Group {
                        if self.calendar.compare(ass.dueDate, to: self.day, toGranularity: .day) == .orderedSame {
                            AssignmentCView(assignment: ass, auxColor: 1)
                        }
                    }
                }
            }.padding(.top)
                .navigationBarTitle(clickedDay)
                .navigationBarItems(trailing: Button("Dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                })
        }
    }
}

struct AssignmentsOnDayView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentsOnDayView(clickedDay: "", day: Date(), curAssignments: Binding.constant([Assignment]()))
    }
}
