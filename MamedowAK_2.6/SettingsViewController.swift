//
//  ViewController.swift
//  MamedowAK_2.2
//
//  Created by FR on 21.10.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    var delegate: SettingsViewControllerDelegate!
    
    var redValue: Float!
    var greenValue: Float!
    var blueValue: Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        
        redSlider.value = redValue
        greenSlider.value = greenValue
        blueSlider.value = blueValue
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        updateSliderLabels()
        updateTextField()
        updateColorView()
        
        addDoneButtonTo(redTextField)
        addDoneButtonTo(greenTextField)
        addDoneButtonTo(blueTextField)
        
    }
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            redLabel.text = getString(from: redSlider)
            redTextField.text = getString(from: redSlider)
        case 1:
            greenLabel.text = getString(from: greenSlider)
            greenTextField.text = getString(from: greenSlider)
        case 2:
            blueLabel.text = getString(from: blueSlider)
            blueTextField.text = getString(from: blueSlider)
        default:
            break
        }
        
        updateColorView()
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        delegate.setNewColor(for: CGFloat(redSlider.value), for: CGFloat(greenSlider.value), and: CGFloat(blueSlider.value))
        dismiss(animated: true)
    }
    
 
    @IBAction func textFieldEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
            
            if let currentValue = Float(text) {
                
                switch textField.tag {
                case 0: redSlider.value = currentValue
                case 1: greenSlider.value = currentValue
                case 2: blueSlider.value = currentValue
                default: break
                }
                
                updateColorView()
                updateSliderLabels()
            } else {
                showAlert(title: "Wrong format!", message: "Please enter correct value")
            }
    }
    
    private func updateSliderLabels() {
        redLabel.text = getString(from: redSlider)
        greenLabel.text = getString(from: greenSlider)
        blueLabel.text = getString(from: blueSlider)
    }
    
    private func updateTextField() {
        redTextField.text = getString(from: redSlider)
        greenTextField.text = getString(from: greenSlider)
        blueTextField.text = getString(from: blueSlider)
    }
    
    private func getString(from slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }
    
    private func updateColorView() {
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)
        
        colorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
    
    extension SettingsViewController {
        
        private func addDoneButtonTo(_ textField: UITextField){
            
            let numberToolBar = UIToolbar()
            textField.inputAccessoryView = numberToolBar
            numberToolBar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
            
            let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            numberToolBar.items = [flexBarButton, doneButton]
        }
        
        @objc private func didTapDone() {
            view.endEditing(true)
        }
        
        private func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
}

