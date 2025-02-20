//
//  FamilyProfileViewController.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 19.02.2025.
//

import UIKit

final class FamilyProfileViewController: UIViewController {
    
    enum Section {
        case main
    }
    let parentView = ParentInfoView()
    typealias DataSource = UITableViewDiffableDataSource<Section, Child>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Child>
    
    private let familyProfileViewModel: FamilyProfileViewModel
    let titleLabel = FPTitleLabel(textAlignment: .left, fontSize: 18, textColor: R.Color.black)
    private let marginOffset: CGFloat = 20
    private let tableView = UITableView()
    private lazy var tableViewDataSource = makeDataSource()
    
    private lazy var dummyChildren: [Child] = [
        Child(context: familyProfileViewModel.storageManager.managedObjectContext)
    ]
    
    
    
    init(viewModel: FamilyProfileViewModel) {
        self.familyProfileViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    
    private func setupTitle() {
        titleLabel.text = R.String.title
        view.addSubviews(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: marginOffset),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
    }
    
    private func setupParentView() {
        let parent = Parent(context: familyProfileViewModel.storageManager.managedObjectContext)
        parent.name = "Петр"
        parent.age = 99
        parentView.parent = parent
        view.addSubviews(parentView)
        NSLayoutConstraint.activate([
            parentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            parentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: marginOffset),
            parentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -marginOffset),
            parentView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func configureTableView() {
        tableView.register(ChildInfoTableViewCell.self, forCellReuseIdentifier: String(describing: ChildInfoTableViewCell.self))
        tableView.register(TableHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: TableHeaderView.self))
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderTopPadding = 0
        tableView.sectionHeaderHeight = 60
        tableView.delegate = self
        tableView.backgroundColor = .clear
        
        view.addSubviews(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: marginOffset),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -marginOffset),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        setupTitle()
        setupParentView()
        configureTableView()
    }
    
    
    // MARK: - DataSource methods
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            tableView: tableView,
            cellProvider: { (tableView, indexPath, item) ->
                UITableViewCell? in
                
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: ChildInfoTableViewCell.self),
                    for: indexPath) as? ChildInfoTableViewCell
                // Configure the cell, set its delegate and indexPath
                
                
                return cell
            })
        return dataSource
    }
    
    
    private func applySnapshot(with items: [Child], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        tableViewDataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    
    
}


extension FamilyProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = tableViewDataSource.itemIdentifier(for: indexPath) else { return }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: TableHeaderView.self)) as? TableHeaderView else {
            return UIView()
        }
        header.delegate = self
        if dummyChildren.count >= 5 {
            header.isTableDataSourceFull = true
        }
        return header
    }
    
}


extension FamilyProfileViewController: TableHeaderViewDelegate {
    func didTapAddChildButton() {
        let addChildViewController = AddChildViewController()
        let navController = UINavigationController()
        navController.setViewControllers([addChildViewController], animated: false)
        addChildViewController.callBack = { child in
                print("""
                      Имя --> \(child.name)
                      Возраст --> \(child.age)
                      """)
        }
        navigationController?.present(navController, animated: true)
    }
    
    
}
