//
//  HomeViewModel.swift
//  ChallengeCeiba
//
//  Created by Agustinch on 29/09/2022.
//

import Foundation
import CoreData

protocol HomeViewModelProtocol {
    func getAllUsers()
    func getAllUsersCoreData()
    func saveInformationUsers(users: [UserModel])
    func saveInformationPosts(posts: [PostModel])

}

protocol HomeViewModelUpdated {
    func startLoading()
    func finishLoading()
    func setAllUser(users: [NSManagedObject])
    func setAllPosts(posts: [NSManagedObject])
    func showAlert(title: String, message: String)
}

class HomeViewModel: HomeViewModelProtocol {

    private let useCase: HomeUseCaseProtocol
    private let view: HomeViewModelUpdated
    private let persistentContainer: NSPersistentContainer
    private let context: NSManagedObjectContext

    // MARK: - Init

    init(useCase: HomeUseCaseProtocol, view: HomeViewModelUpdated, persistentContainer: NSPersistentContainer) {
        self.useCase = useCase
        self.view = view
        self.persistentContainer = persistentContainer
        self.context = persistentContainer.viewContext
    }

    func getAllUsers() {
        useCase.getAllUsers { [weak self] response in
            guard let self = self else { return }

            switch response {
            case .success(let users):
                self.saveInformationUsers(users: users)
            case .failure(_):
                self.view.showAlert(title: "Error", message: "Error de red")
            }
        }
    }

    func getAllPosts() {
        useCase.getAllPosts { [weak self] response in
            guard let self = self else { return }

            switch response {
            case .success(let posts):
                self.saveInformationPosts(posts: posts)
            case .failure(_):
                self.view.showAlert(title: "Error", message: "Error de red")
            }
        }
    }


    func getAllUsersCoreData() {

        let contextBackgound = persistentContainer.newBackgroundContext()

        contextBackgound.perform { [weak self] in
            guard let self = self else { return }

            let request = NSFetchRequest<NSManagedObject>(entityName: "User")

            do {
                let result = try self.context.fetch(request)

                result.isEmpty ? self.getAllUsers() : self.view.setAllUser(users: result)

            } catch {
                self.view.showAlert(title: "Error obtener información Users", message: error.localizedDescription)
            }
        }

    }


    func saveInformationUsers(users: [UserModel]) {

        users.forEach { user in
            let userInfo = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
            userInfo.setValue(user.email, forKey: "email")
            userInfo.setValue(user.phone, forKey: "phone")
            userInfo.setValue(user.name, forKey: "name")
            userInfo.setValue(user.id, forKey: "id")

            do {
                try context.save()
            } catch {
                print("No se guardo la info \(error)")
            }
        }

        self.getAllUsersCoreData()
    }

    func saveInformationPosts(posts: [PostModel]) {
        let contextBackgound = persistentContainer.newBackgroundContext()

        contextBackgound.perform { [weak self] in
            guard let self = self else { return }

            posts.forEach { post in
                let postInfo = NSEntityDescription.insertNewObject(forEntityName: "Post", into: self.context)
                postInfo.setValue(post.body, forKey: "body")
                postInfo.setValue(post.title, forKey: "title")
                postInfo.setValue(post.id, forKey: "id")
                postInfo.setValue(post.userId, forKey: "userId")
                do {
                    try self.context.save()
                } catch {
                    print("No se guardo la info \(error)")
                }
            }
          
        }
        self.getAllPostsCoreData()
    }

    func getAllPostsCoreData() {
        let contextBackgound = persistentContainer.newBackgroundContext()

        let request = NSFetchRequest<NSManagedObject>(entityName: "Post")

        contextBackgound.perform { [weak self] in
            guard let self = self else { return }

            do {
                let result = try self.context.fetch(request)
                result.isEmpty ? self.getAllPosts() : self.view.setAllPosts(posts: result)
            } catch {
                self.view.showAlert(title: "Error obtener información Posts", message: error.localizedDescription)
            }
        }

    }


}
