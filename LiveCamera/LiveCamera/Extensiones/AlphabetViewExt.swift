//
//  AlphabetViewExt.swift
//  LiveCamera
//
//  Created by ADMIN UNACH on 18/09/24.
//

import SwiftUI

extension View {
    func fullScreenCameraAlphabet(isPresented: Binding<Bool>, imageData: Binding<Data?>) -> some View {
        self.fullScreenCover(isPresented: isPresented, content: {
            AlphabetCameraView(imageData: imageData, showCameraAlphabet: isPresented)
        })
    }
}
