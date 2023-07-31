//
//  CustomNavBar.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 31.07.23.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomNavBar: View {
    
    @ObservedObject var mainViewModel = MainMessagesViewViewModel()
    
    var body: some View {
        HStack(spacing: 16) {
            
            WebImage(url: URL(string: mainViewModel.chatUser?.profileImageURL ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(RoundedRectangle(cornerRadius: 50) .stroke(Color(.label), lineWidth: 1))
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(mainViewModel.chatUser?.email
                    .replacingOccurrences(of: "@gmail.com", with: "")
                    .replacingOccurrences(of: "@mail.com", with: "") ?? "")
                    .font(.system(size: 24, weight: .bold))
                
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
                mainViewModel.shouldShowLogOutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
            }
        }
        .padding()
        .confirmationDialog("settings", isPresented: $mainViewModel.shouldShowLogOutOptions) {
            Button(role: .destructive) {
                print("Sign out button tapped")
            } label: {
                Text("Sign Out")
            }

        } message: {
            Text("What do you want to do?")
        }
    }
    
    
}
