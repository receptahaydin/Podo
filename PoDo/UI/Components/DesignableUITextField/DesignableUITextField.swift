import UIKit

@IBDesignable
class DesignableUITextField: UITextField {

    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }

    // Provides right padding for buttons
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= rightPadding
        return textRect
    }

    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateLeftView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateLeftView()
        }
    }

    @IBInspectable var rightButtonImage: UIImage? {
        didSet {
            updateRightButton()
        }
    }

    @IBInspectable var rightPadding: CGFloat = 0 {
        didSet {
            updateRightButton()
        }
    }

    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateLeftView()
        }
    }

    func updateLeftView() {
        if let image = leftImage {
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = .never
            leftView = nil
        }

        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: color])
    }

    func updateRightButton() {
        if let image = rightButtonImage {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            button.contentMode = .scaleAspectFit
            button.setImage(image, for: .normal)
            button.tintColor = color
            button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
            rightViewMode = .always
            rightView = button
        } else {
            rightViewMode = .never
            rightView = nil
        }
    }

    @objc func rightButtonTapped() {
        if self.isSecureTextEntry == true {
            rightButtonImage = UIImage(systemName: "eye.fill")
            self.isSecureTextEntry = false
        } else if self.isSecureTextEntry == false {
            self.isSecureTextEntry = true
            rightButtonImage = UIImage(systemName: "eye.slash.fill")
        }
    }
}
