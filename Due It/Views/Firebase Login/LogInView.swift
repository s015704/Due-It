//
//  LogInView.swift
//  FireDrill
//
//  Created by Annika Naveen (student LM) on 2/10/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

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
