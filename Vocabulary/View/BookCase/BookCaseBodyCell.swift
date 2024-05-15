//
//  BodyCollectionViewCell.swift
//  Vocabulary
//
//  Created by 김한빛 on 5/14/24.
//

import UIKit
import SnapKit

class BookCaseBodyCell: UICollectionViewCell {
    
    static let identifier = String(describing: BookCaseBodyCell.self)
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        view.layer.cornerRadius = 26
        return view
    }()
    
    let menuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "photo")
        img.contentMode = .center
        img.tintColor = .systemGray2
        img.backgroundColor = .white
        return img
    }()
    
    let nameStackView: UIStackView = {
        let nameLabel = LabelFactory().makeLabel(title: "코딩 단어장", size: 20, textAlignment: .left, isBold: true)
        let detailLabel = LabelFactory().makeLabel(title: "간단 설명", size: 15, textAlignment: .left, isBold: false)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, detailLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    let wordStackView: UIStackView = {
        let languageLabel = LabelFactory().makeLabel(title: "단어/의미", size: 15, textAlignment: .left, isBold: false)
        let countLabel = LabelFactory().makeLabel(title: "단어 개수", size: 15, textAlignment: .right, isBold: false)
        
        let stackView = UIStackView(arrangedSubviews: [languageLabel, countLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        contentView.addSubview(cellView)
        
        [menuButton, imageView, nameStackView, wordStackView].forEach{
            cellView.addSubview($0)
        }
        
        cellView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        menuButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        imageView.snp.makeConstraints{
            $0.top.equalTo(menuButton.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(350)
        }
        
        nameStackView.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(25)
        }
        
        wordStackView.snp.makeConstraints{
            $0.top.equalTo(nameStackView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(20)
            
        }
        
    }
}