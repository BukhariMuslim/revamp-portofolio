//
//  SetoranAwalViewController.swift
//  BottomSheetViewControllerExample
//
//  Created by PT Diksha Teknologi Indonesia on 29/06/25.
//

import UIKit

class SetoranAwalViewController: UIViewController, CustomNumberKeyboardDelegate {

    let textField = UITextField()

       override func viewDidLoad() {
           super.viewDidLoad()

           view.backgroundColor = .white
           textField.borderStyle = .roundedRect
           textField.placeholder = "Enter number"
           textField.font = .systemFont(ofSize: 24)
           textField.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(textField)

           NSLayoutConstraint.activate([
               textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
               textField.widthAnchor.constraint(equalToConstant: 250)
           ])

           let keyboard = CustomNumberKeyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
           keyboard.delegate = self
           textField.inputView = keyboard
       }

       func customKeyboardDidTap(number: String) {
           textField.insertText(number)
       }

       func customKeyboardDidTapDelete() {
           textField.deleteBackward()
       }
}
