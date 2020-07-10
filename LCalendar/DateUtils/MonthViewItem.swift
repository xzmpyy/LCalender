//
//  MonthViewItem.swift
//  LCalendar
//
//  Created by 张捷 on 2020/6/22.
//  Copyright © 2020 张捷. All rights reserved.
//

import SwiftUI

//代表一个月视图的数据结构体
struct MonthViewItem {
    
    var year: Int
    var month: Int
    var days: Int
    var firstDayOfWeek: Int
    //7*6的日期列表，-1代表空
    var daysList: [Int] = [Int]()
    //是否显示日期背景的列表
    var isShowBackgroundList: [Bool] = [Bool]()
    
    init(year: Int, month: Int) {
        self.year = year
        self.month = month
        let daysComps = DateUtils.shared.getDaysInMonth(year: year, month: month)
        self.days = daysComps.days
        self.firstDayOfWeek = daysComps.firstDayOfWeek
        
        if self.firstDayOfWeek > 0{
            for _ in 0 ..< self.firstDayOfWeek{
                self.daysList.append(-1)
                self.isShowBackgroundList.append(false)
            }
        }
        for day in 1 ... self.days{
            self.daysList.append(day)
            self.isShowBackgroundList.append(self.isShowBackground(year: year, month: month, day: day))
        }
        if self.daysList.count < 42 {
            for _ in self.daysList.count ... 42{
                self.daysList.append(-1)
                self.isShowBackgroundList.append(false)
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
        self.isShowBackgroundList.removeAll()

        //根据天数不全日期列表
        //若当月第一天非周日，在前面补-1
        if self.firstDayOfWeek > 0{
            for _ in 0 ..< self.firstDayOfWeek{
                self.daysList.append(-1)
                self.isShowBackgroundList.append(false)
            }
        }
        
        //填充日期列表
        for day in 1 ... self.days{
            self.daysList.append(day)
            self.isShowBackgroundList.append(self.isShowBackground(year: year, month: month, day: day))
        }
        //若列表长度不足7*6，补-1
        if self.daysList.count < 42 {
            for _ in self.daysList.count ... 42{
                self.daysList.append(-1)
                self.isShowBackgroundList.append(false)
            }
        }
    }
    
    /// 设置是否显示该日期下的背景
    /// - Parameters:
    ///     - year: 年份
    ///     - month: 月份
    ///     - month: 日
    func isShowBackground(year: Int, month:Int, day: Int) -> Bool{
        if day % 2 == 0{
            return true
        }
        return false
    }
    
    
}
