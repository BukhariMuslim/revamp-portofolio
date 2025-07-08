//
//  BrimoNsPinDelegate.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 29/06/25.
//

import Foundation
import Combine

protocol BrimoNsReusablePinProtocol {
    var pinState: CurrentValueSubject<PinReusableState, Never> { get }
    var pinValidationState: PassthroughSubject<PinReusableValidationState, Never> { get }
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String?, Never> { get }
    var didReachMaxAttempt: PassthroughSubject<Void, Never> { get }

    func addDigit(_ digit: String)
    func deleteDigit()
    func clearError()
}

enum PinReusableValidationState {
    case idle
    case validating
    case valid
    case invalid(message: String)
}

struct PinReusableState {
    let currentPin: String
    var filledDots: Int { currentPin.count }
}
