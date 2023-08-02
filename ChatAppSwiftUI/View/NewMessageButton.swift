//
//  NewMessageButton.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 31.07.23.
//

import SwiftUI

struct NewMessageButton: View {
    
    @ObservedObject var viewModel = MainMessagesViewViewModel()
    @State var chatUser: ChatUser?
    
    var body: some View {
        
        NavigationLink("", isActive: $viewModel.shouldNavigateToChatLogView) {
            ChatLogView(chatUser: self.chatUser)
        }
        
        Button {
            viewModel.shouldShowNewMessageScreen.toggle()
            print("New message button tapped")
        } label: {
            HStack {
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.vertical)
            .background(Color.blue)
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 15)
        }
        .fullScreenCover(isPresented: $viewModel.shouldShowNewMessageScreen) {
            NewMessageView(didSelectNewUser: { user in
                print(user.email)
                self.viewModel.shouldNavigateToChatLogView.toggle()
                self.chatUser = user
            })
        }
    }
}
