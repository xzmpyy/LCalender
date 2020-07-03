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
    //月视图数据源
    @Binding var daysList: [Int]
    let cellSize: CGFloat
    
    //使用VStack嵌套HStack达到网格效果
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< rows) { row in
                HStack(spacing: 0) {
                    ForEach(0 ..< self.columns) { column in
                        //获取对应行列单元格在月视图数据源日期数组中的索引位置
                        //若值为-1代表该单元格不在该月日期范围内，不显示内容
                        if self.daysList[row * 7 + column] == -1{
                            Spacer()
                        }
                        else{
                            Text("\(self.daysList[row * 7 + column])")
                                .frame(width: self.cellSize, height: self.cellSize)
                        }
                    }
                }
            }
        }
    }
    
}
