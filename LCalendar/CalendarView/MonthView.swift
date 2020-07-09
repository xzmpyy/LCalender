//
//  MonthView.swift
//  LCalendar
//
//  Created by 张捷 on 2020/6/24.
//  Copyright © 2020 张捷. All rights reserved.
//

import SwiftUI

struct MonthViewBlock: View {
    
    @Binding var monthViewItem: MonthViewItem
    //响应日期被点击的回调函数
    var onDayItemClicked: ((Int, Int, Int) -> Void)?
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack{
                    Text("\(self.monthViewItem.month)")
                        .frame(width: geometry.size.width / 7, height: geometry.size.width / 7)
                        .font(.title)
                    Text(String(self.monthViewItem.year))
                        .font(.title)
                    Spacer()
                }
                MonthGridStackView(cellSize: geometry.size.width / 7, year: self.$monthViewItem.year, month: self.$monthViewItem.month, daysList: self.$monthViewItem.daysList, onDayItemClicked: self.onDayItemClicked)
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        
    }
    
    
}
