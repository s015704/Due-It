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
            Rectangle()
                .stroke(Color("Auxillary1"), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .frame(width: UIScreen.main.bounds.width-50, height: 200, alignment: .center)
                .cornerRadius(8)
            //.foregroundColor(Color("Auxillary1"))
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
            }
        }
    }
}

struct AssignmentCView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentCView(assignment: Assignment())
    }
}
