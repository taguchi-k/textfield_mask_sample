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

    fileprivate var systemText: String {
        get {
            return UserDefaults().string(forKey: Const.systemTextKey) ?? ""
        }
        set {
            UserDefaults().set(newValue, forKey: Const.systemTextKey)
            UserDefaults().synchronize()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func addObserver() {
        let nc = NotificationCenter.default
        nc.addObserver(self,
                       selector: #selector(textDidChange(notification:)),
                       name: .UITextFieldTextDidChange,
                       object: textField)
    }

    @objc private func textDidChange(notification: Notification) {
        guard let text = textField.text else {
            return
        }
        systemText = text
    }

    private func setup() {
        addObserver()
        textField.text = Mask.maskText(text: systemText)
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
