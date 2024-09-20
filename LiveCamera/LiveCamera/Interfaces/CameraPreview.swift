//
//  CameraPreview.swift
//  LiveCamera
//
//  Created by ADMIN UNACH on 12/09/24.
//

// CARGAR LA FUNCION O MODELO DE LA CAMARA EN LA INTERFAZ PARA QUE SE VISUALIZE

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    
    @Binding var cameraVM: CameraModel
    let frame: CGRect
    
    func makeUIView(context: Context) -> UIView {
        print("PRIMERO")
        let view = UIViewType(frame: frame)
        cameraVM.preview = AVCaptureVideoPreviewLayer(session: cameraVM.session)
        cameraVM.preview.frame = frame
        cameraVM.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(cameraVM.preview)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("segundooooo")
        cameraVM.preview.frame = frame
        cameraVM.preview.connection?.videoRotationAngle = UIDevice.current.orientation.videoRotationAngle
    }
    
}
