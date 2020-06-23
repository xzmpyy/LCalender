//
//  ContentView.swift
//  LCalendar
//
//  Created by 张捷 on 2020/6/19.
//  Copyright © 2020 张捷. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var monthViewItem = MonthViewItem(year: 2020, month: 6)
    
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
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
