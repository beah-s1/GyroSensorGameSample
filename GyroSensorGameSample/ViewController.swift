//
//  ViewController.swift
//  GyroSensorGameSample
//
//  Created by Kentaro Abe on 2021/02/15.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var cubeImageView: UIImageView! // 中央に置く画像
    let motionManager = CMMotionManager() // ジャイロセンサーのデータを取得するためのManager
    var offset = 150 // ジャイロセンサーの傾きから求められる加速のオフセット値、50〜150くらいがちょうどいい難易度になると思います。
    var motion: CMDeviceMotion?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if !motionManager.isGyroAvailable{
            return
        }
        
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (motion, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            self.motion = motion
        }
        
        // 60fps
        Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { (t) in
            // 繰り返される処理
            guard let motion = self.motion else{
                return
            }
            
            let deviceGravity = motion.gravity // デバイスにかかっている重力（-1.0 ≤ x ≤ 1.0)
            
            self.cubeImageView.center.x += CGFloat(deviceGravity.x) * CGFloat(self.offset)
            self.cubeImageView.center.y -= CGFloat(deviceGravity.y) * CGFloat(self.offset)
        }
        
        //TODO: ゲーム性を出すために、スコアリングします
    }


}

