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
    var body: some View {
        NavigationView{
        ZStack{
            VStack {
                List{
                    ForEach(orderVM.historyOrderList, id: \.self){ order in
                        NavigationLink(destination: OrdersInDetail(showHistory: self.$showHistory, orderDetail: order)) {
                            Text("Customer Name: \(order.cName) \nOrder Id: \(order.id ?? "")")
                        }
                        }
                }
            }.edgesIgnoringSafeArea(.all).padding(.top, 30)
                .navigationBarTitle(Text("History Of Orders"))
        }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
