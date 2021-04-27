//
//  AssignmentsOnDayView.swift
//  Due It
//
//  Created by Alexander Bullard (student LM) on 4/22/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import SwiftUI

struct AssignmentsOnDayView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.calendar) var calendar
    @State var clickedDay:String
    @State var day:Date
    @State var curAssignments:[Assignment]
    var body: some View {
        NavigationView{
            VStack{
                
                Button(action: {
                    
                    for ass in self.curAssignments{
                        
                        if self.calendar.compare(ass.dueDate, to: self.day, toGranularity: .day) == .orderedSame{
                        print(ass.name)
                        }
                        print(ass.dueDate)
                    }
                    
                    print(self.day)
                    
                }){Text("click")}
                
                    
                    
                
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
        AssignmentsOnDayView(clickedDay: "", day: Date(), curAssignments:[Assignment]())
    }
}
