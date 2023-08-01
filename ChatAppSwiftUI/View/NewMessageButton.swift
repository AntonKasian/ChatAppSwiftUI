//
//  NewMessageButton.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 31.07.23.
//

import SwiftUI

struct NewMessageButton: View {
    
    @ObservedObject var viewModel = MainMessagesViewViewModel()
    
    var body: some View {
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
            NewMessageView()
        }
    }
}
