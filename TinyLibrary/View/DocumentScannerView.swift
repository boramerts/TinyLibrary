//
//  DocumentScanner.swift
//  TinyLibrary
//
//  Created by Bora Mert on 10.12.2023.
//

import SwiftUI
import VisionKit

struct DocumentScannerView: UIViewControllerRepresentable {
    @Binding var scannedImage: UIImage?

    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var parent: DocumentScannerView

        init(parent: DocumentScannerView) {
            self.parent = parent
        }

        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            // Process the scanned document
            guard scan.pageCount > 0 else {
                controller.dismiss(animated: true)
                return
            }

            let scannedImage = scan.imageOfPage(at: 0)
            parent.scannedImage = scannedImage
            controller.dismiss(animated: true)
        }

        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            controller.dismiss(animated: true)
        }

        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            print("Document scanning error: \(error.localizedDescription)")
            controller.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let documentScannerViewController = VNDocumentCameraViewController()
        documentScannerViewController.delegate = context.coordinator
        return documentScannerViewController
    }

    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
        // Update logic (if needed) when the view is updated
    }
}

struct DocumentScannerDemoView: View {
    @State private var scannedImage: UIImage?

    var body: some View {
        VStack {
            if let scannedImage = scannedImage {
                Image(uiImage: scannedImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Button("Scan Document") {
                    // Toggle the sheet to show the document scanner
                    scannedImage = nil
                }
                .sheet(isPresented: Binding(
                    get: { scannedImage != nil },
                    set: { _ in scannedImage = nil }
                )) {
                    DocumentScannerView(scannedImage: $scannedImage)
                }
            }
        }
        .padding()
        .navigationTitle("Document Scanner")
    }
}

#Preview {
    DocumentScannerView(scannedImage: .constant(UIImage(systemName: "defaultCover")))
}
