//
//  ContentView.swift
//  GuruLukshmi_DashBoard
//
//  Created by Xcode User on 2020-09-29.
//  Copyright © 2020 Xcode User. All rights reserved.
//


import SwiftUI
import LocalAuthentication

struct ContentView: View {
    var arrString = ["Orders" , "History"]
    @ObservedObject var orderVM = OrderViewModel()
    @State var currentOrders = 0
    @AppStorage("log_Status") var status = false
    @StateObject var model = UserObjectModelData()
    
    init() {
        self.orderVM.fetchData()
    }
    var body: some View {
        
        if status{
            NavigationView{
                ZStack{
                    Color.black.opacity(0.9).edgesIgnoringSafeArea(.all)
                    
                    VStack{
                        Text("DASHBOARD").foregroundColor(.white)
                            .font(.largeTitle)
                        Text("Current Orders: \(self.orderVM.orderList.count)").padding().border(Color.green, width: 3)
                            .font(.title).foregroundColor(.white)
                        Button(action: model.logOut,
                               label: {
                                    Text("LogOut")
                                        .foregroundColor(.orange)
                                        .fontWeight(.bold)
                                })
                        List{
                            NavigationLink(destination: CurrentOrders()) {
                                Text("Current Orders")
                            }
                            NavigationLink(destination: HistoryView()) {
                                Text("History")
                            }
                            NavigationLink(destination: AnalyticalView()) {
                                Text("Analytics")
                            }
                            
                        }
                    }
                }.onAppear{
                    self.currentOrders = self.orderVM.orderList.count
                }
            }
        }
        else{
            LoginView(model: model)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

