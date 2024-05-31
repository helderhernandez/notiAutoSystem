//
//  EmployeeService.swift
//  notiAutoSystem
//
//  Created by user215032 on 5/27/24.
//

import Foundation

final class EmployeeService: ObservableObject {
    @Published var employees: [EmployeeModel] = []
    
    @Published var messageError: String?
    
    private let employeeRepository: EmployeeRepository
    
    init(employeeRepository: EmployeeRepository = EmployeeRepository()) {
        self.employeeRepository = employeeRepository
    }
    
    func getAll() {
        employeeRepository.getAll { [weak self] result in
            switch result {
            case .success(let employeesList):
                self?.employees = employeesList
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
   
    func create(employeeForm: EmployeeFormNewRecord) {
        // no include id-document (generate by firebase)
        let newEmployee = EmployeeModel(
            name: employeeForm.name,
            dui: employeeForm.dui,
            phone: employeeForm.phone,
            address: employeeForm.address,
            skills: employeeForm.skills
        )

        employeeRepository.create(employee: newEmployee)
    }
    
    func update(employeeDocumentId: String, employeeForm: EmployeeFormEditRecord) {
        let editEmployee = EmployeeModel(
            id: employeeDocumentId,
            name: employeeForm.name,
            dui: employeeForm.dui,
            phone: employeeForm.phone,
            address: employeeForm.address,
            skills: employeeForm.skills
        )

        employeeRepository.update(employee: editEmployee)
    }
    
    func delete(employeeDocumentId: String) {
        employeeRepository.delete(employeeDocumentId: employeeDocumentId)
    }

}
