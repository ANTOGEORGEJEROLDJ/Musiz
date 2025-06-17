//
//  ContentView.swift
//  LoginPage
//
//  Created by Paranjothi iOS MacBook Pro on 17/06/25.
//

import SwiftUI

struct LoginScreen: View {
    @State private var userName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var navigateToHome = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 30) {
                        // Header
                        VStack(spacing: 8) {
                            Image("LoginImage")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .cornerRadius(50)
                                

                            Text("Login to Continue")
                                .font(.title3.bold())
                                .foregroundColor(.green)
                        }
                        .padding(.top, 50)

                        // Input Fields
                        VStack(spacing: 16) {
                            CustomTextField(icon: "person.fill", placeholder: "Username", text: $userName)
                            CustomTextField(icon: "envelope.fill", placeholder: "Email", text: $email)
                            CustomTextField(icon: "lock.fill", placeholder: "Password", text: $password)
                        }
                        .padding()
                        .background(Color.white.opacity(0.4))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.green.opacity(0.9), lineWidth: 1)
                        )
                        .padding(.horizontal)

                        // Login Button
                        Button(action: {
                            CoreDataManager.shared.saveUser(username: userName, email: email, password: password)
                            navigateToHome = true
                        }) {
                            Text("Login")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.black)
                                .font(.headline.bold())
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        .shadow(color: .green.opacity(0.4), radius: 10, x: 0, y: 5)

                        // Or Divider
                        HStack {
                            Rectangle().frame(height: 1).foregroundColor(.gray)
                            Text("OR")
                                .foregroundColor(.gray)
                                .font(.caption)
                            Rectangle().frame(height: 1).foregroundColor(.gray)
                        }
                        .padding(.horizontal)

                        HStack (spacing: 20){
                            Button(action: {
                                
                            navigateToHome = true
                                
                            }){
                                Image("google")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 19, height: 19)
                            }
                            .frame(width: 70, height: 22)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green.opacity(0.7))
                            .font(.headline)
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                            
                            
                            Button(action:{

                                
                            }){
                                Image("apple")
                                    .resizable()
                                    .scaledToFit()
                                
                            }
                            .frame(width: 70, height: 22)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green.opacity(0.7))
                            .font(.headline)
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                        }

                        Spacer()
                    }
                    .padding()
                }
            }.navigationDestination(isPresented: $navigateToHome) {
                MainTabView()
                    .navigationBarBackButtonHidden(true)
            }

        }
    }
}



#Preview {
    LoginScreen()
}
