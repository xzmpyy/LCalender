//
//  MonthViewItemList.swift
//  LCalendar
//
//  Created by 张捷 on 2020/6/24.
//  Copyright © 2020 张捷. All rights reserved.
//

import SwiftUI

class MonthViewItemList{
    
    
    init() {
        let dateShared = DateUtils.shared
        //四个月视图轮播，初始化显示第二个视图，代表今日
        //视图1
        var firstYear = dateShared.getPrevious(year: yearNow, month: monthNow).Year
        var firstMonth = dateShared.getPrevious(year: yearNow, month: monthNow).previousMonth
        //视图2
        var secondYear = yearNow
        var sencondMonth = monthNow
        //视图3
        var thirdYear = dateShared.getNext(year: yearNow, month: monthNow).Year
        var thirdMonth = dateShared.getNext(year: yearNow, month: monthNow).nextMonth
        var fourthYear = dateShared.getNext(year: self.thirdYear, month: self.thirdMonth).Year
        var fourthMonth = dateShared.getNext(year: self.thirdYear, month: self.thirdMonth).nextMonth
    }
    
    
}
