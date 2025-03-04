//
//  ShoppingList.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 22/01/25.
//

import SwiftUI

/*
 Sources used in this file:
 4. Impleneting a calendar: https://www.youtube.com/watch?v=jBvkFKhnYLI&t=45s
 */


struct CalendarView: View {
   
    @State private var calendarVM = CalendarHelper()
    
    var body: some View {
        NavigationStack{
            VStack {
                
                HStack {//Head for < Month >
                    Button(action: {
                        calendarVM.changeMonth(by: -1)
                        }){
                            Image(systemName: "arrow.left")
                                .font(.title)
                                .foregroundColor(Color.mint)
                                .fontWeight(.bold)
                        }
                    Spacer()
                    Text(calendarVM.currentMonthText)
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        calendarVM.changeMonth(by: +1)
                        }) {
                        Image(systemName: "arrow.right")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.mint)
                        
                    }
                }
                .padding()
                
                HStack{ //Weekdays
                    ForEach(calendarVM.calendar.veryShortWeekdaySymbols.indices, id: \.self){ index in
                        let newIndex = (index + (calendarVM.calendar.firstWeekday - 1 )) % 7
                        Text(calendarVM.calendar.veryShortWeekdaySymbols[newIndex])
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                // 4, Calendar grid
                let days = calendarVM.generateDaysForMonth()
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                    ForEach(days, id: \.self) { day in
                        if day == 0{
                            Text("")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        else {
                            NavigationLink(destination: DayView(selectedDate: calendarVM.getDate(for: day))){
                                Text("\(day)")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .padding(4)
                                    .foregroundColor(.white)
                                    .aspectRatio(1,contentMode: .fit)
                                    .background(day == calendarVM.calendar.component(.day, from: calendarVM.currentDate) ? Color.mint : Color.clear)
                                    .cornerRadius(30)
                            }
                        }
                    }
                }
                .padding(.top)
                Spacer()
            }
            .padding()
        }
    }
    
}


