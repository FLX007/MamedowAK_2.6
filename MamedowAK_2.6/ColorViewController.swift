//
//  ColorViewController.swift
//  MamedowAK_2.2
//
//  Created by FR on 05.11.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewColor(for red: CGFloat, for green: CGFloat, and blue: CGFloat)
}

class ColorViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as?
                SettingsViewController else { return }
        settingsVC.delegate = self
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        view.backgroundColor!.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        settingsVC.redValue = Float(red)
        settingsVC.greenValue = Float(green)
        settingsVC.blueValue = Float(blue)
    }
}

extension ColorViewController: SettingsViewControllerDelegate {
    func setNewColor (for red: CGFloat, for green: CGFloat, and blue: CGFloat) {
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
