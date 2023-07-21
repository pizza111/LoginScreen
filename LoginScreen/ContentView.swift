//
//  ContentView.swift
//  LoginScreen
//
//  Created by Piotr Woźniak on 12/07/2023.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct ContentView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    
    var body: some View {
        if logStatus {
            DemoHome()
        } else {
            Login()
        }
    }
    
    @ViewBuilder
    func DemoHome() -> some View {
        NavigationStack {
            Text("Logged In")
                .navigationTitle("Multi-Login")
                .toolbar {
                    ToolbarItem {
                        Button("Logout") {
                            try? Auth.auth().signOut()
                            GIDSignIn.sharedInstance.signOut()
                            withAnimation(.easeInOut) {
                                logStatus = false
                            }
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
