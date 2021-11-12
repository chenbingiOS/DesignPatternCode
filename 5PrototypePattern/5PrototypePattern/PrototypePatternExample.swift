//
//  PrototypePatternExample.swift
//  5PrototypePattern
//
//  Created by mtAdmin on 2021/11/12.
//

import Foundation

class Author {
    
    private var id: Int
    private var username: String
    private var pages = [Page]()
    
    init(id: Int, username: String) {
        self.id = id
        self.username = username
    }
    
    func add(page: Page) {
        pages.append(page)
    }
    
    var pageCount: Int {
        return pages.count
    }
}

class Page: NSCopying {
    
    private(set) var title: String
    private(set) var contents: String
    private weak var author: Author?
    private(set) var comments = [Comment]()
    
    init(title: String, contents: String, auther: Author?) {
        self.title = title
        self.contents = contents
        self.author = auther
        auther?.add(page: self)
    }
    
    func add(comment: Comment) {
        comments.append(comment)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Page(title: "Copy of '\(title)'", contents: contents, auther: author)
    }
}

struct Comment {
    let data = Data()
    let message: String
}
