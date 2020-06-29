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
    
    var body: some View {
        VStack {
            HStack{
                Text("\(self.monthViewItem.month)")
                    .frame(width: cellWith, height: cellHeight)
                    .font(.title)
                Text(String(self.monthViewItem.year))
                    .font(.title)
                Spacer()
            }
            MonthGridStackView(daysList: self.$monthViewItem.daysList)
        }
    }
    
    
}
