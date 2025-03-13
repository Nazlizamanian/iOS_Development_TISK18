//
//  ShoppingList.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 22/01/25.
//
import SwiftUI

/*
 Sources used:
 1.Calendar grid: https://www.youtube.com/watch?v=jBvkFKhnYLI&t=45s
 
 */

struct CalendarView: View {
    @State private var calendarVM = CalendarHelper()
    @State private var selectedDate = Date()

    var body: some View {
        NavigationStack {
            VStack {
                // Month navigation header
                HStack {
                    Button(action: {
                        calendarVM.changeMonth(by: -1)
                    }) {
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
                        calendarVM.changeMonth(by: 1)
                    }) {
                        Image(systemName: "arrow.right")
                            .font(.title)
                            .foregroundColor(Color.mint)
                            .fontWeight(.bold)
                    }
                }
                .padding()

                // Weekday headers
                HStack {
                    ForEach(calendarVM.calendar.veryShortWeekdaySymbols.indices, id: \.self) { index in
                        let newIndex = (index + (calendarVM.calendar.firstWeekday - 1)) % 7
                        Text(calendarVM.calendar.veryShortWeekdaySymbols[newIndex])
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                    }
                }

                // Calendar grid 1
                ScrollView {
                    let days = calendarVM.generateDaysForMonth()
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                        ForEach(0..<days.count, id: \.self) { index in
                            let day = days[index]
                            if day == 0 {
                                Text("")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            } else {
                                NavigationLink(destination: DayView(selectedDate: calendarVM.getDate(for: day))) {
                                    Text("\(day)")
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .padding(4)
                                        .foregroundColor(.white)
                                        .aspectRatio(1, contentMode: .fit)
                                        .background(
                                            day == calendarVM.calendar.component(.day, from: Date())
                                                ? Color.mint
                                                : Color.gray.opacity(0.3)
                                        )
                                        .cornerRadius(30)
                                }
                            }
                        }
                    }
                    .padding(.top)
                    // Adding an id forces the grid to reload when currentDate changes
                    .id(calendarVM.currentDate)
                }

                .padding(.top)
                Spacer()
            }
            .padding()
            .navigationTitle("Calendar")
        }
    }
}
