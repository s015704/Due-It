//
//  CalendarView.swift
//  Due It
//
//  Created by Annika Naveen (student LM) on 3/23/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import SwiftUI


struct CalendarView<DateView>: View where DateView: View {
    let interval: DateInterval
    let content: (Date) -> DateView

    init(
        interval: DateInterval,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.interval = interval
        self.content = content
    }
    
    private var months: [Date] {
           calendar.generateDates(
               inside: interval,
               matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
           )
       }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(months, id: \.self) { month in
                    MonthView(month: month, content: self.content)
                }
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
