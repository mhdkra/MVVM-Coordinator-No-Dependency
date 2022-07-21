//
//  ProductListVC.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 19/07/22.
//

import UIKit
import Combine
class ProductListVC: UIViewController, ProductListView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var totalQuantityLabel: UILabel!
    var viewModel: ProductListVM!
    var onCardTapped: ((ProductModel) -> Void)?
    
    private var products = [ProductModel](){
        didSet{
        }
    }

    private var isLoadingList : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    func bindViewModel() {
        viewModel.requestproducts(brand: "maybelline")
        
        viewModel.onGettingProduct = { [weak self] products in
            self?.products = products
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
        
        viewModel.currentState = { [weak self] state in
            switch state{
            case .close:
                self?.isLoadingList = false
            case .loading:
                self?.isLoadingList = true
            default: break
            }
        }
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Products"
        createButton.layer.cornerRadius = 5.0
    }
    private func setupTableView(){
        tableView.registerCell(type: ProductCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    @IBAction func createTapped(_ sender: Any) {
        
    }
}

extension ProductListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: ProductCell.self, for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        let data = products[indexPath.row]
        cell.nameLabel.text = data.name
        cell.priceLabel.text = data.price
        cell.typeLabel.text = data.type
        cell.quantityLabel.text = "Quantity: 0"
        cell.productImageView.downloaded(from: data.imgUrl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let target = self.products[indexPath.row]
        onCardTapped?(target)
    }

}
