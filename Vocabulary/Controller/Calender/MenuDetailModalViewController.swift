//
//  MenuDetailViewController.swift
//  Vocabulary
//
//  Created by 김시종 on 5/16/24.
//

import UIKit


protocol MenuDetailModalDelegate: AnyObject {
    func markWordsAsLearned()
    func deleteAllWords()
}

class MenuDetailModalViewController: UIViewController {
    
    let labels = ["다 외웠어요", "전체 삭제"]
    weak var delegate: MenuDetailModalDelegate?
    
    //MARK: - Component 호출
    let filterMainLabel = LabelFactory().makeLabel(title: "단어 상태 설정", size: 23, textAlignment: .left, isBold: true)
    
    let xButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.addArrangedSubview(filterMainLabel)
        stackView.addArrangedSubview(xButton)
        return stackView
    }()
    
    let viewLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MenuDetailTableViewCell.self, forCellReuseIdentifier: MenuDetailTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Setup
    func setupUI() {
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        
        view.addSubview(topStackView)
        view.addSubview(viewLine)
        view.addSubview(menuTableView)
        
        xButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        
        topStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        xButton.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        
        viewLine.snp.makeConstraints {
            $0.top.equalTo(topStackView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        menuTableView.snp.makeConstraints {
            $0.top.equalTo(viewLine.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - TableView Setting
extension MenuDetailModalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuDetailTableViewCell.identifier, for: indexPath) as? MenuDetailTableViewCell else { fatalError("테이블 뷰 오류") }
        
        cell.label.text = labels[indexPath.row]
        cell.selectionStyle = .none
        if indexPath.row == 1 {
            cell.label.textColor = .red
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = AlertController()
        
        if indexPath.row == 0 {
            delegate?.markWordsAsLearned()
            dismissViewController()
        } else if indexPath.row == 1 {
            let alert = alertController.makeAlertWithCompletion(title: "전체 삭제", message: "선택한 날짜의 모든 단어를 삭제하시겠습니까?") { [weak self] _ in
                self?.delegate?.deleteAllWords()
                self?.dismissViewController()
            }
            present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
