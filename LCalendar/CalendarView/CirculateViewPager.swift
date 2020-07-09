//
//  ViewPager.swift
//  LCalendar
//
//  Created by 张捷 on 2020/6/24.
//  Copyright © 2020 张捷. All rights reserved.
//

import SwiftUI

struct CirculateViewPager<Content>: View where Content: View {
    
    //组件宽高
    let viewWidth: CGFloat
    let viewHeight: CGFloat
    //页面切换判定距离
    var minDistanceToChangePage: CGFloat
    //页面最大偏移距离倍数
    let maxOffsetTimes: Int
    //手指在轮播图上的滑动距离
    @State var dragOffset: CGFloat = 0
    //轮播图即将完成左滑或右滑的标记，左滑假，右滑真
    @State var leftOrRight: Bool = false
    //记录各组件的偏移值列表
    @State var viewOffsetList: [CGFloat] = [CGFloat]()
    //轮播显示的View列表
    let viewCount: Int
    let content: (Int) -> Content
    //当页面将被置为最左或最右时触发，Int代表页面的索引，Bool代表是置右还是置左，左为真，右为假
    var monthViewResetToBorderDelegate: ((Int, Bool) -> Void)
    
    //当页面超出范围将要切换时触发的方法，参数为页面索引和重置偏移（至最左为真，置最右为假）
    //let delegate: (Int, Bool) -> Void
    
    /// 轮播图初始化函数
    /// - Parameters:
    ///     - viewWidth: 轮播图宽
    ///     - viewHeight: 轮播图高
    ///     - viewCount: 轮播图个数
    ///     - delegate: 当页面将要切换时触发的方法
    ///     - content: 闭包，根据轮播图索引位置返回对应视图，默认显示index为1的视图
    ///
    /// - Returns: 轮播图View
    init(viewWidth: CGFloat, viewHeight: CGFloat, viewCount: Int, monthViewResetToBorderDelegate: @escaping ((Int, Bool) -> Void), content: @escaping (Int) -> Content){
        self.viewWidth = viewWidth
        self.viewHeight = viewHeight
        self.minDistanceToChangePage = viewWidth / 4
        self.viewCount = viewCount
        //最大偏移倍数为视图个数除以2再向上取整
        self.maxOffsetTimes = viewCount - 2
        self.content = content
        self.monthViewResetToBorderDelegate = monthViewResetToBorderDelegate
    }
    
    var body: some View {
        ZStack{
            ForEach(0 ..< viewCount, id:\.self){ index in
                self.content(index)
                    .frame(maxWidth:self.viewWidth, maxHeight:self.viewHeight)
                    //当视图偏移数组未填充值时，设定常量，当偏移量数组填充后，使用数组中的值
                    .offset(x: self.viewOffsetList.count > 0 ? self.viewOffsetList[index] + self.dragOffset : CGFloat(index - 1) * self.viewWidth)
                    //当视图偏移数组未填充值时，设定常量，当偏移量数组填充后，使用数组中的值计算权重
                    .zIndex(self.viewOffsetList.count > 0 ? (self.leftOrRight ? Double(self.viewOffsetList[index]) : Double(Int(self.viewOffsetList[index]) * -1)) : 0)
                    .animation(.linear)
            }
        }
        .onAppear(){
            if self.viewOffsetList.count == 0{
                //视图显示时，填充视图偏离列表
                for i in 0 ..< self.viewCount{
                    self.viewOffsetList.append(CGFloat(i - 1) * self.viewWidth)
                }
            }
        }
        .gesture(
            DragGesture()
                .onChanged{value in
                    //左滑为负，右滑为正
                    self.dragOffset = value.translation.width
            }
            .onEnded{value in
                //滑动小于三分之一宽度，不切换，超过切换下一个视图
                if abs(value.translation.width) <= self.minDistanceToChangePage
                {
                    self.dragOffset = 0
                }
                else{
                    if value.translation.width > 0{
                        self.leftOrRight = true
                        self.dragOffset = self.viewWidth
                    }else if value.translation.width < 0{
                        self.leftOrRight = false
                        self.dragOffset = -self.viewWidth
                    }
                    //重置各个视图偏移量
                    for index in 0 ..< self.viewOffsetList.count {
                        self.viewOffsetList[index] = self.resetOffset(oldOffset: self.viewOffsetList[index], index: index)
                    }
                }
                self.dragOffset = 0
            }
        )
    }
    
    //滑动完成时，重设各View的offset
    func resetOffset(oldOffset:CGFloat, index: Int) -> CGFloat{
        var newOffset: CGFloat = 0
        //左滑
        if !self.leftOrRight {
            newOffset = oldOffset - self.viewWidth
            //超出左边键，置最右
            if newOffset < CGFloat(-self.maxOffsetTimes) * self.viewWidth{
                self.monthViewResetToBorderDelegate(index, self.leftOrRight)
                newOffset = self.viewWidth
            }
        }
        //右滑
        else if self.leftOrRight {
            newOffset = oldOffset + self.viewWidth
            //超出右边界，置最左
            if newOffset > CGFloat(self.maxOffsetTimes) * self.viewWidth{
                self.monthViewResetToBorderDelegate(index, self.leftOrRight)
                newOffset = -self.viewWidth
            }
        }
        return newOffset
    }
    
}

