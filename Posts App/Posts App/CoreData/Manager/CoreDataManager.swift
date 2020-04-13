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
    func updatePost(postModel: CoreDataModel.Post, completion: @escaping (CoreDataResult<String>) -> Void)
    func deleteAllPosts(completion: @escaping (CoreDataResult<String>) -> Void)
    func deletePost(postId: Int, completion: @escaping (CoreDataResult<String>) -> Void)
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
                    let body = $0.value(forKey: "body") as? String,
                    let read = $0.value(forKey: "read") as? Bool,
                    let favorite = $0.value(forKey: "favorite") as? Bool {
                    let post = CoreDataModel.Post(userId: userId, id: id, title: title, body: body, read: read, favorite: favorite)
                    postsListModel.append(post)
                }
            })
            completion(.success(postsListModel))
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
    
    func savePostsList(postsModel: [CoreDataModel.Post], completion: @escaping (CoreDataResult<String>) -> Void) {
        intializeCoreData()
        guard
            let managedContext = self.managedContext,
            let entity = NSEntityDescription.entity(forEntityName: "Post", in: managedContext)
            else { return }
        
        postsModel.forEach({
            let post = NSManagedObject(entity: entity, insertInto: managedContext)
            post.setValuesForKeys(["id": $0.id, "userId": $0.userId, "title": $0.title, "body": $0.body, "read": $0.read, "favorite": $0.favorite])
            do {
                try managedContext.save()
            } catch let error as NSError {
                completion(.failure(error))
            }
        })
        completion(.success(String()))
    }
    
    func updatePost(postModel: CoreDataModel.Post, completion: @escaping (CoreDataResult<String>) -> Void) {
        intializeCoreData()
        guard let managedContext = self.managedContext else { return }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Post")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(postModel.id)")
        
        do {
            let post = try managedContext.fetch(fetchRequest).first
            post?.setValuesForKeys(["id": postModel.id,
                                    "userId": postModel.userId,
                                    "title": postModel.title,
                                    "body": postModel.body,
                                    "read": postModel.read,
                                    "favorite": postModel.favorite])
            do {
                try managedContext.save()
                completion(.success(String()))
            } catch let error as NSError {
                completion(.failure(error))
            }
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
    
    func deleteAllPosts(completion: @escaping (CoreDataResult<String>) -> Void) {
        intializeCoreData()
        guard let managedContext = self.managedContext else { return }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Post")
        do {
            let postsList = try managedContext.fetch(fetchRequest)
            postsList.forEach({
                managedContext.delete($0)
            })
            do {
                try managedContext.save()
                completion(.success(String()))
            } catch let error as NSError {
                completion(.failure(error))
            }
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
    
    func deletePost(postId: Int, completion: @escaping (CoreDataResult<String>) -> Void) {
        intializeCoreData()
        guard let managedContext = self.managedContext else { return }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Post")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(postId)")
        
        do {
            guard let post = try managedContext.fetch(fetchRequest).first else { return }
            managedContext.delete(post)
            do {
                try managedContext.save()
                completion(.success(String()))
            } catch let error as NSError {
                completion(.failure(error))
            }
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
}
