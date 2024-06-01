//
//  ClientRepository.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/30/24.
//

import Foundation

final class ClientRepository {
    private let clientFirestore: ClientFirestore

    
    init(clientFirestore: ClientFirestore = ClientFirestore()) {
        self.clientFirestore = clientFirestore
    }
    
    func getAll(completionBlock: @escaping (Result<[ClientModel], Error>) -> Void) {
        clientFirestore.getAll(completionBlock: completionBlock)
    }
    
    func create(client: ClientModel) {
        clientFirestore.create(client: client)
    }
    
    func update(client: ClientModel) {
        clientFirestore.update(client: client)
    }
    
    func delete(clientDocumentId: String) {
        clientFirestore.delete(clientDocumentId: clientDocumentId)
    }

}
