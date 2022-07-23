//
//  OrderSummaryVC.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 19/07/22.
//

import UIKit

class OrderSummaryVC: UIViewController, OrderSummaryView {
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var cart : [Int:ProductOrderModel]!
    var onBackTapped: ((Bool,Bool,Timer?) -> Void)?
    var enabled: Bool! = false
    var isReset: Bool! = false
    var timer: Timer?
    var totalPrice : String? {
        var counter :Double = 0
        for (_, value) in cart {
            counter = counter + value.price
        }
        return "$\(counter)"
    }
    var countdown = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onBackTapped?(enabled,isReset,timer)
        isReset = false
    }
    
    func bindViewModel() {}
    
    private func setupView() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Order Summary"
        cancelButton.layer.cornerRadius = 5.0
        continueButton.layer.cornerRadius = 5.0
        totalPriceLabel.text = totalPrice
        startTimer()
    }
    private func setupTableView(){
        tableView.registerCell(type: SummaryCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        if countdown != 0{
            countdown -= 1
            timerLabel.text = "00:\(countdown)"
        }
        else{
            timer?.invalidate()
            resetCart()
        }
    }
    
    private func resetCart(){
        self.enabled = true
        self.isReset = true
        self.timer = nil
        self.navigationController?.popViewController(animated: true)
    }
    
    private func cancelAlert(){
        let alert = UIAlertController(title: "Are you sure?", message: "Your order will be cancelled and you need to order from the beginning", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { action in }))
        alert.addAction(UIAlertAction(title: "Cancel Order", style: .destructive, handler: { [weak self] action in
            self?.resetCart()
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    private func successAlert(){
        let alert = UIAlertController(title: "Congratulation!", message: "Your payment has been received and products will be shipped shortly", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in }))
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
        return self.cart.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Detail Transaksi"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: SummaryCell.self, for: indexPath) as? SummaryCell else {
            return UITableViewCell()
        }
        let data = cart[cart.index(cart.startIndex, offsetBy: indexPath.row)]
        cell.nameLabel.text = data.value.product.name
        cell.quantityLabel.text = "Quantity : \(data.value.quantity) Price : $\(data.value.product.priceStr)"
        cell.totalPriceLabel.text = "$\(data.value.price)"
        return cell
    }

}
