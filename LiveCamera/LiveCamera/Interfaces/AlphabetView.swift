//
//  AlphabetView.swift
//  LiveCamera
//
//  Created by ADMIN UNACH on 12/09/24.
//

import SwiftUI

struct AlphabetView: View {
    
    let arrayLetters: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "LL", "M", "N", "Ñ", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    @State private var viewCameraModel = CameraModel()
    
    @Binding var showAbcdario: Bool
    @State private var imageData: Data? = nil
    @State private var showCameraAlphabet: Bool = false
    
    var body: some View {
        ZStack{
            Color.black
            
            VStack{
                HStack{
                    backButton
                    Spacer()
                    VStack{
                        Image(systemName: "book.fill")
                            .resizable()
                            .frame(width: 100, height: 50)
                        Text("ABCDario")
                            .font(.title)
                    }
                    Spacer()
                }
                
//                VStack{
//                    ZStack{
//                        Color.gray
//                        
//                        Button(action: {
//                            showCameraAlphabet = true
//                            //                            viewCameraModel.abcdario = true
//                            viewCameraModel.selectValueModel(valor: "A")
//                        }, label: {
//                            VStack{
//                                Rectangle()
//                                    .frame(width: 150, height: 150)
//                                Text("A")
//                                    .font(.title)
//                            }
//                        })
//                    }
//                }
                Spacer()
                
                VStack {
                    // Recorremos el arreglo en grupos de 4
                    ForEach(0..<arrayLetters.count/4 + (arrayLetters.count % 4 == 0 ? 0 : 1), id: \.self) { fila in
                        HStack {
                            // Recorremos cada grupo de 4 palabras para crear los botones
                            ForEach(0..<4, id: \.self) { columna in
                                if fila * 4 + columna < arrayLetters.count {
                                    Button(action: {
                                        print("Presionaste: \(arrayLetters[fila * 4 + columna])")
                                        showCameraAlphabet = true
                                        //                            viewCameraModel.abcdario = true
                                        viewCameraModel.selectValueModel(valor: "\(arrayLetters[fila * 4 + columna])")
                                    }) {
                                        Text(arrayLetters[fila * 4 + columna])
                                            .frame(width: 90, height: 80)
                                            .background(Color.blue)
                                            .font(.title)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                        }.padding(.bottom)
                    }
                }
                
            }.foregroundColor(.white)
                .padding()
                .fullScreenCameraAlphabet(isPresented: $showCameraAlphabet, imageData: $imageData)
        }.ignoresSafeArea()
    }
    
    private var backButton: some View {
        Button(action: {
            showAbcdario = false
        }, label: {
            Image(systemName: "arrowshape.backward.fill")
                .resizable()
                .frame(width: 50, height: 50)
        }).padding()
    }
}

#Preview {
    AlphabetView(showAbcdario: .constant(true))
}
