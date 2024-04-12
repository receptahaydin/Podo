//
//  UiModelState.swift
//  CRXDCA
//
//  Created by Walid Baroudi on 4.05.2023.
//

import Foundation

enum UiModelState<T> {
    case success(value: T)
    case error(error: Error)
    case loading
    case none
    
    func getData() -> T? {
        switch self {
        case .success(let value):
            return value
        default:
            return nil
        }
    }
}
