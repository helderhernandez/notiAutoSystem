//
//  ClientService.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/30/24.
//

import Foundation

final class ClientService: ObservableObject {
    @Published var clients: [ClientModel] = []
    
    @Published var messageError: String?
    
    private let clientRepository: ClientRepository
    
    init(clientRepository: ClientRepository = ClientRepository()) {
        self.clientRepository = clientRepository
    }
    
    func getAll() {
        clientRepository.getAll { [weak self] result in
            switch result {
            case .success(let clientsList):
                self?.clients = clientsList
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
   
    func create(clientForm: ClientFormNewRecord) {
        // no include id-document (generate by firebase)
        let newRecord = ClientModel(
            name: clientForm.name,
            dui: clientForm.dui,
            phone: clientForm.phone,
            address: clientForm.address,
            vehicles: [] //clientForm.vehicles
        )

        clientRepository.create(client: newRecord)
    }
    
    func update(clientDocumentId: String, clientForm: ClientFormEditRecord) {
        let editRecord = ClientModel(
            id: clientDocumentId,
            name: clientForm.name,
            dui: clientForm.dui,
            phone: clientForm.phone,
            address: clientForm.address,
            vehicles: [] //clientForm.vehicles
        )

        clientRepository.update(client: editRecord)
    }
    
    func delete(clientDocumentId: String) {
        clientRepository.delete(clientDocumentId: clientDocumentId)
    }

}
