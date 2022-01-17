//
//  PermisionManager.swift
//  Base
//
//  Created by Lê Hoàng Anh on 16/09/2020.
//  Copyright © 2020 Hoàng Anh. All rights reserved.
//

import UIKit
import CoreLocation

final class PermissionManager {
    
    static func checkForLocation(_ manager: CLLocationManager, completion: @escaping (Bool) -> Void) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            completion(true)
        case .denied:
            NoticeView.show(title: "Access denied", message: "Please go to setting and grant location access to use this function", action: {
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            })
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            completion(false)
        @unknown default:
            completion(false)
        }
    }
}
