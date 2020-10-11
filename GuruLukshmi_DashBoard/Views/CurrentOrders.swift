//
//  CurrentOrders.swift
//  GuruLukshmi_Kiosk
//
//  Created by Dhruvil Patel on 2020-09-20.
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
                            Text("Customer Name: \(order.cName) \nOrder Id: \(order.id ?? "")")
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

/*struct swipeGesture : UIViewRepresentable {
    
    func makeCoordinator() -> swipeGesture.Coordinator {
        return swipeGesture.Coordinator()
    }
    
    func makeUIView(context: UIViewRepresentableContext<swipeGesture>) -> UIView   {
        
        let view = UIView()
        view.backgroundColor = .clear
        
        let left = UISwipeGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.left))
        left.direction = .left
        
        view.addGestureRecognizer(left)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<swipeGesture>) {
        
    }
    
    class Coordinator: NSObject {
        @ObservedObject var orderVM = OrderViewModel()
        @EnvironmentObject var envObj: GlobalVariables
        @objc func left(){
            print("ADDED TO HISTORY")
            
        }
    }*/
    

    
