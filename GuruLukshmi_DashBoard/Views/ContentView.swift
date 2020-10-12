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
    @AppStorage("admin_Status") var isAdmin = false
    
    init() {
        self.orderVM.fetchData()
    }
    var body: some View {
        
        if status{
            NavigationView{
                ZStack{
                    Color.black.opacity(0.9).edgesIgnoringSafeArea(.all)
                    
                    VStack{
                        Text(isAdmin ? "ADMIN\nDASHBOARD" : "DASHBOARD").foregroundColor(.white)
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                        if !isAdmin {
                            Text("Current Orders: \(self.orderVM.orderList.count)").padding().border(Color.green, width: 3)
                                .font(.title).foregroundColor(.white)
                        }
                        Button(action: model.logOut,
                               label: {
                                    Text("LogOut")
                                        .foregroundColor(.orange)
                                        .fontWeight(.bold)
                                })
                        List{
                            
                            //if user is staff show them this menu
                            if !isAdmin{
                                NavigationLink(destination: CurrentOrders()) {
                                    Text("Current Orders")
                                }
                            }
                            
                            //if user is admin or staff member then show them this menu
                            NavigationLink(destination: HistoryView()) {
                                Text("History")
                            }
                            
                            //if user is admin then show this menu
                            if isAdmin{
                                NavigationLink(destination: AnalyticalView()) {
                                    Text("Analytics")
                                }
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

