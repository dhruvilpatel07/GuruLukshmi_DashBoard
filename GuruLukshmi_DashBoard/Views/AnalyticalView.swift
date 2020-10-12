//
//  AnalyticalView.swift
//  GuruLukshmi_DashBoard
//
//  Created by Xcode User on 2020-10-10.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import SwiftUI
import Firebase


struct AnalyticalView: View {
    
    @ObservedObject var orderVM = OrderViewModel()
    @State var pickerSelectedItem = 1
    @StateObject var model = UserObjectModelData()
    @State var dataPoints: [[CGFloat]] = [
        [50, 38, 139, 160, 56, 93, 80],
        [120, 60, 12, 100, 63, 39, 189],
        [200, 176, 23, 88, 7, 49, 80]
    ]
    @State var dataPoints1: [[CGFloat]] = [
        [],
        [120, 60, 12, 100, 63, 39, 189],
        [200, 176, 23, 88, 7, 49, 80]
    ]
    @State var day1 = 0
    @State var day2 = 0
    @State var day3 = 0
    @State var val = 0
    @State var dates: [String] = ["Oct 1","Oct 2","Oct 3","Oct 4","Oct 5","Oct 6","Oct 7"]
    
    
    init() {
        // subtracting one day from current date
        //self.orderVM.fetchHistoryDataByDate(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
        
        //getting data from todays data 
        self.orderVM.fetchHistoryDataByDate(date: Date())
            print("Day :1 \(self.orderVM.historyOrderListByDate.count)")
        self.day1 = self.orderVM.historyOrderListByDate.count
        self.orderVM.fetchHistoryDataByDate(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
            print("Day :2 \(self.orderVM.historyOrderListByDate.count)")
        self.day2 = self.orderVM.historyOrderListByDate.count
        self.orderVM.fetchHistoryDataByDate(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!)
            print("Day :3 \(self.orderVM.historyOrderListByDate.count)")
        self.day3 = self.orderVM.historyOrderListByDate.count
       
        
    }
    
    var body: some View {

        ZStack{
            Color.orange.opacity(0.6).edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("Sales")
                    .font(.system(size: 45))
                    .bold()
                
                Picker(selection: $pickerSelectedItem, label: Text("")){
                    Text("Daily").tag(1)
                    Text("Weekly").tag(2)
                    Text("Monthly").tag(3)
                }.pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 25)
                
                HStack(spacing: 30.0){
                    ForEach(0..<7){ x in
                        
                        BarChart(value: dataPoints[pickerSelectedItem - 1][x], dateString: dates[x])
                    }
                   
                }.padding(.top, 30)
                .animation(.default)
            }
            
        }.onAppear{
            
            print("HEYYYY23")
            print(Date.currentTimeStamp)
            print("Day : 1 \(self.day1) \nDay : 2 \(self.day2) \nDay : 3 \(self.day3)")
            print(self.orderVM.historyOrderListByDate.count)
        }
        
    }
}

struct AnalyticalView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticalView()
    }
}

struct BarChart: View {
    var value: CGFloat
    var dateString: String
    var body: some View{
        VStack{
            ZStack(alignment: .bottom){
                Capsule().frame(width: 30, height: 200).foregroundColor(Color.orange.opacity(0.6))
                Capsule().frame(width: 30, height: value).foregroundColor(.white)
            }
            Text(dateString).padding(.top, 10)
        }
    }
}
