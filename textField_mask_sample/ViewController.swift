//
//  ViewController.swift
//  textField_mask_sample
//
//  Created by Kentaro on 2017/08/29.
//  Copyright © 2017年 Kentao Taguchi. All rights reserved.
//

import UIKit

enum Const {
    static let systemTextKey = "systemText"
}

final class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!

    var systemText: String {
        get {
            return UserDefaults().string(forKey: Const.systemTextKey) ?? ""
        }
        set {
            UserDefaults().set(newValue, forKey: Const.systemTextKey)
            UserDefaults().synchronize()
        }
    }

    var displayText: String {
        return Mask.maskText(text: systemText)
    }

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
        guard let text = textField.text else {
            return
        }
        systemText = text
    }

    private func setup() {

        addObserver()
        textField.text = displayText
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = systemText
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = Mask.maskText(text: systemText)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
