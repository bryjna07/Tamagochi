//
//  BoxOfficeViewController.swift
//  RxSwift
//
//  Created by Jack on 1/30/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Toast

final class BoxOfficeViewController: BaseViewController {
    
    private let viewModel: BoxOfficeViewModel
    private let disposeBag = DisposeBag()
    
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    
    init(viewModel: BoxOfficeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
     
    private func bind() {
        
        let input = BoxOfficeViewModel.Input(
            searchTap: searchBar.rx.searchButtonClicked
                .withLatestFrom(searchBar.rx.text.orEmpty)
        )
        
        let output = viewModel.transform(input: input)
        
        let list = BehaviorRelay<[Movie]>(value: [])
        
        output.movie
            .drive(with: self) { owner, reponse in
                switch reponse {
                case .success(let value):
                    list.accept(value.boxOffice.movieList)
                case .failure(let error):
                    owner.view.makeToast(error.errorText, position: .top)
                }
            }
            .disposed(by: disposeBag)

        list
            .bind(to: tableView.rx.items(
                cellIdentifier: PersonTableViewCell.identifier,
                cellType: PersonTableViewCell.self)
            ) { (row, element, cell) in
                cell.usernameLabel.text = element.movieNm
            }
            .disposed(by: disposeBag)
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        navigationItem.titleView = searchBar
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        tableView.backgroundColor = .systemGreen
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }

}
 
