//
//  OrderModel.swift
//  DashBoard
//
//  Created by Xcode User on 2020-09-20.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

struct OrderModel: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var cName: String
    var foodName: String
    var foodQuantity: Int
    var isExtraCheese: Bool?
    var isNoOnion: Bool?
    var orderedTime: Timestamp?
}
