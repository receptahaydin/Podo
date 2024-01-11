//
//  CRXDialogView.swift
//  CRXSkeleton
//
//  Created by Walid Baroudi on 17.05.2023.
//

import UIKit

class DialogView: UIViewController {
    
    
    private var alertTitle: String?
    private var alertMessage: String?
    private var buttons: [CRXDialogButton]?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var buttonStack: UIStackView!
    

    init(title: String, message: String, buttons: [CRXDialogButton]) {
        alertTitle = title
        alertMessage = message
        self.buttons = buttons
        super.init(nibName: "DialogView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        titleLabel.text = alertTitle
        messageLabel.text = alertMessage
        setupView()
    }
    
    private func setupView() {
        setupButtons()
        view.backgroundColor = .darkGray
        containerView.cornerRadius = 22
    }
    
    private func setupButtons() {
        buttonStack.clearSubviews()
        guard let buttons = buttons else { return }
        buttons.forEach { crxBtn in
            let button = crxBtn.toUIButton()
            let target: UIButtonTargetClosure = { _ in
                self.hide(crxBtn.action)
            }
            button.action(closure: target)
            buttonStack.addArrangedSubview(button)
        }
        buttonStack.spacing = buttons.count > 2 ? 4.0 : 20.0
        buttonStack.axis = buttons.count > 2 ? .vertical : .horizontal
    }
    
    func show() {
        if let vc = UIApplication.shared.getTopViewController() {
            self.modalPresentationStyle = .overCurrentContext
            self.modalTransitionStyle = .crossDissolve
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Set the alpha component as needed
            vc.present(self, animated: true, completion: nil)
        }
    }
    
    private func hide(_ action: @escaping () -> Void = {}) {
        self.dismiss(animated: true) {
            action()
        }
    }

}

struct CRXDialogButton {
    let title: String
    let style: UIAlertAction.Style
    let action: () -> Void
    
    func toUIButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.backgroundColor = .clear
        if style == .destructive {
            button.setTitleColor(.red , for: .normal)
            button.setRegularDynamicFont(size: 17)
        } else {
            button.setTitleColor(.cyan, for: .normal)
            button.setBoldDynamicFont(size: 17)
        }
        return button
    }
}
