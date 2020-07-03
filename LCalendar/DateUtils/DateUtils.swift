//
//  DateUtils.swift
//  LCalendar
//
//  Created by 张捷 on 2020/6/22.
//  Copyright © 2020 张捷. All rights reserved.
//

import SwiftUI

class DateUtils{
    
    //日期工具类单例
    static let shared = DateUtils()
    
    /// 获取指定年月的上一个月
    /// - Parameters:
    ///     - year: 被计算日期的年份
    ///     - month: 被计算日期的月份
    ///
    /// - Returns: 返回被计算日期上一个月的年份和月份
    func getPrevious(year: Int, month: Int) -> (Year: Int, previousMonth: Int){
        switch month {
        case 1:
            return (year - 1, 12)
        default:
            return (year, month - 1)
        }
    }
    
    /// 获取指定年月的下一个月
    /// - Parameters:
    ///     - year: 被计算日期的年份
    ///     - month: 被计算日期的月份
    ///
    /// - Returns: 返回被计算日期下一个月的年份和月份
    func getNext(year: Int, month: Int) -> (Year: Int, nextMonth: Int){
        switch month {
        case 12:
            return (year + 1, 1)
        default:
            return (year, month + 1)
        }
    }
    
    /// 获取指定年月的当月有几天，1号是周几
    /// - Parameters:
    ///     - year: 被计算日期的年份
    ///     - month: 被计算日期的月份
    ///
    /// - Returns: 返回指定年月的天数，和第一天是周几(周日是0)
    func getDaysInMonth(year: Int, month: Int) -> (days: Int, firstDayOfWeek: Int){
        
        //指定年月第一天
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        //指定年月的下一个月第一天
        var endComps = DateComponents()
        endComps.day = 1
        endComps.month = month == 12 ? 1 : month + 1
        endComps.year = month == 12 ? year + 1 : year
        
        //DateComponents转成Calendar
        let startDate = calendar.date(from: startComps)!
        let endDate = calendar.date(from: endComps)!
        
        //获取指定年月第一天是周几
        let firstDayOfWeek = calendar.dateComponents([.weekday], from: startDate).weekday! - 1
        //计算日期差值即为指定年月天数
        let days = calendar.dateComponents([.day], from: startDate, to: endDate).day!
        
        return (days, firstDayOfWeek)
    }
    
}

//当前日历
let calendar = Calendar.current
//当前年月日
let dateNow = Date()
let yearNow = calendar.component(.year, from: dateNow)
let monthNow = calendar.component(.month, from: dateNow)
let dayNow = calendar.component(.day, from: dateNow)
let pre = DateUtils.shared.getPrevious(year: yearNow, month: monthNow)
let next = DateUtils.shared.getNext(year: yearNow, month: monthNow)
let afterNext = DateUtils.shared.getNext(year: next.Year, month: next.nextMonth)
//月视图顶部星期标题
let weekTitle = ["S", "M", "T", "W", "T", "F", "S"]


