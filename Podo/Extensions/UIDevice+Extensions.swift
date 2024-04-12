//
//  UIDevice+Extensions.swift
//  ViTouch
//
//  Created by Anil Garip on 11.04.2022.
//

import Foundation
import UIKit

public enum ScreenSize {
    case small
    case medium
    case large
    case unknown
}

extension UIDevice {
    
    var identifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    func getDeviceModel() -> String {
        return self.model + "-" + self.systemVersion
    }
    
    func getDeviceDetails() -> String {
        return self.name
    }

    static var iPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    static var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    var screenSize: ScreenSize {
        guard UIDevice.iPhone else { return .large }

        let width = UIScreen.main.bounds.width
        switch width {
        case _ where width <= 320:                      //iPhone 4, 4S, 5, 5S, 5C, SE
            return .small
        case _ where width > 320 && width <= 375:      //iPhone 6, 6S, 7, 8, X, XS, 11 Pro
            return .medium
        case _ where width >= 414:                      //iPhone 6+, 6S+, 7+, 8+, XR, XS Max, 11, 11 Pro Max, etc.
            return .large
        default:
            return .unknown
        }
    }

}

extension UIDevice {
    var modelName: String {
        // bkz: https://gist.github.com/adamawolf/3048717
        switch identifier {
            // iPods
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"

            // iPhones
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPhone11,2":                              return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
        case "iPhone11,8":                              return "iPhone XR"
        case "iPhone12,1":                              return "iPhone 11"
        case "iPhone12,3":                              return "iPhone 11 Pro"
        case "iPhone12,5":                              return "iPhone 11 Pro Max"
        case "iPhone12,8":                              return "iPhone SE 2. Gen"
        case "iPhone13,1":                              return "iPhone 12 Mini"
        case "iPhone13,2":                              return "iPhone 12"
        case "iPhone13,3":                              return "iPhone 12 Pro"
        case "iPhone13,4":                              return "iPhone 12 Pro Max"
        case "iPhone14,2":                              return "iPhone 13 Pro"
        case "iPhone14,3":                              return "iPhone 13 Pro Max"
        case "iPhone14,4":                              return "iPhone 13 Mini"
        case "iPhone14,5":                              return "iPhone 13"

            // iPads
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Gen"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro 11 Inch"
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro 12.9 Inch 3. Gen"
        case "iPad8,9":                                 return "iPad Pro 11 Inch 4. Gen WiFi"
        case "iPad8,10":                                return "iPad Pro 11 Inch 4. Gen WiFi+Cellular"
        case "iPad8,11":                                return "iPad Pro 12.9 Inch 4. Gen WiFi"
        case "iPad8,12":                                return "iPad Pro 12.9 Inch 4. Gen WiFi+Cellular"
        case "iPad11,1":                                return "iPad Mini 5. Gen Inch WiFi"
        case "iPad11,2":                                return "iPad Mini 5. Gen"
        case "iPad11,3":                                return "iPad Air 3. Gen WiFi"
        case "iPad11,4":                                return "iPad Air 3. Gen"
        case "iPad11,6":                                return "iPad 8. Gen WiFi"
        case "iPad11,7":                                return "iPad 8. Gen WiFi+Cellular"
        case "iPad13,1":                                return "iPad Air 4. Gen WiFi"
        case "iPad13,2":                                return "iPad Air 4. Gen WiFi+Celular"
        case "iPad13,4":                                return "iPad Pro 11 inch 3rd Gen"
        case "iPad13,5":                                return "iPad Pro 11 inch 3rd Gen"
        case "iPad13,6":                                return "iPad Pro 11 inch 3rd Gen"
        case "iPad13,7":                                return "iPad Pro 11 inch 3rd Gen"
        case "iPad13,8":                                return "iPad Pro 12.9 inch 5th Gen"
        case "iPad13,9":                                return "iPad Pro 12.9 inch 5th Gen"
        case "iPad13,10":                               return "iPad Pro 12.9 inch 5th Gen"
        case "iPad13,11":                               return "iPad Pro 12.9 inch 5th Gen"

            // Watchs
        case "Watch1,1":                                return "Apple Watch 38mm case"
        case "Watch1,2":                                return "Apple Watch 42mm case"
        case "Watch2,6":                                return "Apple Watch Series 1 38mm case"
        case "Watch2,7":                                return "Apple Watch Series 1 42mm case"
        case "Watch2,3":                                return "Apple Watch Series 2 38mm case"
        case "Watch2,4":                                return "Apple Watch Series 2 42mm case"
        case "Watch3,1":                                return "Apple Watch Series 3 38mm case (GPS+Cellular)"
        case "Watch3,2":                                return "Apple Watch Series 3 42mm case (GPS+Cellular)"
        case "Watch3,3":                                return "Apple Watch Series 3 38mm case (GPS)"
        case "Watch3,4":                                return "Apple Watch Series 3 42mm case (GPS)"
        case "Watch4,1":                                return "Apple Watch Series 4 40mm case (GPS)"
        case "Watch4,2":                                return "Apple Watch Series 4 44mm case (GPS)"
        case "Watch4,3":                                return "Apple Watch Series 4 40mm case (GPS+Cellular)"
        case "Watch4,4":                                return "Apple Watch Series 4 44mm case (GPS+Cellular)"
        case "Watch5,1":                                return "Apple Watch Series 5 40mm case (GPS)"
        case "Watch5,2":                                return "Apple Watch Series 5 44mm case (GPS)"
        case "Watch5,3":                                return "Apple Watch Series 5 40mm case (GPS+Cellular)"
        case "Watch5,4":                                return "Apple Watch Series 5 44mm case (GPS+Cellular)"
        case "Watch5,9":                                return "Apple Watch SE 40mm case (GPS)"
        case "Watch5,10":                               return "Apple Watch SE 44mm case (GPS)"
        case "Watch5,11":                               return "Apple Watch SE 40mm case (GPS+Cellular)"
        case "Watch5,12":                               return "Apple Watch SE 44mm case (GPS+Cellular)"
        case "Watch6,1":                                return "Apple Watch Series 6 40mm case (GPS)"
        case "Watch6,2":                                return "Apple Watch Series 6 44mm case (GPS)"
        case "Watch6,3":                                return "Apple Watch Series 6 40mm case (GPS+Cellular)"
        case "Watch6,4":                                return "Apple Watch Series 6 44mm case (GPS+Cellular)"

            // Apple TVs
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }

}


enum DeviceModel: String, CaseIterable {
    // iPods
    case iPodTouch5
    case iPodTouch6

