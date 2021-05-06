//
//  UserInfo.swift
// 
//
//  Created by Workflow Team on 3/11/21.
//  Copyright © Workflow. All rights reserved.
// Firebase work imported from firedrill

import Foundation
import FirebaseAuth

class UserInfo: ObservableObject {
    
    enum FBAuthState {
        case undefined, signedOut, signedIn
    }
    
    @Published var isUserAuthenticated: FBAuthState = .undefined
    
    func configureFirebaseStateDidChange() {
        if let _ = Auth.auth().currentUser {
            self.isUserAuthenticated = .signedIn
        } else {
            self.isUserAuthenticated = .signedOut
        }
    }
    
}
