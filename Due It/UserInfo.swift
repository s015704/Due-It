//
//  UserInfo.swift
//  FireDrill
//
//  Created by Annika Naveen (student LM) on 2/10/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

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
