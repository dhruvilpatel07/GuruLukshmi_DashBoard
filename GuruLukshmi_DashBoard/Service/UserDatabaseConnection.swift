//
//  UserDatabaseConnection.swift
//  GuruLukshmi_DashBoard
//
//  Created by Dhruvil Patel on 2020-10-11.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserDatabaseConnection: ObservableObject {
    @Published var arrayOfAdmins = [Admins]()
    @Published var accessCode = [AccessCode]()
 
    let db = Firestore.firestore()
    
    init() {
        loadAdmins()
        loadAccessCode()
    }
    
    func loadAdmins() {
        db.collection("Admins")
        //.order(by: "orderedTime")
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot{
                self.arrayOfAdmins = querySnapshot.documents.compactMap{ document in
                    do{
                        let x = try document.data(as: Admins.self)
                        return x
                    }
                    catch{
                        print(error)
                    }
                    return nil
                    
                }
            }
        }
    }
    
    func loadAccessCode() {
        db.collection("AccessCode")
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot{
                self.accessCode = querySnapshot.documents.compactMap{ document in
                    do{
                        let x = try document.data(as: AccessCode.self)
                        return x
                    }
                    catch{
                        print(error)
                    }
                    return nil
                }
            }
        }
    }
    
    func addAdmins(_ admin: Admins){
        do{
           
            let _ = try db.collection("Admins").addDocument(from: admin)
           // db.collection("Food").whereField("categoryID", isEqualTo: food.foodType.id)
        }
        catch{
            fatalError("Enable to add Admin to table: \(error.localizedDescription)")
        }
    }
    
}
