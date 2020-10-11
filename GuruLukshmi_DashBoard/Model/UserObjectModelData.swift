//
//  UserObjectModelData.swift
//  GuruLukshmi_DashBoard
//
//  Created by Xcode User on 2020-10-10.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import LocalAuthentication

class UserObjectModelData : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var isSignUp = false
    @Published var email_SignUp = ""
    @Published var password_SignUp = ""
    @Published var reEnterPassword = ""
    @Published var isLinkSend = false
    @Published var accessCode_SignUp = ""
    
    // Error Alerts
    
    @Published var alert = false
    @Published var alertMsg = ""
    
    // User Status
    @AppStorage("log_Status") var status = false

    
    // Loading
    @Published var isLoading = false
    
    func resetPassword(){
        
        let alert = UIAlertController(title: "Reset Password", message: "Enter Your E-Mail ID To Reset Your Password", preferredStyle: .alert)
        
        alert.addTextField { (password) in
            password.placeholder = "Email"
        }
        
        let proceed = UIAlertAction(title: "Reset", style: .default) { (_) in
            
            // Sending Password Link
            
            if alert.textFields![0].text! != ""{
                
                withAnimation{
                    
                    self.isLoading.toggle()
                }
                
                Auth.auth().sendPasswordReset(withEmail: alert.textFields![0].text!) { (err) in
                    
                    withAnimation{
                        
                        self.isLoading.toggle()
                    }
                    
                    if err != nil{
                        self.alertMsg = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    
                    self.alertMsg = "Password Reset Link Has Been Sent !!!"
                    self.alert.toggle()
                }
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(proceed)
        
        // Presenting
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
    
    // Login
    
    func login(){
        
        // checking all fields are inputted correctly
        
        if email == "" || password == ""{
            
            self.alertMsg = "Fill the contents properly !!!"
            self.alert.toggle()
            return
        }
        
        withAnimation{
            
            self.isLoading.toggle()
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            
            withAnimation{
                
                self.isLoading.toggle()
            }
            
            if err != nil{
                
                self.alertMsg = "Email or Password doesn't match our records!"
                self.alert.toggle()
                return
            }
            
            // checking if user is verifed or not , if not verified means logging out
            
            let user = Auth.auth().currentUser
            if !user!.isEmailVerified{
                self.alertMsg = "Please Verify Email Address!!!"
                self.alert.toggle()
                try! Auth.auth().signOut()
                return
            }
            // setting user status as true
            withAnimation{
                self.status = true
            }
        }
    }
    
    // SignUp..
    
    func signUp(){
        
        if email_SignUp == "" || password_SignUp == "" || reEnterPassword == ""{
            
            self.alertMsg = "Fill contents proprely!!!"
            self.alert.toggle()
            return
        }
        
        if password_SignUp != reEnterPassword{
            self.alertMsg = "Password Mismatch !!!"
            self.alert.toggle()
            return
        }
        withAnimation{
            self.isLoading.toggle()
        }
        
        Auth.auth().createUser(withEmail: email_SignUp, password: password_SignUp) { (result, err) in
            
            withAnimation{
                self.isLoading.toggle()
            }
            
            if err != nil{
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            // sending Verifcation Link
            
            result?.user.sendEmailVerification(completion: { (err) in
                
                if err != nil{
                    self.alertMsg = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                // Alerting User To Verify Email
                self.alertMsg = "Email Verification Has Been Sent !!! Verify Your Email!"
                self.alert.toggle()
            })
        }
    }
    
    func logOut(){
        try! Auth.auth().signOut()
        withAnimation{
            self.status = false
        }
        // clearing all data
        email = ""
        password = ""
        email_SignUp = ""
        password_SignUp = ""
        reEnterPassword = ""
    }
    
}
