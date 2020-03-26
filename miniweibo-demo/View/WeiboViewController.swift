//
//  WeiboViewController.swift
//  miniweibo-demo
//
//  Created by Weicheng Wang on 2020/3/26.
//  Copyright © 2020 xyli. All rights reserved.
//

import UIKit

class WeiboViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        
        var viewModel = MomentViewModel(momentService: MomentService())
        var moments: [[Moment]] = []
        var text: String = ""
        var id: Int = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.delegate = self
            tableView.dataSource = self
            // 建议使用 register 注册cell 的方式
    //        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "testCellID")
            
            
            // 此处为了避免循环引用，使用weak
            viewModel.updateMoments = { [weak self] moments in
                print(moments[0])
                guard let `self` = self else { return }
                self.moments = moments
                self.tableView.reloadData()
            }
            
            viewModel.fetchMoments()
            // 此处为了避免循环引用，使用weak
    //        viewModel.fetchMoments(completion: { [weak self] (moments) in
    //            print(moments[0])
    //            guard let `self` = self else { return }
    //            self.moments = moments
    //            self.tableView.reloadData()
    //        })
        }
        
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        viewModel.fetchMoments(completion: {
    //            (moments) in
    //            self.moments = moments
    //            self.text = moments[0].text
    //            self.id = moments[0].id
    //        })
    //    }
}

extension WeiboViewController: UITableViewDataSource {
        //MARK: UITableViewDataSource
            // cell的个数

    func numberOfSections(in tableView: UITableView) -> Int {
        return moments.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moments[section].count
    }
    // UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "testCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid)
        if cell==nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellid)
        }

        let moment = moments[indexPath.row]
        
        cell?.textLabel?.text = "\(moment.id)"
        cell?.detailTextLabel?.text = moment.text
        cell?.imageView?.image = UIImage(named:"Expense_success")
        return cell!
                
                
    //            let cell = tableView.dequeueReusableCell(withIdentifier: "testCellID", for: indexPath)
    //
    //            let moment = moments[indexPath.row]
    //
    //            cell.textLabel?.text = "\(moment.id)"
    //            cell.detailTextLabel?.text = moment.text
    //            cell.imageView?.image = UIImage(named:"Expense_success")
    //            //            return cell!,强制拆包不建议，可以使用 if let 或者 guard let 的方式拆包
    //            return cell
    }
}

extension WeiboViewController: UITableViewDelegate {
    //MARK: UITableViewDelegate
    // 设置cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84.0
    }
    // 选中cell后执行此方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}