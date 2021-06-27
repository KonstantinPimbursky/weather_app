//
//  CoreDataStack.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 27.06.2021.
//

import Foundation
import CoreData

class CoreDataStack {
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "LikedPostModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
//    var viewContext: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
//
//    func newBackgroundContext() -> NSManagedObjectContext {
//        return persistentContainer.newBackgroundContext()
//    }
//
//    func fetchLikedPosts(filteredBy author: String?) -> [LikedPost] {
//        let request: NSFetchRequest<LikedPost> = LikedPost.fetchRequest()
//        request.fetchBatchSize = 20
//        if let text = author {
//            let predicate = NSPredicate(format: "%K LIKE %@", #keyPath(LikedPost.postAuthor), text)
//            request.predicate = predicate
//        }
//
//        do {
//            return try viewContext.fetch(request)
//        } catch {
//            fatalError("🤷‍♂️ Что-то пошло не так..")
//        }
//    }
//
//    func remove(likedPost: LikedPost) {
//        viewContext.delete(likedPost)
//
//        save(context: viewContext)
//    }
//
//    func createNewLikedPost(post: PostModel) {
//        let backgroundContext = newBackgroundContext()
//        let newLikedPost = LikedPost(context: backgroundContext)
//        newLikedPost.id = UUID()
//        newLikedPost.postAuthor = post.author
//        newLikedPost.postDescription = post.description
//        newLikedPost.postImage = post.image
//        newLikedPost.postLikes = Int16(post.likes)
//        newLikedPost.postViews = Int16(post.views)
//        backgroundContext.perform {
//            do {
//                try backgroundContext.save()
//            } catch let error {
//                print(error)
//            }
//        }
//    }
//
//    private func save(context: NSManagedObjectContext) {
//        guard context.hasChanges else { return }
//
//        do {
//            try context.save()
//        } catch {
//            print(error)
//        }
//    }
}
