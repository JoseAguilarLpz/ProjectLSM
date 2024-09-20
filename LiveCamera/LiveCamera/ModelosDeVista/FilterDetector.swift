//
//  FilterDetector.swift
//  LiveCamera
//
//  Created by ADMIN UNACH on 12/09/24.
//

// MODELO PARA DETECTAR UNA POSE EN ESPECIFICO Y VERIFICAR LA APROXIMIDAD QUE TENGA

import Foundation
import CoreML
import AVFoundation
import Vision
import UIKit

extension CameraModel {
    
    func selectValueModel(valor: String){
        print("FILTER DETECTOR \(valor)")
        abcdario = true
        letterValue = valor
        print("EL VALOR ES \(abcdario)")
    }
}
