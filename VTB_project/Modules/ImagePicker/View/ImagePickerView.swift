//
//  CameraViewController.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 03.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class ImagePickerView: UIViewController, ImagePickerViewInput {

//    MARK: - Properties

    var presenter: ImagePickerViewOutput?

    private var navigationBar: MainNavigationBar!
    private let spinner = SpinnerViewController()

//    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Фото"
        view.backgroundColor = .white

        addAndConfigureNavigationBar()
        addAndConfigurePhotoSourceButtons()
    }

//    MARK: - UI configuration

    private func addAndConfigureNavigationBar() {
        navigationBar = MainNavigationBar(title: "Фото", rightTitle: UserSettings.shared.foreignLanguage.humanRepresentingNative, rightButtonImage: nil, isSearchBarNeeded: false)
        view.addSubview(navigationBar)

        let constraint = navigationBar.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            constraint
        ])

        let height = CGFloat(60) ///calculated height
        constraint.constant = height
    }

    private func addAndConfigurePhotoSourceButtons() {
        let cameraButton = createAndCummonConfigureButton(with: "Камера")
        let galeryButton = createAndCummonConfigureButton(with: "Галерея")

        let stack = UIStackView(arrangedSubviews: [cameraButton, galeryButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        let stackHeight = CGFloat(200)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.heightAnchor.constraint(equalToConstant: stackHeight),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        galeryButton.addTarget(self, action: #selector(galeryButtonTapped), for: .touchUpInside)
    }

    private func createAndCummonConfigureButton(with title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)

        button.layer.borderColor = #colorLiteral(red: 0.4078038633, green: 0.4117894173, blue: 0.4117121696, alpha: 1)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 20

        button.titleLabel?.numberOfLines = 1


        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        return button
    }

//    MARK: - User interaction

    @objc private func cameraButtonTapped() {
        presenter?.cameraButtonPressed()
    }

    @objc private func galeryButtonTapped() {
        presenter?.galeryButtonPressed()
    }

//    MARK: - UI update

    func showCameraImagePicker() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .camera
        pickerController.allowsEditing = true
        self.present(pickerController, animated: true, completion: nil)
    }

    func showGaleryImagePicker() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        self.present(pickerController, animated: true, completion: nil)
    }

    func showSpinner() {
        addChild(spinner)
        view.addSubview(spinner.view)
        var frame = view.frame

        if let tabBar = tabBarController?.tabBar {
            frame = CGRect(x: 0, y: navigationBar.frame.maxY, width: view.frame.width, height: tabBar.frame.minY - navigationBar.frame.maxY)
        }

        spinner.view.frame = frame
        spinner.didMove(toParent: self)
    }

    func unshowSpinner() {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
}

//MARK: - UIImagePickerControllerDelegate

extension ImagePickerView: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                presenter?.receiveImageFromUser(image: pickedImage)
        }
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - UIImagePickerControllerDelegate


extension ImagePickerView: UINavigationControllerDelegate {}
