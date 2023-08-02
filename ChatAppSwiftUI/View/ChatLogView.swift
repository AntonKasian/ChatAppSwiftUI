//
//  ChatLogView.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 02.08.23.
//

import SwiftUI

struct ChatLogView: View {
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser   // made for let chatUser
        self.viewModel = .init(chatUser: chatUser)
    }
    
    @ObservedObject var viewModel: ChatLogViewModel
    
    var body: some View {
        VStack {
            messagesView
            chatBottomBar
                .background(Color(.systemBackground))
        }
        .padding(.horizontal, -13) // maybe bugs will be here with ScrollView
        .navigationTitle(chatUser?.email ?? "Not found")
            .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
    
    private var messagesView: some View {
        ScrollView {
            ForEach(0..<10) {num in
                HStack {
                    Spacer()
                    HStack {
                        Text("Fake message")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            HStack{
                Spacer()
            }
        }
        .background(Color(.init(white: 0.95, alpha: 1)))
        .edgesIgnoringSafeArea(.horizontal)
    }
    
    private var chatBottomBar: some View {
        HStack(spacing: 16) {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 24))
                .foregroundColor(Color(.darkGray))
            ZStack {
                ZStack {
                    if viewModel.chatText.isEmpty {
                        Text("Message")
                            .foregroundColor(Color(.placeholderText))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 3)
                    }
                    TextEditor(text: $viewModel.chatText)
                        .opacity(viewModel.chatText.isEmpty ? 0.2 : 1)
                }
            }
                .frame(height: 40)
            
            //TextField("Description", text: $viewModel.chatText)
            Button {
                viewModel.handleSend()
            } label: {
                    Text("Send")
                        .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.blue)
            .cornerRadius(5)

        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatLogView(chatUser: .init(data: ["uid" : "y9ow4sph29R5pzznCzfIObGuoTm2",
                                               "email" : "fake@gmail.com"]))
        }
    }
}
