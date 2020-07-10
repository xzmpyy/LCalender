//
//  CalendarView.swift
//  LCalendar
//
//  Created by 张捷 on 2020/6/24.
//  Copyright © 2020 张捷. All rights reserved.
//

import SwiftUI

let CalendarBackgroundColor = Color("CalendarBackgroundColor")
let AccentColorInCalendar = Color("AccentColorInCalendar")
let TextColor = Color.primary

struct CalendarView: View {
    
    let viewWidth: CGFloat
    //月视图的四个页面列表
    @State var monthViewItems = [MonthViewItem(year: pre.Year, month: pre.previousMonth),
                                 MonthViewItem(year: yearNow, month: monthNow),
                                 MonthViewItem(year: next.Year, month: next.nextMonth),
                                 MonthViewItem(year: afterNext.Year, month: afterNext.nextMonth)]
    //响应日期被点击的回调函数
    var onDayItemClicked: ((Int, Int, Int) -> Void)?
    //日期选择标识
    var selectDate: SelectedDateItem = SelectedDateItem(year: yearNow, month: monthNow, day: dayNow)
    
    var body: some View {
        VStack(spacing: 0.0) {
            //星期栏
            HStack(spacing: 0) {
                ForEach(0 ..< 7) { i in
                    Text(weekTitle[i])
                        .fontWeight(.bold)
                        .foregroundColor(TextColor)
                        .frame(width: self.viewWidth / 7 )
                }
            }
            .frame(height: self.viewWidth / 7 )
            .background(CalendarBackgroundColor)
            //月视图组件
            CirculateViewPager(viewWidth: self.viewWidth, viewHeight: self.viewWidth, viewCount: 4, monthViewResetToBorderDelegate: self.monthViewResetToBorder(index:leftOrRight:)) { index in
                MonthViewBlock(monthViewItem: self.$monthViewItems[index], onDayItemClicked: self.onDayItemClicked)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(CalendarBackgroundColor)
            }
        }
        .environmentObject(self.selectDate)
        .frame(width: viewWidth)
    }
    
    /// 当页面被置左置右时，刷新页面内容的方法
    /// - Parameters:
    ///     - index: 即将被置于边界的页面在页面列表中的索引
    ///     - leftOrRight: true为置左，false为置右
    ///
    /// - Returns: Void
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

