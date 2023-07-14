//
//  Login.swift
//  LoginScreen
//
//  Created by Piotr Woźniak on 13/07/2023.
//
import SwiftUI

struct Login: View {
    @StateObject var loginModel: LoginViewModel = .init()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 15) {
                Image(systemName: "triangle")
                    .font(.system(size: 38))
                    .foregroundColor(.black.opacity(0.4))
                
                (Text("Welcome,")
                    .foregroundColor(.black)
                + Text("\nLogin to continue")
                    .foregroundColor(.gray)
                )
                .font(.title)
                .fontWeight(.semibold)
                .lineSpacing(10)
                .padding(.top, 20)
                .padding(.trailing, 15)
                
                CustomTextField(text: $loginModel.mobileNo, hint: "+48 123456789")
                    .disabled(loginModel.showOTPField)
                    .opacity(loginModel.showOTPField ? 0.4 : 1)
                    .overlay(alignment: .trailing, content: {
                        Button("Change") {
                            withAnimation(.easeInOut) {
                                loginModel.showOTPField = false
                                loginModel.otpCode = ""
                                loginModel.CLIENT_CODE = ""
                            }
                        }
                        .font(.caption)
                        .foregroundColor(.indigo)
                        .opacity(loginModel.showOTPField ? 1 : 0)
                        .padding(.trailing, 15)
                    })
                    .padding(.top, 50)
                
                CustomTextField(text: $loginModel.otpCode, hint: "OTP Code")
                    .disabled(!loginModel.showOTPField)
                    .opacity(!loginModel.showOTPField ? 0.4 : 1)
                    .padding(.top, 20)
                
                
                Button(action: loginModel.showOTPField ? loginModel.verifyOTPCode : loginModel.getOTPCode) {
                    HStack(spacing: 15) {
                        Text(loginModel.showOTPField ? "Verify Code" : "Get code")
                            .fontWeight(.semibold)
                            .contentTransition(.identity)
                        
                        Image(systemName: "line.diagonal.arrow")
                            .font(.title3)
                            .rotationEffect(.degrees(45))
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 25)
                    .padding(.vertical)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.black.opacity(0.1))
                    }
                }
                .padding(.top, 30)
            }
            .padding(.leading, 60)
            .padding(.vertical, 15)
        }
        .background(
            LinearGradient(gradient: Gradient(stops: [
                Gradient.Stop(color: .white, location: 0.4),
                Gradient.Stop(color: .black.opacity(0.6), location: 1.3),
                ]), startPoint: .top, endPoint: .bottom)
        )
        .alert(loginModel.errorMessage, isPresented: $loginModel.showError) { }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
