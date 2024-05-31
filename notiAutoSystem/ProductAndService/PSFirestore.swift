//
//  PSFirestore.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/31/24.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift

struct ProductServiceModel: Decodable, Identifiable, Encodable {
    // @DocumentID es un property wrapper
    @DocumentID var id: String?
    
    var description: String
    var pricing: Double
    var type: String
}

final class PSFirestore {
    private let database = Firestore.firestore()
    private let PS_COLLECTION = "productsAndServices" // nombre de la collection
    
    func getAll(completionBlock: @escaping (Result<[ProductServiceModel], Error>) -> Void) {
        database.collection(PS_COLLECTION) // accedemos a la collection
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
                    .map { try? $0.data(as: ProductServiceModel.self) }
                    .compactMap { $0 }
                
                completionBlock(.success(links))
            }
    }
    
    
    func create(productService: ProductServiceModel) {
        do {
            // aca guardamos la informacion en firebase
            _ = try database.collection(PS_COLLECTION).addDocument(from: productService)
        } catch {
            print("Error creating productService in firebase")
        }
    }
    
    
    func update(productService: ProductServiceModel) {
        // obtenemos el document ID (que es generado por firebase)
        guard let documentId = productService.id else {
            return
        }

        do {
            // aca actualizamos la informacion en firebase
            _ = try database.collection(PS_COLLECTION).document(documentId).setData(from: productService)
        } catch {
            print("Error updating productService in firebase")
        }
    }
    
    func delete(productServiceDocumentId: String) {
        database.collection(PS_COLLECTION).document(productServiceDocumentId).delete()
    }
}