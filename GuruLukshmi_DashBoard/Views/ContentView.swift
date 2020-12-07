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
    let adminText = Text("ADMIN").foregroundColor(.orange)
    @Environment(\.colorScheme) var colorScheme
    
    init() {
        self.orderVM.fetchData()
    }
    var body: some View {
        
        if status{
            NavigationView{
                ZStack{
                    if colorScheme == .dark {
                        Color.init(UIColor.secondarySystemBackground).edgesIgnoringSafeArea(.all)
                    }else{
                        Color.black.opacity(0.9).edgesIgnoringSafeArea(.all)
                    }
                    
                    VStack{
                        Text(isAdmin ? "\(adminText)\nDASHBOARD" : "DASHBOARD").foregroundColor(.white)
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                        if !isAdmin {
                            Text("Current Orders: \(self.orderVM.orderList.count)").padding().border(Color.green, width: 3)
                                .font(.title).foregroundColor(.white)
                        }
                        List{
                            
                            //if user is staff show them this menu
                            if !isAdmin{
                                NavigationLink(destination: CurrentOrders()) {
                                    Text("Current Orders")
                                }
                                
                            }
                            
                            //if user is admin or staff member then show them this menu
                            NavigationLink(destination: RecentOrdersView()) {
                                Text("Recent Orders")
                            }
                            
                            NavigationLink(destination: HistoryView()) {
                                Text("Search Orders")
                            }
                            
                            //if user is admin then show this menu
                            if isAdmin{
                                NavigationLink(destination: AnalyticalView()) {
                                    Text("Analytics")
                                }
                                
                                NavigationLink(destination: AddFoodFormView()) {
                                    Text("Edit Food")
                                }
                                
                                NavigationLink(destination: AddCategoryFormView()) {
                                    Text("Edit Category")
                                }
                                
                            }
                            
                        }
                        Spacer()
                        NavigationLink(destination: AdminSettingView( model: model)) {
                            Text("Settings")
                                .font(.system(size: 20))
                                .foregroundColor(.orange)
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

