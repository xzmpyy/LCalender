### 简介 Description
一个用SwiftUI编写的横向滑动日期视图

A Lateral Sliding Calendar View Made In SwiftUI

![avatar](https://raw.githubusercontent.com/xzmpyy/LCalender/master/CalendarView.gif)

*****
### 添加说明 Add To Your Project
请下载压缩包后解压，将解压后的文件添加至工程

You can downLoad the zip from releases,add into your project after unzip the zip

*****
### 使用样例 Demo
```swift
struct ContentView: View {
    
    var body: some View {
        VStack {
            CalendarView(viewWidth: UIScreen.main.bounds.width,
                         onDayItemClicked: self.onDayItemClicked(year:month:day:))
            Spacer()
        }
    }
    
    func onDayItemClicked(year: Int, month: Int, day: Int){
        print("\(year)-\(month)-\(day)")
    }
    
```

*****
## 颜色设置 Color Settings
在CalendarView.swift中设置相关变量

You can set the colors in CalendarView.swift
```swift
let CalendarBackgroundColor = Color("CalendarBackgroundColor")
let AccentColorInCalendar = Color("AccentColorInCalendar")
let TextColor = Color.primary
```

*****
## 设置日期点击的回调函数 Set completion on item clicked 
在初始化CalendarView时，自定义实现并传入onDayItemClicked参数

You need to implements and transmit the completion function when initialize the CalendarView
```swift
func onDayItemClicked(year: Int, month: Int, day: Int){
    print("\(year)-\(month)-\(day)")
}
```

*****
## 自定义日期选中效果 Customize the selected effect
重写CalendarGridView.swift中的结构体SelectedBar

You need to rebuild the struct SelectedBar in CalendarGridView.swift
```swift
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
```

*****
## 自定义日期背景 Customize the background which need to show different
需要在MonthViewItem.swift中重写isShowBackground方法，用以决定哪些日期需显示背景

At first,you need to rebuild the function isShowBackground in MonthViewItem.swift,it decide which item will show the background
```swift
func isShowBackground(year: Int, month:Int, day: Int) -> Bool{
    if day % 2 == 0{
        return true
    }
    return false
}
```
再在CalendarGridView.swift中重写结构体DayItemBackground

then, you need to rebuild the struct DayItemBackground in CalendarGridView.swift
```swift
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
```

*****

## 版本说明 Version Info

| Version        | iOS Deployment Target   | Xcode   |
| :----:   | :----:  | :----:  |
| 0.1      | 13.0  | 11.5  |
