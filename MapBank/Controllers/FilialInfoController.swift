//
//  FilialInfoController.swift
//  MapBank
//
//  Created by Александр Молчан on 12.01.23.
//

import UIKit

class FilialInfoController: UIViewController {
    
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var cashInLabel: UILabel!
    
    var filial: AtmInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateUI()
    }
    
    private func configurateUI() {
        guard let filial else { return }
        adressLabel.text = "\(filial.city), \(filial.address), \(filial.house)"
        if filial.cashIn == "да" {
            cashInLabel.text = "Возможность предусмотрена:)"
        } else {
            cashInLabel.text = "Возможность не предусмотрена:("
        }
    }

}
