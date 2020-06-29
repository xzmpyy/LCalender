//
//  CalendarView.swift
//  LCalendar
//
//  Created by 张捷 on 2020/6/24.
//  Copyright © 2020 张捷. All rights reserved.
//

import SwiftUI

struct CalendarView: View {
    
    
    @State var monthViewItem = MonthViewItem(year: yearNow, month: monthNow)
    
    var body: some View {
        VStack {
            //星期栏
            HStack(spacing: 0) {
                ForEach(0 ..< 7) { i in
                    Text(weekTitle[i])
                        .fontWeight(.bold)
                        .frame(width: cellWith, height: cellHeight)
                }
            }
            //月视图组件
            HStack {
                MonthViewBlock(monthViewItem: self.$monthViewItem)
            }
        }
    }
}

