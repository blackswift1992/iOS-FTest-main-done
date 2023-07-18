//
//  DetailView.swift
//  App
//
//

import UIKit

class DetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func internalInit(items: [String]) {
        var labelFrame = CGRect(x: 20, y: 20, width: self.frame.width - 40, height: 50)

        for i in 0..<items.count {
            let label = UILabel(frame: labelFrame)
            label.text = "\(items[i])"
            label.textAlignment = .center
            label.backgroundColor = .white
            label.layer.cornerRadius = 25.0
            label.clipsToBounds = true

            self.addSubview(label)

            labelFrame.origin.y += labelFrame.size.height + 20
        }
    }
}
