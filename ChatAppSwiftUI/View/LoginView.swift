//
//  ContentView.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 27.07.23.
//

import SwiftUI


struct LoginView: View {
    
    @ObservedObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Picker(selection: $viewModel.isLogInMode) {
                        Text("Log in")
                            .tag(true)
                        Text("Create account")
                            .tag(false)
                    } label: {
                        Text("Picker here")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    if !viewModel.isLogInMode {
                        Button {
                            viewModel.shouldShowImagePicker.toggle()
                        } label: {
                            
                            VStack {
                                if let image = self.viewModel.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 128, height: 128)
                                        .scaledToFit()
                                        .cornerRadius(64)
                                } else {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 64))
                                        .padding()
                                        .foregroundColor(Color(.label))
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 64)
                                .stroke(Color.black, lineWidth: 3)
                            )
                        }
                    }
                    
                    Group {
                        TextField("Email", text: $viewModel.email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                        
                        SecureField("Password", text: $viewModel.password)
                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(10)
                        
                    Button {
                        // Action
                        viewModel.handlerAction()
                    } label: {
                        HStack {
                            Spacer()
                            Text(viewModel.isLogInMode ? "Log In" : "Create account")
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
                Text(viewModel.loginStatusMessage)
                    .foregroundColor(.red)
            }
            .navigationTitle(viewModel.isLogInMode ? "Log In" : "Create account")
            .background(Color(.init(white: 0, alpha: 0.05))
                .ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $viewModel.shouldShowImagePicker) {
            ImagePicker(image: $viewModel.image)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
