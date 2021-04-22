//
//  StepperView.swift
//  Due It
//
//  Created by Annika Naveen (student LM) on 4/20/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import SwiftUI

struct TimeStepperView: View {
    
    @State var value = 0
    @State var estTime=0
    @State var type : TimeType
    enum TimeType {case hour, minute}

    var typeName : String {
        switch type {
        case .hour:
            return "Hours"
        case .minute:
            return "Minutes"
        }
    }

    var body: some View {
        Stepper(onIncrement: incrementStep, onDecrement: decrementStep) {
            Text("\(typeName): \(value)")
        }
    }
    
    func incrementStep() {
        switch type {
        case .hour:
            value+=1
            estTime+=60
        case .minute:
            if value<55 {
                value+=5
                estTime+=5
            }
        }
        print(estTime)
    }
    
    func decrementStep() {
        switch type {
        case .hour:
            if (value-1) >= 0 {
                value-=1
            }
        case .minute:
            if (value-5) >= 0 {
                value-=5
            }
        }
    }
    
    
}

struct TimeStepperView_Previews: PreviewProvider {
    static var previews: some View {
        TimeStepperView(estTime: 0, type: .hour)
    }
}
