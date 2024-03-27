//
//  ServiceTableViewCell.swift
//  VkTestApp
//
//  Created by Khachatryan Arsen on 26.03.2024.
//

import UIKit
import SnapKit

final class ServiceTableViewCell: UITableViewCell {
    
    var link:String?
    var image = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        backgroundColor = .black
        accessoryType = .disclosureIndicator
        
        
        addSubview(image)
        image.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(60)
            make.height.equalTo(70)
        }
        
        
        addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalTo(image).inset(80)
            
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.textAlignment = .left
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).inset(20)
            make.left.equalTo(image).inset(80)
            make.right.equalToSuperview().inset(45)
            make.bottom.equalToSuperview().inset(10)
        }

    }
    
    public func setUIs (iconStr:String, title: String, description:String, linkStr:String) {
        
        link = linkStr
        
        
        
        
            guard let url = URL(string: iconStr) else { return }
            
        
            
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                let icon = UIImage(data: data!)
                self.image.image = icon
            }
        }.resume()
        
        
        
        
        
        titleLabel.text = title
        descriptionLabel.text = description
        
        
    }
    
}

