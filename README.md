#gocronadmin

- gocron 工具的后台管理系统

- 基于beego web开发框架

##Mysql Tables

```
CREATE TABLE `admin_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `pwd` varchar(32) NOT NULL DEFAULT '',
  `ctime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `email` varchar(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8
```

```
 CREATE TABLE `cron` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '任务名',
  `spec` varchar(50) NOT NULL DEFAULT '' COMMENT '调度表达式',
  `cmd` varchar(255) NOT NULL DEFAULT '' COMMENT 'shell命令',
  `stime` datetime NOT NULL COMMENT '开始时间',
  `etime` datetime NOT NULL COMMENT '结束时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '激活为１　未激活为０',
  `running` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否正在运行',
  `modify` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否修改了需要同步',
  `ip` varchar(20) NOT NULL DEFAULT '' COMMENT 'ip地址（选择机器运行）',
  `singleton` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否单例',
  `after` int(11) NOT NULL DEFAULT '0' COMMENT '是否有前置任务',
  `once` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否运行一次标记',
  `user_id` int(11) NOT NULL COMMENT '用户ｉｄ',
  `ctime` datetime NOT NULL,
  `time` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `stime` (`stime`,`etime`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 
```

```
CREATE TABLE `cron_hist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT '任务ｉｄ',
  `process_id` int(11) NOT NULL DEFAULT '0' COMMENT '进程ｉｄ',
  `step` tinyint(4) NOT NULL DEFAULT '0' COMMENT '目前的状态',
  `time` datetime NOT NULL COMMENT '时间',
  `ret` varchar(255) NOT NULL DEFAULT '' COMMENT '运行结果',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=377 DEFAULT CHARSET=utf8
```

```

INSERT INTO `admin_user` (`id`, `name`, `pwd`, `ctime`, `email`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', '2016-11-04 00:00:00', 'admin@admin.com');

```

##使用说明
- go get github.com/widaT/gocronadmin 

- go build gocronadmin

- linux 下使用 app.sh 脚本   ./app.sh [start|stop]

- 用户admin 密码admin登陆管理