    case iPhone4
    case iPhone4s

    case iPhone5
    case iPhone5c
    case iPhone5s

    case iPhone6
    case iPhone6Plus

    case iPhone6s
    case iPhone6sPlus

    case iPhone7
    case iPhone7Plus

    case iPhoneSE

    case iPhone8
    case iPhone8Plus

    case iPhoneX
    case iPhoneXS
    case iPhoneXSMax
    case iPhoneXR

    case iPhone11
    case iPhone11Pro
    case iPhone11ProMax

    case iPhoneSE2Gen

    case iPhone12Mini
    case iPhone12
    case iPhone12Pro
    case iPhone12ProMax

    case iPhone13Pro
    case iPhone13ProMax
    case iPhone13Mini
    case iPhone13

    // iPads
    case iPad2
    case iPad3
    case iPad4
    case iPadAir
    case iPadAir2
    case iPad5
    case iPadMini
    case iPadMini2
    case iPadMini3
    case iPadMini4
    case iPadPro9_7Inch
    case iPadPro12_9Inch
    case iPadPro12_9Inch2Gen
    case iPadPro10_5Inch
    case iPadPro11_Inch
    case iPadPro12_9Inch3Gen
    case iPadPro11Inch4GenWiFi
    case iPadPro11Inch4GenWiFi_Cellular
    case iPadPro12_9Inch4GenWiFi
    case iPadPro12_9Inch4GenWiFi_Cellular
    case iPadMini5GenInchWiFi
    case iPadMini5Gen
    case iPadAir3GenWiFi
    case iPadAir3Gen
    case iPad8GenWiFi
    case iPad8GenWiFi_Cellular
    case iPadAir4GenWiFi
    case iPadAir4GenWiFi_Celular
    case iPadPro11Inch3rdGen
    case iPadPro12_9Inch5thGen
}


// All devices
enum AllDeviceNames: String, CaseIterable {
    case Mac = "Mac"

    case iPhone7 = "iPhone 7"
    case iPhone7Plus = "iPhone 7 Plus"

    case iPhone8 = "iPhone 8"
    case iPhone8Plus = "iPhone 8 Plus"

    case iPhoneSE = "iPhone SE"
    case iPhoneSE2 = "iPhone SE 2. Gen"

    case iPhoneX = "iPhone X"

    case iPhoneXs = "iPhone Xs"
    case iPhoneXsMax = "iPhone Xs Max"

    case iPhoneXr = "iPhone Xʀ"

    case iPhone11 = "iPhone 11"
    case iPhone11Pro = "iPhone 11 Pro"

