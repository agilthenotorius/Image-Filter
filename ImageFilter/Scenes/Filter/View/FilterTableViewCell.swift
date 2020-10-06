//
//  FilterTableViewCell.swift
//  ImageFilter
//
//  Created by Agil Madinali on 10/3/20.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var providerNameLabel: UILabel!
    
    static let identifier = "FilterTableViewCell"
    var cellProvider: Provider?
    
    weak var providerDelegate: ProviderProtocol?
    weak var switchDelegate: SwitchProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.switchButton.addTarget(self, action: #selector(self.switchTurned), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(provider: Provider) {
        self.cellProvider = provider
        self.providerNameLabel.text = provider.name
        self.switchButton.isOn = provider.isOn
    }

    @objc func switchTurned() {
        if let provider = self.cellProvider,
           let shouldPermitToSwitch = self.switchDelegate?.updateSwitches(provider: provider, isOn: self.switchButton.isOn) {
            
            if shouldPermitToSwitch {
                self.providerDelegate?.updateProviders(provider: provider, isOn: self.switchButton.isOn)
            } else {
                self.switchButton.isOn.toggle()
            }
        }
    }
}
