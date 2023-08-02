//
//  NewMessageView.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 01.08.23.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewMessageView: View {
    
    let didSelectNewUser: (ChatUser) -> ()
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = NewMessageViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text(viewModel.errorMessage)
                ForEach(viewModel.users) { user in
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        didSelectNewUser(user)
                    } label: {
                        HStack(spacing: 16) {
                            WebImage(url: URL(string: user.profileImageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(RoundedRectangle(cornerRadius: 50) .stroke(Color(.label), lineWidth: 1))
                            
                            Text(user.email)
                                .foregroundColor(Color(.label))
                            Spacer()
                        } .padding(.horizontal)
                    }
                    Divider()
                        .padding(.vertical, 8)
                }
            } .navigationTitle("New message")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                        }

                    }
                }
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(didSelectNewUser: {_ in 
            
        })
    }
}
