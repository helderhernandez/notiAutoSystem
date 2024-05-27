//
//  EmployeeFirestore.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/27/24.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift

struct EmployeeModel: Decodable, Identifiable, Encodable {
    // @DocumentID es un property wrapper
    @DocumentID var id: String?
    
    let name: String
    let dui: String
    let phone: String
    let address: String
    let skills: [String]
}

final class EmployeeFirestore {
    private let database = Firestore.firestore()
    private let EMPLOYEE_COLLECTION = "employees" // nombre de la collection
    
    func getAll(completionBlock: @escaping (Result<[EmployeeModel], Error>) -> Void) {
        database.collection(EMPLOYEE_COLLECTION) // accedemos a la collection
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
                    .map { try? $0.data(as: EmployeeModel.self) }
                    .compactMap { $0 }
                
                completionBlock(.success(links))
            }
    }
    
    /*
    func createNew(link: LinkModel, completionBlock: @escaping (Result<LinkModel, Error>) -> Void) {
        do {
            _ = try database.collection(collection).addDocument(from: link)
            completionBlock(.success(link))
        } catch {
            completionBlock(.failure(error))
        }
    }
    
    func update(link: LinkModel) {
        // obtenemos el document ID (que es generado por firebase)
        guard let documentId = link.id else {
            return
        }
        do {
            // aca actualizamos la informacion en firebase
            _ = try database.collection(collection).document(documentId).setData(from: link)
        } catch {
            print("Error updating link in our database")
        }
    }
    
    func delete(link: LinkModel) {
        guard let documentId = link.id else {
            return
        }
        database.collection(collection).document(documentId).delete()
    }
 */
}
