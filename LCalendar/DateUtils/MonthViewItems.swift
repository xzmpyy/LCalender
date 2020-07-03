//
//  MonthViewItems.swift
//  LCalendar
//
//  Created by 张捷 on 2020/6/30.
//  Copyright © 2020 张捷. All rights reserved.
//

import Foundation

struct MonthViewItems {
    
    var monthViewItems: [MonthViewItem]
    
    init() {
        self.monthViewItems = [MonthViewItem]()
        let pre = DateUtils.shared.getPrevious(year: yearNow, month: monthNow)
        let next = DateUtils.shared.getNext(year: yearNow, month: monthNow)
        let afterNext = DateUtils.shared.getNext(year: next.Year, month: next.nextMonth)
        self.monthViewItems.append(MonthViewItem(year: pre.Year, month: pre.previousMonth))
        self.monthViewItems.append(MonthViewItem(year: yearNow, month: monthNow))
        self.monthViewItems.append(MonthViewItem(year: next.Year, month: next.nextMonth))
        self.monthViewItems.append(MonthViewItem(year: afterNext.Year, month: afterNext.nextMonth))
    }
    
}
