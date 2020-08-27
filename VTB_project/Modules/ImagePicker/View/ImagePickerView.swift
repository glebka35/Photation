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

    private var navigationBar: MainNavigationBar?
    private let spinner = SpinnerViewController()

    private var cameraButton: UIButton?
    private var galeryButton: UIButton?

//    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        addAndConfigureNavigationBar()
        addAndConfigurePhotoSourceButtons()

        presenter?.viewDidLoad()
    }

//    MARK: - UI configuration

    private func addAndConfigureNavigationBar() {
        let navigationBar = MainNavigationBar(title: "", rightTitle: "", rightButton: nil, isSearchBarNeeded: false)
        view.addSubview(navigationBar)

        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10),
            navigationBar.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 70)
        ])

        self.navigationBar = navigationBar
    }

    private func addAndConfigurePhotoSourceButtons() {
        let cameraButton = createAndCummonConfigureButton()
        let galeryButton = createAndCummonConfigureButton()

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

        self.cameraButton = cameraButton
        self.galeryButton = galeryButton
    }

    private func createAndCummonConfigureButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
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

        if let tabBar = tabBarController?.tabBar, let navigationBar = navigationBar{
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


    func update(with model: ImagePickerViewModel) {
        navigationBar?.update(with: model.navigationBarModel)
        cameraButton?.setTitle(model.cameraButtonTitle, for: .normal)
        galeryButton?.setTitle(model.galeryButtonTitle, for: .normal)

        title = model.navigationBarModel.title
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
