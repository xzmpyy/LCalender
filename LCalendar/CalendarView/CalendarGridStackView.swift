//
//  CalendarGridView.swift
//  LCalendar
//
//  Created by 张捷 on 2020/6/23.
//  Copyright © 2020 张捷. All rights reserved.
//

import SwiftUI

//定义了一个必须准守View协议的泛型Content
//代表可提供任意的类型，但提供的这个类型必须准守View协议
struct MonthGridStackView: View {
    //行列数6*7
    let rows: Int = 6
    let columns: Int = 7
    //单元格尺寸
    let cellSize: CGFloat
    let barWidth: CGFloat
    let barHeight: CGFloat
    //月视图数据对象
    @Binding var monthViewItem: MonthViewItem
    //父容器传入的日期选择标识
    @EnvironmentObject var selectDate: SelectedDateItem
    //响应日历点击事件的方法，参数为年、月、日
    var onDayItemClicked: ((Int, Int, Int) -> Void)?
    
    init(cellSize: CGFloat, monthViewItem: Binding<MonthViewItem>, onDayItemClicked: ((Int, Int, Int) -> Void)?) {
        self.cellSize = cellSize
        self.barWidth = cellSize / 4 * 3
        self.barHeight = cellSize / 10
        self._monthViewItem = monthViewItem
        if onDayItemClicked != nil{
            self.onDayItemClicked = onDayItemClicked
        }
    }
    
    //使用VStack嵌套HStack达到网格效果
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< self.rows , id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0 ..< self.columns, id: \.self) { column in
                        //获取对应行列单元格在月视图数据源日期数组中的索引位置
                        //若值为-1代表该单元格不在该月日期范围内，不显示内容
                        Group{
                            if self.monthViewItem.daysList[row * 7 + column] == -1{
                                CalendarBackgroundColor
                                .frame(width: self.cellSize, height: self.cellSize)
                            }
                            else{
                                ZStack {
                                    //是否显示日期单元格背景
                                    if "\(self.monthViewItem.isShowBackgroundList[row * 7 + column])" == "true"{
                                        DayItemBackground(cellWidth: self.cellSize)
                                    }
                                    //是否显示日期选中的标识
                                    if self.selectDate.year == self.monthViewItem.year && self.selectDate.month == self.monthViewItem.month{
                                        if "\(self.selectDate.day)" == "\(self.monthViewItem.daysList[row * 7 + column])"{
                                            SelectedBar(barWidth: self.barWidth, barHeight: self.barHeight)
                                        }
                                    }
                                    //日期显示文字
                                    Text("\(self.monthViewItem.daysList[row * 7 + column])")
                                        .foregroundColor(TextColor)
                                        .frame(width: self.cellSize, height: self.cellSize)
                                }
                                .onTapGesture {
                                    self.selectDate.year = self.monthViewItem.year
                                    self.selectDate.month = self.monthViewItem.month
                                    self.selectDate.day = self.monthViewItem.daysList[row * 7 + column]
                                    //响应日期被点击的回调函数
                                    if self.onDayItemClicked != nil{
                                        self.onDayItemClicked!(self.monthViewItem.year, self.monthViewItem.month, self.monthViewItem.daysList[row * 7 + column])
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
}

//日期被选中效果
struct SelectedBar: View {
    
    let barWidth: CGFloat
    let barHeight: CGFloat
    
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .frame(width: self.barWidth, height: self.barHeight)
                .cornerRadius(20)
        }
    }
}

//日期单元格背景
struct DayItemBackground: View {
    
    let cellWidth: CGFloat
    
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
            .frame(width: self.cellWidth / 10, height: self.cellWidth / 10)
                .clipShape(Circle())
        }
    }
}
