//
//  DeviceOrientation.swift
//  LiveCamera
//
//  Created by ADMIN UNACH on 12/09/24.
//

// CONFIGURACION DE LA ROTACION DE LA APLICACION PARA MOSTRAR EL RESULTADO EN PANTALLA EN LA MISMA ROTACION EN LA QUE DEBE ESTAR

import UIKit

extension UIDeviceOrientation {
    var videoRotationAngle: CGFloat {
        switch self {
        case .landscapeLeft:
            0
        case .portrait:
            90
        case .landscapeRight:
            180
        case .portraitUpsideDown:
            270
        default:
            0
        }
    }
}
