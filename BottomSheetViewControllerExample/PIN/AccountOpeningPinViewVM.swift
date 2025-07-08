//
//  BrimoNsPinViewModel.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 29/06/25.
//


import Combine
import Foundation
import Combine

final class AccountOpeningPinViewVM: BrimoNsReusablePinProtocol {
    
    // MARK: - Subjects
    let pinState = CurrentValueSubject<PinReusableState, Never>(PinReusableState(currentPin: ""))
    let pinValidationState = PassthroughSubject<PinReusableValidationState, Never>()
    let isLoading = PassthroughSubject<Bool, Never>()
    let errorMessage = PassthroughSubject<String?, Never>()
    let didReachMaxAttempt = PassthroughSubject<Void, Never>()

    // MARK: - Constants
    private let requiredPinLength = 6
    private(set) var retryCount = 0
    private let maxRetry = 4

    // MARK: - Logic

    func addDigit(_ digit: String) {
        guard pinState.value.currentPin.count < requiredPinLength else { return }
        var pin = pinState.value.currentPin
        pin.append(digit)
        pinState.send(PinReusableState(currentPin: pin))

        if pin.count == requiredPinLength {
            validate(pin: pin)
        }
    }

    func deleteDigit() {
        var pin = pinState.value.currentPin
        guard !pin.isEmpty else { return }
        pin.removeLast()
        pinState.send(PinReusableState(currentPin: pin))
    }

    func clearError() {
        errorMessage.send(nil)
    }

    private func validate(pin: String) {
        pinValidationState.send(.validating)
        isLoading.send(true)

        // Simulasi async validasi PIN
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.isLoading.send(false)

            if pin == "123456" {
                self.pinValidationState.send(.valid)
            } else {
                self.retryCount += 1
                self.pinState.send(PinReusableState(currentPin: ""))

                switch self.retryCount {
                case self.maxRetry:
                    self.didReachMaxAttempt.send()
                case self.maxRetry - 1:
                    self.pinValidationState.send(.invalid(message: "Kamu telah mencoba 3 kali dari 4 percobaan yang diperbolehkan."))
                default:
                    self.pinValidationState.send(.invalid(message: "PIN salah. Silakan coba lagi."))
                }
            }
        }
    }
}
