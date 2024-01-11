//
//  CRXHeaderView.swift
//  CRXDCA
//
//  Created by Recep Taha Aydın on 20.09.2023.
//

import UIKit

@objc protocol PodoHeaderViewDelegate: AnyObject {
    func actionBack()
}

class PodoHeaderView: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable var hasBackButton: Bool = true {
        didSet {
            backButton.isHidden = !hasBackButton
        }
    }

    @IBInspectable var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    @IBOutlet weak var delegate: PodoHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }
    
    private func initializeView() {
        Bundle.main.loadNibNamed("PodoHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction private func actionBack(_ sender: UIButton) {
        delegate?.actionBack()
    }
}
