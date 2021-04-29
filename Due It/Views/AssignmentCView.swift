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
    @State var auxColor : Int
    
    var body: some View {
        ZStack{
            Rectangle()
                .stroke(lineWidth: 8)
                .frame(width: UIScreen.main.bounds.width-50, height: 200, alignment: .center)
                .cornerRadius(10)
                .foregroundColor(auxColor==1 ? Color("Auxillary1") : Color("Auxillary2"))
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
                    Text("Completion Status: ")
                        .font(.caption)
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
        AssignmentCView(assignment: Assignment(), auxColor: 1)
    }
}
