//
//  ContentView.swift
//
//  Created by zztkm on 2025/01/18.
//
import SwiftUI
import Sora

// 接続状態
enum ConnectionState {
    case connecting // 接続試行
    case connected // 接続
    case disconnected //切断
}

public struct ContentView: View {
    @State private var mediaChannel: MediaChannel?

    @State private var senderStream: MediaStream?
    @State private var showsAlert = false
    @State private var connectionError: Error?
    @State private var connectionState: ConnectionState = .disconnected // 接続状態を管理

    // connectionMode が manual のときは以下の State で映像制御を実装する必要がある
    @State private var isVideoStopped: Bool = false // Video描画の停止管理
    @State private var isVideoClear: Bool = false // Video描画をクリアして背景を表示させるフラグ
    
    public init() {}

    public var body: some View {
        VStack {
            ZStack {
                SwiftUIVideoView(
                    senderStream,
                    isStop: $isVideoStopped,
                    isClear: $isVideoClear
                )
                    .videoAspect(.fill)
                    .connectionMode(.manual) // NOTE: mode によって、view の autoStop 時の挙動が変わる（default: .autoClear
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            connect()
                        } label: {
                            Text("接続")
                                .font(.title)
                        }
                        .disabled(connectionState == .connecting || connectionState == .connected) // 接続試行中 or 接続中は無効化


                        Button {
                            disconnect()
                        } label: {
                            Text("切断")
                                .font(.title)
                        }
                        .disabled(connectionState == .connecting || connectionState == .disconnected) // 接続試行中 or 切断中は無効化

                        Button {
                            toggleVideo()
                        } label: {
                            Text("映像表示切替")
                                .font(.title)
                        }
                    }
                }.padding()
            }
            .alert("エラー", isPresented: $showsAlert, actions: {
                Button("OK") {
                    showsAlert = false
                    connectionError = nil
                }
            }, message: {
                if let error = connectionError {
                    Text(error.localizedDescription)
                } else {
                    Text("エラー内容不明")
                }
            })
        }
    }

    func connect() {
        if connectionState == .connected {
            print("Already connected.")
            return
        }

        connectionState = .connecting // 接続処理中に設定

        let config = Configuration(
            urlCandidates: AppEnvironment.urls,
            channelId: AppEnvironment.channelId,
            role: .sendonly,
            multistreamEnabled: true)

        _ = Sora.shared.connect(configuration: config) { mediaChannel, error in
            if let error = error {
                connectionError = error
                showsAlert = true
                connectionState = .disconnected // 接続失敗したので、状態を切断中に更新
                print("Error: \(error)")
            } else {
                self.mediaChannel = mediaChannel
                senderStream = self.mediaChannel?.senderStream
                connectionState = .connected
            }
        }
    }

    func disconnect() {
        if connectionState == .disconnected {
            print("Already disconnected.")
            return
        }
        guard let mediaChannel = self.mediaChannel else {
            return
        }
        mediaChannel.disconnect(error: nil)
        self.mediaChannel = nil
        self.senderStream = nil
        self.connectionState = .disconnected
    }

    func toggleVideo() {
        isVideoStopped.toggle()
        isVideoClear.toggle()
    }
}

#Preview {
    ContentView()
}
