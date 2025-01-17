//
//  SelectBottomView.swift
//  Vocabulary
//
//  Created by Dongik Song on 5/21/24.
//

import UIKit
import SnapKit

class SelectBottomView: UIView {
    
    lazy var startButton = ButtonFactory().makeButton(title: "설정하기", size: 18) { [weak self] _ in
        self?.setUpGame()
    }
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            UIView(),
            UIView(),
            startButton,
            UIView(),
            UIView()
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpGame () {
        guard let currentVC = currentViewController as? SelectVocaViewController else { return }
        let count = currentVC.quizCount
        let category = currentVC.selectedCategory
        let data = GenQuizModel(category: category, quizCount: count)
        if currentVC.checkDataCount(query: category) < 4 {
            let alert = currentVC.alertController.makeNormalAlert(title: "갯수 부족", message: "한 단어장에 최소 4개의 단어가 있어야합니다.")
            currentVC.present(alert, animated: true)
        } else {
            NotificationCenter.default.post(name: .sender, object: data)
            currentVC.dismiss(animated: true)
        }
    }
    
    private func layout () {
        self.addSubview(hStackView)
        
        hStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
