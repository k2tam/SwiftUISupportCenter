//
//  SupportScheduleScreen.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 19/12/2023.
//



import SwiftUI
import SwiftUIBackports


struct HiCalendar: View {
    
    let weekDays = ["T2","T3","T4","T5","T6","T7","CN"]
    
    @State var selectedDate: Date? = nil
    @State var selectedMonthDate = Date()
    @State var offSetMonth = 0
    @State var datesOfMonthSelected: [CalendarDate] = []
    
    private var CalendarToolBar: some View {
        HStack{
            
            //Previous month button
            if self.selectedMonthDate > Date() {
                Button(action: {
                    withAnimation(.easeInOut) {
                        offSetMonth -= 1
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                        .imageScale(.small)
                        .foregroundColor(Color(hex: "#969696"))
                        .frame(width: 24, height: 24)
                    
                })
            }
            
            Spacer()
            
            Text(selectedMonthDate.monthAndYearToString())
            
            Spacer()
            
            //Next month button
            Button(action: {
                withAnimation(.easeInOut) {
                    offSetMonth += 1
                    
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
            
            WeekDaysLine
                        
            CalendarDates
            
        }
        .padding(.horizontal, 16)
        .onAppear(perform: {
            self.datesOfMonthSelected = fetchDates()
            self.selectedDate = Date()
        })
        .backport.onChange(of: offSetMonth, perform: { _ in
            selectedMonthDate = fetchDateOfSelectedMonth()
            self.datesOfMonthSelected = fetchDates()
        })
        
        
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
            if self.isSelected {
                return Color.white
            }
            
            if self.isToday {
                return Color.hiTheme.primaryColor
            }
            
            return Color.black
        }else {
            return Color(hex: "#CCCCCC")
        }
        
        
        
        return Color.black
    }
    
}

extension HiCalendar{
    private var WeekDaysLine: some View {
        HStack {
            ForEach(weekDays, id: \.self) { day in
                Text(day)
                    .font(.system(size: 13, weight: .medium))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 8)
    }
    
    private var CalendarDates: some View {
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
    }
    
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
        let date = calendar.date(byAdding: .month, value: offSetMonth, to: Date())
        
        return date ?? Date()
        
    }
}


#Preview {
    HiCalendar()
}


