//
//  EStatementCSVQuickLookVC.swift
//  BottomSheetViewControllerExample
//
//  Created by User01 on 18/07/25.
//

import UIKit

class EStatementCSVQuickLookVC: UIViewController {
    var docController: UIDocumentInteractionController?
    var fileToPreview: URL?
    private var hasPresented = false

    func previewFile(url: URL) {
        self.fileToPreview = url
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if hasPresented {
            dismiss(animated: true)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !hasPresented {
            hasPresented = true
            guard let fileURL = fileToPreview else { return }

            docController = UIDocumentInteractionController(url: fileURL)
            docController?.delegate = self
            docController?.presentPreview(animated: true)
        }
    }
}

extension EStatementCSVQuickLookVC: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}
