//
//  ServicesListTableView.swift
//  VkTestApp
//
//  Created by Khachatryan Arsen on 27.03.2024.
//

import UIKit

class ServicesListTableView:UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        backgroundColor = .black
    }
    
}

