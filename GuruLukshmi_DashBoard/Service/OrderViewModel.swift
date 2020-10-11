//
//  OrderViewModel.swift
//  DashBoard
//
//  Created by Xcode User on 2020-09-20.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift

class OrderViewModel: ObservableObject {
    @Published var orderList = [Orders]()
    @Published var historyOrderList = [Orders]()
    @Published var historyOrderListByDate = [Orders]()
    @Published var accessCode = [AccessCode]()
    private var db = Firestore.firestore()
    
    init() {
        fetchData()
        fetchHistoryData()
        loadAccessCode()
    }
    
    //Fetching data from Order table 
    func fetchData() {
        db.collection("Orders")
        .order(by: "orderedTime")
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot{
                self.orderList = querySnapshot.documents.compactMap{ document in
                    do{
                        let x = try document.data(as: Orders.self)
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
    //Getting order from History table
    func fetchHistoryData() {
        db.collection("OrderHistory")
        .order(by: "orderedTime")
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot{
                self.historyOrderList = querySnapshot.documents.compactMap{ document in
                    do{
                        let x = try document.data(as: Orders.self)
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
    
    //Getting DAT from History table
    func fetchHistoryDataByDate(date : Timestamp) {
           db.collection("OrderHistory")
        .whereField("orderedTime", isEqualTo: date)
           .order(by: "orderedTime")
               .addSnapshotListener { (querySnapshot, error) in
               if let querySnapshot = querySnapshot{
                   self.historyOrderList = querySnapshot.documents.compactMap{ document in
                       do{
                           let x = try document.data(as: Orders.self)
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
    
    func deleteOrder(_ order: Orders){
        if let orderID = order.id{
            db.collection("Orders").document(orderID).delete(){ err in
                if let err = err{
                    print("Error deleting Order: \(err)")
                }else{
                    print("Order deleted!")
                }
            }
        }
    }
    
    func addToHistory(_ order: Orders) {
        do{
            let _ = try db.collection("OrderHistory").addDocument(from: order)
        }
        catch{
            fatalError("Can't add to History \(error.localizedDescription)")
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
}
