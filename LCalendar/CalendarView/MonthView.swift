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
            VStack(spacing: 0.0) {
                HStack{
                    Text("\(self.monthViewItem.month)")
                        .foregroundColor(TextColor)
                        .frame(width: geometry.size.width / 7, height: geometry.size.width / 7)
                        .font(.title)
                    Text(String(self.monthViewItem.year))
                        .foregroundColor(TextColor)
                        .font(.title)
                    Spacer()
                }
                MonthGridStackView(cellSize: geometry.size.width / 7, monthViewItem: self.$monthViewItem, onDayItemClicked: self.onDayItemClicked)
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        
    }
    
    
}
