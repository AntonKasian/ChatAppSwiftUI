//
//  MainMessagesView.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 31.07.23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainMessagesView: View {
    
    @ObservedObject var viewModel = MainMessagesViewViewModel()
    @State var chatUser: ChatUser?
    
    var body: some View {
        NavigationView {
            VStack {
                CustomNavBar()
                messagesScrollView
                NavigationLink("", isActive: $viewModel.shouldNavigateToChatLogView) {
                    ChatLogView(chatUser: self.chatUser)
                }
                
            }
            .overlay(
                newMessageButton
                , alignment: .bottom
            )
            .navigationBarHidden(true)
        }
    }
    
    private var messagesScrollView: some View {
        ScrollView {
            ForEach(viewModel.recentMessages) { recentMessage in
                VStack {
                    NavigationLink {
                        Text("Destination")
                    } label: {
                        HStack(spacing: 16) {
                            WebImage(url: URL(string: recentMessage.profileImageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                                .clipped()
                                .cornerRadius(64)
                                .overlay(RoundedRectangle(cornerRadius: 44)
                                    .stroke(Color(.label), lineWidth: 1))
                                .shadow(radius: 5)
                            VStack(alignment: .leading)  {
                                Text(recentMessage.email)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(.label))
                                Text(recentMessage.text)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(.darkGray))
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            
                            Text("22d")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color(.label))
                        }
                    }
                    
                    
                    
                    Divider()
                        .padding(.vertical, 8)
                }
                .padding(.horizontal)
                .padding(.top, 2)
            } .padding(.bottom, 50)
        }
    }
    
    private var newMessageButton: some View {
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

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
