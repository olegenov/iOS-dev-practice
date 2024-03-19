//
//  AddWishCell.swift
//  nakitaevPW2
//
//  Created by Никита Китаев on 05.03.2024.
//

import UIKit

final class AddWishCell: UITableViewCell {
    static let reuseId: String = "AddWishCell"
    
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        
        static let wishTextFontSize: CGFloat = 16
        
        static let submitButtonCornerRadius: CGFloat = 16
        static let submitButtonColor: UIColor = UIColor("#702AF6")
        static let submitButtonColorTapped: UIColor = UIColor("#8F56FE")
        static let submitButtonTitleColor: UIColor = UIColor.white
        
        static let placeholder: String = "Write your wish here"
        static let placeholderColor: UIColor = UIColor("#A7A7A7")
        
        static let textColor: UIColor = UIColor("#000000")
        
        static let sudmitButtonWidth: CGFloat = 32
    }
    
    private let wishText: UITextView = UITextView()
    private let submitButton: UIButton = UIButton()
    private let wrap: UIView = UIView()
    var addWish: ((String) -> ())?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = Constants.wrapColor
        layer.cornerRadius = Constants.wrapRadius
        
        configureWrap()
        configureText()
        configureSubmitButton()
    }
    
    private func configureText() {
        wishText.isUserInteractionEnabled = true
        wishText.isEditable = true
        
        wishText.text = Constants.placeholder
        wishText.textColor = Constants.placeholderColor

        wishText.font = UIFont.systemFont(ofSize: Constants.wishTextFontSize)
        wishText.delegate = self
        
        wrap.addSubview(wishText)
        
        wishText.pinVertical(to: wrap)
        wishText.pinHorizontal(to: wrap)
    }
    
    private func configureWrap() {
        wrap.isUserInteractionEnabled = true
        
        contentView.addSubview(wrap)
        
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
    }
    
    private func configureSubmitButton() {
        submitButton.backgroundColor = Constants.submitButtonColor
        submitButton.setTitleColor(Constants.submitButtonTitleColor, for: .normal)
        
        submitButton.layer.cornerRadius = Constants.submitButtonCornerRadius
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setWidth(Constants.sudmitButtonWidth)
        submitButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        
        let icon = UIImageView()
        icon.image = UIImage(named: "plus")
        icon.translatesAutoresizingMaskIntoConstraints = false
        submitButton.addSubview(icon)
        
        wrap.addSubview(submitButton)
        
        submitButton.pinTop(to: wrap)
        submitButton.pinBottom(to: wrap)
        submitButton.pinRight(to: wrap)
        
        icon.pinCenter(to: submitButton)
        
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTouchDown() {
        UIView.animate(withDuration: 0.1) {
            self.submitButton.backgroundColor = Constants.submitButtonColorTapped
        }
    }
    
    @objc private func submitButtonTapped() {
        UIView.animate(withDuration: 0.1) {
            self.submitButton.backgroundColor = Constants.submitButtonColor
        }
        
        if wishText.text.isEmpty || wishText.text == Constants.placeholder {
            return
        }
        
        guard let wish = wishText.text else { return }
        addWish?(wish)
    }
    
    func configureAddWish(action: @escaping (String) -> ()) {
        addWish = action
    }
}

// MARK: - UITextViewDelegate
extension AddWishCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if wishText.textColor != Constants.placeholderColor {
            return
        }
        
        wishText.text = nil
        wishText.textColor = Constants.textColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if !wishText.text.isEmpty {
            return
        }
        
        wishText.text = Constants.placeholder
        wishText.textColor = Constants.placeholderColor
    }
}
