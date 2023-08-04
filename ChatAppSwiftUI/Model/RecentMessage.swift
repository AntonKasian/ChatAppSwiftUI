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
    
    var username: String {
        email.components(separatedBy: "@").first ?? email
    }
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
}
