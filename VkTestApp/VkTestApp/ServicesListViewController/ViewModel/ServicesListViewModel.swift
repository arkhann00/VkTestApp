//
//  ServicesListViewModel.swift
//  VkTestApp
//
//  Created by Khachatryan Arsen on 26.03.2024.
//

import Foundation

final class ServicesListViewModel {
    
    private var services:[Service] = []
    private let network = NetworkManager.shared
    
    weak var delegate: ServicesListViewDelegate?
    
    init(){
        fetchServices()
    }
    
    func numberOfSections() -> Int { return 1 }
    
    func numberOfRows() -> Int {
        print(services.count)
        return services.count
        
    }
    
    func heightForRow() -> CGFloat {
        return 80
    }
    
    func fetchServiceForRow(for row: Int) -> [String] {
        
        let selectedService = services[row]
        
        return [selectedService.iconURL, selectedService.name, selectedService.description, selectedService.link]
        
    }
    
    func fetchLinkForSelectedCell(for row:Int) -> String {
        
        return services[row].link
        
    }
    
    private func fetchServices() {
        
        network.fetchServices {  result in
            
            switch result {
            case .success(let services):
                self.services = services
                print(self.services)
                DispatchQueue.main.async {
                    self.delegate?.reloadTableView()
                }
                
                
            case .failure(let error):
                print(error)
            }
            print(self.services)
        }
        
        
        
    }
    
    
}


