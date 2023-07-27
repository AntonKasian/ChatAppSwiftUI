//
//  ContentView.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 27.07.23.
//

import SwiftUI

struct LoginView: View {
    
    @State var isLogInMode = false
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Picker(selection: $isLogInMode) {
                        Text("Log in")
                            .tag(true)
                        Text("Create account")
                            .tag(false)
                    } label: {
                        Text("Picker here")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    if !isLogInMode {
                        Button {
                            //
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .padding()
                        }
                    }
                    
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                        
                        SecureField("Password", text: $password)
                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(10)
                        
                    Button {
                        // Action
                       handlerAction()
                    } label: {
                        HStack {
                            Spacer()
                            Text(isLogInMode ? "Log In" : "Create account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 16, weight: .semibold))
                            Spacer()
                        }
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationTitle(isLogInMode ? "Log In" : "Create account")
            .background(Color(.init(white: 0, alpha: 0.05))
                .ignoresSafeArea())
        }
    }
    private func handlerAction() {
        if isLogInMode {
            print("Login")
        } else {
            print("Create account")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
