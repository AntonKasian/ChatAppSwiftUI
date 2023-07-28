//
//  FirebaseManager.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 27.07.23.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore


class FirebaseManager: NSObject {
    
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
}
