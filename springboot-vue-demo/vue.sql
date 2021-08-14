/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : localhost:3306
 Source Schema         : vue

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 14/08/2021 11:49:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, 'Java入门到入土', 99.00, 'java之父', '2021-08-12 16:00:00', 'http://localhost:9090/files/be110f51354c4a8a8fc42a47696acaa8');
INSERT INTO `book` VALUES (2, '123', 123.00, '123', '2021-08-01 16:00:00', 'http://localhost:9090/files/fb04aca305d441e9b7f2f85f3600e17c');
INSERT INTO `book` VALUES (3, 'php', 1.00, 'xxx', '2021-07-31 16:00:00', 'http://localhost:9090/files/71c6e6a8e1014a329eb7ccb8fd7534cc');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (1, '1', NULL, '1', '2021-07-31 16:00:00');
INSERT INTO `news` VALUES (2, '2', NULL, '2', '2021-08-01 16:00:00');
INSERT INTO `news` VALUES (3, '3', NULL, '3', '2021-08-02 16:00:00');
INSERT INTO `news` VALUES (4, '哈哈哈', '<p>1234</p><p><br/></p><p>撒发送</p>', '234', '2021-08-03 16:00:00');
INSERT INTO `news` VALUES (5, 'test', '<p>ces<img src=\"https://img2.baidu.com/it/u=3663359702,1992818410&amp;fm=26&amp;fmt=auto&amp;gp=0.jpg\" contenteditable=\"false\" style=\"color: var(--el-text-color-regular); font-size: var(--el-dialog-content-font-size); max-width: 100%;\"/></p>', '小文', '2021-08-13 06:03:46');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `age` int(0) NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `role` int(0) NULL DEFAULT NULL COMMENT '1.管理员，2.普通用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (2, '2', NULL, '哈哈', 1, '女', '1', 2);
INSERT INTO `user` VALUES (4, '4', '214', '4', 4, '男', '啊实打实', 2);
INSERT INTO `user` VALUES (5, '5', '5', '5', 5, '男', '5', 2);
INSERT INTO `user` VALUES (6, '6', '123456', '小六子', 6, '男', '6', 2);
INSERT INTO `user` VALUES (7, '7', '123456', '7', 7, '女', '7', 2);
INSERT INTO `user` VALUES (8, '8', '123456', '8', 8, '男', '8', 2);
INSERT INTO `user` VALUES (9, '9', '123456', '9', 9, '女', '9', 2);
INSERT INTO `user` VALUES (10, '10', '123456', '10', 12, '女', '121', 2);
INSERT INTO `user` VALUES (11, '11', '123456', '11', 11, '男', '11', 2);
INSERT INTO `user` VALUES (12, 'root', 'root', '小文', 18, '男', '大重庆', 1);
INSERT INTO `user` VALUES (13, 'HAHA', '123456', 'OO', 12, '男', '1212', 2);
INSERT INTO `user` VALUES (14, 'EEE', '123456', 'EE', 90, '男', 'GH', 2);
INSERT INTO `user` VALUES (15, 'aa', '123456', 'asd', 1, '未知', 'asd', 2);

SET FOREIGN_KEY_CHECKS = 1;
