//
//  CustomerService.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-20.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit
import CoreData

struct CustomerService {
    
    static var managedObjectContext = CoreDataStack().persistentContainer.viewContext
    
    static internal func verify(username: String, password: String) -> Customer? {
        let request: NSFetchRequest<Customer> = Customer.fetchRequest()
        request.predicate = NSPredicate(format: "email = %@ AND password = %@", username, password)
        
        do {
            let result = try managedObjectContext.fetch(request)
            
            if result.count > 0 {
                return result.first
            }
            
            return nil
        } catch let error as NSError {
            print("Error verifying customer login: \(error.localizedDescription)")
            return nil
        }
        
    }
    
}

