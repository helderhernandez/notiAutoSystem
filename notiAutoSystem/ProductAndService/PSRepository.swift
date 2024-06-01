//
//  PSRepository.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/31/24.
//

import Foundation

final class PSRepository {
    private let psFirestore: PSFirestore

    
    init(psFirestore: PSFirestore = PSFirestore()) {
        self.psFirestore = psFirestore
    }
    
    func getAll(completionBlock: @escaping (Result<[ProductServiceModel], Error>) -> Void) {
        psFirestore.getAll(completionBlock: completionBlock)
    }
    
    func create(productService: ProductServiceModel) {
        psFirestore.create(productService: productService)
    }
    
    func update(productService: ProductServiceModel) {
        psFirestore.update(productService: productService)
    }
    
    func delete(productServiceDocumentId: String) {
        psFirestore.delete(productServiceDocumentId: productServiceDocumentId)
    }

}