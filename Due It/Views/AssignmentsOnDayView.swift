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
    @State var clickedDay:String
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    
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
        AssignmentsOnDayView(clickedDay: "")
    }
}
