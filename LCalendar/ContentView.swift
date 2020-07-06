//
//  ContentView.swift
//  LCalendar
//
//  Created by 张捷 on 2020/6/19.
//  Copyright © 2020 张捷. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            CalendarView(viewWidth: UIScreen.main.bounds.width)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ContentView().previewDevice("iPhone Xs Max")
//            ContentView().previewDevice("iPhone X")
//            ContentView().previewDevice("iPhone 8 Plus")
//            ContentView().previewDevice("iPhone 8")
        }
    }
}
