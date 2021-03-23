//
//  CalendarView.swift
//  Due It
//
//  Created by Annika Naveen (student LM) on 3/23/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        let calendar = CalendarView(frame: CGRectMake(0, 0, CGRectGetWidth(view.frame), 320))
        view.addSubview(calendar)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
