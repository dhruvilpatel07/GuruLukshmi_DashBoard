//
//  GraphSwiftUI.swift
//  GuruLukshmi_DashBoard
//
//  Created by Dhruvil Patel on 2020-10-11.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import SwiftUI

struct GraphSwiftUI: View {
    @State var pickerSelectedItem = 1
    //@ObservedObject var orderVM = OrderViewModel()
    @StateObject var model = UserObjectModelData()
    @State var dataPoints: [[CGFloat]] = [
        [50, 38, 139, 160, 56, 93, 80],
        [120, 60, 12, 100, 63, 39, 189],
        [200, 176, 23, 88, 7, 49, 80]
    ]
    @State var val = 0
    @State var dates: [String] = ["Oct 1","Oct 2","Oct 3","Oct 4","Oct 5","Oct 6","Oct 7"]
    
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
                   
                    //BarChart(value: dataPoints[pickerSelectedItem - 1][1], dateString: dates[1])
                    //BarChart(value: dataPoints[pickerSelectedItem - 1][2], dateString: dates[2])
                    //BarChart(value: dataPoints[pickerSelectedItem - 1][3], dateString: dates[3])
                }.padding(.top, 30)
                .animation(.default)
            }
        }
    }
}

struct GraphSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        GraphSwiftUI()
    }
}

/*
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
*/
