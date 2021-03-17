//
//  LogOutView.swift
//  FireDrill
//
//  Created by Annika Naveen (student LM) on 2/10/21.
//  Copyright © 2021 Annika Naveen (student LM). All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct HomeView: View {
    
    @EnvironmentObject var userInfo : UserInfo
    @State private var image : Image = Image("user")
    @State private var showingImagePicker = false
    @State private var inputImage : UIImage?
    
    var body: some View {
        VStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200, alignment: .center)
                .clipped()
            Button(action: {
                
            }) {
                Text("Change Image")
                    .frame(width: 200)
                    .padding(.vertical, 15)
                    .background(Color.green)
                    .cornerRadius(8)
                    .foregroundColor(.white)
            }
            Button(action: {
                try! Auth.auth().signOut()
                self.userInfo.configureFirebaseStateDidChange()
            }) {
                Text("Log Out")
                    .frame(width: 200)
                    .padding(.vertical, 15)
                    .background(Color.green)
                    .cornerRadius(8)
                    .foregroundColor(.white)
            }.sheet(isPresented: $showingImagePicker, onDismiss: saveImage) {
                ImagePicker(image: self.$inputImage)
            }
        }
    }
    
    func saveImage() {
        guard let input = inputImage else {return}
        image = Image(uiImage: input)
        
        // reference to the current user in firebase
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        // reference to storage object
        let storage = Storage.storage().reference().child("user/\(uid)")
        
        // images must be saved as data objects -> convert and compress
        guard let imageData = input.jpegData(compressionQuality: 0.75) else {return}
        
        storage.putData(imageData, metadata: StorageMetadata()) { (metadata, error) in
            if let _ = metadata {
                storage.downloadURL { (url, error) in
                    guard let imageURL = url else {return}
                    
                    let database = Database.database().reference().child("users/\(uid)")
                }
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
