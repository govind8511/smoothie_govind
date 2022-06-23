//
//  HomeViewController.swift
//  Smoothie
//
//  Created by Govind on 21/06/22.
//

import UIKit
import AVKit

class HomeViewController: UIViewController{
    // MARK: - IBOutlets
    @IBOutlet weak var dataTable: UITableView!
    
    // MARK: - Member Properties
    var feedsArray = [Feeds]()
    var player : AVPlayer?
    var isVideoPlaying = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialsetUp()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopVideoPlayer()
    }
    
    // MARK: - Setup Methods
    func initialsetUp(){
        self.title = Constants.shared.dashboardTitle
        dataTable.estimatedRowHeight = 400
        dataTable.rowHeight = UITableView.automaticDimension
        self.dataTable.register(UINib(nibName: FeedVideoTableViewCell.Identifier, bundle: nibBundle), forCellReuseIdentifier: FeedVideoTableViewCell.Identifier)
        self.dataTable.register(UINib(nibName: FeedImageTableViewCell.Identifier, bundle: nibBundle), forCellReuseIdentifier: FeedImageTableViewCell.Identifier)
        self.dataTable.register(UINib(nibName: FeedUrlTableViewCell.Identifier, bundle: nibBundle), forCellReuseIdentifier: FeedUrlTableViewCell.Identifier)
        self.dataTable.register(UINib(nibName: FeedsTextTableViewCell.Identifier, bundle: nibBundle), forCellReuseIdentifier: FeedsTextTableViewCell.Identifier)
        //Get data from saved file
        let feedsData = FeedDataDecoder.decodeFeedBundleJson()
        feedsArray = feedsData.data
        dataTable.dataSource = self
        dataTable.delegate = self
        dataTable.reloadData()
        playVideoForVisibleRow()
    }
}

// #MARK:- TableView datasource and deleagtes
extension HomeViewController : UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Also working With automaticDimension, only card size for url and text will be small
        return 400// UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataType = feedsArray[indexPath.row].item_type
        //UI handling on basis of Feed type
        switch dataType {
        case FeedType.url.rawValue :
            let cell = dataTable.dequeueReusableCell(withIdentifier:FeedUrlTableViewCell.Identifier , for: indexPath) as! FeedUrlTableViewCell
            cell.selectionStyle = .none
            cell.showUrl(url: feedsArray[indexPath.row].data, descriptionText: feedsArray[indexPath.row].description)
            return cell
            
        case FeedType.image.rawValue :
            let cell = dataTable.dequeueReusableCell(withIdentifier:FeedImageTableViewCell.Identifier , for: indexPath) as! FeedImageTableViewCell
            cell.displayImage(url: feedsArray[indexPath.row].data, descriptionText: feedsArray[indexPath.row].description)
            cell.selectionStyle = .none
            return cell
            
        case FeedType.video.rawValue :
            let cell = dataTable.dequeueReusableCell(withIdentifier:FeedVideoTableViewCell.Identifier , for: indexPath) as! FeedVideoTableViewCell
            cell.selectionStyle = .none
            cell.setDescription(text: feedsArray[indexPath.row].description)
            return cell
       
        case FeedType.text.rawValue :
            let cell = dataTable.dequeueReusableCell(withIdentifier:FeedsTextTableViewCell.Identifier , for: indexPath) as! FeedsTextTableViewCell
            cell.showText(textString: feedsArray[indexPath.row].data, descriptionText: feedsArray[indexPath.row].description)
            cell.selectionStyle = .none
            return cell
        default:break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //UI handling on basis of Feed type
        let dataType = feedsArray[indexPath.row].item_type
        switch dataType {
        case FeedType.url.rawValue :
            // if feedtype is Url , Redirect to  in app webview
            if  feedsArray[indexPath.row].data != "" {
                self.stopVideoPlayer()
                let controller = Common.shared.getWebController()
                controller.url = feedsArray[indexPath.row].data
                self.navigationController?.pushViewController(controller, animated: true)
            }
            break
        case FeedType.video.rawValue :
            isVideoPlaying = !isVideoPlaying
            PlayPauseVideo()
            break
        default : break
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        playVideoForVisibleRow()
    }
}

// #MARK:-  For video play and pause
extension HomeViewController  {
    func stopVideoPlayer() {
        player?.pause()
        player = nil
    }
    
    func playVideoFor(url: String, View: UIView) {
        // Start AV player
        player?.replaceCurrentItem(with: nil)
        player = AVPlayer(url: URL(string: url)!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill //
        playerLayer.needsDisplayOnBoundsChange = true //
        playerLayer.frame = View.bounds
        View.layer.masksToBounds = true // 2
        View.layer.addSublayer(playerLayer)
        player?.play()
    }
    // Play pause the video afer tableview did select
    func PlayPauseVideo(){
        if isVideoPlaying{
            isVideoPlaying = true
            player?.play()
        }
        else{
            isVideoPlaying = false
            player?.pause()
        }
    }
    
    func playVideoForVisibleRow() {
        if let indexPathsForVisibleRows = dataTable.indexPathsForVisibleRows, indexPathsForVisibleRows.count > 0 {
            var focusCell: FeedVideoTableViewCell?
            for indexPath in indexPathsForVisibleRows {
                if let cell = dataTable.cellForRow(at: indexPath) as? FeedVideoTableViewCell {
                    if focusCell == nil {
                        let rect = dataTable.rectForRow(at: indexPath)
                        if dataTable.bounds.contains(rect) {
                            focusCell = cell
                            playVideoFor(url: feedsArray[indexPath.row].data, View: cell.videoView)
                        } else {
                            stopVideoPlayer()
                        }
                    } else {
                        stopVideoPlayer()
                    }
                }
            }
        }
    }
    
}






