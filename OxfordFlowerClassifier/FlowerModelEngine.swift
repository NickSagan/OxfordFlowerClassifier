//
//  FlowerModelEngine.swift
//  OxfordFlowerClassifier
//
//  Created by Nick Sagan on 15.10.2021.
//

import Foundation
import CoreML
import Vision
import UIKit

class FlowerModelEngine {
    
    func detect(image: CIImage) -> String {
        
        var result: String = ""
        
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            fatalError("Loading CoreML model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            
            result = results.first?.identifier.capitalized ?? ""
        }
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        return result
    }
    
}
