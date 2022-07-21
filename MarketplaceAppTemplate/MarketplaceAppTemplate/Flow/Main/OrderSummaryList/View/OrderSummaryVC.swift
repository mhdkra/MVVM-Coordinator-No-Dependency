//
//  OrderSummaryVC.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 19/07/22.
//

import UIKit

class OrderSummaryVC: UIViewController, OrderSummaryView {
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var products = [OrderSummaryModel](){
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    func bindViewModel() {}
    
    private func setupView() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Order Summary"
        cancelButton.layer.cornerRadius = 5.0
        continueButton.layer.cornerRadius = 5.0
    }
    private func setupTableView(){
        tableView.registerCell(type: ProductSummaryCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func cancelAlert(){
        let alert = UIAlertController(title: "Are you sure?", message: "Your order will be cancelled and you need to order from the beginning", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { action in

        }))
        alert.addAction(UIAlertAction(title: "Cancel Order", style: .destructive, handler: { action in

        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    private func successAlert(){
        let alert = UIAlertController(title: "Congratulation!", message: "Your payment has been received and products will be shipped shortly", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in

        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        cancelAlert()
    }
    
    @IBAction func continueTapped(_ sender: Any) {
        successAlert()
    }
}

extension OrderSummaryVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(
            withType: ProductCell.self,
            for: indexPath) as? ProductSummaryCell else {
            return UITableViewCell()
        }
        let data = products[indexPath.row]
        cell.nameLabel.text = data.name
        cell.totalquantityLabel.text = data.totalPrice
        cell.quantityLabel.text = "Quantity: \(data.quantity) Price:\(data.priceEach)"
        return cell
    }

}
