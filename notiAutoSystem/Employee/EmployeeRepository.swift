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
    
    func create(employee: EmployeeModel) {
        employeeFirestore.create(employee: employee)
    }
    
    func update(employee: EmployeeModel) {
        employeeFirestore.update(employee: employee)
    }
    
    func delete(employeeDocumentId: String) {
        employeeFirestore.delete(employeeDocumentId: employeeDocumentId)
    }

}
