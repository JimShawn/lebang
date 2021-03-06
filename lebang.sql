/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : lebang

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2017-05-15 15:08:41
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `app`
-- ----------------------------
DROP TABLE IF EXISTS `app`;
CREATE TABLE `app` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_time` int(10) unsigned DEFAULT NULL COMMENT '创建时间',
  `enabled` tinyint(1) unsigned NOT NULL COMMENT '是否启用',
  `modified_time` int(10) unsigned DEFAULT NULL COMMENT '修改时间',
  `name` varchar(50) NOT NULL COMMENT 'app名称',
  `secret` char(32) NOT NULL COMMENT 'app_secret',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app
-- ----------------------------
INSERT INTO `app` VALUES ('1', '1494313266', '1', '1494313487', 'app1', 'xEE1a0jSGXxd!yV%jfi7YWBvY^TP@gW$');
INSERT INTO `app` VALUES ('2', '1494313276', '1', '1494313276', 'app2', '$p9ULb8iMdABDtOIVhK3vOK4Fc!v2U@U');
INSERT INTO `app` VALUES ('3', '1494313279', '1', '1494313279', 'app3', 'dZRm3TZ5DdehLE1mJBgl2+7IawkcD6g#');
INSERT INTO `app` VALUES ('4', '1494313283', '1', '1494313283', 'app4', '4zU^EAxGD1oVwSAPdnD3uklz2W4ohl$%');
INSERT INTO `app` VALUES ('5', '1494313286', '1', '1494313286', 'app5', 'V2j~3O85FIUcEDD8f3lR%i6OBnHg^3dW');

-- ----------------------------
-- Table structure for `city_task`
-- ----------------------------
DROP TABLE IF EXISTS `city_task`;
CREATE TABLE `city_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `city_id` bigint(20) unsigned NOT NULL COMMENT '城市id',
  `created_time` int(10) unsigned DEFAULT NULL COMMENT '创建时间',
  `enabled` tinyint(1) unsigned NOT NULL COMMENT '是否启用',
  `modified_time` int(10) unsigned DEFAULT NULL COMMENT '修改时间',
  `province_id` bigint(20) unsigned NOT NULL COMMENT '省份id',
  `task_id` bigint(20) unsigned NOT NULL COMMENT '任务id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of city_task
-- ----------------------------

