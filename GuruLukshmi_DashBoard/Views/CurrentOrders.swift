//
//  CurrentOrders.swift
//  GuruLukshmi_Kiosk
//
//  Created by Xcode User on 2020-09-20.
//

import SwiftUI

struct CurrentOrders: View {
        
    @State private var showingAlert = false
    @ObservedObject var orderVM = OrderViewModel()
    @State private var deleteIndexSet: IndexSet?
    @State var showHistory = true
    
    var body: some View {
        NavigationView{
        ZStack{
            VStack {
                List{
                    ForEach(orderVM.orderList, id: \.self){ order in
                        
                        NavigationLink(destination: OrdersInDetail(showHistory: self.$showHistory, orderDetail: order)) {
                            Text("\(order.isDineIn ? "Table # : - \(String(order.tableNumber ?? 0))" :  "Customer Name: - \(String(order.cName!))") \n--                                  \(order.isDineIn ? "Dine In" : "Take Out")").bold()
                        }
                        }
                }
            }.edgesIgnoringSafeArea(.all).padding(.top, 30)
                .navigationBarTitle(Text("Current Orders"))
        }
        }
    }
}


struct CurrentOrders_Previews: PreviewProvider {
    static var previews: some View {
        CurrentOrders()
    }
}
