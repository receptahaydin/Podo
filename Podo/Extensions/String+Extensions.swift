//
//  String+Extensions.swift
//  CRXDCA
//
//  Created by Recep Taha Aydın on 14.08.2023.
//

import UIKit

extension String {

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    var integerValue: Int? {
        let newValue = self.replacingOccurrences(of: ",", with: ".")
        return Int(newValue)
    }

    var doubleValue: Double? {
        let newValue = self.replacingOccurrences(of: ",", with: ".")
        return Double(newValue)
    }

    var floatValue: Float? {
        let newValue = self.replacingOccurrences(of: ",", with: ".")
        return Float(newValue)
    }

    var boolValue: Bool {
        return (self as NSString).boolValue
    }

    func size(of font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        /// Option first
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let attributedString = NSAttributedString(string: self, attributes: attributes)
        let largestSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
        let suggestFrameSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(), nil, largestSize, nil)

        return ceil(suggestFrameSize.height * 1.25)

        /// Option second
        //        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        //        let boundingBox = self.boundingRect(with: constraintRect,
        //                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
        //                                            attributes: [.font: font],
        //                                            context: nil)
        //        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)

        return ceil(boundingBox.width)
    }

    func getLabelWidth(font: UIFont) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()

        return label.intrinsicContentSize.width
    }

    func getLabelHeight(font: UIFont, labelWidth: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: labelWidth, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()

        return label.frame.height
    }

    func convertToDictionary() -> [String:Any]? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
            return json
        } catch {
            print("Something went wrong")
            return nil
        }

    }

}
