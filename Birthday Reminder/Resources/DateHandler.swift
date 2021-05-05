//
//  DateHandler.swift
//  Birthday Reminder
//
//  Created by Media Davarkhah on 2/4/1400 AP.
//

import Foundation
class DateHandler{
    static func daysUntil(birthday: Date) -> Int {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        let date = cal.startOfDay(for: birthday)
        let components = cal.dateComponents([.day, .month], from: date)
        let nextDate = cal.nextDate(after: today, matching: components, matchingPolicy: .nextTimePreservingSmallerComponents)
        return cal.dateComponents([.day], from: today, to: nextDate ?? today).day ?? 0
    }
}
