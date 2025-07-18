//
//  EStatementQuickLookVC.swift
//  BottomSheetViewControllerExample
//
//  Created by User01 on 18/07/25.
//

import UIKit

class EStatementQuickLookVC: UIViewController {
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

extension EStatementQuickLookVC: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}

/*import QuickLook

class EStatementQuickLookVC: UIViewController, QLPreviewControllerDataSource {
    var fileURL: URL!

    func previewFile(at url: URL) {
        self.fileURL = url
        let previewController = QLPreviewController()
        previewController.dataSource = self
        present(previewController, animated: true)
    }

    // MARK: QLPreviewControllerDataSource
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return fileURL as NSURL
    }
}*/
