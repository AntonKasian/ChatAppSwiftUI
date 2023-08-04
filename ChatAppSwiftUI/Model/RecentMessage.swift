//
//  RecentMessage.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 03.08.23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct RecentMessage: Codable, Identifiable {

    @DocumentID var id: String?

    let text, email: String
    let fromId, toId: String
    let profileImageURL: String
    let timestamp: Date
}
