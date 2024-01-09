//
//  SupportScheduleScreen.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 19/12/2023.
//



import SwiftUI
import SwiftUIBackports
import HiThemes

enum eCalendarBusinessType {
    case technical
    case procedure
}

struct HiCalendar: View {
    
    let weekDays = ["T2","T3","T4","T5","T6","T7","CN"]
    
    let calendarType: eCalendarBusinessType

    @Binding var checkedDate: Date?
    
    @State var canForwardMonth: Bool = true
    @State var canBackwardMonth: Bool = false
    
    //Variable for showing current month
    @State var selectedMonthDate = Date()
    
    //Variable for update fetch dates of month -/+ month
    @State var offSetMonth = 0
    @State var datesOfMonthSelected: [CalendarDateModel] = []
    
    
    
    private var CalendarToolBar: some View {
        HStack{
            //Previous month button
          
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
                .disabled(!self.canBackwardMonth)
                .opacity(self.canBackwardMonth ? 1 : 0)
            
            
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
            .disabled(!self.canForwardMonth)
            .opacity(self.canForwardMonth ? 1 : 0)
        
           
        }
        .padding(.vertical, 9)
        .frame(height: 42)
        .backport.onChange(of: self.offSetMonth) { newOffSetMonth in
            self.canBackwardMonth = newOffSetMonth > 0

            switch calendarType {
            case .technical:
                self.canForwardMonth = newOffSetMonth < 4
            default:
                break
            }
           
        }
       
    }
    
    var body: some View {
        VStack {
            BlockTitle(icon: "ic_blue_calendar", title: "Chọn ngày")
                .frame(height: 36)

               HiDividerLine()
                    .padding(.vertical, 16)
            
            CalendarToolBar
        
            WeekDaysLine

            CalendarDates
        }
        .padding(.all , 16)
        .background(Color.white)
        .cornerRadius(8)

        .onAppear(perform: {
            self.datesOfMonthSelected = fetchDates()
            
            if calendarType == .procedure {
                self.canForwardMonth = false
            }
        })
        .backport.onChange(of: offSetMonth, perform: { _ in
            selectedMonthDate = fetchDateOfSelectedMonth()
            self.datesOfMonthSelected = fetchDates()
        })
        
        
    }
    
    
}

struct modifierSelectionUIForDateCell : ViewModifier {
    let date: CalendarDateModel
    var isChecked: Bool = false

    func body(content: Content) -> some View {
        content
            .foregroundColor(setForegroudcolor())
            .background(
                ZStack {
                    if isChecked {
                        Circle()
                            .fill(Color.hiPrimary)
                    }else if date.isToday {
                        Circle()
                            .fill(Color(hex: "#EFF4FF"))
                    }
                }
            )
    }
    
    func setForegroudcolor() -> Color {
        if date.type == .AbleDay {
            if isChecked {
                return Color.white
            }
            
            if date.isToday {
                return Color.hiPrimary
            }
            
            return Color.black
        }else {
            return Color(hex: "#CCCCCC")
        }
        
        
        
    }
    
}

extension HiCalendar{
    private var WeekDaysLine: some View {
        HStack {
            ForEach(weekDays, id: \.self) { day in
                Text(day)
                    .font(.system(size: 16, weight: .medium))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 9)
                
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
    
    private var CalendarDates: some View {
        VStack(spacing: 8){
            if !self.datesOfMonthSelected.isEmpty  {
                ForEach(0..<6, id: \.self) { lineIndex in
                    
                    let firstItemLineIndex: Int = lineIndex * 7
                    let lastItemLineIndex: Int = firstItemLineIndex + 6
                    

                    
                    HStack{
                        ForEach(firstItemLineIndex..<lastItemLineIndex+1 ) { index  in
                            let dateItem = self.datesOfMonthSelected[index]
                            
                            if dateItem.day != "" {
                                Button(action: {
                                    self.checkedDate = dateItem.date

                                }, label: {
                                    Text(dateItem.day)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 40)
                                            .modifier(
                                                modifierSelectionUIForDateCell(
                                                    date: dateItem,
                                                    isChecked: self.checkedDate?.string() == dateItem.date.string()
                                                )
                                            )
                                            
                                })
                                .buttonStyle(PlainButtonStyle())
                                .disabled(dateItem.type == .UnableDay)

                                
                            }else {
                                Text("")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 40)
                            }
                            
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            
        }
    }
    
    func fetchDates() -> [CalendarDateModel]  {
        let calendar =  Calendar.current
        let currentMonth = fetchDateOfSelectedMonth()
        
        var datesOfMonth = currentMonth.datesOfMonth().map {
//            return CalendarDate(day: calendar.component(.day, from: $0), date: $0)
            if $0.string() == Date().string() {
                var todayDate =  CalendarDateModel(date: $0)
                todayDate.isToday = true
                return todayDate
            }
            return CalendarDateModel(date: $0)
        }

        //firstDayOfWeek -> 2 for Monday, 3 for Tuesday, ...
        let firstDayOfWeek = calendar.component(.weekday, from: datesOfMonth.first?.date ?? Date())
        
        var previousDayOfMonthToAppend = calendar.date(byAdding: .day, value: -1, to: datesOfMonth.first?.date ?? Date())
        
        //Case first day of week is Sunday so firstDayOfWeek is 1
        if firstDayOfWeek == 1 {
            for _ in 0..<6 {
              
                
                
                datesOfMonth.insert(CalendarDateModel(date: previousDayOfMonthToAppend ?? Date()), at: 0)
                
                previousDayOfMonthToAppend = calendar.date(byAdding: .day, value: -1, to: previousDayOfMonthToAppend ?? Date())
                
            }
        }else {
            for _ in 0..<firstDayOfWeek - 2 {
             
                
                
                datesOfMonth.insert(CalendarDateModel(date: previousDayOfMonthToAppend ?? Date()), at: 0)
                
                previousDayOfMonthToAppend = calendar.date(byAdding: .day, value: -1, to: previousDayOfMonthToAppend ?? Date())
            }
        }
        
        while datesOfMonth.count < 7 * 6 {
            //Dummy date to full fill calendar
            datesOfMonth.append(CalendarDateModel(date: Date(), day: ""))
        }
        
        return datesOfMonth
        
    }
    
    func fetchDateOfSelectedMonth() -> Date {
        let calendar =  Calendar.current
        let date = calendar.date(byAdding: .month, value: offSetMonth, to: Date())
        
        return date ?? Date()
        
    }
}


struct HiCalendar_Previews: PreviewProvider {
    static var previews: some View {
        @State var checkedDate: Date? = Date()

        HiCalendar(calendarType: .technical, checkedDate: $checkedDate)
    }
}


