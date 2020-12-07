//
//  RecentOrdersView.swift
//  GuruLukshmi_DashBoard
//
//  Created by Dhruvil Patel on 2020-11-11.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import SwiftUI

struct RecentOrdersView: View {
    @ObservedObject var orderVM = OrderViewModel()
    @State var showHistory = false
    
    var body: some View {
        var orderList = orderVM.historyOrderList
        NavigationView{
            ZStack{
                VStack {
                    Button(action: {
                        self.orderVM.fetchHistoryData()
                        orderList = self.orderVM.historyOrderList
                    }, label: {
                        Text("View All Orders")
                    }).padding(.leading, 50)
                    .padding(.bottom, 20)
                    
                    Button(action: {
                        self.orderVM.fetchHistoryDataWithLimit()
                        orderList = self.orderVM.historyOrderList
                    }, label: {
                        Text("View Recent Orders")
                    }).padding(.leading, 50)
                    
                    List{
                        ForEach(orderList, id: \.self){ order in
                            NavigationLink(destination: OrdersInDetail(showHistory: self.$showHistory, orderDetail: order)) {
                                Text("Customer Name: \(order.cName!) \nOrder Id: \(order.orderId ?? "")")
                            }
                        }
                    }
                }.edgesIgnoringSafeArea(.all).padding(.top, 30)
                .navigationBarTitle(Text("Recent Orders"))
            }
        }
    }
}

struct RecentOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        RecentOrdersView()
    }
}
