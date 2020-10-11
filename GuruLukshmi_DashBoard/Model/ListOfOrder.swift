//
//  ListOfOrder.swift
//  DashBoard
//
//  Created by Xcode User on 2020-09-29.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import Foundation
import Combine

//Individual order which is placed inside the cart/my order
struct ListOfOrder: Codable, Identifiable, Hashable{
    
    var id = UUID().uuidString
    var foodRefrence: Food
    var foodQuantity: Int
}

