//
//  ContentView.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 27.07.23.
//

import SwiftUI


struct LoginView: View {
    let didCompleteLoginProcess: () -> ()
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
                                .stroke(Color(.label), lineWidth: 3)
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
                    .background(Color(.init(gray: 0.4, alpha: 0.2)))
                    .cornerRadius(10)
                    
                    Button {
                        // Action
                        handlerAction()
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
    
    func handlerAction() {
        if viewModel.isLogInMode {
           DispatchQueue.main.async {
               self.loginUser()
           }
           //loginUser()
          print("Login")
       } else {
           DispatchQueue.main.async {
               self.createNewAccount()
           }
//            createNewAccount()
           print("Create account")
       }
   }
   
    private func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: viewModel.email, password: viewModel.password) {result, error in
           if let error = error {
               print("Failed to create user", error)
               self.viewModel.loginStatusMessage = "Failed to create user \(error)"
               return
           }
           
           print("Successfully created user: \(result?.user.uid ?? "")")
            self.viewModel.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
           
           // Download image to Firebase
           
            self.viewModel.persistImageToStorage()
           
           self.didCompleteLoginProcess()
       }
   }
   
   private func loginUser() {
       FirebaseManager.shared.auth.signIn(withEmail: viewModel.email, password: viewModel.password) { result, error in
           if let error = error {
               print("Failed to login user", error)
               self.viewModel.loginStatusMessage = "Failed to login user \(error)"
               return
           }
           
           print("Successfully loged in as user: \(result?.user.uid ?? "")")
           self.viewModel.loginStatusMessage = "Successfully loged in as user: \(result?.user.uid ?? "")"
           
           self.didCompleteLoginProcess()
       }
       
   }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(didCompleteLoginProcess: {
            
        })
    }
}
