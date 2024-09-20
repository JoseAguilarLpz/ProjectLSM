//
//  AlphabetCameraView.swift
//  LiveCamera
//
//  Created by ADMIN UNACH on 18/09/24.
//

import SwiftUI

struct AlphabetCameraView: View {
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    @State private var viewCameraModel = CameraModel()
    
    @Binding var imageData: Data?
    @Binding var showCameraAlphabet: Bool
    
    var isPortrait: Bool { verticalSizeClass == .compact }
    
    var body: some View {
        ZStack{
            Color.black
            
            VStack{
                // SE LLAMA LA VISTA QUE CONTIENE EL FRAME DE LA CAMARA
                HStack{
                    cameraPreview
                    if isPortrait {
                        verticalMenu
                    }
                }
                
                if !isPortrait {
                    horizontalMenu
                }
            }
        }.ignoresSafeArea()
    }
    
    // CONTENIDO DEL FRAME DE LA CAMARA
    private var cameraPreview: some View {
        GeometryReader { geo in
            CameraPreview(cameraVM: $viewCameraModel, frame: geo.frame(in: .global))
                .onAppear(){
                    viewCameraModel.requestPermission()
                }
        }
    }
    
    // BARRA DE NAVEGACION CUANDO EL DISPOSITIVO ESTA DE FORMA VERTICAL
    private var horizontalMenu: some View {
        HStack{
            backButton
            Spacer()
            resultLabel
            Spacer()
            Text("MENU").foregroundStyle(Color.white)
        }
    }
    
    // BARRA DE NAVEGACION CUANDO EL DISPOSITIVO ESTA DE FORMA HORITZONTAL
    private var verticalMenu: some View {
        VStack{
            backButton
            Spacer()
            resultLabel
            Spacer()
            Text("MENU").foregroundStyle(Color.white)
        }
    }
    
    // BOTON DE ACCION PARA REGRESAR A LA INTERFAZ ANTERIOR (O CERRRAR EL ACTUAL)
    private var backButton: some View {
        Button(action: {
            showCameraAlphabet = false
            viewCameraModel.abcdario = false
        }, label: {
            Image(systemName: "arrowshape.backward.fill")
                .resizable()
                .frame(width: 50, height: 50)
        }).padding()
    }
    
    // ETIQUETA PARA VISUALIZAR CUAL ES EL RESULTADO DE LA POSE DE MANO RECREADA
    private var resultLabel: some View {
//        Text("La pose es: \(viewCameraModel.handResultLabel)")
//            .font(.title)
        Text("LA POSE ES: \(viewCameraModel.abcdarioResultLabel)")
    }
}

#Preview {
    AlphabetCameraView(imageData: .constant(nil), showCameraAlphabet: .constant(true))
}
