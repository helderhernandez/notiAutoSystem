//
//  PSService.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/31/24.
//

import Foundation

final class PSServcie: ObservableObject {
    @Published var productsServices: [ProductServiceModel] = []
    
    @Published var messageError: String?
    
    private let psRepository: PSRepository
    
    init(psRepository: PSRepository = PSRepository()) {
        self.psRepository = psRepository
    }
    
    func getAll() {
        psRepository.getAll { [weak self] result in
            switch result {
            case .success(let productsServicesList):
                self?.productsServices = productsServicesList
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
   
    func create(productServiceForm: ProductServcieFormNewRecord) {
        // no include id-document (generate by firebase)
        let newRecord = ProductServiceModel(
            description: productServiceForm.description,
            pricing: productServiceForm.pricing,
            type: productServiceForm.type
        )

        psRepository.create(productService: newRecord)
    }
    
    func update(productServiceDocumentId: String, productServiceForm: ProductServiceFormEditRecord) {
        let editRecord = ProductServiceModel(
            id: productServiceDocumentId,
            description: productServiceForm.description,
            pricing: productServiceForm.pricing,
            type: productServiceForm.type
        )

        psRepository.update(productService: editRecord)
    }
    
    func delete(productServiceDocumentId: String) {
        psRepository.delete(productServiceDocumentId: productServiceDocumentId)
    }

}