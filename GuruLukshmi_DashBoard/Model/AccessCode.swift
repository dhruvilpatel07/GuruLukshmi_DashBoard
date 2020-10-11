//
//  AccessCode.swift
//  GuruLukshmi_DashBoard
//
//  Created by Xcode User on 2020-10-10.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift


struct AccessCode: Codable, Identifiable, Hashable{
    
    @DocumentID var id: String?
    var code: String
}
