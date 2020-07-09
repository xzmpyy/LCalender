//
//  SelectedDateItem.swift
//  LCalendar
//
//  Created by 张捷 on 2020/7/8.
//  Copyright © 2020 张捷. All rights reserved.
//

import SwiftUI

class SelectedDateItem: ObservableObject {
    
    @Published var year: Int
    @Published var month: Int
    @Published var day: Int
    
    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }
    
    func compareDates(year: Int, month: Int, day: Int) -> Bool{
        return (self.year == year && self.month == month && self.day == day)
    }
    
}
