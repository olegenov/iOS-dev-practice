//
//  WishMakerViewController.swift
//  nakitaevPW2
//
//  Created by Никита Китаев on 07.02.2024.
//

import UIKit

// MARK: WishMaker ViewController.
final class WishMakerViewController: UIViewController, UIColorPickerViewControllerDelegate {
    enum Constants {
        static let backgroundColor: UIColor = UIColor("#7958FF")
        
        static let titleText: String = "WishMaker"
        static let titleFontSize: CGFloat = 32
        static let titleColor: UIColor = UIColor("#FFFFFF")
        static let titleTopOffset: CGFloat = 30
        static let titleLeftOffset: CGFloat = 20
        
        static let descriptionText: String = "Create and grand your wishes!"
        static let descriptionFontSize: CGFloat = 16
        static let descriptionColor: UIColor = UIColor("#FFFFFF")
        static let descriptionTopOffset: CGFloat = 12
        static let descriptionLeftOffset: CGFloat = 20
        
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        
        static let stackBorderWidth: CGFloat = 2
        static let stackBorderColor: UIColor = UIColor("#C6C6C6")
        static let stackRadius: CGFloat = 20
        static let stackBottomOffset: CGFloat = -10
        static let stackLeftOffset: CGFloat = 20
        static let stackVerticalMargin : CGFloat = 10
        
        static let slidersStackActionButtonActiveText: String = "Show background settings"
        static let slidersStackActionButtonText: String = "Hide background settings"
        static let slidersStackActionButtonLeftOffset: CGFloat = 20
        static let slidersStackActionButtonBottomOffset: CGFloat = -40
        
        static let colorInputFieldLeftPadding: CGFloat = 10
        static let colorInputFieldHeight: CGFloat = 40
        static let colorInputFieldWidth: CGFloat = 20
        static let colorInputFieldBorderWidth: CGFloat = 2
        static let colorInputFieldBorderRadius: CGFloat = 20
        static let colorInputFieldBorderColor: UIColor = UIColor("#C6C6C6")
        static let colorInputFieldBackgroundColor: UIColor = UIColor.clear
        static let colorInputFieldColor: UIColor = UIColor("#FFFFFF")
        
        static let colorInputSpacing: CGFloat = 10
        static let colorInputBottomOffset: CGFloat = -10
        static let colorInputLeftOffset: CGFloat = 20
        
        static let colorSubmitText = "Submit"
        static let colorSubmitBorderWidth: CGFloat = 2
        static let colorSubmitBorderRadius: CGFloat = 20
        static let colorSubmitBorderColor: UIColor = UIColor("#C6C6C6")
        
        static let colorRandomText = "Random"
        static let colorRandomBorderWidth: CGFloat = 2
        static let colorRandomBorderRadius: CGFloat = 20
        static let colorRandomBorderColor: UIColor = UIColor("#C6C6C6")
        
        static let colorPickerWidth: CGFloat = 22
        static let colorPickerBorderWidth: CGFloat = 2
        static let colorPickerBorderRadius: CGFloat = 20
        static let colorPickerBorderColor: UIColor = UIColor("#C6C6C6")
    }
    
