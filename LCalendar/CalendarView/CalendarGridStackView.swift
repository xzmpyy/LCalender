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
    @Binding var year: Int
    @Binding var month: Int
    //月视图数据源
    @Binding var daysList: [Int]
    //父容器传入的日期选择标识
    @EnvironmentObject var selectDate: SelectedDateItem
    
    init(cellSize: CGFloat, year: Binding<Int>, month: Binding<Int>, daysList: Binding<[Int]>) {
        self.cellSize = cellSize
        self.barWidth = cellSize / 4 * 3
        self.barHeight = cellSize / 10
        self._year = year
        self._month = month
        self._daysList = daysList
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
                            if self.daysList[row * 7 + column] == -1{
                                Color("CalendarBackgroundColor")
                                .frame(width: self.cellSize, height: self.cellSize)
                            }
                            else{
                                ZStack {
                                    if self.selectDate.year == self.year && self.selectDate.month == self.month{
                                        if "\(self.selectDate.day)" == "\(self.daysList[row * 7 + column])"{
                                            SelectedBar(barWidth: self.barWidth, barHeight: self.barHeight)
                                        }
                                    }
                                    Text("\(self.daysList[row * 7 + column])")
                                    .frame(width: self.cellSize, height: self.cellSize)
                                }
                                .onTapGesture {
                                    self.selectDate.year = self.year
                                    self.selectDate.month = self.month
                                    self.selectDate.day = self.daysList[row * 7 + column]
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
