//
//  CustomSlider.swift
//  nakitaevPW2
//
//  Created by Никита Китаев on 07.02.2024.
//

import UIKit

// MARK: Custom slider class.
final class CustomSlider: UIView {
    enum Constants {
        static let titleLabelFontSize : CGFloat = 16
        static let titleLabelTopOffset : CGFloat = 10.0
        static let titleLabelLeftOffset : CGFloat = 20.0
        static let titleLabelColor : UIColor = UIColor("#FFFFFF")
        
        static let sliderMinimumTrackTintColor: UIColor = UIColor("#C6C6C6")
        static let sliderMaximumTrackTintColor: UIColor = UIColor.clear
        static let sliderBottomOffset : CGFloat = -10.0
        static let sliderLeftOffset : CGFloat = 20.0
        static let sliderTopOffser : CGFloat = 10.0
    }
    
    var valueChanged: ((Double) -> Void)?
    
    var slider = UISlider()
    var titleView = UILabel()
    
    init(title: String, min: Double, max: Double, value : Float) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.value = value
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Slider configuration.
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        titleView.font = UIFont.systemFont(ofSize: Constants.titleLabelFontSize)
        titleView.textColor = Constants.titleLabelColor
        slider.minimumTrackTintColor = Constants.sliderMinimumTrackTintColor
        slider.maximumTrackTintColor = Constants.sliderMaximumTrackTintColor
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleLabelTopOffset),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleLabelLeftOffset),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constants.sliderTopOffser),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.sliderBottomOffset),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderLeftOffset)
        ])
    }
    
    // MARK: Slider value changed.
    @objc
    public func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}

