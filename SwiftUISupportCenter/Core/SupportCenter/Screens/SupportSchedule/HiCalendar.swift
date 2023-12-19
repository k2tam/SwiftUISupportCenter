//
//  SupportScheduleScreen.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 19/12/2023.
//



import SwiftUI
import SwiftUIBackports


struct CalendarDate: Identifiable {
    let id = UUID()
    var day: Int
    var date: Date
    
    var availableDate: Bool {
        if date.string() == Date().string() {
            return true
        }
        
        if date >= Date() {
            return true
        }
        
        return false
    }

}


struct HiCalendar: View {
    
    let days = ["T2","T3","T4","T5","T6","T7","CN"]
    
    @State var selectedDate: Date? = nil
    @State var selectedDisplayDate = Date()
    @State var selectedMonth = 0
    @State var datesOfMonthSelected: [CalendarDate] = []
    
    private var CalendarToolBar: some View {
        HStack{
            Button(action: {
                withAnimation(.easeInOut) {
                    selectedMonth -= 1
                }
            }, label: {
                Image(systemName: "chevron.left")
                    .imageScale(.small)
                    .foregroundColor(Color(hex: "#969696"))
                    .frame(width: 24, height: 24)
                
            })
            
            Spacer()
            
            Text(selectedDisplayDate.monthAndYearToString())
            
            Spacer()
            
            
            Button(action: {
                withAnimation(.easeInOut) {
                    selectedMonth += 1
                    
                }
            }, label: {
                Image(systemName: "chevron.right")
                    .imageScale(.small)
                
                    .foregroundColor(Color(hex: "#969696"))
                    .frame(width: 24, height: 24)
                
                
            })
        }
        .padding(.all, 8)
    }
    
    
    var body: some View {
        VStack {
            CalendarToolBar
            
            
            HStack {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 13, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                    
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 8)
            
            
            VStack(spacing: 8){
                if !self.datesOfMonthSelected.isEmpty  {
                    ForEach(0..<6) { lineIndex in
                        let firstItemLineIndex = lineIndex * 7
                        let lastItemLineIndex = firstItemLineIndex + 6
                        
                        
                        HStack{
                            ForEach(firstItemLineIndex..<lastItemLineIndex+1) { index in
                                
                                let date = self.datesOfMonthSelected[index]
                                
                                if date.day != -1 {
                                    Button(action: {
                                        self.selectedDate = date.date
                                    }, label: {
                                        Text("\(date.day)")
                                            .frame(maxWidth: .infinity, maxHeight: 40)
                                            .modifier(
                                                modifierSelectionUIForDateCell(
                                                    isSelected: self.selectedDate?.string() == date.date.string(),
                                                    isToday: date.date.string() == Date().string(),
                                                    isAvailable: date.availableDate)
                                            )
                                        
                                    })
                                    .buttonStyle(PlainButtonStyle())
                                    .disabled(!date.availableDate)

                                    
                                    
                                }else {
                                    Text("")
                                        .frame(maxWidth: .infinity, maxHeight: 40)
                                    
                                }
                                
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                
            }
            .onAppear(perform: {
                self.datesOfMonthSelected = fetchDates()
            })
            .backport.onChange(of: selectedMonth, perform: { _ in
                selectedDisplayDate = fetchDateOfSelectedMonth()
                self.datesOfMonthSelected = fetchDates()
            })
            
            
        }
        .padding(.horizontal, 16)
        
        
    }
    
    
}

struct modifierSelectionUIForDateCell : ViewModifier {
    var isSelected: Bool
    var isToday: Bool
    var isAvailable: Bool
    

    func body(content: Content) -> some View {
        
        content
            .foregroundColor(setForegroudcolor())
            .background(
                ZStack {
                    if isSelected {
                        Circle()
                            .fill(Color.hiTheme.primaryColor)
                    }else if isToday {
                        Circle()
                            .fill(Color(hex: "#EFF4FF"))
                    }
                }
            )
    }
    
    func setForegroudcolor() -> Color {
        if isAvailable {
            if self.isToday {
                return Color.hiTheme.primaryColor
            }
            
            if self.isSelected {
                return Color.white
            }
            
            return Color.black
        }else {
            return Color(hex: "#CCCCCC")
        }
        
        
        
        return Color.black
    }
    
}

extension HiCalendar{
    func fetchDates() -> [CalendarDate]  {
        let calendar =  Calendar.current
        let currentMonth = fetchDateOfSelectedMonth()
        
        var datesOfMonth = currentMonth.datesOfMonth().map {
            return CalendarDate(day: calendar.component(.day, from: $0), date: $0)
            
        }
        
        
        //firstDayOfWeek -> 2 for Monday, 3 for Tuesday, ...
        let firstDayOfWeek = calendar.component(.weekday, from: datesOfMonth.first?.date ?? Date())
        
        
        var previousDayOfMonthToAppend = calendar.date(byAdding: .day, value: -1, to: datesOfMonth.first?.date ?? Date())
        
        //Case first day of week is Sunday so firstDayOfWeek is 1
        if firstDayOfWeek == 1 {
            for _ in 0..<6 {
                let dayOfPreviousDayOfMonthToAppend = previousDayOfMonthToAppend?.getIntDay() ?? 0
                
                
                datesOfMonth.insert(CalendarDate(day: dayOfPreviousDayOfMonthToAppend, date: previousDayOfMonthToAppend ?? Date()), at: 0)
                
                previousDayOfMonthToAppend = calendar.date(byAdding: .day, value: -1, to: previousDayOfMonthToAppend ?? Date())
                
            }
        }else {
            for _ in 0..<firstDayOfWeek - 2 {
                let dayOfPreviousDayOfMonthToAppend = previousDayOfMonthToAppend?.getIntDay() ?? 0
                
                
                datesOfMonth.insert(CalendarDate(day: dayOfPreviousDayOfMonthToAppend, date: previousDayOfMonthToAppend ?? Date()), at: 0)
                
                previousDayOfMonthToAppend = calendar.date(byAdding: .day, value: -1, to: previousDayOfMonthToAppend ?? Date())
                
                
            }
        }
        
        while datesOfMonth.count < 7 * 6 {
            datesOfMonth.append(CalendarDate(day: -1, date: Date()))
        }
        
        
        
        return datesOfMonth
        
    }
    
    func fetchDateOfSelectedMonth() -> Date {
        let calendar =  Calendar.current
        let month = calendar.date(byAdding: .month, value: selectedMonth, to: Date())
        
        return month ?? Date()
        
    }
}

extension Date {
    func getIntDay() -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }
    
    func getIntMonth() -> Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: self)
    }
    
    func string() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
    
    func monthAndYearToString() -> String {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: self)
        let currentYear = calendar.component(.year, from: self)
        
        return "THG \(currentMonth) / \(currentYear)"
    }
    
    
    func datesOfMonth() -> [Date] {
        let calendar =  Calendar.current
        let currentMonth = calendar.component(.month, from: self)
        let currentYear = calendar.component(.year, from: self)
        
        var startDateComponents = DateComponents()
        startDateComponents.year = currentYear
        startDateComponents.month = currentMonth
        startDateComponents.day = 1
        
        let startDate = calendar.date(from: startDateComponents)!
        
        var endDateComponents = DateComponents()
        endDateComponents.month = 1
        endDateComponents.day = -1
        let endDate = calendar.date(byAdding: endDateComponents, to: startDate)!
        
        var dates: [Date] = []
        var currentDate = startDate
        
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return dates
    }
}


#Preview {
    HiCalendar()
}