    case iPhone11ProMax = "iPhone 11 Pro Max"
    case iPhone12Mini = "iPhone 12 Mini"
    case iPhone12 = "iPhone 12"
    case iPhone12Pro = "iPhone 12 Pro"
    case iPhone12ProMax = "iPhone 12 Max"

    case iPhone13Mini = "iPhone 13 Mini"
    case iPhone13 = "iPhone 13"
    case iPhone13Pro = "iPhone 13 Pro"
    case iPhone13ProMax = "iPhone 13 Max"

    case iPadMini4 = "iPad mini 4"
    case iPadAir2 = "iPad Air 2"
    case iPadPro_9_7 = "iPad Pro (9.7-inch)"
    case iPadPro_12_9 = "iPad Pro (12.9-inch)"
    case iPad_5Gen = "iPad (5th generation)"
    case iPadPro_12_9_2Gen = "iPad Pro (12.9-inch) (2nd generation)"
    case iPadPro_10_5 = "iPad Pro (10.5-inch)"
    case iPad_6Gen = "iPad (6th generation)"
    case iPadPro_11 = "iPad Pro (11-inch)"
    case iPadPro_12_9_3Gen = "iPad Pro (12.9-inch) (3rd generation)"
    case iPadMini_5Gen = "iPad mini (5th generation)"
    case iPadAir_3Gen = "iPad Air (3rd generation)"
    case AppleTV = "Apple TV"
    case AppleTV4K = "Apple TV 4K"
    case AppleTV4K_1080 = "Apple TV 4K (at 1080p)"
    case AppleWatch2_38 = "Apple Watch Series 2 - 38mm"
    case AppleWatch2_42 = "Apple Watch Series 2 - 42mm"
    case AppleWatch3_38 = "Apple Watch Series 3 - 38mm"
    case AppleWatch3_42 = "Apple Watch Series 3 - 42mm"
    case AppleWatch4_40 = "Apple Watch Series 4 - 40mm"
    case AppleWatch4_44 = "Apple Watch Series 4 - 44mm"

    static var all: [String] {
        return AllDeviceNames.allCases.map { $0.rawValue }
    }
}

// All iPhone devices
enum iPhoneDeviceNames: String, CaseIterable {
    case iPhone7 = "iPhone 7"
    case iPhone7Plus = "iPhone 7 Plus"

    case iPhone8 = "iPhone 8"
    case iPhone8Plus = "iPhone 8 Plus"

    case iPhoneSE = "iPhone SE"

    case iPhoneSE2 = "iPhone SE 2. Gen"

    case iPhoneX = "iPhone X"

    case iPhoneXs = "iPhone Xs"
    case iPhoneXsMax = "iPhone Xs Max"

    case iPhoneXr = "iPhone Xʀ"

    case iPhone11 = "iPhone 11"
    case iPhone11Pro = "iPhone 11 Pro"

    case iPhone11ProMax = "iPhone 11 Pro Max"
    case iPhone12Mini = "iPhone 12 Mini"
    case iPhone12 = "iPhone 12"
    case iPhone12Pro = "iPhone 12 Pro"
    case iPhone12ProMax = "iPhone 12 Max"

    case iPhone13Mini = "iPhone 13 Mini"
    case iPhone13 = "iPhone 13"
    case iPhone13Pro = "iPhone 13 Pro"
    case iPhone13ProMax = "iPhone 13 Max"

    static var all: [String] {
        return iPhoneDeviceNames.allCases.map { $0.rawValue }
    }
}

// All iPad devices
enum iPadDeviceNames: String, CaseIterable {
    case iPadMini4 = "iPad mini 4"
    case iPadAir2 = "iPad Air 2"
    case iPadPro_9_7 = "iPad Pro (9.7-inch)"
    case iPadPro_12_9 = "iPad Pro (12.9-inch)"
    case iPad_5Gen = "iPad (5th generation)"
    case iPadPro_12_9_2Gen = "iPad Pro (12.9-inch) (2nd generation)"
    case iPadPro_10_5 = "iPad Pro (10.5-inch)"
    case iPad_6Gen = "iPad (6th generation)"
    case iPadPro_11 = "iPad Pro (11-inch)"
    case iPadPro_12_9_3Gen = "iPad Pro (12.9-inch) (3rd generation)"
    case iPadMini_5Gen = "iPad mini (5th generation)"
    case iPadAir_3Gen = "iPad Air (3rd generation)"

    static var all: [String] {
        return iPadDeviceNames.allCases.map { $0.rawValue }
    }
}
