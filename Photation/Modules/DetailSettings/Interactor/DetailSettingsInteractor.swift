//
//  DetailSettingsInteractor.swift
//  Photation
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class DetailSettingsInteractor: DetailSettingsInteractorInput {
//    MARK: - Properties

    weak var presenter: DetailSettingsInteractorOutput?
    private let coreDataStore: DataStoreProtocol = CoreDataStore.shared
    private let settings: SettingsList
    private var dictCount: [Language:Int] = [:]

//    MARK: - Life cycle

    init(with setting: SettingsList) {
        self.settings = setting
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(NotificionIdentifier.newImageAdded), object: nil)
    }


    func viewDidLoad() {
        reloadData()
    }

//    MARK: - Saving

    func languageChosen(at indexPath: IndexPath) {
        switch settings {
        case .foreignLanguage:
            SettingsStore.shared.saveForeign(language: Language.allCases[indexPath.row])
        case.mainLanguage:
            SettingsStore.shared.saveNative(language: Language.allCases[indexPath.row])
        default:
            break
        }
    }

    private func getEntitiesCount(completion: @escaping (_ countDict: [Language:Int])->Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            var countDictionary: [Language:Int] = [:]
            switch self?.settings {
            case .mainLanguage:
                Language.allCases.forEach { (language) in
                    let count = self?.coreDataStore.imagesCountFor(predicates: ["nativeLanguage": language.rawValue])
                    countDictionary[language] = count
                }

            case .foreignLanguage:
                Language.allCases.forEach { (language) in
                    let count = self?.coreDataStore.imagesCountFor(predicates: ["nativeLanguage": SettingsStore.shared.getNativeLanguage().rawValue, "foreignLanguage": language.rawValue])
                    countDictionary[language] = count
                }

            default:
                break
            }
            DispatchQueue.main.async {
                completion(countDictionary)
            }
        }
    }

    @objc private func reloadData() {
        getEntitiesCount() { dictCount in
            self.dictCount = dictCount
            self.update()
        }
    }

    private func update() {
        var languageSettings = Language.en

        switch settings {
        case .mainLanguage:
            languageSettings = SettingsStore.shared.getNativeLanguage()

        case .foreignLanguage:
            languageSettings = SettingsStore.shared.getForeignLanguage()
        default:
            break
        }

        let cellModels = Language.allCases.map { (language) -> LanguageCellViewModel in
            LanguageCellViewModel(main: language.humanRepresentingNative, additional: language.humanRepresentingEnglish, isChosen: language ==  languageSettings, translationCount: dictCount[language] ?? 0)
        }

        presenter?.update(with: cellModels, and: DefaultNavigationBarModel(title: LocalizedString().getSettingsString(settings: settings), backButtonTitle: LocalizedString().backButton))
    }
}
