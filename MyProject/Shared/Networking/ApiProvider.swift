//
//  ApiProvider.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 16/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

final class ApiProvider<Target: TargetType>: MoyaProvider<Target> {
    
    init(plugins: [PluginType]) {
        var plugins = plugins
        plugins.append(NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)))
        super.init(plugins: plugins)
    }
            
    func request(target: Target) -> Single<Response> {
        return connectedToInternet()
            .timeout(RxTimeInterval.seconds(kApiTimeOut), scheduler: MainScheduler.instance)
            .filter({ $0 == true })
            .take(1)
            .flatMap({ _ in
                return self
                    .rx
                    .request(target)
                    .timeout(RxTimeInterval.seconds(kApiTimeOut), scheduler: MainScheduler.instance)
            })
            .observe(on: MainScheduler.instance)
            .asSingle()
    }
        
}
