//
//  ViewController.swift
//  Smile Mirror
//
//  Created by Raj Vishal on 18/06/22.
//

import UIKit
import AVKit
import Vision
import CoreML

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //camera startup
        
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice =
                AVCaptureDevice.default(for: .video) else {return }
        guard let input = try? AVCaptureDeviceInput(device:captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
     
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        
        //VNImageRequestHandler(cgImage: CGImage, options : [:]).perform(<#T##requests: [VNRequest]##[VNRequest]#>)
    }
    
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection)  {
        print("Camera was able to capture a frame", Date())

        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

        
        print(pixelBuffer)


        
        func testModel() -> smile_detection? {
            
            do{
                let config = MLModelConfiguration()
                
                guard let model = try? smile_detection(configuration: config)
                else {
                    print("Model Not Found")
                    return nil
                }
                print("Model Found")


                
            } catch{
                print("Model Not Found")
            }
            
            return nil
        }
        
        
        let prediction = testModel()
    
    }
    
    
}


