//
//  ClientFirestore.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/30/24.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift

struct VehicleModel: Decodable, Encodable {
    var brand: String
    var model: String
    var logo: String
    var chassisNumber: String
    var yearManufacture: Int
}

struct ClientModel: Decodable, Identifiable, Encodable {
    // @DocumentID es un property wrapper
    @DocumentID var id: String?
    
    let name: String
    let dui: String
    let phone: String
    let address: String
    let vehicles: [Vehicle]
}

final class ClientFirestore {
    private let database = Firestore.firestore()
    private let CLIENT_COLLECTION = "clients" // nombre de la collection
    
    func getAll(completionBlock: @escaping (Result<[ClientModel], Error>) -> Void) {
        database.collection(CLIENT_COLLECTION) // accedemos a la collection
            .addSnapshotListener { query, error in
                // manejando error (si existiese)
                if let error = error {
                    print("Error getting all links \(error.localizedDescription)")
                    completionBlock(.failure(error))
                    return
                }
                
                // si no existen errores continuamos...
                
                // si no hay ningun document retornamos vacio
                guard let documents = query?.documents.compactMap({ $0 }) else {
                    completionBlock(.success([]))
                    return
                }
                
                // si existen documents, extraemos y mapeamos a nuestro model
                let links = documents
                    .map { try? $0.data(as: ClientModel.self) }
                    .compactMap { $0 }
                
                completionBlock(.success(links))
            }
    }
    
    
    func create(client: ClientModel) {
        do {
            // aca guardamos la informacion en firebase
            _ = try database.collection(CLIENT_COLLECTION).addDocument(from: client)
        } catch {
            print("Error creating client in firebase")
        }
    }
    
    
    func update(client: ClientModel) {
        // obtenemos el document ID (que es generado por firebase)
        guard let documentId = client.id else {
            return
        }

        do {
            // aca actualizamos la informacion en firebase
            _ = try database.collection(CLIENT_COLLECTION).document(documentId).setData(from: client)
        } catch {
            print("Error updating client in firebase")
        }
    }
    
    func delete(clientDocumentId: String) {
        database.collection(CLIENT_COLLECTION).document(clientDocumentId).delete()
    }
}