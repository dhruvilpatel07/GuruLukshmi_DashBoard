//
//  AnalyticalView.swift
//  GuruLukshmi_DashBoard
//
//  Created by Xcode User on 2020-10-10.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import SwiftUI

struct AnalyticalView: View {
    
    @ObservedObject var orderVM = OrderViewModel()
    @State var orderCount : CGFloat = 500.0
    @State var orderCount1 = 00
        
    static let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }()
    
    var body: some View {

        HStack(spacing: 10.0){
            ForEach(0..<7, id: \.self) { x in
            
                //yVal = Swift.min(order/10, 150)
                
                VStack{
                    Text(String(self.orderCount1))
                        .font(.caption)
                        .foregroundColor(Color.black)
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 25, height:CGFloat(self.orderVM.historyOrderList.count))
                    // Text("\(orderVM.historyOrderList, formatter: AnalyticalView.self.dateFormatter)")
                }.onAppear{
                    //self.orderVM.fetchHistoryDataByDate(date: Double(Date().timeIntervalSince1970))
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(15)
        .padding(10)
            .onAppear{//self.orderCount = CGFloat(self.orderVM.historyOrderList.count)
                self.orderCount1 = self.orderVM.historyOrderList.count
        }
    }
}

struct AnalyticalView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticalView()
    }
}
