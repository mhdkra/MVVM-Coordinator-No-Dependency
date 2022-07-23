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
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var timeRemainingSV: UIStackView!
    var viewModel: ProductListVM!
    var onCartTapped: (([Int:ProductOrderModel]) -> Void)?
    var enabled: Bool! = true
    var isReset: Bool! = false
    var timer: Timer?
    private var products = [ProductModel]()
    private var isLoadingList : Bool = false
    var myCart = [Int:ProductOrderModel](){
        didSet{
            setupView()
        }
    }
    var countdown = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initView()
        setupView()
        tableView.reloadData()
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
    
    private func initView(){
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Products"
        createButton.layer.cornerRadius = 5.0
        self.myCart = isReset ? [:] : myCart
    }
    
    private func setupView() {
        timeRemainingSV.isHidden = enabled
        createButton.setTitle(enabled ? "Create order" : "BACK TO ORDER SUMMARY", for: .normal)
        createButton.backgroundColor = myCart.count > 0 ? .blue : .lightGray
        createButton.isEnabled = myCart.count > 0 ? true : false
        tableView.isUserInteractionEnabled = enabled ? true : false
        self.totalQuantityLabel.text = isReset ? "0" : totalQuantityLabel.text
        guard let _ = timer else {
            return
        }
        startTimer()
    }
    func startTimer(){
        guard timer != nil else {
            return
        }
        var _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    
    @objc func update() {
        if countdown != 0{
            countdown -= 1
            timeRemainingLabel.text = "00:\(countdown)"
        }
        else{
            timer?.invalidate()
            resetCart()
            timer =  nil
        }
    }
    
    private func setupTableView(){
        tableView.registerCell(type: ProductCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func resetCart(){
        self.enabled = true
        self.isReset = true
        self.timer = nil
    }
    
    private func processAction(action : CartAction){
        switch action {
        case .incrementProduct(let product):
            if let order = self.myCart[product.id] {
                if (order.quantity < 5){
                    self.myCart.updateValue(order.incremented, forKey: product.id)
                }
                
            }else{
                self.myCart.updateValue(ProductOrderModel(product: product), forKey: product.id)
            }
        case .decrementProduct(let productId):
            if let order = self.myCart[productId] {
                let decrementedOrder = order.decremented
                if (decrementedOrder.quantity == 0) {
                    self.myCart.removeValue(forKey: productId)
                } else {
                    self.myCart.updateValue(decrementedOrder, forKey: productId)
                }
            }
        case .clear:
            self.myCart = [Int:ProductOrderModel]()
        }
    }
    
    @IBAction func createTapped(_ sender: Any) {
        onCartTapped?(self.myCart)
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
        cell.product = data
        cell.row = indexPath.row
        cell.nameLabel.text = data.name
        cell.priceLabel.text = "\(data.price)"
        cell.typeLabel.text = data.type
        cell.productImageView.downloaded(from: data.imgUrl)
        
        cell.delegate = self
        if let foo = myCart[data.id] {
            cell.quantityLabel.text = "Quantity: \(foo.quantity)"
        }else{
            cell.quantityLabel.text = "Quantity: 0"
        }
        return cell
    }
}

extension ProductListVC : ProductCellDelegate{
    func didTapWithAction(action: CartAction, row: Int) {
        processAction(action: action)
        tableView.reloadRows(at: [IndexPath(item: row, section: 0)], with: .fade)
        
        var counter :Int = 0
        for (_, value) in myCart {
            counter = counter + value.quantity
        }
        self.totalQuantityLabel.text = "\(counter)"
    }
}
