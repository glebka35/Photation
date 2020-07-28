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

    private var dictionary: SynchronizedStringDictionary = SynchronizedStringDictionary()

    func translate(objects: ObjectsOnImage, from nativeLang: Languages, to foreignLang: Languages, completion: @escaping (_ objects: ObjectsOnImage)->Void) {
        dictionary.removeAll()

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in

            let dispatchGroup = DispatchGroup()

            objects.objects.forEach { (object) in
                dispatchGroup.enter()
                self?.translationClient.getTranslation(of: object.nativeName, from: nativeLang.rawValue, to: foreignLang.rawValue) { [weak self] (word, translatedWord) in
                    if let word = word, let translatedWord = translatedWord {
                        self?.dictionary[word] = translatedWord
                    } else {
                        print("no translation")
                    }
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.wait()

            var newObjects = objects
            for index in 0..<objects.objects.count {
                if let dictionary = self?.dictionary {
                    newObjects.objects[index].foreignName = dictionary[newObjects.objects[index].nativeName]
                }
            }
            completion(newObjects)
        }
    }
}

