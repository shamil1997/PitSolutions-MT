//
//  NetworkMonitor.swift
//  PitSolutions MT
//
//  Created by Iris Medical Solutions on 03/02/23.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()

    private let checkerQueue = DispatchQueue.global()
    private let monitor : NWPathMonitor
    
    public private(set) var isConnected : Bool = false
    public private(set) var connectionType : ConnectionType = .unknown
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init() {
        self.monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: checkerQueue)
        monitor.pathUpdateHandler = {[weak self]path in
            self?.isConnected = path.status == .satisfied
            self?.getConenctionType(path)
        }
    }
    
    private func getConenctionType(_ path : NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        }else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        }else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        }else{
            connectionType = .unknown
        }
    }
    func stopMonitoring() {
        monitor.cancel()
    }
}
