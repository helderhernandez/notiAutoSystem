//
//  EmployeeRepository.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/27/24.
//

import Foundation

final class EmployeeRepository {
    private let employeeFirestore: EmployeeFirestore

    
    init(employeeFirestore: EmployeeFirestore = EmployeeFirestore()) {
        self.employeeFirestore = employeeFirestore
    }
    
    func getAll(completionBlock: @escaping (Result<[EmployeeModel], Error>) -> Void) {
        employeeFirestore.getAll(completionBlock: completionBlock)
    }
    
    /*
    func createNewLink(withURL url: String, completionBlock: @escaping (Result<LinkModel, Error>) -> Void) {
        
        //metadataDatasource.getMetadata(fromURL: url, completionBlock: completionBlock)
        
        metadataDatasource.getMetadata(fromURL: url) { [weak self] result in
            switch result {
            case .success(let linkModel):
                self?.linkDatasource.createNew(link: linkModel,
                                               completionBlock: completionBlock)
            case .failure(let error):
                completionBlock(.failure(error))
            }
        }
    }
    
    func update(link: LinkModel) {
        linkDatasource.update(link: link)
    }
    
    func delete(link: LinkModel) {
        linkDatasource.delete(link: link)
    }
 */
}
