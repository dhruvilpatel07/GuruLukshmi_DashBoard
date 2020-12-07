//
//  Orders.swift
//  DashBoard
//
//  Created by Xcode User on 2020-09-29.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

/// #This will be the main Order strcuture which will be addded to database
struct Orders: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var orderId: String?
    var cName: String?
    var cEmail: String?
    var tableNumber: Int?
    var listOfOrder = [ListOfOrder]()
    @ServerTimestamp var orderedTime: Timestamp?
    var orderedTimeInString: String?
    var orderSubTotal = 0.0
    var isDineIn : Bool
}
