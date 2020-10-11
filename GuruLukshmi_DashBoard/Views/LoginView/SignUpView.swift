//
//  SignUpView.swift
//  GuruLukshmi_DashBoard
//
//  Created by Xcode User on 2020-10-10.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var model : UserObjectModelData
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
            Color.newPrimaryColor.opacity(0.4).edgesIgnoringSafeArea(.all)
            VStack{
                
                Spacer(minLength: 0)
                
                ZStack{
                    Image("logo")
                        .resizable()
                        .frame(width:500, height: 400)
                }
                    .padding(.horizontal)
                    .padding(.vertical,20)
                    .cornerRadius(30)
                
                VStack(spacing: 4){
                    
                    HStack(spacing: 0){
                        
                        Text("New")
                            .font(.system(size: 40, weight: Font.Weight.bold, design: Font.Design.rounded))
                            .foregroundColor(.white)
                        
                        Text(" Admin")
                            .font(.system(size: 40, weight: Font.Weight.bold, design: Font.Design.rounded))
                            .foregroundColor(.newSecondaryColor)
                    }
                    
                    Text("Create a new admin!")
                        .foregroundColor(Color.black.opacity(0.3))
                        .fontWeight(.heavy)
                }
                .padding(.top)
                
                VStack(spacing: 20){
                    
                    CustomTextFieldView(image: "person", placeHolder: "Email", txt: $model.email_SignUp)
                    
                    CustomTextFieldView(image: "lock", placeHolder: "Password", txt: $model.password_SignUp)
                    
                    CustomTextFieldView(image: "lock", placeHolder: "Re-Enter", txt: $model.reEnterPassword)
                    
                    CustomTextFieldView(image: "lock", placeHolder: "Access Code", txt: $model.accessCode_SignUp)
                }
                .padding(.top)
                
                Button(action: model.signUp) {
                    
                    Text("SIGNUP")
                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.vertical,22)
                
                Spacer(minLength: 0)
            }
            
            Button(action: {model.isSignUp.toggle()}) {
                
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
            }
            .padding(.trailing)
            .padding(.top,10)
            
            if model.isLoading{
                
                LoadingView()
            }
        })
        .background(LinearGradient(gradient: .init(colors: [Color.newPrimaryColor,Color.newSecondaryColor]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
        .alert(isPresented: $model.alert, content: {
            
            Alert(title: Text("Message"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Ok"), action: {
                 
                // if email link sent means closing the signupView
                if model.alertMsg == "Email Verification Has Been Sent !!! Verify Your Email ID !!!"{
                    
                    model.isSignUp.toggle()
                    model.email_SignUp = ""
                    model.password_SignUp = ""
                    model.reEnterPassword = ""
                }
                
            }))
        })
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(model: UserObjectModelData())
    }
}
