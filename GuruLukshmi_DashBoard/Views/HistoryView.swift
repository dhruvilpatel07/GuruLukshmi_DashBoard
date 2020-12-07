//
//  HistoryView.swift
//  GuruLukshmi_DashBoard
//
//  Created by Xcode User on 2020-09-30.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var orderVM = OrderViewModel()
    @State var showHistory = false
    @State var orderID = ""
    @State var date = Date()
    // @State var orderList = [Orders]()
    
    
    var body: some View {
        var orderList = orderVM.historyOrderList1
        //NavigationView{
        ZStack{
            HStack {
                VStack(alignment: .leading) {
                    
                    Text("By orderId: ").font(.headline)
                    
                    HStack {
                        TextField("Enter Order ID", text: $orderID)
                            .font(.system(size: 20, weight: Font.Weight.bold, design: Font.Design.rounded))
                            .background(Color.init(UIColor.secondarySystemBackground))
                            .frame(width: 150)
                            .cornerRadius(5.0)
                            .padding(.leading, 130)
                            .multilineTextAlignment(.center)
                        
                        //Search by orderID
                        Button(action: {
                            self.orderVM.fetchHistoryData1(orderId: orderID)
                            orderList = self.orderVM.historyOrderList1
                            // print(o)
                        }, label: {
                            Image(systemName: "arrow.right").font(.system(size: 20, weight: Font.Weight.bold, design: Font.Design.rounded))
                        })
                    }.padding(.bottom)
                    Spacer()
                    Divider()
                    Spacer()
                    Text("By Date: ").font(.headline)
                    
                    DatePicker("Select date", selection: $date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                        
                   
                    // serach by date
                    Button(action: {
                        self.orderID = ""
                        self.orderVM.fetchHistoryDataByCustomDateArray(date: date)
                        orderList = self.orderVM.historyOrderList1
                        
                    }) {
                        Text("Search by date").padding().frame(width: 200, alignment: .center)
                            .foregroundColor(Color.black)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 2)
                                    .background(Color.green.opacity(0.9).cornerRadius(10))
                            )
                    }.padding(.top, 20)
                    .padding(.leading, 170)
                    Spacer()
                    
                    
                }.frame(width: 600)
                .edgesIgnoringSafeArea(.all).padding([.top, .leading], 30)
                .navigationBarTitle(Text("Search Orders"))
                
                Spacer()
                ZStack {
                    Color.init(UIColor.secondarySystemBackground).edgesIgnoringSafeArea(.all)
                    VStack(alignment: .leading, spacing: 20.0) {
                            
                        Text("List of orders: ").font(.headline).padding(.leading)
                        List{
                            ForEach(orderList, id: \.self){ order in
                                NavigationLink(destination: OrdersInDetail(showHistory: self.$showHistory, orderDetail: order)) {
                                    Text("Customer Name: \(order.cName!) \nOrder Id: \(order.orderId ?? "")")
                                }
                            }.listRowBackground(Color.init(UIColor.secondarySystemBackground))
                        }
                        .padding(.leading)
                    }
                    .padding(.top, 40.0)
                }.onAppear{
                    UITableView.appearance().backgroundColor = UIColor.clear
                }
                Spacer()
            }
        }
        
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
