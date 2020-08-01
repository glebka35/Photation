//
//  Translator.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 28.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class Translator {
    private let translationClient = TranslationClient()

    private var firstLangdictionary: SynchronizedStringDictionary = SynchronizedStringDictionary()
    private var secondLangdictionary: SynchronizedStringDictionary = SynchronizedStringDictionary()

    func translate(objects: ObjectsOnImage, nativeLang: Language, foreignLang: Language, completion: @escaping (_ objects: ObjectsOnImage)->Void) {

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in

            let dispatchGroup = DispatchGroup()
            var newObjects = objects

            if nativeLang != .en {
                dispatchGroup.enter()

                var words: [String] = []
                objects.objects.forEach() {
                    words.append($0.nativeName)
                }
                self?.translate(words: words, from: .en, to: nativeLang) { dict in
                    for index in 0..<objects.objects.count {
                        newObjects.objects[index].nativeName = dict[objects.objects[index].nativeName] ?? ""
                    }
                    dispatchGroup.leave()
                }
            }

            if foreignLang != .en {
                dispatchGroup.enter()
                
                var words: [String] = []
                objects.objects.forEach() {
                    if let foreignName = $0.foreignName {
                        words.append(foreignName)
                    }
                }
                self?.translate(words: words, from: .en, to: foreignLang) { dict in
                    for index in 0..<objects.objects.count {
                        newObjects.objects[index].foreignName = dict[objects.objects[index].nativeName]
                    }
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.wait()

            completion(newObjects)
        }
    }

    private func translate(words: [String], from inLanguage: Language, to outLanguage: Language, completion: @escaping (_ dictionary: SynchronizedStringDictionary)->Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let dispatchGroup = DispatchGroup()
            let dictionary = SynchronizedStringDictionary()

            words.forEach { (word) in
                dispatchGroup.enter()
                self?.translationClient.getTranslation(of: word, from: inLanguage.rawValue, to: outLanguage.rawValue) { (word, translatedWord) in
                    if let word = word, let translatedWord = translatedWord {
                        dictionary[word] = translatedWord
                    } else {
                        print("no translation")
                    }
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.wait()
            completion(dictionary)
        }
    }
}

