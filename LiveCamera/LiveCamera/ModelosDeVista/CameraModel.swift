//
//  CameraModel.swift
//  LiveCamera
//
//  Created by ADMIN UNACH on 12/09/24.
//

// MODELO QUE CONTIENE LA FUNCION PARA MOSTRAR LA CAMARA EN LA INTERFAZ ASIGNADA

import Foundation
import AVFoundation
import UIKit
import CoreML

@Observable
class CameraModel: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var session = AVCaptureSession()
    var preview = AVCaptureVideoPreviewLayer()
    var output = AVCapturePhotoOutput()
    var handResultLabel = ""
    
    var letterValue: String? {
        get {
            return UserDefaults.standard.string(forKey: "letterValue")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "letterValue")
        }
    }
    var abcdario: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "abcdario")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "abcdario")
        }
    }
    var abcdarioResultLabel = ""
    
    private var videoOutput = AVCaptureVideoDataOutput()
    
    func requestPermission() {
        print("PERMISOOOO")
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) {
                didAllowAccess in
                self.setup()
            }
        case .authorized:
            setup()
        default:
            print("")
        }
    }
    
    func setup() {
        print("setuuuuuuuup")
        session.beginConfiguration()
        session.sessionPreset = AVCaptureSession.Preset.photo
        
        do {
            guard let device = AVCaptureDevice.default(for: .video) else { return }
            let input = try AVCaptureDeviceInput(device: device)
            
            guard session.canAddInput (input) else { return }
            session.addInput (input)
            
            guard session.canAddOutput (output) else { return }
            session.addOutput(output)
            
            session.commitConfiguration()
            
            Task(priority: .background) {
                self.session.startRunning()
                await MainActor.run{
                    self.preview.connection?.videoRotationAngle = UIDevice.current.orientation.videoRotationAngle
                }
            }
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleBufferQueue"))
            session.addOutput(videoOutput)
            videoOutput.connection(with: .video)?.videoRotationAngle = 90
        } catch let error {
            print("Error SETUP en CameraModel: \(error)")
        }
    }
}
