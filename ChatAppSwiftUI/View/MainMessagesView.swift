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
    
    
    var body: some View {
        NavigationView {
            VStack {
                CustomNavBar()
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
//                            Image(systemName: "person.fill")
//                                .font(.system(size: 32))
//                                .padding(8)
//                                .foregroundColor(Color(.label))
//                                .overlay(RoundedRectangle(cornerRadius: 44)
//                                    .stroke(Color(.label), lineWidth: 1)
//                                )
                            
                            
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
}

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
