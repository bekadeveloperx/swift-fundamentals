//
//  ContentView.swift
//  Shared
//
//  Created by Begzod Bakhriddinov on 23/04/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @Binding var document: ImageDocDemoDocument
    @State var ciFilter = CIFilter.colorMonochrome()
    
    let context = CIContext()

    var body: some View {
        VStack {
            Image(uiImage: document.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(7.0)
                .padding()
            
            Button(action: { filterImage() } ) {
                Text("Filter")
            }
            .padding()
        }
    }
    
    func filterImage() {
        ciFilter.intensity = Float(1.0)
        
        let ciImage = CIImage(image: document.image)
        
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        
        guard let outputImage = ciFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            document.image = UIImage(cgImage: cgImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(ImageDocDemoDocument()))
    }
}
