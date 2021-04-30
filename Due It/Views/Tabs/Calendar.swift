import SwiftUI

fileprivate extension DateFormatter {
    
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }
    
    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
    
}

fileprivate extension Calendar {
    
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)
        
        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        
        return dates
    }
    
}

struct WeekView<DateView>: View where DateView: View {
    
    @Environment(\.calendar) var calendar
    
    let week: Date
    let content: (Date) -> DateView
    
    init(week: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.week = week
        self.content = content
    }
    
    private var days: [Date] {
        guard
            let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
            else { return [] }
        return calendar.generateDates(
            inside: weekInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
    var body: some View {
        HStack {
            ForEach(days, id: \.self) { date in
                HStack {
                    if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
                        self.content(date)
                    } else {
                        self.content(date).hidden()
                    }
                }
            }
        }
    }
}

struct MonthView<DateView>: View where DateView: View {
    
    @Environment(\.calendar) var calendar
    
    let month: Date
    let showHeader: Bool
    let content: (Date) -> DateView
    
    init(
        month: Date,
        showHeader: Bool = true,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.month = month
        self.content = content
        self.showHeader = showHeader
    }
    
    private var weeks: [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month)
            else { return [] }
        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday)
        )
    }
    
    private var header: some View {
        let component = calendar.component(.month, from: month)
        let formatter = component > 0 ? DateFormatter.monthAndYear : .month
        return Text(formatter.string(from: month))
            .font(.title)
            .padding()
    }
    
    var body: some View {
        VStack {
            if showHeader {
                header
            }
            ForEach(weeks, id: \.self) { week in
                WeekView(week: week, content: self.content)
            }
        }
    }
}

struct CalendarView<DateView>: View where DateView: View {
    
    @Environment(\.calendar) var calendar
    
    let interval: DateInterval
    let content: (Date) -> DateView
    
    init(interval: DateInterval, @ViewBuilder content: @escaping (Date) -> DateView) {
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

struct RootView: View {
    @Environment(\.calendar) var calendar
    @Binding var curAssignments : [Assignment]
    @Binding var showCurAss: Bool
    @Binding var clickedDay: String
    @Binding var day : Date
    @State var color : String = ""
    
    private var startIntervalDate : Date {
        let components : DateComponents = calendar.dateComponents([.year, .month], from: Date())
        let d = calendar.date(from: components)
        return d!
    }
    private var endIntervalDate : Date {
        var components : DateComponents = calendar.dateComponents([.year, .month], from: Date())
        components.year! += 1
        let d = calendar.date(from: components)
        return d!
    }
    
    private var dInterval: DateInterval {
        DateInterval(start: startIntervalDate, end: endIntervalDate)
    }
    var body: some View {
        CalendarView(interval: dInterval) { date in
                Button(action: {
                    self.showCurAss=true
                    self.clickedDay="\(self.calendar.component(.month, from:date))/\(self.calendar.component(.day, from: date))/\(self.calendar.component(.year, from: date))"
                    self.day=date
                    print(self.day)
                }){
                    Text("30")
                        .hidden()
                        .padding(8)
                        .background(Color("Auxillary1"))
                        .clipShape(Circle())
                        .padding(.vertical, 4)
                        .overlay(
                            Text(String(self.calendar.component(.day, from: date))))
                        .foregroundColor(Color.black)
                }
            
                ForEach(self.curAssignments, id: \.id){ ass in
                    Group{
                        if self.calendar.compare(ass.dueDate, to: date, toGranularity: .day) == .orderedSame {
                            Button(action: {
                                self.showCurAss=true
                                self.clickedDay="\(self.calendar.component(.month, from:date))/\(self.calendar.component(.day, from: date))/\(self.calendar.component(.year, from: date))"
                                self.day=date
                                print(self.day)
                            }){
                                Text("30")
                                    .hidden()
                                    .padding(8)
                                    .background(Color("background"))
                                    .clipShape(Circle())
                                    .padding(.vertical, 4)
                                    .overlay(
                                        Text(String(self.calendar.component(.day, from: date))))
                                    .foregroundColor(Color.black)
                                
                            }
                        } /*else {
                            Button(action: {
                                self.showCurAss=true
                                self.clickedDay="\(self.calendar.component(.month, from:date))/\(self.calendar.component(.day, from: date))/\(self.calendar.component(.year, from: date))"
                                self.day=date
                                print(self.day)
                            }){
                                Text("30")
                                    .hidden()
                                    .padding(8)
                                    .background(Color("Auxillary1"))
                                    .clipShape(Circle())
                                    .padding(.vertical, 4)
                                    .overlay(
                                        Text(String(self.calendar.component(.day, from: date))))
                                    .foregroundColor(Color.black)
                            }
                        }*/
                    
                }
            }
        }
    }
}
