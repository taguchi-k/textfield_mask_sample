//
//  ViewController.swift
//  textField_mask_sample
//
//  Created by Kentaro on 2017/08/29.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!

    var systemText = ""
    var displayText: String {
        return maskText(text: systemText)
    }

    var previousText = ""
    var lastRange = NSRange()
    var lastReplacementString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func addObserver() {
        let nc = NotificationCenter.default
        nc.addObserver(self,
                       selector: #selector(textDidChange(notification:)),
                       name: .UITextFieldTextDidChange,
                       object: textField)
    }

    func textDidChange(notification: Notification) {
        guard
//            let textField = notification.object as? UITextField,
            textField.markedTextRange == nil,
            let textCount = textField.text?.characters.count,
            textCount > systemText.characters.count, let range = Range(lastRange) else {
                return
        }

        // 内部の文字列を更新する
        systemText = (systemText as NSString).replacingCharacters(in: lastRange, with: lastReplacementString)
        textField.text = displayText
    }

    private func setup() {

        addObserver()

        systemText = "hogehoge"
        textField.text = displayText
    }

    private func maskText(text: String) -> String {
        guard text.characters.count > 3 else {
            return text
        }

        // マスク部分
        let range = text.startIndex ..< text.index(text.endIndex, offsetBy: -(text.characters.count - 3))
        let substring = text.substring(with: range)
        let maskedText = Array(repeating: "●", count: substring.characters.count).joined()

        // 表示部分
        let displayText = text.substring(from: text.index(text.endIndex, offsetBy: -3))

        return maskedText + displayText
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        previousText = systemText
        lastRange = range
        lastReplacementString = string

        return true
    }
}
