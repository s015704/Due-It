//
//  AddButtonView.swift
//  Due It
//
//  Created by Annika Naveen (student LM) on 3/25/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import SwiftUI

struct AddButtonView: View {
    
    @State var showSheet : Bool
    
    var body: some View {
        Button(action: {
            self.showSheet = true
        }) {
            Image(systemName: "plus.circle.fill").scaleEffect(4)
        }.foregroundColor(Color("regular1"))
    }
}

struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView()
    }
}
