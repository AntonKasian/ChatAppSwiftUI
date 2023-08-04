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
    @State var isAnimating = true
    
    var body: some View {
        NavigationView {
            VStack {
//                CustomNavBar()
                customNavBar
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
                    // Maybe in future I should remove IF statement.
//                    if recentMessage.fromId == FirebaseManager.shared.auth.currentUser?.uid {
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
                                        Text(recentMessage.username)
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(Color(.label))
                                            .multilineTextAlignment(.leading)
                                        Text(recentMessage.text)
                                            .font(.system(size: 14))
                                            .foregroundColor(Color(.darkGray))
                                            .multilineTextAlignment(.leading)
                                    }
                                    Spacer()
                                    Text(recentMessage.timeAgo)
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(Color(.label))
                                }
                            }
                            Divider()
                                .padding(.vertical, 8)
                        }
                        .padding(.horizontal)
                        .padding(.top, 2)
//                    }
                }
                .padding(.bottom, 50)
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
    
    private var customNavBar: some View {
        HStack(spacing: 16) {
            
            WebImage(url: URL(string: viewModel.chatUser?.profileImageURL ?? "Not found"))
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(RoundedRectangle(cornerRadius: 50) .stroke(Color(.label), lineWidth: 1))
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 4) {
                if let email = viewModel.chatUser?.email {
                    Text(email
                        .replacingOccurrences(of: "@gmail.com", with: "")
                        .replacingOccurrences(of: "@mail.com", with: ""))
                    .font(.system(size: 24, weight: .bold))
                } else {
                    ActivityIndicator($isAnimating) // Вместо "Not found" будет показываться индикатор загрузки
                }
                
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 12, height: 12)
                    Text("Online")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.lightGray))
                }
            }
            Spacer()
            Button {
                viewModel.shouldShowLogOutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
            }
        }
        .padding()
        .confirmationDialog("settings", isPresented: $viewModel.shouldShowLogOutOptions) {
            Button(role: .destructive) {
                print("Sign out button tapped")
                viewModel.handleSignOut()
            } label: {
                Text("Sign Out")
            }

        } message: {
            Text("What do you want to do?")
        }
        .fullScreenCover(isPresented: $viewModel.isUserCurrentlyLogedOut) {
            LoginView(didCompleteLoginProcess: {
                self.viewModel.isUserCurrentlyLogedOut = false
                self.viewModel.fetchCurrentUser()
                self.viewModel.fetchResentMessages()
            })
        }
    }
    }


struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
