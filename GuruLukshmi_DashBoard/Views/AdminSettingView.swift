//
//  AdminSettingView.swift
//  GuruLukshmi_DashBoard
//
//  Created by Dhruvil Patel on 2020-10-13.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import SwiftUI

struct AdminSettingView: View {
    @ObservedObject var db = UserDatabaseConnection()
    @ObservedObject var model : UserObjectModelData
    var body: some View {
        Form {
            if model.isAdmin {
                Section(header: Text("Access Code")) {
                    HStack {
                        Text("Acess Code")
                        Spacer()
                        Text("\(db.accessCode[0].code)").foregroundColor(.gray)
                    }
                   
                }
            }
            
            Section {
                Button(action: model.logOut,
                   label: {
                        Text("LogOut")
                            .foregroundColor(.red)
                    })
                }
        }
        .navigationBarTitle("Settings")
    }
}

struct AdminSettingView_Previews: PreviewProvider {
    static var previews: some View {
        AdminSettingView( model: UserObjectModelData())
    }
}
