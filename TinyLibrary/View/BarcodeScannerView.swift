//
//  BarcodeScanner.swift
//  TinyLibrary
//
//  Created by Bora Mert on 21.12.2023.
//

import SwiftUI
import VisionKit
import AVFoundation

struct BarcodeScannerView: UIViewControllerRepresentable {
    var scannedBarcode: String?
    @Binding var foundBooks: Books?
    @Environment(\.presentationMode) var presentationMode
    
    var onScanComplete: ((Books?) -> Void)?

    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: BarcodeScannerView
        var captureSession: AVCaptureSession? // Hold a reference to the capture session
        var isBarcodeDetected = false

        init(parent: BarcodeScannerView) {
            self.parent = parent
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if !isBarcodeDetected, let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
               let scannedBarcode = metadataObject.stringValue {

                isBarcodeDetected = true // Set the flag
                self.captureSession?.stopRunning() // Stop the session immediately

                DispatchQueue.main.async {
                    print("Scanned barcode")
                    
                    self.parent.presentationMode.wrappedValue.dismiss() // Dismiss the scanner view
                    print("Dismissing scanner view")

                    BookSearchManager().getBookInfo(isbn: scannedBarcode) { books in
                        print("DispatchQueue running...")
                        self.parent.foundBooks = books
                        print("foundBooks")
                        self.parent.onScanComplete?(books) // Call the callback here
                    }
                }
            }
        }
    }


    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            print("Failed to get the camera device")
            return viewController
        }
        
        let captureSession = AVCaptureSession()

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            let captureSession = AVCaptureSession()
            captureSession.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.ean8, .ean13, .pdf417, .qr] // Add other types you want to support

            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = viewController.view.layer.bounds
            
            DispatchQueue.main.async {
                viewController.view.layer.addSublayer(previewLayer)
            }

            DispatchQueue.global(qos: .userInitiated).async {
                captureSession.startRunning()
            }
        } catch {
            print("Error setting up the barcode scanner: \(error)")
            return viewController
        }
        
        context.coordinator.captureSession = captureSession

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update logic if needed
    }
}


#Preview {
    Text("Hello")
}
