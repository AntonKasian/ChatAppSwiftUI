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


class FirebaseManager: NSObject {
    
    let auth: Auth
    let storage: Storage
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        
        super.init()
    }
}
