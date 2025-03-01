//
//  FamilyProfileViewController.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 19.02.2025.
//

import UIKit
import Combine

protocol FamilyProfileViewHeaderDelegate {
    func hideAddChildButton(_ childrenCount: Int)
}


protocol FamilyProfileViewFooterDelegate {
    func hideDeleteAllChildrenButton(_ childrenCount: Int)
}



final class FamilyProfileViewController: UIViewController {
    
    var familyProfileHeaderDelegate: FamilyProfileViewHeaderDelegate?
    var familyProfileFooterDelegate: FamilyProfileViewFooterDelegate?
    private lazy var childrenCount = 0 {
        didSet {
            familyProfileHeaderDelegate?.hideAddChildButton(childrenCount)
            familyProfileFooterDelegate?.hideDeleteAllChildrenButton(childrenCount)
        }
    }
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
    private var cancellables = Set<AnyCancellable>()
    
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
        familyProfileViewModel.loadChildrenFromStorage()
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
        familyProfileViewModel.parent.name = "Петр"
        familyProfileViewModel.parent.age = 99
        parentView.parent = familyProfileViewModel.parent
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
        tableView.register(TableFooterView.self, forHeaderFooterViewReuseIdentifier: String(describing: TableFooterView.self))
        
        tableView.sectionHeaderTopPadding = 0
        tableView.sectionHeaderHeight = 60
        tableView.rowHeight = 170
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        
        
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
        bind()
    }
    
    
    private func bind() {
        familyProfileViewModel.childrenPublisher
            .sink { [weak self] children in
                guard let self else { return }
                childrenCount = children.count
                self.applySnapshot(with: children)
            }
            .store(in: &cancellables)
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
                
                cell?.set(with: item)
                cell?.delegate = self
                cell?.child = item
                
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: TableHeaderView.self)) as? TableHeaderView else {
            return UIView()
        }
        header.delegate = self
        self.familyProfileHeaderDelegate = header
        if childrenCount >= 5 {
            header.addChildButton.isHidden = true
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: TableFooterView.self)) as? TableFooterView else {
            return UIView()
        }
        footer.delegate = self
        self.familyProfileFooterDelegate = footer
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if childrenCount == 0 {
            return 0
        } else {
            return 60
        }
    }
}


extension FamilyProfileViewController: TableHeaderViewDelegate {
    func didTapAddChildButton() {
        let addChildViewController = AddChildViewController()
        let navController = UINavigationController()
        navController.setViewControllers([addChildViewController], animated: false)
        addChildViewController.callBack = { [weak self] dummyChild in
            guard let self else { return }
            
            let context = self.familyProfileViewModel.storageManager.managedObjectContext
            
            let child = Child(context: context)
            child.id = UUID()
            child.name = dummyChild.name
            child.age = dummyChild.age
            context.perform {
                do {
                    try context.save()
                } catch {
                    let message = StorageError.savingError.rawValue
                    DispatchQueue.main.async {
                        ErrorPresenter.showError(message: message, on: self)
                    }
                }
            }
            self.familyProfileViewModel.loadChildrenFromStorage()
        }
        navigationController?.present(navController, animated: true)
    }
}


extension FamilyProfileViewController: ChildInfoTableViewCellDelegate {
    func deleteObjectFromStorage(_ child: Child?) {
        guard let child else { return }
        do {
            try familyProfileViewModel.deleteChildFromStorage(child: child)
        } catch {
            ErrorPresenter.showError(message: StorageError.deletingError.rawValue, on: self)
        }
    }
}


extension FamilyProfileViewController: TableFooterViewDelegate {
    func didTapDeleteAllChildrenButton() {
        let alert = UIAlertController(title: "", message: R.String.clearScreen, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: R.String.cancel, style: .cancel, handler: nil)
        
        let clearAction = UIAlertAction(title: R.String.resetData, style: .destructive) { [weak self] _ in
            guard let self else { return }
            do {
                try familyProfileViewModel.storageManager.deleteAllChildren()
                familyProfileViewModel.parent.age = 0
                familyProfileViewModel.parent.name = "..."
                parentView.parent = familyProfileViewModel.parent
                familyProfileViewModel.loadChildrenFromStorage()
            } catch {
                ErrorPresenter.showError(message: StorageError.clearStorageError.rawValue, on: self)
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(clearAction)
        
        present(alert, animated: true)
    }
}
