//
//  AnalyticalView.swift
//  GuruLukshmi_DashBoard
//
//  Created by Xcode User on 2020-10-10.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import SwiftUI
import Firebase
import SwiftUICharts


struct AnalyticalView: View {
    
    @ObservedObject var orderVM = OrderViewModel()
    @State var pickerSelectedItem = 1
    @StateObject var model = UserObjectModelData()
    @State var dataPoints: [[Double]] = [
        [50, 38, 139, 160, 56, 93, 80],
        [120, 60, 12, 100, 63, 39, 189],
        [200, 176, 23, 88, 7, 49, 80]
    ]
    @State var dataPoints1: [[CGFloat]] = [
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //Hourly
        [0, 0, 0, 0, 0, 0, 0], //weekly
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] // monthly
    ]
    @State var dates: [[String]] = [
        ["12 PM", "1 PM", "2 PM", "3 PM", "4 PM", "5 PM", "6 PM", "7 PM", "8 PM", "9 PM"],
        Date.getDates(forLastNDays: 7),
        ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    ]
    
    @State var sample1 : [ChartCellModel] = []
    @State var colorArray : [Color] = [Color.red, Color.yellow, Color.green, Color.blue, Color.purple]
    
    var body: some View {
        
        ZStack{
            Color.orange.opacity(0.6).edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical) {
                
                VStack(spacing: 20.0){
                    //Sales Graph
                    //Image(systemName: "arrow.right").font(.largeTitle)
                        
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
                        
                        if pickerSelectedItem == 1 {
                            ForEach(0..<10){ x in
                                BarChart(value: dataPoints1[pickerSelectedItem - 1][x], dateString: dates[pickerSelectedItem - 1][x])
                            }
                        }else if pickerSelectedItem == 2{
                            ForEach(0..<7){ x in
                                BarChart(value: dataPoints1[pickerSelectedItem - 1][x], dateString: dates[pickerSelectedItem - 1][x])
                            }
                            /*LineView(data: dataPoints[0], legend: "# of order", style: ChartStyle(backgroundColor: .clear, accentColor: .white, gradientColor: GradientColors.green, textColor: .white, legendTextColor: .black, dropShadowColor: .red)).frame(width: 1000, height: 600)*/
                        }else{
                            ForEach(0..<12){ x in
                                BarChart(value: dataPoints1[pickerSelectedItem - 1][x], dateString: dates[pickerSelectedItem - 1][x])
                            }
                        }
                        
                    }.padding(.top, 30)
                    .animation(.default)
                    
                    //Most Item sold soo far
                    //PieChartView(data: dataPoints[0], title: "Item Sold")
                    CustomePieChartView(sample1: sample1)//.frame(width: 400, height: 400, alignment: .center)
                    
                }
            }
            
        }.onAppear{
            print(self.orderVM.listOfMostItemSold)
            for num in 0..<10{
                self.dataPoints1[0][num] = CGFloat(self.orderVM.historyOrderListByHourArrayCount[num] * 10)
            }
            for num in 0..<7{
                self.dataPoints1[1][num] = CGFloat(self.orderVM.historyOrderListByDateArrayCount[num] * 10)
            }
            for num in 0..<12{
                self.dataPoints1[2][num] = CGFloat(self.orderVM.historyOrderListByMonthArrayCount[num] * 10)
            }
            var x = 0
            for foodItem in self.orderVM.listOfMostItemSold{
                self.sample1.append(ChartCellModel(color: self.colorArray[x], value: CGFloat(foodItem.numberOfItemSold!), name: foodItem.foodName))
                x += 1
            }
            
            print("INSIDE ANALYTIC\(self.sample1)")
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
            Text("\(String( format: "%.0f" ,value))").padding(.top, 10)
            ZStack(alignment: .bottom){
                Capsule().frame(width: 30, height: 300).foregroundColor(Color.orange.opacity(0.6))
                Capsule().frame(width: 30, height: value).foregroundColor(.white)
            }
            Text(dateString).padding(.top, 10)
        }
    }
}
