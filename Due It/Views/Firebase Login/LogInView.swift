//
//  LogInView.swift
//
//
//  Created by Workflow Team on 3/11/21.
//  Copyright © Workflow. All rights reserved.
//  Login/Logout

import SwiftUI

struct LogInView: View {
    
    enum Action {
        case signUp, resetPW
    }
    @State var showSheet = false
    @State var action : Action?
    @Binding var user: UserViewModel
    @EnvironmentObject var userInfo: UserInfo
    
    var body: some View {
        SignInWithEmailView(user: self.$user, showSheet: $showSheet, action: $action)
            .sheet(isPresented: $showSheet) {
                if self.action == .signUp {
                    SignUpView(user: self.$user).environmentObject(self.userInfo)
                } else {
                    ForgotPasswordView(user: self.$user)
                }
            }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(user: Binding.constant(UserViewModel()))
    }
}
