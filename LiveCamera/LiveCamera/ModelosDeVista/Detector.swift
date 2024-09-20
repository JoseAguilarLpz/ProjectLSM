//
//  Detector.swift
//  LiveCamera
//
//  Created by ADMIN UNACH on 12/09/24.
//

// FUNCIONES PARA DETECTAR LAS POSES DE LA MANO DESDE EL MODELO NEURONAL ML CREADO

import Vision
import AVFoundation
import CoreML

extension CameraModel {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print("SALIDAAAAAAA")
        print("EL VALOR EN EL DETECTOR ES \(abcdario)")
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let handPoseRequest = VNDetectHumanHandPoseRequest()
        
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            do {
                try handler.perform([handPoseRequest])

                if let observation = handPoseRequest.results?.first {
                    let handPoints = try observation.recognizedPoints(.all)
                    
                    // Prepara el MLMultiArray con los puntos de la mano
                    if let multiArrayInput = prepareMultiArrayFromHandPoints(handPoints) {
                        // Aquí se pasa el multiArrayInput al modelo
                        let modelo = try Modelo_abecedario(configuration: MLModelConfiguration())
                        
//                        let modelDes = modelo.model.modelDescription
//                        let input = modelDes.inputDescriptionsByName
//                        let out = modelDes.outputDescriptionsByName
//                        
//                        print("entrada: \(input) y salida: \(out)")
                        
                        
                        // SE HACE LA DETECCION DE UNA POSE EXISTENTE
                        do{
                            let prediction = try modelo.prediction(poses: multiArrayInput)
//                            if let pre = prediction.featureValue(for: "A")?.multiArrayValue {
//                                
//                            }
                            
//                            var label = prediction.label
//                            
//                            
                            print("LA LETRA MANDADA ES \(letterValue ?? "NINGUNA")")
                            if self.abcdario == false {
                                print("Pose: \(prediction.label)")
                                self.handResultLabel = prediction.label
                            } else {
                                if prediction.label == self.letterValue {
                                    print("CORRECTO")
                                    self.abcdarioResultLabel = "CORRECTO"
                                } else {
                                    print("INCORRECTO")
                                    self.abcdarioResultLabel = "INCORRECTO"
                                }
                            }
                        } catch let error{
                            print("Error con la prediccion: \(error)")
                            self.handResultLabel = "ERROR x_x"
                        }
                    }
                } else {
                    self.handResultLabel = "NINGUNA"
                    print("NINGUNA")
                }
        } catch let Error{
            print("Error de solicitud de vision: \(Error)")
        }
    }
    
    func prepareMultiArrayFromHandPoints(_ handPoints: [VNHumanHandPoseObservation.JointName: VNRecognizedPoint]) -> MLMultiArray? {
        do {
            // Crea un MLMultiArray con las dimensiones 1 x 3 x 21
            let multiArray = try MLMultiArray(shape: [1, 3, 21], dataType: .float32)
            
            // El modelo espera las coordenadas `x`, `y` y la confianza de cada articulación
            // Suponemos que el diccionario `handPoints` contiene las articulaciones que necesitamos (21 en total)
            
            let jointNames: [VNHumanHandPoseObservation.JointName] = [
                .thumbTip, .thumbIP, .thumbMP, .thumbCMC,
                .indexTip, .indexDIP, .indexPIP, .indexMCP,
                .middleTip, .middleDIP, .middlePIP, .middleMCP,
                .ringTip, .ringDIP, .ringPIP, .ringMCP,
                .littleTip, .littleDIP, .littlePIP, .littleMCP,
                .wrist
            ]
            
            // Recorrer los puntos y llenar el MLMultiArray con las coordenadas `x`, `y` y la confianza
            for (index, joint) in jointNames.enumerated() {
                if let point = handPoints[joint] {
                    // Dimensión 0 es el frame (1 frame)
                    multiArray[[0, 0, NSNumber(value: index)]] = NSNumber(value: Float(point.location.x))
                    multiArray[[0, 1, NSNumber(value: index)]] = NSNumber(value: Float(point.location.y))
                    multiArray[[0, 2, NSNumber(value: index)]] = NSNumber(value: Float(point.confidence))
                } else {
                    // Si no se encuentra el punto, lo puedes rellenar con ceros o con algún valor predeterminado
                    multiArray[[0, 0, NSNumber(value: index)]] = 0.0
                    multiArray[[0, 1, NSNumber(value: index)]] = 0.0
                    multiArray[[0, 2, NSNumber(value: index)]] = 0.0
                }
            }
            
            return multiArray
        } catch {
            print("Error creando el MLMultiArray: \(error)")
            return nil
        }
    }
}
