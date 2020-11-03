//
//  OrderViewModel.swift
//  DashBoard
//
//  Created by Xcode User on 2020-09-20.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift

class OrderViewModel: ObservableObject {
    
    @Published var arrayOfCategory = [FoodCategory]()
    @Published var arrayOfFoodList = [Food]()
    @Published var orderList = [Orders]()
    @Published var historyOrderList = [Orders]()
    
    //fetching by day
    @Published var historyOrderListByDateArray = [Orders]()
    @Published var historyOrderListByDateArrayCount = [Int]()
    
    //fetching by hourly
    @Published var historyOrderListByHourArray = [Orders]()
    @Published var historyOrderListByHourArrayCount = [Int]()
    
    //fetching by monthly
    @Published var historyOrderListByMonthArray = [Orders]()
    @Published var historyOrderListByMonthArrayCount = [Int]()
    
    //fetching most sold food item
    @Published var listOfMostItemSold = [Food]()
    
    let componentsYear = Calendar.current.dateComponents([.year], from: Date())
    
    
    
    private var db = Firestore.firestore()
    
    init() {
        fetchData()
        loadCategory()
        loadFood()
        loadMostItemSold()
        fetchHistoryData()
        fetchHistoryDataByDateArray(dates: [
                        Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                        Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
                        Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
                        Calendar.current.date(byAdding: .day, value: -4, to: Date())!,
                        Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
                        Calendar.current.date(byAdding: .day, value: -6, to: Date())!,
                        Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        ])
        
        
        fetchHistoryDataByHourArray(dates: [
                         Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!
                        ,Calendar.current.date(bySettingHour: 13, minute: 0, second: 0, of: Date())!
                        ,Calendar.current.date(bySettingHour: 14, minute: 0, second: 0, of: Date())!
                        ,Calendar.current.date(bySettingHour: 15, minute: 0, second: 0, of: Date())!
                        ,Calendar.current.date(bySettingHour: 16, minute: 0, second: 0, of: Date())!
                        ,Calendar.current.date(bySettingHour: 17, minute: 0, second: 0, of: Date())!
                        ,Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())!
                        ,Calendar.current.date(bySettingHour: 19, minute: 0, second: 0, of: Date())!
                        ,Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date())!
                        ,Calendar.current.date(bySettingHour: 21, minute: 0, second: 0, of: Date())!
                        ,Calendar.current.date(bySettingHour: 22, minute: 0, second: 0, of: Date())!
        ])
    

        /*fetchHistoryDataByMonthArray(dates: [
            Calendar.current.date(from: DateComponents.init(year: componentsYear.year ?? 0, month: 1))!,
            Calendar.current.date(from: DateComponents.init(year: componentsYear.year ?? 0, month: 2))!,
            Calendar.current.date(from: DateComponents.init(year: componentsYear.year ?? 0, month: 3))!,
            Calendar.current.date(from: DateComponents.init(year: componentsYear.year ?? 0, month: 4))!,
            Calendar.current.date(from: DateComponents.init(year: componentsYear.year ?? 0, month: 5))!,
            Calendar.current.date(from: DateComponents.init(year: componentsYear.year ?? 0, month: 6))!,
            Calendar.current.date(from: DateComponents.init(year: componentsYear.year ?? 0, month: 7))!,
            Calendar.current.date(from: DateComponents.init(year: componentsYear.year ?? 0, month: 8))!,
            Calendar.current.date(from: DateComponents.init(year: componentsYear.year ?? 0, month: 9))!,
            Calendar.current.date(from: DateComponents.init(year: componentsYear.year ?? 0, month: 10))!,
            Calendar.current.date(from: DateComponents.init(year: componentsYear.year ?? 0, month: 11))!,
            Calendar.current.date(from: DateComponents.init(year: componentsYear.year ?? 0, month: 12))!
        ])*/
        
        fetchHistoryDataByMonthArrayWithCustomYear(year: 2020)
    }
    
    
    //Fetching category
    func loadCategory() {
        db.collection("FoodCategory")
            .order(by: "foodType")
        //.order(by: "orderedTime")
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot{
                self.arrayOfCategory = querySnapshot.documents.compactMap{ document in
                    do{
                        let x = try document.data(as: FoodCategory.self)
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
    
    //Fetching foodlist
    func loadFood() {
        db.collection("Food")
        //.order(by: "orderedTime")
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot{
                self.arrayOfFoodList = querySnapshot.documents.compactMap{ document in
                    do{
                        let x = try document.data(as: Food.self)
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
    
    //fetch most item sold
    func loadMostItemSold() {
        db.collection("Food")
            .order(by: "numberOfItemSold", descending: true)
            .limit(to: 5)
        //.order(by: "orderedTime")
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot{
                self.listOfMostItemSold = querySnapshot.documents.compactMap{ document in
                    do{
                        let x = try document.data(as: Food.self)
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
    
    //Getting DATA by days
    func fetchHistoryDataByDateArray(dates : [Date]) {
        for date in dates {
            db.collection("OrderHistory")
                .whereField("orderedTime", isDateInToday: date)
                .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot{
                    self.historyOrderListByDateArray = querySnapshot.documents.compactMap{ document in
                        do{
                            let x = try document.data(as: Orders.self)
                            
                            return x
                        }
                        catch{
                            print(error)
                        }
                        return nil
                    }
                    //adding number of order to array count
                    self.historyOrderListByDateArrayCount.append(self.historyOrderListByDateArray.count)
                }
            }
        }
    }
    
    //Getting DATA by hourly
    func fetchHistoryDataByHourArray(dates : [Date]) {
        for date in dates {
            db.collection("OrderHistory")
                .whereField("orderedTime", isHourly: date)
                .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot{
                    self.historyOrderListByHourArray = querySnapshot.documents.compactMap{ document in
                        do{
                            let x = try document.data(as: Orders.self)
                            return x
                        }
                        catch{
                            print(error)
                        }
                        return nil
                    }
                    //adding number of order to array count
                    self.historyOrderListByHourArrayCount.append(self.historyOrderListByHourArray.count)
                }
            }
        }
    }
    
    //getting Data by monthly
    func fetchHistoryDataByMonthArray(dates : [Date]) {
        for date in dates {
            db.collection("OrderHistory")
                .whereField("orderedTime", isMonthly: date)
                .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot{
                    self.historyOrderListByMonthArray = querySnapshot.documents.compactMap{ document in
                        do{
                            let x = try document.data(as: Orders.self)
                            return x
                        }
                        catch{
                            print(error)
                        }
                        return nil
                    }
                    //adding number of order to array count
                    self.historyOrderListByMonthArrayCount.append(self.historyOrderListByMonthArray.count)
                }
            }
        }
    }
    
    //getting Data by monthly by custom year 
    func fetchHistoryDataByMonthArrayWithCustomYear(year : Int) {
        for month in 1..<13 {
            let date = Calendar.current.date(from: DateComponents.init(year: year, month: month))!
            db.collection("OrderHistory")
                .whereField("orderedTime", isMonthly: date)
                .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot{
                    self.historyOrderListByMonthArray = querySnapshot.documents.compactMap{ document in
                        do{
                            let x = try document.data(as: Orders.self)
                            return x
                        }
                        catch{
                            print(error)
                        }
                        return nil
                    }
                    //adding number of order to array count
                    self.historyOrderListByMonthArrayCount.append(self.historyOrderListByMonthArray.count)
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
    
    // Add Food
    func addFoods(_ food: Food){
        do{
           
            let _ = try db.collection("Food").addDocument(from: food)
           // db.collection("Food").whereField("categoryID", isEqualTo: food.foodType.id)
        }
        catch{
            fatalError("Enable to add Order: \(error.localizedDescription)")
        }
    }
    
    //update Food
    func updateFood(foodId: String, foodDesc: String, foodPrice: Double){
        
        let foodRef = db.collection("Food").document(foodId)

        foodRef.updateData([
            "foodDescription" : foodDesc,
            "foodPrice" : foodPrice
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
   

    
    //Delete Food
    func deleteFood(_ foodId: String){
        db.collection("Food").document(foodId).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }

}

