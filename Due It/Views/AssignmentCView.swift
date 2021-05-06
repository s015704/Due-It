//
//  AssignmentCView.swift
//  Due It
//
//  Created by Workflow Team on 3/11/21.
//  Copyright © Workflow. All rights reserved.
// This shows the assignmens in our callander after clicking on the due date

import SwiftUI

struct AssignmentCView: View {
    
    @State var assignment : Assignment
    @State var auxColor : Int
    
    var body: some View {
        ZStack{
            Rectangle()
                .stroke(lineWidth: 10)
                .frame(width: UIScreen.main.bounds.width-50, height: 200, alignment: .center)
                .cornerRadius(10)
                .foregroundColor(Color("Auxillary1"))
            VStack {
                Text(assignment.name)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width-80, alignment: .center)
                Group {
                    if assignment.course != "" {
                        Text(assignment.course)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .frame(width: UIScreen.main.bounds.width-80, alignment: .center)
                    }
                }
                Text("")
                Group {
                    if assignment.description != "" {
                        Text(assignment.description)
                            .multilineTextAlignment(.center)
                            .frame(width: UIScreen.main.bounds.width-80, alignment: .center)
                    }
                }
                HStack {
                    Text("Priority Level: ")
                        .font(.caption)
                        .bold()
                    Group {
                        if assignment.priority == 0 {
                            Text("Low")
                        } else if assignment.priority == 1 {
                            Text("Med")
                        } else if assignment.priority == 2 {
                            Text("High")
                        }
                    }.font(.caption)
                        .padding(.trailing, 20)
                    Text("Completion Status: ")
                        .font(.caption)
                        .bold()
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

struct AssignmentCView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentCView(assignment: Assignment(), auxColor: 1)
    }
}
