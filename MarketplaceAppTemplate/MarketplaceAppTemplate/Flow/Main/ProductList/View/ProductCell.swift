//
//  ProductCell.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 19/07/22.
//

import UIKit

protocol ProductCellDelegate: AnyObject {
    func didTapWithAction(action: CartAction, row: Int)
}


class ProductCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var buttonContainer: UIView!
    weak var delegate : ProductCellDelegate?
    
    var product :  ProductModel?
    var row :  Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buttonContainer.layer.cornerRadius = 5.0
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func minusTapped(_ sender: Any) {
        guard let product = product else {
            return
        }
        guard let row = row else {
            return
        }
        delegate?.didTapWithAction(action: .decrementProduct(withId: product.id), row: row)
        
    }
    
    @IBAction func addTapped(_ sender: Any) {
        guard let product = product else {
            return
        }
        guard let row = row else {
            return
        }
        delegate?.didTapWithAction(action: .incrementProduct(withObject: product), row: row)
        
    }
}
