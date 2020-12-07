//
//  AddCategoryFormView.swift
//  GuruLukshmi_DashBoard
//
//  Created by Dhruvil Patel on 2020-11-12.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import SwiftUI

struct AddCategoryFormView: View {
    @ObservedObject var orderVM = OrderViewModel()
    @State var selected_CRUD_Operation = 1
    @State var categoryName: String = ""
    @State var changeCategoryName: String = ""
    @State var categoryToFetchFoodList = ""
    @State var testCategory: FoodCategory = FoodCategory(foodType: "", categoryImage: "")
    var body: some View {
        Picker(selection: $selected_CRUD_Operation, label: Text("Category")){
            Text("Add Category").tag(1)
            Text("Edit/Delete Category").tag(2)
        }.pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal, 15)
        
        if selected_CRUD_Operation == 1{
            Form {
                Section(header: Text("Category Name")) {
                    TextField("Category Name", text: $categoryName)
                    
                    
                }
                
                Section {
                    if categoryName != ""{
                        Button(action: {
                            self.orderVM.addCategory(FoodCategory(foodType: categoryName, categoryImage: "Pizza"))
                            self.categoryName = ""
                        }) {
                            Text("Add category")
                        }
                    }
                }
            }
            .navigationBarTitle("Edit Food", displayMode: .inline)
        }else{
            Form{
                Section(header: Text("SELECT CATEGORY")) {
                    Picker(selection: $categoryToFetchFoodList,
                           label: Text("Category")) {
                        ForEach(self.orderVM.arrayOfCategory, id: \.self) { cate in
                            Text(cate.foodType).tag(cate.foodType).onTapGesture {
                                self.testCategory = cate
                                self.changeCategoryName = cate.foodType
                            }
                        }
                    }
                }
                
                if categoryToFetchFoodList != ""{
                    Section(header: Text("EDIT CATEGORY")) {
                        TextField("Category Name", text: $changeCategoryName)
                    }
                    
                    Section{
                        if changeCategoryName != ""{
                            Button {
                                self.orderVM.updateCategory(categoryId: self.testCategory.id!, categoryType: self.changeCategoryName)
                                
                                self.changeCategoryName = ""
                            } label: {
                                Text("Update Category")
                            }
                            
                            Button {
                                self.orderVM.deleteCategory(self.testCategory.id!)
                                self.changeCategoryName = ""
                            } label: {
                                Text("Delete Category").foregroundColor(.red)
                            }
                            
                        }
                        
                    }
                    
                    
                }
            }
            
        }
    }
}

struct AddCategoryFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryFormView()
    }
}
