//
//  ContentView.swift
//  LoginPage
//
//  Created by ivo on 2021/10/06.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
let storedUsername = "Username"
let storedPassword = "password"
struct ContentView: View {
    @State var username = ""
    @State var password = ""
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false
    @State var editingMode: Bool = false
    var body: some View {
        ZStack {
            VStack {
                WelcomeText()
                userImage()
                UsernameTextField(username: $username, editingMode: $editingMode)
                PasswordSecureField(password: $password)
                if authenticationDidFail {
                    Text("Information not correct. Try again.")
                        .foregroundColor(.red)
                        .offset(y: -10)
                }
                Button(action: {
                    if self.username == storedUsername && self.password == storedPassword {
                        self.authenticationDidSucceed = true
                        self.authenticationDidFail = false
                    } else {
                        self.authenticationDidFail = true
                        self.authenticationDidSucceed = false
                    }
                }, label: {
                    LoginButtonContent()
                })
                
            } .padding()
            if authenticationDidSucceed {
                Text("Login successful")
                    .font(.headline)
                    .frame(width: 250, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.green)
                    .cornerRadius(20.0)
                    .foregroundColor(.white)
                    .animation(Animation.default)
            }
        }.offset(y: editingMode ? -50 : 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WelcomeText: View {
    var body: some View {
        Text("Welcome!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct userImage: View {
    var body: some View {
        Image("userImage")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

struct UsernameTextField: View {
    @Binding var username: String
    @Binding var editingMode: Bool
    var body: some View {
        TextField("Username", text:$username, onEditingChanged: { edit in
            if edit {
                self.editingMode = true
            } else {
                self.editingMode = false
            }
        })
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct PasswordSecureField: View {
    @Binding var password: String
    var body: some View {
        SecureField("Password", text:$password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}
