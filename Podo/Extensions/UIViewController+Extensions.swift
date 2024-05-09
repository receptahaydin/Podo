import UIKit

extension UIViewController {
    private var loadingIndicator: UIActivityIndicatorView? {
        return view.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView
    }
    
    func showLoadingIndicator() {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .podoRed
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        indicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        loadingIndicator?.stopAnimating()
        loadingIndicator?.removeFromSuperview()
    }
}
