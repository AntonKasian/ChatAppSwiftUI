//
//  CustomNavBar.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 31.07.23.
//

import SwiftUI

struct CustomNavBar: View {
    
    @ObservedObject var mainViewModel = MainMessagesViewViewModel()
    
    var body: some View {
        HStack(spacing: 16) {
            
            Image(systemName: "person.fill")
                .font(.system(size: 34, weight: .heavy))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("USERNAME")
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
