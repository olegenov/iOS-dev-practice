//
//  SettingsView.swift
//  GalleryApp
//
//  Created by Никита Китаев on 19.03.2024.
//

import UIKit

class SettingsView: UIView {
    enum Constants {
        static let slidersHeader: String = "Image size"
        static let minSlider: Double = 128
        static let maxSlider: Double = 512
        static let sideOffset: CGFloat = 16
        static let borderRadius: CGFloat = 16
    }
    
    let changeBgColorButton = UIButton()
    var changeColorAction: (() -> Void)?
    let sliderView: Slider
    
    init() {
        sliderView = Slider(title: Constants.slidersHeader, min: Constants.minSlider, max: Constants.maxSlider, value: Float(Constants.minSlider))
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSizeSliderAction(action: @escaping (Double) -> Void) {
        sliderView.valueChanged = action
    }
    
    private func configureUI() {
        layer.borderWidth = 1
        layer.cornerRadius = Constants.borderRadius
        configureSlider()
        configureChangeBgButton()
    }
    
    private func configureSlider() {
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(sliderView)
        
        NSLayoutConstraint.activate([
            sliderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            sliderView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.sideOffset),
            sliderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sideOffset),
            sliderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sideOffset),
        ])
    }
    
    private func configureChangeBgButton() {
        changeBgColorButton.translatesAutoresizingMaskIntoConstraints = false
        changeBgColorButton.setTitle("Change background", for: .normal)
        changeBgColorButton.layer.cornerRadius = Constants.borderRadius
        changeBgColorButton.setTitleColor(.black, for: .normal)
        changeBgColorButton.layer.borderWidth = 1
        
        addSubview(changeBgColorButton)
        
        NSLayoutConstraint.activate([
            changeBgColorButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            changeBgColorButton.topAnchor.constraint(equalTo: sliderView.bottomAnchor, constant: Constants.sideOffset),
            changeBgColorButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sideOffset),
            changeBgColorButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sideOffset),
            changeBgColorButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func configureChangeBgAction(action: @escaping () -> Void) {
        changeBgColorButton.addTarget(self, action: #selector(permormChangeColorAction), for: .touchUpInside)
        
        changeColorAction = action
    }
    
    @objc private func permormChangeColorAction() {
        changeColorAction?()
    }
}
