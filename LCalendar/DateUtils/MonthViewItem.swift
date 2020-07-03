//
//  MonthViewItem.swift
//  LCalendar
//
//  Created by 张捷 on 2020/6/22.
//  Copyright © 2020 张捷. All rights reserved.
//

import Foundation

//代表一个月视图的数据结构体
struct MonthViewItem {
    
    var year: Int
    var month: Int
    var days: Int
    var firstDayOfWeek: Int
    //7*6的日期列表，-1代表空
    var daysList: [Int] = [Int]()
    
    init(year: Int, month: Int) {
        self.year = year
        self.month = month
        let daysComps = DateUtils.shared.getDaysInMonth(year: year, month: month)
        self.days = daysComps.days
        self.firstDayOfWeek = daysComps.firstDayOfWeek
        
        if self.firstDayOfWeek > 0{
            for _ in 0 ..< self.firstDayOfWeek{
                self.daysList.append(-1)
            }
        }
        for day in 1 ... self.days{
            self.daysList.append(day)
        }
        if self.daysList.count < 42 {
            for _ in self.daysList.count ... 42{
                self.daysList.append(-1)
            }
        }
        
    }
    
    /// 更新当前月视图结构体数据
    /// - Parameters:
    ///     - year: 设置年份
    ///     - month: 设置月份
    mutating func setDateInfo(year: Int, month: Int){
        self.year = year
        self.month = month
        //获取当月天数和第一天是周几(周日是0)
        let daysComps = DateUtils.shared.getDaysInMonth(year: year, month: month)
        self.days = daysComps.days
        self.firstDayOfWeek = daysComps.firstDayOfWeek
        
        self.daysList.removeAll()
        
        //根据天数不全日期列表
        //若当月第一天非周日，在前面补-1
        if self.firstDayOfWeek > 0{
            for _ in 0 ..< self.firstDayOfWeek{
                self.daysList.append(-1)
            }
        }
        //填充日期列表
        for day in 1 ... self.days{
            self.daysList.append(day)
        }
        //若列表长度不足7*6，补-1
        if self.daysList.count < 42 {
            for _ in self.daysList.count ... 42{
                self.daysList.append(-1)
            }
        }
    }
    
}
