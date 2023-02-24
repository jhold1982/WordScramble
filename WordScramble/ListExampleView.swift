//
//  ListExampleView.swift
//  WordScramble
//
//  Created by Justin Hold on 2/24/23.
//

import SwiftUI

// List(0..<5) {
//		Text("Dynamic List Row \(0)")
//	}

// let people = ["People 1", "People 2", "People 3"]

// List(people, id: \.self)

struct ListExampleView: View {
    var body: some View {
		
		List {
			
		
			Section("Section 1") {
				
				Text("Static Row 1")
				Text("Static Row 2")
			}
		
			Section("Section 2 - Dynamic") {
				ForEach(0..<5) {
					Text("Dynamic row \($0)")
				}
			}
			
			Section("Section 3") {
				Text("Static Row 4")
				Text("Static Row 5")
			}
		}
		// makes everything edge-to-edge
//		.listStyle(.grouped)
    }
	
	
//	func loadFile() {
//		if let fileURL = Bundle.main.url(
//			forResource: "some-file",
//			withExtension: ".txt"
//		){
//			if let fileContents = try? String(contentsOf: fileURL) {
//				fileContents
//			}
//		}
//	}
	
}

struct ListExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ListExampleView()
    }
}
