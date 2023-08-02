//
//  ChatLogView.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 02.08.23.
//

import SwiftUI

struct ChatLogView: View {
    
    let chatUser: ChatUser?
    @State var isAnimating = true
    
    var body: some View {
        ScrollView {
            ForEach(0..<10) {num in
                Text("Fake message")
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        ChatLogView(chatUser: nil)
    }
}
