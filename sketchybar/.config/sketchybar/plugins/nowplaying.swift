#!/usr/bin/swift

import Foundation

let bundle = CFBundleCreate(
    kCFAllocatorDefault,
    NSURL(fileURLWithPath: "/System/Library/PrivateFrameworks/MediaRemote.framework")
)

guard let fnPtr = CFBundleGetFunctionPointerForName(bundle, "MRMediaRemoteGetNowPlayingInfo" as CFString) else {
    exit(0)
}

typealias GetNowPlayingFn = @convention(c) (DispatchQueue, @escaping ([String: AnyObject]) -> Void) -> Void
let getNowPlaying = unsafeBitCast(fnPtr, to: GetNowPlayingFn.self)

getNowPlaying(DispatchQueue.main) { info in
    let title = info["kMRMediaRemoteNowPlayingInfoTitle"] as? String ?? ""
    let artist = info["kMRMediaRemoteNowPlayingInfoArtist"] as? String ?? ""
    if !title.isEmpty {
        print(artist.isEmpty ? title : "\(title) – \(artist)")
    }
    exit(0)
}

RunLoop.main.run(until: Date(timeIntervalSinceNow: 2))
