//
//  BodyView.swift
//  Vocabulary
//
//  Created by 김한빛 on 5/13/24.
//

import Foundation
import UIKit
import SnapKit

class BodyView: UIView {
    
    let vocaBookCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 13
        layout.sectionInset = .init(top: 0, left: 25, bottom: 0, right: 25)
        layout.itemSize = .init(width: 300, height: 520)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    //응원 문구 ( 랜덤으로 들어가게 하고싶다 )
    let motivationLabel = LabelFactory().makeLabel(title: "응원 문구 !", size: 15, isBold: false)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupConstraints()
        configureUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
        [vocaBookCollectionView, motivationLabel].forEach {
            addSubview($0)
        }
        
        vocaBookCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(520)
        }
        
        motivationLabel.snp.makeConstraints{
            $0.top.equalTo(vocaBookCollectionView.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(40)
        }
    }
    
    func configureUI(){
        
        vocaBookCollectionView.delegate = self
        vocaBookCollectionView.dataSource = self
        
        vocaBookCollectionView.register(BodyCollectionViewCell.self, forCellWithReuseIdentifier: BodyCollectionViewCell.identifier)
    }
}

extension BodyView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = vocaBookCollectionView.dequeueReusableCell(withReuseIdentifier: BodyCollectionViewCell.identifier, for: indexPath) as! BodyCollectionViewCell
        return cell
    }
}
