//
//  LoginView.swift
//  GuruLukshmi_DashBoard
//
//  Created by Xcode User on 2020-10-10.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var model : UserObjectModelData
    var body: some View {
        ZStack{
            Color.newPrimaryColor.opacity(0.4).edgesIgnoringSafeArea(.all)
            VStack{
                
                Spacer(minLength: 0)
                
                ZStack{
                    Image("guru_logo")
                        .resizable()
                        .frame(width: 500, height: 400)
                }
                    .padding(.horizontal)
                    .padding(.vertical,20)
                    .cornerRadius(30)

                
                VStack(spacing: 20){
                    CustomTextFieldView(image: "person", placeHolder: "Email", txt: $model.email)
                    
                    CustomTextFieldView(image: "lock", placeHolder: "Password", txt: $model.password)
                }
                .padding(.top)
                Button(action: model.login) {
                    Text("Login")
                        .fontWeight(.bold)
                        .foregroundColor(.newPrimaryColor)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.top,20)
                
                HStack(spacing: 10){
                    
                    Text("Don't have an account?")
                        .foregroundColor(Color.white.opacity(0.7))
                    
                    Button(action: {model.isSignUp.toggle()}) {
                        
                        Text("Sign Up Now")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .padding(.top,25)
                
                Spacer(minLength: 0)
                
                Button(action: model.resetPassword) {
                    
                    Text("Forget Password?")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.vertical,22)

            }
            
            if model.isLoading{
                
                LoadingView()
            }
        }
        .background(LinearGradient(gradient: .init(colors: [Color.newPrimaryColor,Color.newSecondaryColor]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
        .fullScreenCover(isPresented: $model.isSignUp) {
            
            SignUpView(model: model)
        }
        .alert(isPresented: $model.alert, content: {
            Alert(title: Text("Message"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Ok")))
        })
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(model: UserObjectModelData())
    }
}
