//
//  CalendarView.swift
//  LCalendar
//
//  Created by 张捷 on 2020/6/24.
//  Copyright © 2020 张捷. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    
    let viewWidth: CGFloat
    @State var monthViewItems = [MonthViewItem(year: pre.Year, month: pre.previousMonth),
                                 MonthViewItem(year: yearNow, month: monthNow),
                                 MonthViewItem(year: next.Year, month: next.nextMonth),
                                 MonthViewItem(year: afterNext.Year, month: afterNext.nextMonth)]
    
    var body: some View {
        VStack {
            //星期栏
            HStack(spacing: 0) {
                ForEach(0 ..< 7) { i in
                    Text(weekTitle[i])
                        .fontWeight(.bold)
                        .frame(width: self.viewWidth / 7 )
                }
            }
            .frame(height: self.viewWidth / 7 )
            //月视图组件
            CirculateViewPager(viewWidth: self.viewWidth, viewHeight: self.viewWidth, viewCount: 4, delegate: self.monthViewResetToBorder(index:leftOrRight:)) { index in
                MonthViewBlock(monthViewItem: self.$monthViewItems[index])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("CalendarBackgroundColor"))
            }
        }
        .frame(width: viewWidth)
    }
    
    func monthViewResetToBorder(index: Int, leftOrRight: Bool){
        var newYear = self.monthViewItems[index].year
        var newMonth = self.monthViewItems[index].month
        //如果将被置为最左，则应往前倒四个月
        if leftOrRight{
            for _ in 0 ..< 4{
                let pre = DateUtils.shared.getPrevious(year: newYear, month: newMonth)
                newYear = pre.Year
                newMonth = pre.previousMonth
            }
        }
        //如果将被置最右，则应往后倒四个月
        else{
            for _ in 0 ..< 4{
                let next = DateUtils.shared.getNext(year: newYear, month: newMonth)
                newYear = next.Year
                newMonth = next.nextMonth
            }
        }
        self.monthViewItems[index].setDateInfo(year: newYear, month: newMonth)
    }
    
}

