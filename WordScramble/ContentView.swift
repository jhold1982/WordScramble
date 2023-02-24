//
//  ContentView.swift
//  WordScramble
//
//  Created by Justin Hold on 8/27/22.
//
import SwiftUI

struct ContentView: View {
	
	// properties to control word usage
	@State private var usedWords = [String]()
	@State private var rootWord = ""
	@State private var newWord = ""
	
	// property to control score count
    @State private var score = 0
    
	// properties to control Alerts
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
	
    var body: some View {
		
        NavigationStack {
			
            List {
				
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
				
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        .accessibilityElement()
                        .accessibilityLabel(word)
                        .accessibilityHint("\(word.count) letters")
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
			// onAppear runs a function when a view is shown
            .onAppear(perform: startGame)
			// alert section
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
			// toolbar button for new game
            .toolbar {
                Button("New Game", action: startGame)
            }
			// modifier for score area
            .safeAreaInset(edge: .bottom) {
                Text("Score: \(score)")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .font(.title)
            }
        }
    }
	
	
	
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 3 else {
            wordError(title: "Word too short", message: "Words must be at least four letters long.")
            return
        }
        guard answer != rootWord else {
            wordError(title: "Nice try…", message: "You can't use your starting word!")
            return
        }
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
        score += answer.count
    }
	
	
	
    func startGame() {
        newWord = ""
        usedWords.removeAll()
        score = 0
		// find the URL for start.txt in the app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
			// if we've found the file, we can now load
            if let startWords = try? String(contentsOf: startWordsURL) {
				// if we've loaded the file, what to do next?
                let allWords = startWords.components(separatedBy: "\n")
				// the word we are pulling from the txt file
                rootWord = allWords.randomElement() ?? "silkworm"
				// if all that has worked, we can exit / return
                return
            }
        }
		// couldn't find start.txt, found start.txt but couldn't load
		// crash app if issue with start.txt files
        fatalError("Could not load start.txt from bundle.")
    }
	
	
	
	// this method accepts a string as its only parameter, returns true or false
    func isOriginal(word: String) -> Bool {
		// this must return true if word has not been used already
        !usedWords.contains(word)
    }
	
	
	
    func isPossible(word: String) -> Bool {
		// making a variable copy of rootword to loop over
        var tempWord = rootWord
		// get each letter the player entered
        for letter in word {
			// does that exist somewhere in our temp rootword copy
            if let pos = tempWord.firstIndex(of: letter) {
				// remove letter they used each time
                tempWord.remove(at: pos)
            } else {
				// if letter wasn't found, don't allow
                return false
            }
        }
		// we've gone over every letter they've entered, word is good
        return true
    }
	
	
	
    func isReal(word: String) -> Bool {
		// required to check spelling of words
        let checker = UITextChecker()
		// required to check length of word / string
        let range = NSRange(location: 0, length: word.utf16.count)
		// confirms if word is mispelled
        let misspelledRange = checker.rangeOfMisspelledWord(
			in: word,
			range: range,
			startingAt: 0,
			wrap: false,
			language: "en"
		)
		// returns true if word is actual english word
        return misspelledRange.location == NSNotFound
    }
	
	
	
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
