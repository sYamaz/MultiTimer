//
//  Injected.swift
//  CupNoodlesMusicTimer
//
//  Created by 山﨑駿 on 2021/02/16.
//

import Foundation

@propertyWrapper
struct Injected<Service> {
    private var service: Service!
    public var container: Resolver?
    public var name: String?
    public init() {}
    public init(name: String? = nil, container: Resolver? = nil) {
        self.name = name
        self.container = container
    }
    public var wrappedValue: Service {
        mutating get {
            if self.service == nil {
                self.service = container?.resolve(Service.self, name: name) ?? Resolver.resolve(Service.self, name: name)
            }
            return service
        }
        mutating set { service = newValue  }
    }
    public var projectedValue: Injected<Service> {
        get { return self }
        mutating set { self = newValue }
    }
}
