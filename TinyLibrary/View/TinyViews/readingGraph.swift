//
//  readingGraph.swift
//  TinyLibrary
//
//  Created by Bora Mert on 22.12.2023.
//

import SwiftUI
import Charts

struct readingGraph: View {
    @Binding var book : Book
    
    var body: some View {
        VStack {
            Text("Progress").font(.title2).fontWeight(.bold).padding(.bottom,10)
            Spacer()
            let data = lastSevenDaysReadingData(for: book)
            
            Chart {
                ForEach(data, id: \.date) { dataPoint in
                    LineMark(
                        x: .value("Date", dataPoint.date, unit: .day),
                        y: .value("Pages Read", dataPoint.pagesRead)
                    )
                    .interpolationMethod(.catmullRom) // This makes the line curve smoothly
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .day))
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(.black).stroke(.secondary, lineWidth: 3))
    }

    private func lastSevenDaysReadingData(for book: Book) -> [DailyReading] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        var dataPoints: [DailyReading] = []
        
        for dayOffset in 0..<7 {
            let day = calendar.date(byAdding: .day, value: -dayOffset, to: today)!
            let pagesRead = book.dailyReadings.first(where: { calendar.isDate($0.date, inSameDayAs: day) })?.pagesRead ?? 0
            dataPoints.append(DailyReading(date: day, pagesRead: pagesRead))
        }
        
        return dataPoints.reversed()
    }
}

#Preview {
    readingGraph(book: .constant(Book(name: "Book Name Long For Demo", writer: "Long Writer Name to Demo", pagesRead: 1, bookLength: 100)))
}
