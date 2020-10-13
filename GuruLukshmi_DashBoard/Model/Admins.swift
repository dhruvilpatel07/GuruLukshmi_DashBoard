//
//  Admins.swift
//  GuruLukshmi_DashBoard
//
//  Created by Xcode User on 2020-10-11.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Admins: Codable, Identifiable, Hashable{
    
    @DocumentID var id: String?
    var email: String
    var uuid: String
}
