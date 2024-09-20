//
//  ContentView.swift
//  LiveCamera
//
//  Created by ADMIN UNACH on 11/09/24.
//

// INTERFAZ PRINCIPAL

import SwiftUI

struct ContentView: View {
    
//    @State private var imageData: Data? = nil
    @State private var showCamera: Bool = false
    @State private var showAbcdario: Bool = false
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack {
                Spacer()
                //            if let imageData, let uiImage = UIImage(data: imageData) {
                //                Image(uiImage: uiImage)
                //                    .resizable()
                //                    .scaledToFit()
                //            } else {
                //                Image(systemName: "photo")
                //                    .resizable()
                //                    .scaledToFit()
                //                    .foregroundColor(.gray)
                //            }
                
                VStack{
                    Text("Bienvenido a (LS)Mexa")
                        .font(.title)
                        .fontWeight(.heavy)
                        .scaleEffect(3)
                }.padding()
                
                Spacer()
                
                VStack{
                    Button(action: {
                        showCamera = true
                    }, label: {
                        ZStack{
                            Text("Probar Cámara")
                                .font(.title)
                        }
                    })
                    .padding()
                    .background()
                    .clipShape(Capsule())
                    
                    Button(action: {
                        showAbcdario = true
                    }, label: {
                        Text("ABCDario")
                            .font(.title)
                    })
                    .padding()
                    .background()
                    .clipShape(Capsule())
                }.foregroundStyle(Color.black)
                    .padding()
                
                Spacer()
                
            }.padding()
                .fullScreenCamera(isPresented: $showCamera /*imageData: $imageData*/)
                .fullScreenAbcdario(isPresented: $showAbcdario)
        }.foregroundStyle(Color.white)
    }
}

#Preview {
    ContentView()
}
