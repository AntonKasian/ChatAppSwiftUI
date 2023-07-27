//
//  ContentView.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 27.07.23.
//

import SwiftUI
import Firebase

class FirebaseManager: NSObject {
    
    let auth: Auth
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        
        super.init()
    }
}

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
                Text(self.loginStatusMessage)
                    .foregroundColor(.red)
            }
            .navigationTitle(isLogInMode ? "Log In" : "Create account")
            .background(Color(.init(white: 0, alpha: 0.05))
                .ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    private func handlerAction() {
        if isLogInMode {
            loginUser()
//            print("Login")
        } else {
            createNewAccount()
//            print("Create account")
        }
    }
    
    @State var loginStatusMessage = ""
    
    private func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) {result, error in
            if let error = error {
                print("Failed to create user", error)
                self.loginStatusMessage = "Failed to create user \(error)"
                return
            }
            
            print("Successfully created user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
        }
    }
    
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to login user", error)
                self.loginStatusMessage = "Failed to login user \(error)"
                return
            }
            
            print("Successfully loged in as user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully loged in as user: \(result?.user.uid ?? "")"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
