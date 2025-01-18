//
//  Environment.swift
//  Core
//
//  Created by zztkm on 2025/01/18.
//
import Foundation

enum AppEnvironment {
    // 接続するサーバーのシグナリング URL
    // 配列で複数の URL を指定することが可能です
    static let urls = [URL(string: "wss://sora.example.com/signaling")!]

    // チャネル ID
    static let channelId = "sora"
}