    private var titleView: UILabel = UILabel()
    private var descrptionView : UILabel = UILabel()
    private var slidersStackView : UIStackView = UIStackView()
    private var slidersStackActionButtonView: UIButton = UIButton()
    private var colorInputFieldView: UITextField = UITextField()
    private var colorInputView: UIStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI();
        view.backgroundColor = Constants.backgroundColor
    }
    
    private func configureUI() {
        view.backgroundColor = Constants.backgroundColor
        
        configureTitle()
        configureDescription()
        configureHideSlidersButton()
        configureSliders()
        configureColorInput()
    }
    
    // MARK: Configurates title.
    private func configureTitle() {
        let title: UILabel = titleView
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = Constants.titleText
        title.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        title.textColor = Constants.titleColor
        
        view.addSubview(title)
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleLeftOffset),
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTopOffset)
        ])
    }
    
    // MARK: Configurates description.
    private func configureDescription() {
        let description: UILabel = descrptionView
        
        description.translatesAutoresizingMaskIntoConstraints = false
        description.text = Constants.descriptionText
        description.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        description.textColor = Constants.descriptionColor
        
        view.addSubview(description)
        NSLayoutConstraint.activate([
            description.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            description.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.descriptionLeftOffset),
            description.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constants.descriptionTopOffset)
        ])
    }
    
    // MARK: Configurates color sliders.
    private func configureSliders() {
        let stack = slidersStackView
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        
        view.addSubview(stack)
        
        stack.layer.cornerRadius = Constants.stackRadius
        stack.layer.borderWidth = Constants.stackBorderWidth
        stack.layer.borderColor = Constants.stackBorderColor.cgColor
        stack.layoutMargins = UIEdgeInsets(top: Constants.stackVerticalMargin, left: 0, bottom: Constants.stackVerticalMargin, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        
        stack.clipsToBounds = true
        let backgroundRGB = view.backgroundColor?.RGBFromColor()
        
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax, value: (backgroundRGB![0]))
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax, value: backgroundRGB![1])
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax, value: backgroundRGB![2])
        
        for slider in [sliderRed, sliderGreen, sliderBlue] {
            slider.valueChanged = { newValue in
                self.updateBackgroundColor(UIColor(red: CGFloat(sliderRed.slider.value), green: CGFloat(sliderGreen.slider.value), blue: CGFloat(sliderBlue.slider.value), alpha: 1.0))
            }
        }
        
        for slider in [sliderRed, sliderGreen, sliderBlue] {
            stack.addArrangedSubview(slider)
        }
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeftOffset),
            stack.bottomAnchor.constraint(equalTo: slidersStackActionButtonView.topAnchor, constant: Constants.stackBottomOffset),
        ])
    }
    
    // MARK: Configurates hide button.
    private func configureHideSlidersButton() {
        let button: UIButton = slidersStackActionButtonView
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.slidersStackActionButtonText, for: .normal)
        button.setTitleColor(Constants.titleColor, for: .normal)
        button.addTarget(self, action: #selector(hideSlidersButtonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.slidersStackActionButtonBottomOffset),
        ])
    }
    
    // MARK: Configurates color HEX input, also ColorPicker and RandomColor button.
    private func configureColorInput() {
        let inputField: UITextField = colorInputFieldView
        let submitButton: UIButton = UIButton()
        let randomButton: UIButton = UIButton()
        let pickerButton: UIButton = UIButton()
        
        let input: UIStackView = colorInputView
        
        input.translatesAutoresizingMaskIntoConstraints = false
        input.distribution = .fillProportionally
        input.spacing = Constants.colorInputSpacing
        
        inputField.textColor = Constants.colorInputFieldColor
        inputField.backgroundColor = Constants.colorInputFieldBackgroundColor
        inputField.text = view.backgroundColor?.hexStringFromColor()
        
        inputField.layer.cornerRadius = Constants.colorInputFieldBorderRadius
        inputField.layer.borderWidth = Constants.colorInputFieldBorderWidth
        inputField.layer.borderColor = Constants.colorInputFieldBorderColor.cgColor
        inputField.heightAnchor.constraint(equalToConstant: Constants.colorInputFieldHeight).isActive = true
        
        inputField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.colorInputFieldLeftPadding, height: inputField.frame.height))
        inputField.leftViewMode = .always
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle(Constants.colorSubmitText, for: .normal)
        submitButton.addTarget(self, action: #selector(submitColorButtonTapped), for: .touchUpInside)
        submitButton.layer.borderWidth = Constants.colorInputFieldBorderWidth
        submitButton.layer.borderColor = Constants.colorInputFieldBorderColor.cgColor
        submitButton.layer.cornerRadius = Constants.colorInputFieldBorderRadius
        
        randomButton.translatesAutoresizingMaskIntoConstraints = false
        randomButton.setTitle(Constants.colorRandomText, for: .normal)
        randomButton.addTarget(self, action: #selector(randomColorButtonTapped), for: .touchUpInside)
        randomButton.layer.borderWidth = Constants.colorInputFieldBorderWidth
        randomButton.layer.borderColor = Constants.colorInputFieldBorderColor.cgColor
        randomButton.layer.cornerRadius = Constants.colorInputFieldBorderRadius
        
        pickerButton.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 14.0, *) {
            pickerButton.addTarget(self, action: #selector(pickerColorButtonTapped), for: .touchUpInside)
        }
        
        pickerButton.layer.borderWidth = Constants.colorPickerBorderWidth
        pickerButton.layer.borderColor = Constants.colorPickerBorderColor.cgColor
        pickerButton.layer.cornerRadius = Constants.colorPickerBorderRadius
        pickerButton.setImage(UIImage(named: "picker"), for: .normal)
        
        input.addArrangedSubview(inputField)
        input.addArrangedSubview(submitButton)
        input.addArrangedSubview(randomButton)
        input.addArrangedSubview(pickerButton)
        view.addSubview(input)
        
        NSLayoutConstraint.activate([
            input.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            input.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.colorInputLeftOffset),
            input.bottomAnchor.constraint(equalTo: slidersStackView.topAnchor, constant: Constants.colorInputBottomOffset),
        ])
    }
    
    // MARK: Updates backgroundcolor.
    private func updateBackgroundColor(_ color : UIColor) {
        view.backgroundColor = color
        updateColorInput()
        updateColorSliders()
    }
    
    // MARK: Hides Sliders and other color stuff.
    @objc private func hideSlidersButtonTapped() {
        self.slidersStackView.isHidden = !self.slidersStackView.isHidden
        self.colorInputView.isHidden = !self.colorInputView.isHidden
        
        let slidersStackIsHidden = self.slidersStackView.isHidden
        
        let buttonText = slidersStackIsHidden ? Constants.slidersStackActionButtonActiveText : Constants.slidersStackActionButtonText
        
        slidersStackActionButtonView.setTitle(buttonText, for: .normal)
    }
    
    // MARK: Gets users HEX input.
    @objc private func submitColorButtonTapped() {
        updateBackgroundColor(UIColor(colorInputFieldView.text ?? ""))
    }
    
    // MARK: Randomizes background color.
    @objc private func randomColorButtonTapped() {
        updateBackgroundColor(UIColor.getRandom())
    }
    
    // MARK: Opens color picking menu.
    @available(iOS 14.0, *)
    @objc private func pickerColorButtonTapped() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true, completion: nil)
    }
    
    // MARK: Updates HEX input value.
    private func updateColorInput() {
        self.colorInputFieldView.text = view.backgroundColor?.hexStringFromColor()
    }
    
    // MARK: Updates color sliders.
    private func updateColorSliders() {
        let backgroundRGB = view.backgroundColor?.RGBFromColor()
        var i = 0
        
        for slider in slidersStackView.arrangedSubviews {
            if let sliderView: CustomSlider = slider as? CustomSlider {
                sliderView.slider.value = backgroundRGB![i]
            }
            i += 1
        }
    }
    
    // MARK: Sets background color depends on color picker.
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        updateBackgroundColor(selectedColor)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Sets background color depends on color picker.
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        updateBackgroundColor(selectedColor)
    }
}