-- ----------------------------
-- Table structure for `reviewer_task_statistics`
-- ----------------------------
DROP TABLE IF EXISTS `reviewer_task_statistics`;
CREATE TABLE `reviewer_task_statistics` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `accepted_amount` int(10) unsigned NOT NULL COMMENT '任务渠道通过量',
  `begin_time` int(10) unsigned NOT NULL COMMENT '统计开始时间',
  `end_time` int(10) unsigned NOT NULL COMMENT '统计结束时间',
  `reviewed_amount` int(10) unsigned NOT NULL COMMENT '任务渠道领取量',
  `reviewer_user_id` bigint(20) unsigned NOT NULL COMMENT '审核人员UserId',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_reviewer_begin_end` (`reviewer_user_id`,`begin_time`,`end_time`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reviewer_task_statistics
-- ----------------------------
INSERT INTO `reviewer_task_statistics` VALUES ('1', '4', '1493568000', '1496246400', '7', '2');
INSERT INTO `reviewer_task_statistics` VALUES ('2', '4', '1493568000', '1496246400', '5', '3');
INSERT INTO `reviewer_task_statistics` VALUES ('3', '1', '1493568000', '1496246400', '1', '7');
INSERT INTO `reviewer_task_statistics` VALUES ('4', '1', '1493568000', '1496246400', '3', '4');
INSERT INTO `reviewer_task_statistics` VALUES ('5', '6', '1493568000', '1496246400', '6', '5');
INSERT INTO `reviewer_task_statistics` VALUES ('6', '11', '1490976000', '1493568000', '19', '2');
INSERT INTO `reviewer_task_statistics` VALUES ('7', '111', '1490976000', '1493568000', '127', '3');
INSERT INTO `reviewer_task_statistics` VALUES ('8', '99', '1490976000', '1493568000', '100', '5');
INSERT INTO `reviewer_task_statistics` VALUES ('9', '30', '1488297600', '1490976000', '30', '2');

-- ----------------------------
-- Table structure for `task`
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `amount` int(10) unsigned NOT NULL COMMENT '任务数量',
  `begin_time` int(10) unsigned NOT NULL COMMENT '任务开始时间',
  `city_limited` tinyint(1) unsigned NOT NULL COMMENT '是否限定城市',
  `cost` decimal(6,2) unsigned NOT NULL COMMENT '任务成本',
  `created_time` int(10) unsigned DEFAULT NULL COMMENT '创建时间',
  `device_type_mask` tinyint(3) unsigned NOT NULL COMMENT '设备类型掩码',
  `each_person_limit` int(10) unsigned NOT NULL COMMENT '每人限制次数',
  `end_time` int(10) unsigned NOT NULL COMMENT '任务结束时间',
  `left_amount` int(10) unsigned NOT NULL COMMENT '任务余量',
  `modified_time` int(10) unsigned DEFAULT NULL COMMENT '修改时间',
  `price` decimal(6,2) unsigned NOT NULL COMMENT '任务单价',
  `recommended_person` varchar(20) DEFAULT NULL COMMENT '推荐人',
  `recycle_days_limit` int(10) unsigned NOT NULL COMMENT '每次完成限制周期',
  `review_period` int(10) unsigned DEFAULT NULL COMMENT '审核周期',
  `task_type_id` bigint(20) unsigned NOT NULL COMMENT '任务类型id',
  `task_type_name` varchar(100) NOT NULL COMMENT '任务类型名称',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否启用',
  `name` varchar(100) NOT NULL COMMENT '任务名称',
  `accepted_amount` int(10) unsigned NOT NULL COMMENT '任务通过量',
  `completed_amount` int(10) unsigned NOT NULL COMMENT '任务完成量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES ('1', '5', '1493790500', '0', '18.00', '1493781437', '127', '2', '1503780500', '0', '1493781437', '19.89', null, '1', null, '2', '淘宝评论', '1', '评论快去', '1', '1');
INSERT INTO `task` VALUES ('5', '5', '1493790500', '0', '18.00', '1493967172', '127', '1', '1503780500', '1', '1493967172', '19.89', null, '0', null, '2', '微信群', '1', '我的任务', '3', '4');
INSERT INTO `task` VALUES ('14', '5', '1493790500', '0', '18.00', '1493967645', '127', '1', '1503780500', '1', '1493967645', '19.89', null, '0', null, '2', '微信群', '1', '我的任务', '2', '4');
INSERT INTO `task` VALUES ('16', '5', '1493790500', '0', '18.00', '1493975061', '127', '1', '1503780500', '0', '1493975061', '19.89', null, '0', null, '2', '微信群', '1', '我的任务', '3', '5');
INSERT INTO `task` VALUES ('17', '5', '1493790500', '1', '18.00', '1493977197', '127', '1', '1503780500', '5', '1493977830', '19.89', null, '0', null, '2', '微信群', '1', '我的任务', '0', '0');
INSERT INTO `task` VALUES ('18', '5', '1493790500', '1', '18.00', '1493977929', '127', '1', '1503780500', '5', '1493977929', '19.89', null, '0', null, '2', '微信群', '1', '我的任务', '0', '0');
INSERT INTO `task` VALUES ('19', '5', '1493790500', '1', '18.00', '1493978066', '127', '1', '1503780500', '5', '1493978066', '19.89', null, '0', null, '2', '微信群', '1', '我的任务', '0', '0');
INSERT INTO `task` VALUES ('20', '5', '1493790500', '1', '18.00', '1494395605', '127', '1', '1503780500', '5', '1494395605', '19.89', null, '0', null, '2', '微信群', '1', '我的任务111', '0', '0');
INSERT INTO `task` VALUES ('21', '5', '1493790500', '0', '18.00', '1494395620', '127', '1', '1503780500', '0', '1494395620', '19.89', null, '0', null, '2', '微信群', '1', '我的任务111', '2', '3');
INSERT INTO `task` VALUES ('22', '5', '1493790500', '0', '18.00', '1494395621', '127', '1', '1503780500', '0', '1494395621', '19.89', null, '0', null, '2', '微信群', '1', '我的任务111', '2', '3');
INSERT INTO `task` VALUES ('23', '5', '1493790500', '0', '18.00', '1494395622', '127', '1', '1503780500', '2', '1494395622', '19.89', null, '0', null, '2', '微信群', '1', '我的任务111', '2', '3');
INSERT INTO `task` VALUES ('24', '5', '1493790500', '0', '18.00', '1494395622', '127', '1', '1503780500', '1', '1494395622', '19.89', null, '0', null, '2', '微信群', '1', '我的任务111', '1', '3');

-- ----------------------------
-- Table structure for `task_app_statistics`
-- ----------------------------
DROP TABLE IF EXISTS `task_app_statistics`;
CREATE TABLE `task_app_statistics` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `accepted_amount` int(10) unsigned NOT NULL COMMENT '任务渠道通过量',
  `app_id` bigint(20) unsigned NOT NULL COMMENT '渠道app id',
  `begin_time` int(10) unsigned NOT NULL COMMENT '统计开始时间',
  `completed_amount` int(10) unsigned NOT NULL COMMENT '任务渠道完成量',
  `end_time` int(10) unsigned NOT NULL COMMENT '统计结束时间',
  `received_amount` int(10) unsigned NOT NULL COMMENT '任务渠道领取量',
  `task_id` bigint(20) unsigned NOT NULL COMMENT '任务id',
  `total_flow` decimal(11,2) unsigned NOT NULL COMMENT '任务渠道流水',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_task_app_begin_end` (`task_id`,`app_id`,`begin_time`,`end_time`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task_app_statistics
-- ----------------------------
INSERT INTO `task_app_statistics` VALUES ('1', '3', '4', '1494345600', '5', '1494432000', '5', '16', '59.67');
INSERT INTO `task_app_statistics` VALUES ('2', '1', '3', '1494345600', '3', '1494432000', '4', '24', '19.89');
INSERT INTO `task_app_statistics` VALUES ('3', '2', '4', '1494345600', '4', '1494432000', '4', '14', '39.78');
INSERT INTO `task_app_statistics` VALUES ('4', '2', '3', '1494345600', '3', '1494432000', '5', '22', '39.78');
INSERT INTO `task_app_statistics` VALUES ('5', '2', '3', '1494345600', '3', '1494432000', '3', '23', '39.78');
INSERT INTO `task_app_statistics` VALUES ('6', '2', '3', '1494345600', '3', '1494432000', '5', '21', '39.78');
INSERT INTO `task_app_statistics` VALUES ('7', '2', '4', '1494345600', '2', '1494432000', '3', '5', '39.78');
INSERT INTO `task_app_statistics` VALUES ('8', '1', '1', '1494259200', '1', '1494345600', '5', '1', '19.89');
INSERT INTO `task_app_statistics` VALUES ('9', '1', '2', '1494259200', '1', '1494345600', '1', '5', '19.89');

-- ----------------------------
-- Table structure for `task_city`
-- ----------------------------
DROP TABLE IF EXISTS `task_city`;
CREATE TABLE `task_city` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `city_id` bigint(20) unsigned NOT NULL COMMENT '城市id',
  `created_time` int(10) unsigned DEFAULT NULL COMMENT '创建时间',
  `modified_time` int(10) unsigned DEFAULT NULL COMMENT '修改时间',
  `province_id` bigint(20) unsigned NOT NULL COMMENT '省份id',
  `task_id` bigint(20) unsigned NOT NULL COMMENT '任务id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_task_city` (`task_id`,`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task_city
-- ----------------------------
INSERT INTO `task_city` VALUES ('1', '1', '1493977197', '1493977197', '1', '17');
INSERT INTO `task_city` VALUES ('4', '3', '1493977830', '1493977830', '1', '17');
INSERT INTO `task_city` VALUES ('5', '2', '1493977929', '1493977929', '1', '18');
INSERT INTO `task_city` VALUES ('6', '1', '1493977929', '1493977929', '1', '18');
INSERT INTO `task_city` VALUES ('7', '1', '1494395605', '1494395605', '1', '20');
INSERT INTO `task_city` VALUES ('8', '2', '1494395605', '1494395605', '1', '20');

-- ----------------------------
-- Table structure for `task_procedure`
-- ----------------------------
DROP TABLE IF EXISTS `task_procedure`;
CREATE TABLE `task_procedure` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_time` int(10) unsigned DEFAULT NULL COMMENT '创建时间',
  `description` varchar(2000) NOT NULL COMMENT '描述',
  `images` varchar(500) NOT NULL COMMENT '图片',
  `modified_time` int(10) unsigned DEFAULT NULL COMMENT '修改时间',
  `procedure_order` tinyint(1) unsigned NOT NULL COMMENT '顺序',
  `task_id` bigint(20) unsigned NOT NULL COMMENT '任务id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_task_procedure_order` (`task_id`,`procedure_order`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task_procedure
-- ----------------------------
INSERT INTO `task_procedure` VALUES ('15', '1493967645', 'order 1', '1.jpg,2.jpg', '1493967645', '5', '14');
INSERT INTO `task_procedure` VALUES ('16', '1493967645', 'order 2', '1.jpg,2.jpg', '1493967645', '1', '14');
INSERT INTO `task_procedure` VALUES ('19', '1493968385', 'order 1', '1.jpg,2.jpg', '1493968385', '5', '1');
INSERT INTO `task_procedure` VALUES ('22', '1493975061', 'order 1', '1.jpg,2.jpg', '1493975061', '3', '16');
INSERT INTO `task_procedure` VALUES ('23', '1493975061', 'order 2', '1.jpg,2.jpg', '1493975061', '1', '16');
INSERT INTO `task_procedure` VALUES ('24', '1493977197', 'order 1', '1.jpg,2.jpg', '1493977197', '3', '17');
INSERT INTO `task_procedure` VALUES ('25', '1493977197', 'order 2', '1.jpg,2.jpg', '1493977197', '1', '17');
INSERT INTO `task_procedure` VALUES ('26', '1493977929', 'order 1', '1.jpg,2.jpg', '1493977929', '3', '18');
INSERT INTO `task_procedure` VALUES ('27', '1493977929', 'order 2', '1.jpg,2.jpg', '1493977929', '1', '18');
INSERT INTO `task_procedure` VALUES ('28', '1493978066', 'order 1', '1.jpg,2.jpg', '1493978066', '3', '19');
INSERT INTO `task_procedure` VALUES ('29', '1493978066', 'order 2', '1.jpg,2.jpg', '1493978066', '1', '19');
INSERT INTO `task_procedure` VALUES ('30', '1494395605', 'order 1', '1.jpg,2.jpg', '1494395605', '3', '20');
INSERT INTO `task_procedure` VALUES ('31', '1494395605', 'order 2', '1.jpg,2.jpg', '1494395605', '1', '20');
INSERT INTO `task_procedure` VALUES ('32', '1494395620', 'order 1', '1.jpg,2.jpg', '1494395620', '3', '21');
INSERT INTO `task_procedure` VALUES ('33', '1494395620', 'order 2', '1.jpg,2.jpg', '1494395620', '1', '21');
INSERT INTO `task_procedure` VALUES ('34', '1494395621', 'order 1', '1.jpg,2.jpg', '1494395621', '3', '22');
INSERT INTO `task_procedure` VALUES ('35', '1494395621', 'order 2', '1.jpg,2.jpg', '1494395621', '1', '22');
INSERT INTO `task_procedure` VALUES ('36', '1494395622', 'order 1', '1.jpg,2.jpg', '1494395622', '3', '23');
INSERT INTO `task_procedure` VALUES ('37', '1494395622', 'order 2', '1.jpg,2.jpg', '1494395622', '1', '23');
INSERT INTO `task_procedure` VALUES ('38', '1494395622', 'order 1', '1.jpg,2.jpg', '1494395622', '3', '24');
INSERT INTO `task_procedure` VALUES ('39', '1494395622', 'order 2', '1.jpg,2.jpg', '1494395622', '1', '24');

-- ----------------------------
-- Table structure for `task_type`
-- ----------------------------
DROP TABLE IF EXISTS `task_type`;
CREATE TABLE `task_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_time` int(10) unsigned DEFAULT NULL COMMENT '创建时间',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否启用',
  `modified_time` int(10) unsigned DEFAULT NULL COMMENT '修改时间',
  `name` varchar(100) NOT NULL COMMENT '任务类型名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task_type
-- ----------------------------
INSERT INTO `task_type` VALUES ('1', '1493780037', '0', '1493780260', '微信朋友圈');
INSERT INTO `task_type` VALUES ('2', '1493780049', '1', '1493780049', '微信群');
INSERT INTO `task_type` VALUES ('3', '1493780091', '1', '1493780091', 'QQ空间分享');
INSERT INTO `task_type` VALUES ('4', '1493780102', '1', '1493780102', '微博分享');
INSERT INTO `task_type` VALUES ('5', '1493780112', '1', '1493780112', '微信好友分享');
INSERT INTO `task_type` VALUES ('6', '1493780130', '1', '1493780130', '淘宝评论');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_time` int(10) unsigned DEFAULT NULL COMMENT '创建时间',
  `modified_time` int(10) unsigned DEFAULT NULL COMMENT '修改时间',
  `password` char(80) DEFAULT NULL COMMENT '用户密码（登录用）,使用Spring Security的BaseEncoder加密',
  `role` varchar(20) NOT NULL COMMENT '用户角色',
  `status` tinyint(2) unsigned NOT NULL COMMENT '用户状态',
  `username` varchar(20) NOT NULL COMMENT '用户账号（登录用）',
  `avatar` varchar(50) DEFAULT NULL COMMENT '头像',
  `nickname` varchar(20) DEFAULT NULL COMMENT '昵称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '1493863306', '1493863306', '471dc9c238566c9687b4f03822dd0bddec2069d883554fd5e8b7cff7b538447fd4f35420751447b3', 'ROLE_ADMIN', '1', 'lebang', null, null);
INSERT INTO `user` VALUES ('2', '1493951428', '1493951428', 'd868a87d197667983fa5560f01a9bd6cf9d6d24c87ddb4a766b27b6603786d903e040baa561458fa', 'ROLE_TASK_REVIEWER', '1', 'reviewer1', null, null);
INSERT INTO `user` VALUES ('3', '1493951434', '1493951434', '00c1c0f1e0279b09623d77a26ea795854fc70b6a0605f1bb7fa9067fa1fb4faf93254e28b8df1c58', 'ROLE_TASK_REVIEWER', '1', 'reviewer2', null, null);
INSERT INTO `user` VALUES ('4', '1493951436', '1493951436', 'd79c9c9b445216fb8f4817f4e1b6011ff6594382124fda7b60a9aff421cb640f4983d78dee2201ab', 'ROLE_TASK_REVIEWER', '1', 'reviewer3', null, null);
INSERT INTO `user` VALUES ('5', '1493951439', '1493951439', '93d9db7bced8efe57ec66f7ba5d48944ad09cca99df3d452822e5f5f887004c9c690f2ba9ac7e57a', 'ROLE_TASK_REVIEWER', '1', 'reviewer4', null, null);
INSERT INTO `user` VALUES ('6', '1493951443', '1493951443', 'be07d414b258d4102bb8bde30460efbf24fb59a4d8470c7e620b1c59d31780d9744c6d8e36c38e07', 'ROLE_TASK_REVIEWER', '1', 'reviewer5', null, null);
INSERT INTO `user` VALUES ('7', '1493951446', '1493951446', 'd1b0b4984577f1c2ef2bb586e8d0cf63da3c421412620e6e8ecf2159649c4db4eeacc556b3e87665', 'ROLE_TASK_REVIEWER', '1', 'reviewer6', null, null);
INSERT INTO `user` VALUES ('8', '1493951450', '1493951450', '7dcc786a6dd09ba99babc895c66e21a938aeb9f0d29ada0addbc8601ca2b3f6ef7de27a47632ebe2', 'ROLE_TASK_REVIEWER', '1', 'reviewer7', null, null);
INSERT INTO `user` VALUES ('9', '1493951454', '1493951454', '340ea2eac052f03b7af883e8972653cd354c78e3549f1947c0c3b03e09a64378b9847e6ee6ebc87a', 'ROLE_TASK_REVIEWER', '1', 'reviewer8', null, null);

-- ----------------------------
-- Table structure for `user_task`
-- ----------------------------
DROP TABLE IF EXISTS `user_task`;
CREATE TABLE `user_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `app_id` varchar(20) NOT NULL COMMENT '用户来源app',
  `app_user_id` varchar(32) NOT NULL COMMENT '用户在来源app中user_id',
  `city_id` bigint(20) unsigned DEFAULT NULL COMMENT '城市id',
  `completed_time` int(10) unsigned DEFAULT NULL COMMENT '任务完成时间',
  `created_time` int(10) unsigned DEFAULT NULL COMMENT '创建时间',
  `images` varchar(1000) DEFAULT NULL COMMENT '用户完成任务图片',
  `modified_time` int(10) unsigned DEFAULT NULL COMMENT '修改时间',
  `note` varchar(200) DEFAULT NULL COMMENT '用户完成任务留言',
  `price` decimal(6,2) unsigned NOT NULL COMMENT '任务单价',
  `province_id` bigint(20) unsigned DEFAULT NULL COMMENT '省份id',
  `review_end_time` int(10) unsigned DEFAULT NULL COMMENT '审核截至时间',
  `reviewed_time` int(10) unsigned DEFAULT NULL COMMENT '任务审核时间',
  `reviewer_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '审核用户id',
  `status` tinyint(2) unsigned NOT NULL COMMENT '任务进度',
  `task_end_time` int(10) unsigned NOT NULL COMMENT '任务结束时间',
  `task_id` bigint(20) unsigned NOT NULL COMMENT '任务id',
  `task_name` varchar(100) NOT NULL COMMENT '任务名称',
  `task_type_name` varchar(100) NOT NULL COMMENT '任务类型名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_task
-- ----------------------------
INSERT INTO `user_task` VALUES ('1', '1', '9822438', null, '1494296247', '1494296112', '1.jpg,2.jpg', '1494296292', '', '19.89', null, '3641779047', '1494296292', '7', '2', '1503780500', '1', '评论快去', '淘宝评论');
INSERT INTO `user_task` VALUES ('2', '1', '98224383', null, null, '1494296186', null, '1494296186', null, '19.89', null, null, null, null, '0', '1503780500', '1', '评论快去', '淘宝评论');
INSERT INTO `user_task` VALUES ('3', '1', '12345', null, null, '1494296192', null, '1494296192', null, '19.89', null, null, null, null, '0', '1503780500', '1', '评论快去', '淘宝评论');
INSERT INTO `user_task` VALUES ('4', '1', '45678', null, null, '1494296199', null, '1494296199', null, '19.89', null, null, null, null, '0', '1503780500', '1', '评论快去', '淘宝评论');
INSERT INTO `user_task` VALUES ('5', '1', '1234567', null, null, '1494296204', null, '1494296204', null, '19.89', null, null, null, null, '0', '1503780500', '1', '评论快去', '淘宝评论');
INSERT INTO `user_task` VALUES ('6', '2', '421aa32', null, '1494319047', '1494318495', '1.jpg,2.jpg', '1494319123', '', '19.89', null, '3641801847', '1494319123', '4', '2', '1503780500', '5', '我的任务', '微信群');
INSERT INTO `user_task` VALUES ('7', '4', '123123', null, null, '1494394647', null, '1494394647', null, '19.89', null, null, null, null, '0', '1503780500', '5', '我的任务', '微信群');
INSERT INTO `user_task` VALUES ('8', '4', '111111', null, '1494394854', '1494394661', '1.jpg,2.jpg', '1494395327', '', '19.89', null, '3641877654', '1494395327', '3', '2', '1503780500', '5', '我的任务', '微信群');
INSERT INTO `user_task` VALUES ('9', '4', '55555', null, '1494394842', '1494394669', '1.jpg,2.jpg', '1494395406', '', '19.89', null, '3641877642', '1494395406', '2', '2', '1503780500', '5', '我的任务', '微信群');
INSERT INTO `user_task` VALUES ('10', '4', '55555', null, '1494394945', '1494394691', '1.jpg,2.jpg', '1494395362', '', '19.89', null, '3641877745', '1494395362', '3', '3', '1503780500', '14', '我的任务', '微信群');
INSERT INTO `user_task` VALUES ('11', '4', '123123', null, '1494394934', '1494394696', '1.jpg,2.jpg', '1494395415', '', '19.89', null, '3641877734', '1494395415', '2', '2', '1503780500', '14', '我的任务', '微信群');
INSERT INTO `user_task` VALUES ('12', '4', '56422334', null, '1494394928', '1494394701', '1.jpg,2.jpg', '1494395482', '', '19.89', null, '3641877728', '1494395482', '5', '2', '1503780500', '14', '我的任务', '微信群');
INSERT INTO `user_task` VALUES ('13', '4', '8888888', null, '1494394955', '1494394707', '1.jpg,2.jpg', '1494395432', '', '19.89', null, '3641877755', '1494395432', '2', '3', '1503780500', '14', '我的任务', '微信群');
INSERT INTO `user_task` VALUES ('14', '4', '8888888', null, '1494394816', '1494394713', '1.jpg,2.jpg', '1494395492', '', '19.89', null, '3641877616', '1494395492', '5', '2', '1503780500', '16', '我的任务', '微信群');
INSERT INTO `user_task` VALUES ('15', '4', '11111', null, '1494394872', '1494394717', '1.jpg,2.jpg', '1494395496', '', '19.89', null, '3641877672', '1494395496', '5', '2', '1503780500', '16', '我的任务', '微信群');
INSERT INTO `user_task` VALUES ('16', '4', '22221', null, '1494394905', '1494394722', '1.jpg,2.jpg', '1494394905', '', '19.89', null, '3641877705', null, '6', '1', '1503780500', '16', '我的任务', '微信群');
INSERT INTO `user_task` VALUES ('17', '4', '33222', null, '1494394881', '1494394725', '1.jpg,2.jpg', '1494395440', '', '19.89', null, '3641877681', '1494395440', '2', '3', '1503780500', '16', '我的任务', '微信群');
INSERT INTO `user_task` VALUES ('18', '4', '655332', null, '1494394914', '1494394728', '1.jpg,2.jpg', '1494395445', '', '19.89', null, '3641877714', '1494395445', '2', '2', '1503780500', '16', '我的任务', '微信群');
INSERT INTO `user_task` VALUES ('19', '3', '111111', null, '1494395929', '1494395728', '1.jpg,2.jpg', '1494396149', '', '19.89', null, '3641878729', '1494396149', '5', '2', '1503780500', '21', '我的任务111', '微信群');
INSERT INTO `user_task` VALUES ('20', '3', '111111', null, '1494395931', '1494395735', '1.jpg,2.jpg', '1494396234', '', '19.89', null, '3641878731', '1494396234', '2', '2', '1503780500', '22', '我的任务111', '微信群');
INSERT INTO `user_task` VALUES ('21', '3', '111111', null, '1494395932', '1494395739', '1.jpg,2.jpg', '1494396199', '', '19.89', null, '3641878732', '1494396199', '4', '3', '1503780500', '23', '我的任务111', '微信群');
INSERT INTO `user_task` VALUES ('22', '3', '111111', null, '1494395938', '1494395744', '1.jpg,2.jpg', '1494396153', '', '19.89', null, '3641878738', '1494396153', '5', '2', '1503780500', '24', '我的任务111', '微信群');
INSERT INTO `user_task` VALUES ('23', '3', '22', null, '1494395968', '1494395753', '1.jpg,2.jpg', '1494395968', '', '19.89', null, '3641878768', null, '7', '1', '1503780500', '24', '我的任务111', '微信群');
INSERT INTO `user_task` VALUES ('24', '3', '22', null, '1494395970', '1494395756', '1.jpg,2.jpg', '1494396084', '', '19.89', null, '3641878770', '1494396084', '3', '2', '1503780500', '23', '我的任务111', '微信群');
INSERT INTO `user_task` VALUES ('25', '3', '22', null, '1494395971', '1494395760', '1.jpg,2.jpg', '1494396190', '', '19.89', null, '3641878771', '1494396190', '4', '3', '1503780500', '22', '我的任务111', '微信群');
INSERT INTO `user_task` VALUES ('26', '3', '22', null, '1494395972', '1494395762', '1.jpg,2.jpg', '1494395972', '', '19.89', null, '3641878772', null, '6', '1', '1503780500', '21', '我的任务111', '微信群');
INSERT INTO `user_task` VALUES ('27', '3', '33333', null, '1494395949', '1494395766', '1.jpg,2.jpg', '1494396158', '', '19.89', null, '3641878749', '1494396158', '5', '2', '1503780500', '21', '我的任务111', '微信群');
INSERT INTO `user_task` VALUES ('28', '3', '33333', null, '1494395950', '1494395768', '1.jpg,2.jpg', '1494396094', '', '19.89', null, '3641878750', '1494396094', '3', '2', '1503780500', '22', '我的任务111', '微信群');
INSERT INTO `user_task` VALUES ('29', '3', '33333', null, '1494395951', '1494395770', '1.jpg,2.jpg', '1494396096', '', '19.89', null, '3641878751', '1494396096', '3', '2', '1503780500', '23', '我的任务111', '微信群');
INSERT INTO `user_task` VALUES ('30', '3', '33333', null, '1494395955', '1494395771', '1.jpg,2.jpg', '1494396241', '', '19.89', null, '3641878755', '1494396241', '2', '3', '1503780500', '24', '我的任务111', '微信群');
INSERT INTO `user_task` VALUES ('31', '3', '91872', null, null, '1494395781', null, '1494395781', null, '19.89', null, null, null, null, '0', '1503780500', '21', '我的任务111', '微信群');
INSERT INTO `user_task` VALUES ('32', '3', '91872', null, null, '1494395783', null, '1494395783', null, '19.89', null, null, null, null, '0', '1503780500', '22', '我的任务111', '微信群');
INSERT INTO `user_task` VALUES ('33', '3', '191872', null, null, '1494395787', null, '1494395787', null, '19.89', null, null, null, null, '0', '1503780500', '22', '我的任务111', '微信群');
INSERT INTO `user_task` VALUES ('34', '3', '1191872', null, null, '1494395795', null, '1494395795', null, '19.89', null, null, null, null, '0', '1503780500', '24', '我的任务111', '微信群');
INSERT INTO `user_task` VALUES ('35', '3', '1191872', null, null, '1494395797', null, '1494395797', null, '19.89', null, null, null, null, '0', '1503780500', '21', '我的任务111', '微信群');

-- ----------------------------
-- Table structure for `user_task_log`
-- ----------------------------
DROP TABLE IF EXISTS `user_task_log`;
CREATE TABLE `user_task_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `created_time` int(10) unsigned DEFAULT NULL COMMENT '创建时间',
  `from_status` tinyint(2) unsigned NOT NULL COMMENT '操作前任务进度',
  `operator_app_id` varchar(20) DEFAULT NULL COMMENT '操作用户来源app',
  `operator_app_user_id` varchar(32) DEFAULT NULL COMMENT '操作用户在来源app中user_id',
  `operator_user_id` bigint(20) unsigned DEFAULT NULL COMMENT '操作用户',
  `to_status` tinyint(2) unsigned NOT NULL COMMENT '操作后任务进度',
  `user_task_id` bigint(20) unsigned NOT NULL COMMENT '用户任务id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_task_log
-- ----------------------------
INSERT INTO `user_task_log` VALUES ('1', '1494296112', '0', '1', '9822438', null, '0', '1');
INSERT INTO `user_task_log` VALUES ('2', '1494296186', '0', '1', '98224383', null, '0', '2');
INSERT INTO `user_task_log` VALUES ('3', '1494296192', '0', '1', '12345', null, '0', '3');
INSERT INTO `user_task_log` VALUES ('4', '1494296199', '0', '1', '45678', null, '0', '4');
INSERT INTO `user_task_log` VALUES ('5', '1494296204', '0', '1', '1234567', null, '0', '5');
INSERT INTO `user_task_log` VALUES ('6', '1494296247', '0', '1', '9822438', null, '1', '1');
INSERT INTO `user_task_log` VALUES ('7', '1494296247', '1', null, null, '1', '2', '1');
INSERT INTO `user_task_log` VALUES ('8', '1494318495', '0', '2', '421aa32', null, '0', '6');
INSERT INTO `user_task_log` VALUES ('9', '1494318527', '0', '2', '421aa32', null, '1', '6');
INSERT INTO `user_task_log` VALUES ('10', '1494318527', '1', null, null, '2', '4', '6');
INSERT INTO `user_task_log` VALUES ('11', '1494319047', '4', '2', '421aa32', null, '1', '6');
INSERT INTO `user_task_log` VALUES ('12', '1494319047', '1', null, null, '4', '2', '6');
INSERT INTO `user_task_log` VALUES ('13', '1494394647', '0', '4', '123123', null, '0', '7');
INSERT INTO `user_task_log` VALUES ('14', '1494394661', '0', '4', '111111', null, '0', '8');
INSERT INTO `user_task_log` VALUES ('15', '1494394669', '0', '4', '55555', null, '0', '9');
INSERT INTO `user_task_log` VALUES ('16', '1494394691', '0', '4', '55555', null, '0', '10');
INSERT INTO `user_task_log` VALUES ('17', '1494394696', '0', '4', '123123', null, '0', '11');
INSERT INTO `user_task_log` VALUES ('18', '1494394701', '0', '4', '56422334', null, '0', '12');
INSERT INTO `user_task_log` VALUES ('19', '1494394707', '0', '4', '8888888', null, '0', '13');
INSERT INTO `user_task_log` VALUES ('20', '1494394713', '0', '4', '8888888', null, '0', '14');
INSERT INTO `user_task_log` VALUES ('21', '1494394717', '0', '4', '11111', null, '0', '15');
INSERT INTO `user_task_log` VALUES ('22', '1494394722', '0', '4', '22221', null, '0', '16');
INSERT INTO `user_task_log` VALUES ('23', '1494394725', '0', '4', '33222', null, '0', '17');
INSERT INTO `user_task_log` VALUES ('24', '1494394728', '0', '4', '655332', null, '0', '18');
INSERT INTO `user_task_log` VALUES ('25', '1494394816', '0', '4', '8888888', null, '1', '14');
INSERT INTO `user_task_log` VALUES ('26', '1494394842', '0', '4', '55555', null, '1', '9');
INSERT INTO `user_task_log` VALUES ('27', '1494394854', '0', '4', '111111', null, '1', '8');
INSERT INTO `user_task_log` VALUES ('28', '1494394872', '0', '4', '11111', null, '1', '15');
INSERT INTO `user_task_log` VALUES ('29', '1494394881', '0', '4', '33222', null, '1', '17');
INSERT INTO `user_task_log` VALUES ('30', '1494394905', '0', '4', '22221', null, '1', '16');
INSERT INTO `user_task_log` VALUES ('31', '1494394914', '0', '4', '655332', null, '1', '18');
INSERT INTO `user_task_log` VALUES ('32', '1494394928', '0', '4', '56422334', null, '1', '12');
INSERT INTO `user_task_log` VALUES ('33', '1494394934', '0', '4', '123123', null, '1', '11');
INSERT INTO `user_task_log` VALUES ('34', '1494394945', '0', '4', '55555', null, '1', '10');
INSERT INTO `user_task_log` VALUES ('35', '1494394955', '0', '4', '8888888', null, '1', '13');
INSERT INTO `user_task_log` VALUES ('36', '1494394854', '1', null, null, '3', '2', '8');
INSERT INTO `user_task_log` VALUES ('37', '1494394945', '1', null, null, '3', '3', '10');
INSERT INTO `user_task_log` VALUES ('38', '1494394842', '1', null, null, '2', '2', '9');
INSERT INTO `user_task_log` VALUES ('39', '1494394934', '1', null, null, '2', '2', '11');
INSERT INTO `user_task_log` VALUES ('40', '1494394955', '1', null, null, '2', '3', '13');
INSERT INTO `user_task_log` VALUES ('41', '1494394881', '1', null, null, '2', '3', '17');
INSERT INTO `user_task_log` VALUES ('42', '1494394914', '1', null, null, '2', '2', '18');
INSERT INTO `user_task_log` VALUES ('43', '1494394928', '1', null, null, '5', '2', '12');
INSERT INTO `user_task_log` VALUES ('44', '1494394816', '1', null, null, '5', '2', '14');
INSERT INTO `user_task_log` VALUES ('45', '1494394872', '1', null, null, '5', '2', '15');
INSERT INTO `user_task_log` VALUES ('46', '1494395728', '0', '3', '111111', null, '0', '19');
INSERT INTO `user_task_log` VALUES ('47', '1494395735', '0', '3', '111111', null, '0', '20');
INSERT INTO `user_task_log` VALUES ('48', '1494395739', '0', '3', '111111', null, '0', '21');
INSERT INTO `user_task_log` VALUES ('49', '1494395744', '0', '3', '111111', null, '0', '22');
INSERT INTO `user_task_log` VALUES ('50', '1494395753', '0', '3', '22', null, '0', '23');
INSERT INTO `user_task_log` VALUES ('51', '1494395756', '0', '3', '22', null, '0', '24');
INSERT INTO `user_task_log` VALUES ('52', '1494395760', '0', '3', '22', null, '0', '25');
INSERT INTO `user_task_log` VALUES ('53', '1494395762', '0', '3', '22', null, '0', '26');
INSERT INTO `user_task_log` VALUES ('54', '1494395766', '0', '3', '33333', null, '0', '27');
INSERT INTO `user_task_log` VALUES ('55', '1494395768', '0', '3', '33333', null, '0', '28');
INSERT INTO `user_task_log` VALUES ('56', '1494395770', '0', '3', '33333', null, '0', '29');
INSERT INTO `user_task_log` VALUES ('57', '1494395771', '0', '3', '33333', null, '0', '30');
INSERT INTO `user_task_log` VALUES ('58', '1494395781', '0', '3', '91872', null, '0', '31');
INSERT INTO `user_task_log` VALUES ('59', '1494395783', '0', '3', '91872', null, '0', '32');
INSERT INTO `user_task_log` VALUES ('60', '1494395787', '0', '3', '191872', null, '0', '33');
INSERT INTO `user_task_log` VALUES ('61', '1494395795', '0', '3', '1191872', null, '0', '34');
INSERT INTO `user_task_log` VALUES ('62', '1494395797', '0', '3', '1191872', null, '0', '35');
INSERT INTO `user_task_log` VALUES ('63', '1494395929', '0', '3', '111111', null, '1', '19');
INSERT INTO `user_task_log` VALUES ('64', '1494395931', '0', '3', '111111', null, '1', '20');
INSERT INTO `user_task_log` VALUES ('65', '1494395932', '0', '3', '111111', null, '1', '21');
INSERT INTO `user_task_log` VALUES ('66', '1494395938', '0', '3', '111111', null, '1', '22');
INSERT INTO `user_task_log` VALUES ('67', '1494395949', '0', '3', '33333', null, '1', '27');
INSERT INTO `user_task_log` VALUES ('68', '1494395950', '0', '3', '33333', null, '1', '28');
INSERT INTO `user_task_log` VALUES ('69', '1494395951', '0', '3', '33333', null, '1', '29');
INSERT INTO `user_task_log` VALUES ('70', '1494395955', '0', '3', '33333', null, '1', '30');
INSERT INTO `user_task_log` VALUES ('71', '1494395968', '0', '3', '22', null, '1', '23');
INSERT INTO `user_task_log` VALUES ('72', '1494395970', '0', '3', '22', null, '1', '24');
INSERT INTO `user_task_log` VALUES ('73', '1494395971', '0', '3', '22', null, '1', '25');
INSERT INTO `user_task_log` VALUES ('74', '1494395972', '0', '3', '22', null, '1', '26');
INSERT INTO `user_task_log` VALUES ('75', '1494395970', '1', null, null, '3', '2', '24');
INSERT INTO `user_task_log` VALUES ('76', '1494395950', '1', null, null, '3', '2', '28');
INSERT INTO `user_task_log` VALUES ('77', '1494395951', '1', null, null, '3', '2', '29');
INSERT INTO `user_task_log` VALUES ('78', '1494395929', '1', null, null, '5', '2', '19');
INSERT INTO `user_task_log` VALUES ('79', '1494395938', '1', null, null, '5', '2', '22');
INSERT INTO `user_task_log` VALUES ('80', '1494395949', '1', null, null, '5', '2', '27');
INSERT INTO `user_task_log` VALUES ('81', '1494395971', '1', null, null, '4', '3', '25');
INSERT INTO `user_task_log` VALUES ('82', '1494395932', '1', null, null, '4', '3', '21');
INSERT INTO `user_task_log` VALUES ('83', '1494395931', '1', null, null, '2', '2', '20');
INSERT INTO `user_task_log` VALUES ('84', '1494395955', '1', null, null, '2', '3', '30');
