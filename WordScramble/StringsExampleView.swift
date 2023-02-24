//
//  StringsExampleView.swift
//  WordScramble
//
//  Created by Justin Hold on 2/24/23.
//

import SwiftUI

struct StringsExampleView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
	
//	func test1() {
//		let input = "a b c"
//		let letters = input.components(separatedBy: " ")
//	}
	
//	func test2() {
//		let input = """
//a
//b
//c
//"""
//		let letters = input.components(separatedBy: "\n")
//		let letter = letters.randomElement()
//
//		let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
//	}
	
//	func test3() {
//		let word = "swift"
//		let checker = UITextChecker()
//		
//		let range = NSRange(location: 0, length: word.utf16.count)
//		let misspelledRange = checker.rangeOfMisspelledWord(
//			in: word,
//			range: range,
//			startingAt: 0,
//			wrap: false,
//			language: "en"
//		)
//		let allGood = misspelledRange.location == NSNotFound
//	}
}

struct StringsExampleView_Previews: PreviewProvider {
    static var previews: some View {
        StringsExampleView()
    }
}
