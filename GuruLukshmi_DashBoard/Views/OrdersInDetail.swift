//
//  OrdersInDetail.swift
//  DashBoard
//
//  Created by Xcode User on 2020-09-20.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import SwiftUI

struct OrdersInDetail: View {
    @State private var showingAlert = false
    @Binding var showHistory : Bool
    @ObservedObject var orderVM = OrderViewModel()
    var orderDetail: Orders
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        
        ZStack {
            Color.init(UIColor.secondarySystemBackground).edgesIgnoringSafeArea(.all)
            VStack(spacing: !showHistory ? 60 : 80){
                VStack(spacing: 10){
                    HStack{
                        
                        Text("Customer name: \(Text(orderDetail.cName!).font(.system(size: 20, weight: Font.Weight.light, design: Font.Design.rounded)))")
                            .font(.system(size: 20, weight: Font.Weight.bold, design: Font.Design.rounded))
                        Spacer()
                        Text("Order Type: \(orderDetail.isDineIn ? Text("Dine-In").font(.system(size: 20, weight: Font.Weight.light, design: Font.Design.rounded)) : Text("Take-Out").font(.system(size: 20, weight: Font.Weight.light, design: Font.Design.rounded)))")
                            .font(.system(size: 20, weight: Font.Weight.bold, design: Font.Design.rounded))
                    }.padding(.horizontal, 20)
                    HStack{
                        Text("Ordered Time: \(Text(orderDetail.orderedTimeInString ?? "").font(.system(size: 20, weight: Font.Weight.light, design: Font.Design.rounded)))")
                            .font(.system(size: 20, weight: Font.Weight.bold, design: Font.Design.rounded))
                        Spacer()
                        if orderDetail.isDineIn{
                            Text("Table # : \(Text(String(orderDetail.tableNumber ?? 0)).font(.system(size: 20, weight: Font.Weight.light, design: Font.Design.rounded)))")
                                .font(.system(size: 20, weight: Font.Weight.bold, design: Font.Design.rounded))
                        }
                    }.padding(.horizontal, 20)
                    if !self.showHistory{
                        HStack{
                            Text("Customer email: \(Text(orderDetail.cEmail ?? "").font(.system(size: 20, weight: Font.Weight.light, design: Font.Design.rounded)))")
                                .font(.system(size: 20, weight: Font.Weight.bold, design: Font.Design.rounded))
                            Spacer()
                            Text("Amount paid: \(Text(String(format: "$ %.2f", orderDetail.orderSubTotal )).font(.system(size: 20, weight: Font.Weight.light, design: Font.Design.rounded)))")
                                .font(.system(size: 20, weight: Font.Weight.bold, design: Font.Design.rounded))
                        }.padding(.horizontal, 20)
                       
                    }
                }.overlay(
                    Text("Order #: \(Text(orderDetail.orderId ?? "").font(.system(size: 20, weight: Font.Weight.light, design: Font.Design.rounded)))")
                        .font(.system(size: 20, weight: Font.Weight.bold, design: Font.Design.rounded))
                        .offset(x: 0, y: -100)
                )
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 10){
                        ForEach(orderDetail.listOfOrder){ eachOrder in
                            DisplayOrder(food: eachOrder).cornerRadius(15)
                        }
                    }
                }.padding(.horizontal, 30)
                HStack(spacing: 100){
                    //Print Button
                    Button(action: {
                        self.showingAlert = true
                    }) {
                        Text("Print Order").padding().frame(width: 300, alignment: .center)
                            .foregroundColor(Color.black)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 2)
                                    .background(Color.newPrimaryColor.cornerRadius(10))
                        )
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Order is Printing"), dismissButton: .default(Text("OK")))
                    }
                    if self.showHistory {
                        
                        
                        Button(action: {
                            //Order Complete button
                            self.orderVM.addToHistory(self.orderDetail)
                            self.orderVM.deleteOrder(self.orderDetail)
                            self.mode.wrappedValue.dismiss()
                            
                        }) {
                            Text("Order Complete").padding().frame(width: 300, alignment: .center)
                                .foregroundColor(Color.black)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 2)
                                        .background(Color.green.cornerRadius(10))
                            )
                        }
                    }
                }
            }
        }
    }
    
    
    
    struct OrdersInDetail_Previews: PreviewProvider {
        static var previews: some View {
            OrdersInDetail(showHistory: .constant(true), orderDetail: Orders(isDineIn: false))
        }
    }
}
