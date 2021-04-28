//
//  AssignmentCView.swift
//  Due It
//
//  Created by Alexander Bullard (student LM) on 4/28/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import SwiftUI

struct AssignmentCView: View {
    
    @State var assignment : Assignment
    
    var body: some View {
        ZStack{
            
            
            VStack {
                Text("Name: \(assignment.name)")
                Group {
                    if assignment.description != "" {
                        Text("Description: \(assignment.description)")
                    }
                }
                Group {
                    if assignment.course != "" {
                        Text("Course: \(assignment.course)")
                    }
                }
                HStack {
                    Text("Completion Status: ")
                    Group {
                        if assignment.isCompleted {
                            Image(systemName: "checkmark.square.fill")
                        } else {
                            Image(systemName: "xmark.rectangle")
                        }
                    }
                }
                Rectangle().frame(width: 300 , height: 200, alignment: .center).foregroundColor(Color("Auxilary1")).accentColor(Color("Background"))
            }
        }
    }
}

struct AssignmentCView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentCView(assignment: Assignment())
    }
}
