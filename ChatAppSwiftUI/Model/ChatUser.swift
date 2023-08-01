//
//  ChatUser.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 31.07.23.
//

import SwiftUI

struct ChatUser: Identifiable {
    
    var id: String { uid }
    
    let uid, email, profileImageURL: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageURL = data["profileImageURL"] as? String ?? ""
    }
}
