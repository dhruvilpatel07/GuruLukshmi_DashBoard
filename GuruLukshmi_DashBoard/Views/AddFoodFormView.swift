//
//  AddFoodFormView.swift
//  GuruLukshmi_DashBoard
//
//  Created by Xcode User on 2020-10-12.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import SwiftUI

struct AddFoodFormView: View {
    @ObservedObject var orderVM = OrderViewModel()
    @State var foodName: String = ""
    @State var foodDescription: String = ""
    @State var foodPrice: String = ""
    @State private var category = ""
    @State var imgName = ""
    @State var categoryImage = ""
    @State var selected_CRUD_Operation = 1
    @State var categoryToFetchFoodList = ""
    @State var fetchFoodListByCategory = ""
    @State var foodDescription1: String = ""
    @State var foodPrice1: String = ""
    @State var testFood: Food = testData[0]
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case appetizers = "Appetizers"
        case indianBreads = "Indian Breads"
        case idly = "Idly"
        case dosa = "Dosa"
        case signatureDosa = "Signature Dosa"
        case dessert = "Dessert"
        case uthapams = "Uthapams"
        case rice = "Rice"
        case beverages = "Beverages"
        case sideDish = "Side Dish"
    }
    
    
    var formattedNumber : NSNumber {
        
        let formatter = NumberFormatter()
        
        guard let number = formatter.number(from: foodPrice) else {
            print("not valid to be converted")
            return 0
        }
        
        return number
    }
    
    var formattedNumber1 : NSNumber {
        
        let formatter = NumberFormatter()
        
        guard let number = formatter.number(from: foodPrice1) else {
            print("not valid to be converted")
            return 0
        }
        
        return number
    }
    
    var body: some View {
        
        Picker(selection: $selected_CRUD_Operation, label: Text("Food")){
            Text("Add Food").tag(1)
            Text("Update/Delete Food").tag(2)
        }.pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal, 15)
        
        if selected_CRUD_Operation == 1{
            Form {
                Section(header: Text("Food Name")) {
                    TextField("Food Name", text: $foodName)
                    TextField("Food Description", text: $foodDescription)
                    
                }
                
                Section(header: Text("SELECT CATEGORY")) {
                    Picker(selection: $category,
                           label: Text("Category")) {
                        ForEach(self.orderVM.arrayOfCategory, id: \.self) { cate in
                            Text(cate.foodType).tag(cate.foodType)
                        }
                    }
                }
                Section(header: Text("Food Price")) {
                    TextField("Food Price", text: $foodPrice).keyboardType(.numberPad)
                }
                
                Section {
                    if foodName != "" && foodDescription != "" && formattedNumber != 0.0
                        && category != ""{
                        Button(action: {
                            print(Double(formattedNumber).rounded(toPlaces: 2))
                            
                            if self.category == Category.appetizers.rawValue {
                                self.imgName = "dosa"
                                self.categoryImage = "Appetizers"
                            }else if self.category == Category.dosa.rawValue {
                                self.imgName = "dosa"
                                self.categoryImage = "Dosa"
                            }else if self.category == Category.signatureDosa.rawValue {
                                self.imgName = "dosa"
                                self.categoryImage = "SignatureDosa"
                            }else if self.category == Category.idly.rawValue {
                                self.imgName = "idly"
                                self.categoryImage = "Idly"
                            }else if self.category == Category.uthapams.rawValue {
                                self.imgName = "springRoll"
                                self.categoryImage = "Uthapam"
                            }else if self.category == Category.rice.rawValue {
                                self.imgName = "rice"
                                self.categoryImage = "Rice"
                            }else if self.category == Category.indianBreads.rawValue {
                                self.imgName = "springRoll"
                                self.categoryImage = "IndianBread"
                            }else if self.category == Category.dessert.rawValue {
                                self.imgName = "faluda"
                                self.categoryImage = "Dessert"
                            }else if self.category == Category.beverages.rawValue {
                                self.imgName = "faluda"
                                self.categoryImage = "Beverages"
                            }else if self.category == Category.sideDish.rawValue {
                                self.imgName = "faluda"
                                self.categoryImage = "SideDish"
                            }else{
                                self.imgName = ""
                                self.categoryImage = ""
                            }
                            
                            self.orderVM.addFoods(Food(foodName: self.foodName, foodDescription: self.foodDescription, foodType: self.category, imgName: self.imgName, categoryImage: self.categoryImage, foodPrice: Double(formattedNumber).rounded(toPlaces: 2)))
                            
                            print("Perform an action here...")
                            
                            self.foodName = ""
                            self.foodDescription = ""
                            self.category = ""
                            self.foodPrice = ""
                            self.imgName = ""
                            self.categoryImage = ""
                            
                        }) {
                            Text("Add Food")
                        }
                    }
                }
            }
            .navigationBarTitle("Edit Food", displayMode: .inline)
        }else{
            Form {
                Section(header: Text("SELECT CATEGORY")) {
                    Picker(selection: $categoryToFetchFoodList,
                           label: Text("Category")) {
                        ForEach(self.orderVM.arrayOfCategory, id: \.self) { cate in
                            Text(cate.foodType).tag(cate.foodType)
                        }
                    }
                }
                
                if categoryToFetchFoodList != ""{
                    Section(header: Text("SELECT FOOD")) {
                        Picker(selection: $fetchFoodListByCategory,
                               label: Text("Food")) {
                            ForEach(self.orderVM.arrayOfFoodList, id: \.self) { food in
                                if self.categoryToFetchFoodList == food.foodType {
                                    
                                    
                                    Text(food.foodName).tag(food.foodName)
                                        .onTapGesture {
                                            self.testFood = food
                                            self.foodDescription1 = testFood.foodDescription
                                            self.foodPrice1 = String(format: "%.2f", food.foodPrice)
                                        }
                                        
                                }
                            }
                            //Text(cate.foodType).tag(cate.foodType)
                        }
                    }
                }
                
                if fetchFoodListByCategory != ""{
                    Section(header: Text("Edit")) {
                        TextField("Food Description", text: $foodDescription1)
                        TextField("Food Price", text: $foodPrice1)
                         
                     }
                    
                }
                
                Section {
                    if foodDescription1 != "" && formattedNumber1 != 0.0{
                        
                        Button(action: {
                            print("ID : - \(self.testFood.id!)")
                            self.orderVM.updateFood(foodId: self.testFood.id!, foodDesc: self.foodDescription1, foodPrice: Double(truncating: formattedNumber1))
                           // self.orderVM.updateFood(self.testFood)
                        }) {
                            Text("Update Food")
                        }
                    }
                }
            }
            
        }
    }
    
    
}


struct AddFoodFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodFormView()
    }
}
