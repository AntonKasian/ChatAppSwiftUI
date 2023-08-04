//
//  ChatLogView.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 02.08.23.
//

import SwiftUI

struct ChatLogView: View {
    
    let chatUser: ChatUser?
    static let emptyScrolltoString = "Empty"
    
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
        .padding(.horizontal, -13)
        .navigationTitle(chatUser?.email ?? "Not found")
        .navigationBarTitleDisplayMode(.inline)

        .padding()
    }
    
    private var messagesView: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                
                VStack {
                    ForEach(viewModel.chatMessages) {message in
                        MessageView(message: message)
                    }
                    HStack{
                        Spacer()
                    }
                    .id(Self.emptyScrolltoString)
                }
                .onReceive(viewModel.$count) { _ in
                    if viewModel.count > 0 {
                        withAnimation(.easeOut(duration: 0.5)) {
                            scrollViewProxy.scrollTo(Self.emptyScrolltoString, anchor: .bottom)
                        }
                    }
                }
            }
        }
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.horizontal)
    }
    
    private var chatBottomBar: some View {
        HStack(spacing: 16) {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 24))
                .foregroundColor(Color(.label))
            ZStack {
                ZStack {
                    if viewModel.chatText.isEmpty {
                        Text("Message")
                            .foregroundColor(Color(.placeholderText))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 3)
                    }
                    TextEditor(text: $viewModel.chatText)
                        .background(Color(.init(white: 0.8, alpha: 1)))
                        .cornerRadius(10)
                        .opacity(viewModel.chatText.isEmpty ? 0.2 : 1)
                        
                }
            }
                .frame(height: 40)
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
//        NavigationView {
//            ChatLogView(chatUser: .init(data: ["uid" : "y9ow4sph29R5pzznCzfIObGuoTm2",
//                                               "email" : "fake@gmail.com"]))
//        }
        MainMessagesView()
    }
}
