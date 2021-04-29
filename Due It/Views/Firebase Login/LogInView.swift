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
    @State var num =  3
    @State var showSheet = false
    @State var action : Action?
    @EnvironmentObject var userInfo: UserInfo
    
    var body: some View {
        SignInWithEmailView(showSheet: $showSheet, action: $action)
            .sheet(isPresented: $showSheet) {
                if self.action == .signUp {
                    SignUpView().environmentObject(self.userInfo)
                } else {
                    ForgotPasswordView()
                }
            }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
