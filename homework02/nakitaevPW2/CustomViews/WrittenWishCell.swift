//
//  WrittenWishCell.swift
//  nakitaevPW2
//
//  Created by Никита Китаев on 04.03.2024.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    static let reuseId: String = "WrittenWishCell"
    
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wrapVerticalMargin: CGFloat = 8
        static let wrapHorizontalMargin: CGFloat = 16
        static let closeButtonRightOffset: CGFloat = 8
        static let editButtonRightOffset: CGFloat = 24
    }
    
    private let wishLabel: UILabel = UILabel()
    private let deleteButton: UIButton = UIButton()
    private let editButton: UIButton = UIButton()
    private let wrap: UIView = UIView()
    var deleteWish: ((Int16) -> ())?
    var editWish: ((Int16) -> ())?
    public var id: Int16 = 0
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
        wrap.addSubview(wishLabel)
        wishLabel.pinVertical(to: wrap, Constants.wrapVerticalMargin)
        wishLabel.pinHorizontal(to: wrap, Constants.wrapHorizontalMargin)
        
        configureDeleteButton()
        configureEditButton()
    }
    
    func configureDeleteButton() {
        contentView.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        deleteButton.pinTop(to: wrap)
        deleteButton.pinBottom(to: wrap)
        deleteButton.pinRight(to: wrap, Constants.closeButtonRightOffset)
        
        let icon = UIImageView()
        icon.image = UIImage(named: "cross")
        icon.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addSubview(icon)
        
        icon.pinCenter(to: deleteButton)
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    func configureEditButton() {
        contentView.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        editButton.pinTop(to: wrap)
        editButton.pinBottom(to: wrap)
        editButton.pinRight(to: deleteButton, Constants.editButtonRightOffset)
        
        let icon = UIImageView()
        icon.image = UIImage(named: "edit")
        icon.translatesAutoresizingMaskIntoConstraints = false
        editButton.addSubview(icon)
        
        icon.pinCenter(to: editButton)
        
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    
    @objc private func deleteButtonTapped() {
        deleteWish?(id)
    }
    
    @objc private func editButtonTapped() {
        editWish?(id)
    }
    
    func configureDeleteWish(action: @escaping (Int16) -> ()) {
        deleteWish = action
    }
    
    func configureEditWish(action: @escaping (Int16) -> ()) {
        editWish = action
    }
}
