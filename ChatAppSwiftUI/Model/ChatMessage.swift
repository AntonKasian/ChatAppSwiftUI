//
//  ChatMessage.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 03.08.23.
//

import SwiftUI


struct ChatMessage: Identifiable {

    var id: String { documentId }

    let documentId: String
    let fromId, toId, text: String

    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.fromId = data[FirebaseConstants.fromId] as? String ?? ""
        self.toId = data[FirebaseConstants.toId] as? String ?? ""
        self.text = data[FirebaseConstants.text] as? String ?? ""
    }
}

//struct ChatMessage: Codable, Identifiable {
//    @DocumentID var id: String?
//
//    let fromId, toId, text: String
//    let timestamp: Date
//}
