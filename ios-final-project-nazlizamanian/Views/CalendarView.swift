//
//  ShoppingList.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 22/01/25.
//

import SwiftUI

/*
 Sources used:
 1. https://www.youtube.com/watch?v=jBvkFKhnYLI&t=45s
 
 */


struct CalendarView: View {
    @State private var currentDate = Date() // Current date
    
    private let calendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 2 //Start on monday
        return calendar
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy" // Month and Year
        return formatter
    }()
    
    var body: some View {
        NavigationStack{
            VStack {
                
                HStack {//Head for < Month >
                    Button(action: {
                        if let newDate = calendar.date(byAdding: .month, value: -1, to: currentDate){
                            currentDate = newDate
                        }}){
                            Image(systemName: "arrow.left")
                                .font(.title)
                                .foregroundColor(Color.mint)
                                .fontWeight(.bold)
                        }
                    Spacer()
                    Text(dateFormatter.string(from: currentDate))
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        if let newDate = calendar.date(byAdding: .month,value:+1, to: currentDate){
                            currentDate = newDate
                        }
                    }) {
                        Image(systemName: "arrow.right")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.mint)
                        
                    }
                }
                .padding()
                
                HStack{ //Wekkdays
                    ForEach(calendar.veryShortWeekdaySymbols.indices, id: \.self){ index in
                        let newIndex = (index + (calendar.firstWeekday - 1 )) % 7
                        Text(calendar.veryShortWeekdaySymbols[newIndex])
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                // Calendar grid
                let days = generateDaysForMonth()
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                    ForEach(days, id: \.self) { day in
                        if day == 0{
                            Text("")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        else {
                            NavigationLink(destination: DayView()){
                                Text("\(day)")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .padding(4)
                                    .aspectRatio(1,contentMode: .fit)
                                    .background(day == calendar.component(.day, from: currentDate) ? Color.mint : Color.clear) // Highlight today
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

    
    private func generateDaysForMonth() -> [Int] {
        guard let range = calendar.range(of: .day, in: .month, for: currentDate) else { return [] }
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        let weekdayOfFirstDay = calendar.component(.weekday, from: firstDayOfMonth) - 1 // 0-based index
        
        let emptyDays = Array(repeating: 0, count: weekdayOfFirstDay)
        let days = Array(range)
        
        return emptyDays + days
    }
    
  
    
    
}


