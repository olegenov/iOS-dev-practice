//
//  GalleryViewController.swift
//  GalleryApp
//
//  Created by Никита Китаев on 19.03.2024.
//

import UIKit

final class GalleryViewController: UIViewController {
    enum Constants {
        static let backgroundColor: UIColor = UIColor("#FFFFFF")
        static let sideOffset: CGFloat = 16
        
        static let settingsButtonTitle: String = "Settings"
        static let textColor: UIColor = UIColor("#000000")
        static let buttonHeight: CGFloat = 36
        static let borderRadius: CGFloat = 16
    }
    
    private let settingsView: SettingsView = SettingsView()
    private let pictures: [Picture] = []
    private let gallery: Gallery = Gallery()
    private let settingsButton: UIButton = UIButton()
    public let Apis: [ApiService] = [
        ApiService(url: URL(string: "https://randomfox.ca/floof/")!, param: "image"),
        ApiService(url: URL(string: "https://random.dog/woof.json")!, param: "url"),
    ]
    
    static let currentApi = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = Constants.backgroundColor
        
        configureGallery()
        configureSettingsButton()
        configureSettings()
    }
    
    private func configureGallery() {
        gallery.translatesAutoresizingMaskIntoConstraints = false
        gallery.backgroundColor = .clear
        
        gallery.updateData([Picture(stringUrl: "https://mobimg.b-cdn.net/v3/fetch/3c/3cccd3c65e2abc4d5085221f2e38544c.jpeg"), Picture(stringUrl: "https://img.razrisyika.ru/kart/24/1200/95250-kotiki-kartinki-20.jpg")])
        view.addSubview(gallery)
        
        NSLayoutConstraint.activate([
            gallery.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gallery.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            gallery.heightAnchor.constraint(equalToConstant: 300),
            gallery.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            gallery.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
        ])
    }
    
    private func configureSettings() {
        settingsView.isHidden = true
        settingsView.configureSizeSliderAction(action: self.updateCardSize)
        settingsView.configureChangeBgAction(action: pickColor)
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsView)
        
        NSLayoutConstraint.activate([
            settingsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
            settingsView.bottomAnchor.constraint(equalTo: settingsButton.topAnchor, constant: -10),
            settingsView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func updateCardSize(newsize: Double) {
        gallery.updateCardSize(CGFloat(newsize))
    }
    
    private func configureSettingsButton() {
        settingsButton.setTitle(Constants.settingsButtonTitle, for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.layer.cornerRadius = Constants.borderRadius
        settingsButton.layer.borderWidth = 1
        settingsButton.setTitleColor(Constants.textColor, for: .normal)
        
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        view.addSubview(settingsButton)
        
        NSLayoutConstraint.activate([
            settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideOffset),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideOffset),
            settingsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingsButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    @objc private func settingsButtonTapped() {
        if (settingsView.isHidden) {
            settingsView.isHidden = false
        } else {
            settingsView.isHidden = true
        }
    }
    
    private func updateBackgroundColor(_ color : UIColor) {
        view.backgroundColor = color
    }
    
    public func pickColor() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true, completion: nil)
    }
}


// MARK: - UIColorPickerViewControllerDelegate
extension GalleryViewController: UIColorPickerViewControllerDelegate {
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        updateBackgroundColor(selectedColor)
        dismiss(animated: true, completion: nil)
    }
    
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        updateBackgroundColor(selectedColor)
    }
}
