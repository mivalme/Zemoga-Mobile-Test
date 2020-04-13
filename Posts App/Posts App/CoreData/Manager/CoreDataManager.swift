//
//  CoreDataManager.swift
//  Posts App
//
//  Created by Miguel Valcarcel on 12/04/20.
//  Copyright © 2020 Miguel Valcarcel. All rights reserved.
//

import UIKit
import CoreData

enum CoreDataResult<T> {
    case success(T)
    case failure(Error)
}

protocol CoreDataManagerProtocol {
    func getPostsList(completion: @escaping (CoreDataResult<[CoreDataModel.Post]>) -> Void)
    func savePostsList(postsModel: [CoreDataModel.Post],completion: @escaping (CoreDataResult<String>) -> Void)
}

class CoreDataManager: CoreDataManagerProtocol {
    var appDelegate: AppDelegate?
    var managedContext: NSManagedObjectContext?
    
    private func intializeCoreData() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
    }
    
    func getPostsList(completion: @escaping (CoreDataResult<[CoreDataModel.Post]>) -> Void) {
        intializeCoreData()
        guard let managedContext = self.managedContext else { return }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Post")
        
        do {
            let postsList = try managedContext.fetch(fetchRequest)
            var postsListModel = [CoreDataModel.Post]()
            postsList.forEach({
                if let userId = $0.value(forKey: "userId") as? Int,
                    let id = $0.value(forKey: "id") as? Int,
                    let title = $0.value(forKey: "title") as? String,
                    let body = $0.value(forKey: "body") as? String {
                    let post = CoreDataModel.Post(userId: userId, id: id, title: title, body: body)
                    postsListModel.append(post)
                }
            })
            completion(.success(postsListModel))
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
    
    func savePostsList(postsModel: [CoreDataModel.Post],completion: @escaping (CoreDataResult<String>) -> Void) {
        intializeCoreData()
        guard
            let managedContext = self.managedContext,
            let entity = NSEntityDescription.entity(forEntityName: "Post", in: managedContext)
            else { return }
        
        postsModel.forEach({
            let post = NSManagedObject(entity: entity, insertInto: managedContext)
            post.setValuesForKeys(["id": $0.id, "userId": $0.userId, "title": $0.title, "body": $0.body])
            do {
                try managedContext.save()
            } catch let error as NSError {
                completion(.failure(error))
            }
        })
        completion(.success(String()))
    }
}
