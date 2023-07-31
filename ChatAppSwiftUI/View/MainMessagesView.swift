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
                // Custom nav bar
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
                        viewModel.shouldShowLogOutOptions.toggle()
                    } label: {
                        Image(systemName: "gear")
                            .font(.system(size: 24, weight: .bold))
                    }
                }
                .padding()
                
                ScrollView {
                    ForEach(0..<10, id: \.self) { num in
                        VStack {
                            HStack(spacing: 16) {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 32))
                                    .padding(8)
                                    .overlay(RoundedRectangle(cornerRadius: 44)
                                        .stroke(Color.black, lineWidth: 1)
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
                        } .padding(.horizontal)
                    } .padding(.bottom, 50)
                }
            }
            .overlay(
                Button {
                    //
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
                }, alignment: .bottom
            )
            .navigationBarHidden(true)
        }
    }
}

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
