//
//  ContentViewExt.swift
//  LiveCamera
//
//  Created by ADMIN UNACH on 12/09/24.
//

// AQUI SE ANEXAN LAS EXTENSIONES PARA UNA MEJOR ESTRUCTURA DEL CONTENIDO
// INTERFAZ PRINCIPAL (CONTENT VIEW)

import SwiftUI

extension View {
    func fullScreenCamera(isPresented: Binding<Bool> /*imageData: Binding<Data?>*/) -> some View {
        self.fullScreenCover(isPresented: isPresented, content: {
             CameraView(/*imageData: imageData,*/ showCamera: isPresented)
         })
    }
    
    func fullScreenAbcdario(isPresented: Binding<Bool>) -> some View {
        self.fullScreenCover(isPresented: isPresented, content: {
            AlphabetView(showAbcdario: isPresented)
        })
    }
}
