//
//  MainMessagesView.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 31.07.23.
//

import SwiftUI

struct MainMessagesView: View {
    
    @ObservedObject var viewModel = MainMessagesViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
               // Text("User: \(viewModel.chatUser?.email ?? "")")
                // Custom nav bar
                CustomNavBar()
                
                //ScrollView
                messagesScrollView
            }
            .overlay(
                NewMessageButton()
                , alignment: .bottom
            )
            .navigationBarHidden(true)
        }
    }
    
    private var messagesScrollView: some View {
        ScrollView {
            ForEach(0..<10, id: \.self) { num in
                VStack {
                    HStack(spacing: 16) {
                        Image(systemName: "person.fill")
                            .font(.system(size: 32))
                            .padding(8)
                            .overlay(RoundedRectangle(cornerRadius: 44)
                                .stroke(Color(.label), lineWidth: 1)
                            )
                        
                        
                        VStack(alignment: .leading)  {
                            Text("Username")
                                .font(.system(size: 16, weight: .bold))
                            Text("Messages sent to user")
                                .font(.system(size: 14))
                                .foregroundColor(Color(.lightGray))
                        }
                        Spacer()
                        
                        Text("22d")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    Divider()
                        .padding(.vertical, 8)
                }
                .padding(.horizontal)
                .padding(.top, 2)
            } .padding(.bottom, 50)
        }
    }
}

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
