//
//  DisplayOrder.swift
//  DashBoard
//
//  Created by Xcode User on 2020-09-29.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import SwiftUI

struct DisplayOrder: View {
    let fade =  Gradient(colors: [Color.black,Color.black, Color.clear])
    var food: ListOfOrder
    var body: some View {
        ZStack{
            Color.newSecondaryColor.edgesIgnoringSafeArea(.all)
            VStack{
                Image(food.foodRefrence.imgName).resizable()
                    .frame(height: 200)
                    .mask(LinearGradient(gradient: fade
                        , startPoint: .top, endPoint: .bottom))
                Text(food.foodRefrence.foodName)
                    .font(.system(size: 30, weight: Font.Weight.bold, design: Font.Design.rounded))
                    .foregroundColor(.newPrimaryColor)
                    .padding()
                HStack {
                    VStack {
                        Text("Quantity: \(food.foodQuantity)")
                            .font(.system(size: 18, weight: Font.Weight.bold, design: Font.Design.rounded))
                            .foregroundColor(.white)
                            .padding(.bottom, 5)
                        Text("Avoid: ")
                            .font(.system(size: 18, weight: Font.Weight.bold, design: Font.Design.rounded))
                            .foregroundColor(.white)
                        VStack(alignment: .center, spacing: 6.0){
                            HStack{
                                Image(systemName: "xmark").foregroundColor(.red)
                                Text("No Cheese").foregroundColor(.gray)
                            }
                            HStack{
                                Image(systemName: "xmark").foregroundColor(.red)
                                Text("No Onion").foregroundColor(.gray)
                            }
                        }.padding(.top, 2).offset(x: 55, y: 0)
                    }
                    Spacer()
                }.padding(.leading)
                
                Spacer()
            }
        }.frame(width: 300, height: 500)
    }
}

struct DisplayOrder_Previews: PreviewProvider {
    static var previews: some View {
        DisplayOrder(food: ListOfOrder(id: "dsfs", foodRefrence: testData[0], foodQuantity: 2))
    }
}
