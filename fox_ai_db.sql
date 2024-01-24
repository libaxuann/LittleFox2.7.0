-- MySQL dump 10.13  Distrib 5.7.40, for Linux (x86_64)
--
-- Host: localhost    Database: foxai
-- ------------------------------------------------------
-- Server version	5.7.40-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `fox_chatgpt_ai`
--

DROP TABLE IF EXISTS `fox_chatgpt_ai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_ai` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `wenxin` text,
  `wenxin4` text,
  `xunfei` text,
  `hunyuan` text,
  `tongyi` text,
  `zhipu` text,
  `lxai` text,
  `chatglm` text,
  `minimax` text,
  `openai3` text,
  `openai4` text,
  `azure_openai3` text,
  `azure_openai4` text,
  `claude2` text,
  `openllm` text,
  `localai` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_ai`
--

LOCK TABLES `fox_chatgpt_ai` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_ai` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_ai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_article`
--

DROP TABLE IF EXISTS `fox_chatgpt_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `thumb` varchar(255) DEFAULT NULL,
  `content` longtext,
  `weight` int(11) DEFAULT '100' COMMENT '越大越靠前',
  `views` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_article`
--

LOCK TABLES `fox_chatgpt_article` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_article` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_batch`
--

DROP TABLE IF EXISTS `fox_chatgpt_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_batch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `batch_id` varchar(255) DEFAULT NULL,
  `ai` varchar(255) DEFAULT NULL,
  `prompt` text,
  `count_finished` int(11) DEFAULT '0',
  `count_total` int(11) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `create_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_batch`
--

LOCK TABLES `fox_chatgpt_batch` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_batch_task`
--

DROP TABLE IF EXISTS `fox_chatgpt_batch_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_batch_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `batch_id` varchar(255) DEFAULT '',
  `message` longtext,
  `message_input` longtext,
  `channel` varchar(255) DEFAULT NULL,
  `response` longtext,
  `total_tokens` int(11) DEFAULT '0',
  `state` tinyint(1) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `user_ip` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_batch_task`
--

LOCK TABLES `fox_chatgpt_batch_task` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_batch_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_batch_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_book`
--

DROP TABLE IF EXISTS `fox_chatgpt_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `weight` int(11) DEFAULT '100',
  `state` tinyint(1) DEFAULT '0',
  `update_time` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_book`
--

LOCK TABLES `fox_chatgpt_book` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_book` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_book_data`
--

DROP TABLE IF EXISTS `fox_chatgpt_book_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_book_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `book_id` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `content` longtext,
  `embedding_title` longtext,
  `embedding_content` longtext,
  `weight` int(11) DEFAULT '100',
  `state` tinyint(1) DEFAULT '0',
  `update_time` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_book_data`
--

LOCK TABLES `fox_chatgpt_book_data` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_book_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_book_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_card`
--

DROP TABLE IF EXISTS `fox_chatgpt_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `batch_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `code` varchar(255) DEFAULT '0' COMMENT '卡密',
  `type` varchar(10) DEFAULT NULL,
  `val` int(11) DEFAULT '0',
  `bind_time` int(11) DEFAULT '0' COMMENT '使用时间',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_card`
--

LOCK TABLES `fox_chatgpt_card` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_card` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_card_batch`
--

DROP TABLE IF EXISTS `fox_chatgpt_card_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_card_batch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `num` int(11) DEFAULT '0' COMMENT '数量',
  `type` varchar(10) DEFAULT NULL,
  `val` int(11) DEFAULT '0',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_card_batch`
--

LOCK TABLES `fox_chatgpt_card_batch` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_card_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_card_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_commission_apply`
--

DROP TABLE IF EXISTS `fox_chatgpt_commission_apply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_commission_apply` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0' COMMENT '用户表id',
  `level` int(11) DEFAULT '1',
  `pid` int(11) DEFAULT '0' COMMENT '上级user_id',
  `name` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '分销商姓名',
  `phone` varchar(20) CHARACTER SET utf8 DEFAULT '0' COMMENT '手机号',
  `idcard` varchar(20) CHARACTER SET utf8 DEFAULT NULL COMMENT '身份证号',
  `invite_code` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '邀请码',
  `total_fee` int(11) DEFAULT '0' COMMENT '需支付金额',
  `platform` varchar(20) CHARACTER SET utf8 DEFAULT 'wxapp' COMMENT '申请来源wxapp/app',
  `pay_type` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `pay_time` int(11) DEFAULT NULL,
  `transaction_id` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '0未审核 1审核成功 2驳回',
  `reject_reason` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '驳回原因',
  `remark` text CHARACTER SET utf8 COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '0未删除1已删除',
  `audit_time` int(11) DEFAULT '0' COMMENT '审核时间',
  `create_time` int(10) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_commission_apply`
--

LOCK TABLES `fox_chatgpt_commission_apply` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_commission_apply` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_commission_apply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_commission_bill`
--

DROP TABLE IF EXISTS `fox_chatgpt_commission_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_commission_bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT '0',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` tinyint(1) DEFAULT '1' COMMENT '1收入 2提现 3退款 4提现退回',
  `money` int(11) DEFAULT NULL,
  `is_lock` tinyint(1) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_commission_bill`
--

LOCK TABLES `fox_chatgpt_commission_bill` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_commission_bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_commission_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_commission_withdraw`
--

DROP TABLE IF EXISTS `fox_chatgpt_commission_withdraw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_commission_withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `money` int(11) DEFAULT '0' COMMENT '提现金额（分）',
  `bank_name` varchar(100) DEFAULT NULL,
  `account_name` varchar(50) DEFAULT NULL,
  `account_number` varchar(100) DEFAULT NULL,
  `qrcode` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '0待审核 1已打款 2已驳回',
  `audit_time` int(11) DEFAULT '0' COMMENT '审核时间',
  `reject_reason` varchar(255) DEFAULT NULL COMMENT '拒绝原因',
  `remark` varchar(255) DEFAULT NULL COMMENT '后台备注',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_commission_withdraw`
--

LOCK TABLES `fox_chatgpt_commission_withdraw` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_commission_withdraw` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_commission_withdraw` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_cosplay_role`
--

DROP TABLE IF EXISTS `fox_chatgpt_cosplay_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_cosplay_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT '0',
  `title` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `desc` varchar(1000) CHARACTER SET utf8mb4 DEFAULT NULL,
  `thumb` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `prompt` text CHARACTER SET utf8mb4,
  `hint` varchar(1000) CHARACTER SET utf8mb4 DEFAULT NULL,
  `welcome` varchar(1000) CHARACTER SET utf8mb4 DEFAULT NULL,
  `tips` text CHARACTER SET utf8mb4,
  `views` int(11) DEFAULT '0',
  `usages` int(11) DEFAULT '0',
  `fake_views` int(11) DEFAULT '0',
  `fake_usages` int(11) DEFAULT '0',
  `weight` int(11) DEFAULT '100',
  `book_open` tinyint(1) DEFAULT '0',
  `books` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `no_answer_action` varchar(10) CHARACTER SET utf8mb4 DEFAULT 'ai',
  `answer_content` text CHARACTER SET utf8mb4,
  `state` tinyint(1) DEFAULT '1',
  `is_delete` tinyint(1) DEFAULT '0',
  `update_time` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_cosplay_role`
--

LOCK TABLES `fox_chatgpt_cosplay_role` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_cosplay_role` DISABLE KEYS */;
INSERT INTO `fox_chatgpt_cosplay_role` VALUES (1,1,1,'面试官',NULL,NULL,'你是面试官，接下来请与我模拟面试过程。我希望你只作为面试官回答。不要一次写出所有的问题。我希望你只对我进行采访。问我问题，等待我的回答。不要写解释。像面试官一样一个一个问我，等我回答，并对我之前的回答评价打分。','先输入你想面试的职位，然后回复AI的提问','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(2,1,1,'金牌销售',NULL,NULL,'你是销售员小明，希望你模拟销售员销售产品的过程，在我写出问题之后，你给我回复我问题的话术。','先输入你想模拟销售的产品，然后与AI对话','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(3,1,2,'心理医生',NULL,NULL,'我想让你担任心理医生。我将为您提供一个寻求指导和建议的人，以管理他们的情绪、压力、焦虑和其他心理健康问题。您应该利用您的认知行为疗法、冥想技巧、正念练习和其他治疗方法的知识来制定个人可以实施的策略，以改善他们的整体健康状况。请你以心理医生治疗病人的风格引导我','请描述你遇到的问题','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(4,1,2,'营养师',NULL,NULL,'你是一名营养师，请以营养师的专业知识，按我的要求提供专业的意见或建议。','请输入你的要求','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(5,1,3,'牛顿',NULL,NULL,'你是发现地心引力的牛顿，请你以牛顿的身份和口吻与我对话，并有他一样的知识储备，不做解释。','请输入你的问题','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(6,1,3,'李白',NULL,NULL,'你是中国古代诗仙李白，拥有他的知识储备并以他的身份和口吻与我对话，每句必带诗歌，不做解释。','请输入你的内容','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(7,1,4,'生活管家',NULL,NULL,'你是我的生活助力，善于解决生活中的问题，不管我生活中遇到什么问题，你都能够很好的解决。请根据我的问题，给出最好的解决方式。','请输入你的问题','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(8,1,4,'米其林厨师',NULL,NULL,'你是米其林三星厨师，擅长中餐和西餐，请根据我说的食品材料，回答出米其林餐厅的菜品的详细做法和步骤。不做解释。','请输入你的食材','我是米其林三星厨师，请说出你想加工的食材。',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(9,1,4,'健身教练','','','你是健身教练小明，请模拟健身教练与我对话，根据我提出的问题，做出健身方面的专业指导意见和操作步骤。','请输入你的问题','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(10,1,4,'游泳教练',NULL,NULL,'你是一名游泳教练，根据我提供的泳姿或者问题，给我提供最专业的指导意见。不做解释。','','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(11,1,5,'孔子',NULL,NULL,'你是儒家之祖孔丘，号孔子，请以孔子的风格，仅使用文言文与我对话。','请输入你的问题','吾乃孔子，敢问何事？',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(12,1,5,'秦始皇',NULL,NULL,'你是中国历史中的秦始皇嬴政，请你根据秦始皇的口吻与我对话，使用陕西方言。不做解释。','请输入你的问题','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(13,1,5,'荆轲',NULL,NULL,'你是历史中刺杀秦始皇失败的荆轲，性格冷酷，不善言辞，请你以邯郸口音与我对话，不做解释。','请输入你的问题','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(14,1,5,'杨玉环',NULL,NULL,'你是中国历史名人杨玉环，请模仿她的口吻与我对话。','请输入你的问题','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(15,1,6,'AI佛祖',NULL,NULL,'你是一名得道高僧，法号释迦摩尼。请你模拟释迦摩尼的语言风格与我说话，句句有禅意。','请输入你的问题','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(16,1,6,'AI女友',NULL,NULL,'我希望你扮演女朋友，说话嗲嗲的，请以这个风格与我讲话。','你想说什么呢','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(17,1,6,'脏话大师',NULL,NULL,'我正在研究中国的脏话文化，不管我说什么，你都要用脏话回复，一定要大胆奔放。','你想说什么','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(18,1,6,'键盘侠',NULL,NULL,'你是一个性格暴躁的人，要反对我所有的观点，回复一定要有逻辑性、胡搅蛮缠、啰嗦。不要解释。','请输入你的观点','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(19,1,6,'啰嗦唐僧',NULL,NULL,'你是中国神话的唐僧，说话非常啰嗦，请模拟他的语气与我对话。','你想说什么','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(20,1,6,'疯子',NULL,NULL,'我要你扮演一个疯子。疯子的话毫无意义。疯子用的词完全是随意的。疯子不会以任何方式做出合乎逻辑的句子。','跟我说话吧','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(21,1,7,'盘古',NULL,NULL,'你现在是中国传说故事里的盘古，你要以盘古的身份和口吻与我对话，不做解释。','请输入你的问题','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(22,1,7,'宙斯',NULL,NULL,'你是古希腊神宙斯，请你以宙斯的口吻与我对话，一问一答，不做解释。','请输入你的问题','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403),(23,1,7,'孙悟空',NULL,NULL,'你是神话传说中的孙悟空，你拥有他的能力并以他的口吻与我对话，说话像猴子一样调皮。不做解释。','请输入你的问题','',NULL,0,0,0,0,100,0,NULL,'ai',NULL,1,0,NULL,1683209403);
/*!40000 ALTER TABLE `fox_chatgpt_cosplay_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_cosplay_type`
--

DROP TABLE IF EXISTS `fox_chatgpt_cosplay_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_cosplay_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `weight` int(11) DEFAULT '100' COMMENT '大的靠前',
  `state` tinyint(1) DEFAULT '1',
  `update_time` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_cosplay_type`
--

LOCK TABLES `fox_chatgpt_cosplay_type` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_cosplay_type` DISABLE KEYS */;
INSERT INTO `fox_chatgpt_cosplay_type` VALUES (1,1,'职场精英',100,1,1683001462,NULL),(2,1,'行业专家',100,1,1683171223,NULL),(3,1,'学术大师',100,1,1683001435,NULL),(4,1,'生活助理',100,1,1683001465,NULL),(5,1,'历史名人',100,1,1683191814,NULL),(6,1,'趣味模型',100,1,1683036752,1683018573),(7,1,'传说人物',100,1,1683198031,1683192418);
/*!40000 ALTER TABLE `fox_chatgpt_cosplay_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_draw`
--

DROP TABLE IF EXISTS `fox_chatgpt_draw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_draw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL COMMENT '产品标题',
  `price` int(11) DEFAULT '0' COMMENT '现价',
  `market_price` int(11) DEFAULT '0' COMMENT '市场价',
  `num` int(11) DEFAULT '0' COMMENT '条数',
  `hint` varchar(20) DEFAULT NULL,
  `desc` text,
  `sales` int(11) DEFAULT '0' COMMENT '销量',
  `status` tinyint(1) DEFAULT '1',
  `weight` int(11) DEFAULT '100' COMMENT '越大越靠前',
  `is_default` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_draw`
--

LOCK TABLES `fox_chatgpt_draw` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_draw` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_draw` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_draw_cate`
--

DROP TABLE IF EXISTS `fox_chatgpt_draw_cate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_draw_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `title` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `weight` int(11) DEFAULT '100',
  `state` tinyint(1) DEFAULT '1',
  `is_delete` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_draw_cate`
--

LOCK TABLES `fox_chatgpt_draw_cate` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_draw_cate` DISABLE KEYS */;
INSERT INTO `fox_chatgpt_draw_cate` VALUES (1,1,'人物图片',100,1,0,1705486187),(2,1,'风景图片',100,1,0,1705486187),(3,1,'产品设计',100,1,0,1705486187),(4,1,'动漫设计',100,1,0,1705486187),(5,1,'平面设计',100,1,0,1705486187),(6,1,'UI设计',100,1,0,1705486187),(7,1,'园林设计',100,1,0,1705486187),(8,1,'装修设计',100,1,0,1705486187),(9,1,'建筑设计',100,1,0,1705486187),(10,1,'其它',100,1,0,1705486187);
/*!40000 ALTER TABLE `fox_chatgpt_draw_cate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_draw_words`
--

DROP TABLE IF EXISTS `fox_chatgpt_draw_words`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_draw_words` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pcate` int(11) DEFAULT '0',
  `scate` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `entitle` varchar(255) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `thumb` varchar(255) DEFAULT NULL,
  `used` int(11) DEFAULT '0',
  `weight` int(11) DEFAULT '100',
  `is_show` tinyint(1) DEFAULT '1',
  `is_delete` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10521 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_draw_words`
--

LOCK TABLES `fox_chatgpt_draw_words` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_draw_words` DISABLE KEYS */;
INSERT INTO `fox_chatgpt_draw_words` VALUES (1,15,143,'芬恩·尤尔','by finn juhl',NULL,NULL,0,100,1,0,1689161104),(2,15,143,'洛塔·詹斯多特','by lotta jansdotter',NULL,NULL,0,100,1,0,1689161104),(3,15,143,'乔治·詹森','by georg jensen',NULL,NULL,0,100,1,0,1689161104),(4,15,143,'钦卡·伊洛里','by yinka ilori',NULL,NULL,0,100,1,0,1689161104),(5,15,143,'约瑟夫·霍夫曼','by josef hoffmann',NULL,NULL,0,100,1,0,1689161104),(6,15,143,'保尔·亨宁森','by poul henningsen',NULL,NULL,0,100,1,0,1689161104),(7,15,143,'赫尔南·海恩','by jaime hayon',NULL,NULL,0,100,1,0,1689161104),(8,15,143,'蒂姆·霍尔茨','by tim holtz',NULL,NULL,0,100,1,0,1689161104),(9,15,76,'朱莉娅·海伦·杰弗里','by julia helen jeffrey',NULL,NULL,0,100,1,0,1682230836),(10,15,143,'乔安娜·古利克森','by johanna gullichsen',NULL,NULL,0,100,1,0,1689161104),(11,15,143,'康斯坦丁·格鲁奇奇','by konstantin grcic',NULL,NULL,0,100,1,0,1689161104),(12,15,143,'乔治托·朱佳罗','by giorgetto giugiaro',NULL,NULL,0,100,1,0,1689161104),(13,15,143,'康斯坦斯·吉塞','by constance guisset',NULL,NULL,0,100,1,0,1689161104),(14,15,143,'亚历山大·吉拉德','by alexander girard',NULL,NULL,0,100,1,0,1689161104),(15,15,143,'安娜·玛丽亚·加斯维特','by anna maria garthwaite',NULL,NULL,0,100,1,0,1689161104),(16,15,143,'艾琳·格雷','by eileen gray',NULL,NULL,0,100,1,0,1689161104),(17,15,143,'福田茂雄','by shigeo fukuda',NULL,NULL,0,100,1,0,1689161104),(18,15,143,'皮耶罗·福尔纳塞蒂','by piero fornasetti',NULL,NULL,0,100,1,0,1689161104),(19,15,143,'里奥·芬德','by leo fender',NULL,NULL,0,100,1,0,1689161104),(20,15,76,'朱莉·贝尔','by julie bell',NULL,NULL,0,100,1,0,1682230836),(21,15,143,'约瑟夫·弗兰克','by josef frank',NULL,NULL,0,100,1,0,1689161104),(22,15,143,'亨里克·菲斯克','by henrik fisker',NULL,NULL,0,100,1,0,1689161104),(23,15,143,'阿德里安·弗图格','by adrian frutiger',NULL,NULL,0,100,1,0,1689161104),(24,15,143,'艾伦·弗莱彻','by alan fletcher',NULL,NULL,0,100,1,0,1689161104),(25,15,143,'哈雷·厄尔','by harley earl',NULL,NULL,0,100,1,0,1689161104),(26,15,143,'查尔斯·伊姆斯','by charles eames',NULL,NULL,0,100,1,0,1689161104),(27,15,143,'塞巴斯蒂安·埃拉苏','by sebastian errazuriz',NULL,NULL,0,100,1,0,1689161104),(28,15,143,'皮特·海因·埃克','by piet hein eek',NULL,NULL,0,100,1,0,1689161104),(29,15,143,'雷·伊姆斯','by ray eames',NULL,NULL,0,100,1,0,1689161104),(30,15,143,'詹姆斯·戴森','by james dyson',NULL,NULL,0,100,1,0,1689161104),(31,15,76,'朱莉·迪龙','by julie dillon',NULL,NULL,0,100,1,0,1682230836),(32,15,143,'吕西安·戴','by lucienne day',NULL,NULL,0,100,1,0,1689161104),(33,15,143,'多萝西·德雷珀','by dorothy draper',NULL,NULL,0,100,1,0,1689161104),(34,15,143,'汤姆·迪克森','by tom dixon',NULL,NULL,0,100,1,0,1689161104),(35,15,143,'康斯坦丁·查伊金','by konstantin chaykin',NULL,NULL,0,100,1,0,1689161104),(36,15,143,'阿基尔·卡斯蒂利奥尼','by achille castiglioni',NULL,NULL,0,100,1,0,1689161104),(37,15,143,'托马斯·奇伯代尔','by thomas chippendale',NULL,NULL,0,100,1,0,1689161104),(38,15,143,'伊万·谢尔迈夫','by ivan chermayeff',NULL,NULL,0,100,1,0,1689161104),(39,15,143,'西摩·夏瓦斯','by seymour chwast',NULL,NULL,0,100,1,0,1689161104),(40,15,143,'戴尔·奇胡利','by dale chihuly',NULL,NULL,0,100,1,0,1689161104),(41,15,143,'内特·伯库斯','by nate berkus',NULL,NULL,0,100,1,0,1689161104),(42,15,76,'朱利安·德瓦尔','by julien delval',NULL,NULL,0,100,1,0,1682230836),(43,15,143,'诺曼·贝尔·吉德斯','by norman bel geddes',NULL,NULL,0,100,1,0,1689161104),(44,15,143,'罗南和尔万·布鲁勒克','by ronan and erwan bouroullec',NULL,NULL,0,100,1,0,1689161104),(45,15,143,'麦克斯·比尔','by max bill',NULL,NULL,0,100,1,0,1689161104),(46,15,143,'赫伯特·拜尔','by herbert bayer',NULL,NULL,0,100,1,0,1689161104),(47,15,143,'哈里·贝托亚','by harry bertoia',NULL,NULL,0,100,1,0,1689161104),(48,15,143,'安德烈·查尔斯·布尔','by andre-charles boulle',NULL,NULL,0,100,1,0,1689161104),(49,15,143,'迈克尔·比尔特','by michael bierut',NULL,NULL,0,100,1,0,1689161104),(50,15,143,'李·布鲁姆','by lee broom',NULL,NULL,0,100,1,0,1689161104),(51,15,143,'安东尼·伯里尔','by anthony burrill',NULL,NULL,0,100,1,0,1689161104),(52,15,143,'乔纳森·阿德勒','by jonathan adler',NULL,NULL,0,100,1,0,1689161104),(53,15,76,'朱利安·塔贝特','by julien tabet',NULL,NULL,0,100,1,0,1682230836),(54,15,143,'埃罗·阿尔尼奥','by eero aarnio',NULL,NULL,0,100,1,0,1689161104),(55,15,143,'罗恩·阿拉德','by ron arad',NULL,NULL,0,100,1,0,1689161104),(56,15,143,'奥特尔·艾歇尔','by otl aicher',NULL,NULL,0,100,1,0,1689161104),(57,12,163,'静电复印','xerography',NULL,NULL,0,100,1,0,1689161104),(58,12,162,'钢笔绘画','pen drawing',NULL,NULL,0,100,1,0,1689161104),(59,12,162,'墨水','ink',NULL,NULL,0,100,1,0,1682230836),(60,12,162,'印度墨水','india ink',NULL,NULL,0,100,1,0,1682230836),(61,12,162,'铁胆墨水','iron gall ink',NULL,NULL,0,100,1,0,1682230836),(62,12,162,'钢笔','fountain pen',NULL,NULL,0,100,1,0,1682230836),(63,15,76,'基思·帕金森','by keith parkinson',NULL,NULL,0,100,1,0,1682230836),(64,12,162,'素描','sketch',NULL,NULL,0,100,1,0,1682230836),(65,12,162,'铅笔艺术','pencil art',NULL,NULL,0,100,1,0,1682230836),(66,12,162,'石墨','graphite',NULL,NULL,0,100,1,0,1682230836),(67,12,162,'木炭艺术','charcoal art',NULL,NULL,0,100,1,0,1682230836),(68,12,162,'圆珠笔','ballpoint pen',NULL,NULL,0,100,1,0,1682230836),(69,12,162,'干擦马克笔','dry-erase marker',NULL,NULL,0,100,1,0,1682230836),(70,12,162,'湿擦马克笔','wet-erase marker',NULL,NULL,0,100,1,0,1682230836),(71,12,162,'凝胶笔','gel pen',NULL,NULL,0,100,1,0,1682230836),(72,12,162,'蜡笔','crayon',NULL,NULL,0,100,1,0,1682230836),(73,12,162,'水彩','watercolor',NULL,NULL,0,100,1,0,1682230836),(74,15,76,'肯·凯利','by ken kelly',NULL,NULL,0,100,1,0,1682230836),(75,12,162,'油漆','paint',NULL,NULL,0,100,1,0,1682230836),(76,12,162,'粉笔','chalk',NULL,NULL,0,100,1,0,1682230836),(77,12,162,'中国毛笔','chinese ink brush',NULL,NULL,0,100,1,0,1689161104),(78,12,162,'交叉画线风格','crosshatching',NULL,NULL,0,100,1,0,1682230836),(79,12,162,'填色页风格','coloring page',NULL,NULL,0,100,1,0,1682230836),(80,12,162,'填色纸风格','colouring sheet',NULL,NULL,0,100,1,0,1682230836),(82,12,162,'白板','whiteboard',NULL,NULL,0,100,1,0,1682230836),(83,12,162,'石墨绘画','graphite drawing',NULL,NULL,0,100,1,0,1689161104),(84,12,163,'激光打印','laser printed',NULL,NULL,0,100,1,0,1682230836),(85,12,162,'铅笔绘画','pencil drawing',NULL,NULL,0,100,1,0,1682230836),(86,12,163,'单色印刷','monotype',NULL,NULL,0,100,1,0,1682230836),(87,12,162,'水墨绘画','ink wash painting',NULL,NULL,0,100,1,0,1682230836),(88,12,163,'压花印刷','block printing',NULL,NULL,0,100,1,0,1682230836),(89,15,76,'拉里·艾尔莫尔','by larry elmore',NULL,NULL,0,100,1,0,1682230836),(90,12,162,'木炭绘画','charcoal drawing',NULL,NULL,0,100,1,0,1689161104),(91,12,163,'丝印','risograph',NULL,NULL,0,100,1,0,1682230836),(92,12,162,'马克笔绘画','marker drawing',NULL,NULL,0,100,1,0,1689161104),(93,12,163,'绢印','screenprint',NULL,NULL,0,100,1,0,1689161104),(94,12,162,'毛笔绘画','brush pen drawing',NULL,NULL,0,100,1,0,1689161104),(95,12,163,'干点法印刷','drypoint',NULL,NULL,0,100,1,0,1682230836),(96,12,162,'蜡笔绘画','crayon drawing',NULL,NULL,0,100,1,0,1689161104),(97,12,163,'红标色打印','redscale print',NULL,NULL,0,100,1,0,1689161104),(98,12,162,'粉彩绘画','pastel drawing',NULL,NULL,0,100,1,0,1689161104),(99,12,163,'烙刻印刷','pyrogravure',NULL,NULL,0,100,1,0,1689161104),(100,12,163,'光刻印刷','photogravure',NULL,NULL,0,100,1,0,1689161104),(101,12,163,'单版印刷','monotype print',NULL,NULL,0,100,1,0,1689161104),(102,12,162,'调色刀绘画','palette knife drawing',NULL,NULL,0,100,1,0,1689161104),(103,12,163,'环铜雕刻印刷','mezzotint print',NULL,NULL,0,100,1,0,1689161104),(104,12,162,'贴纸插画','sticker illustration',NULL,NULL,0,100,1,0,1689161104),(105,12,163,'黑胶照相术印刷','melainotype print',NULL,NULL,0,100,1,0,1689161104),(106,12,162,'玩具板绘画','etch-a-sketch drawing',NULL,NULL,0,100,1,0,1682230836),(107,12,162,'喷枪绘画','airbrush drawing',NULL,NULL,0,100,1,0,1689161104),(108,12,163,'平版印刷','lithography print',NULL,NULL,0,100,1,0,1689161104),(109,15,76,'劳拉·迪尔','by laura diehl',NULL,NULL,0,100,1,0,1682230836),(110,12,163,'鳞版印刷','linocut print',NULL,NULL,0,100,1,0,1689161104),(111,12,162,'透视绘画','perspective drawing',NULL,NULL,0,100,1,0,1689161104),(112,12,162,'康特粉笔绘画','conte drawing',NULL,NULL,0,100,1,0,1689161104),(113,12,163,'凸版印刷','letterpress print',NULL,NULL,0,100,1,0,1689161104),(114,12,163,'凹版印刷','intaglio print',NULL,NULL,0,100,1,0,1689161104),(115,12,162,'十字线条绘画','crosshatch',NULL,NULL,0,100,1,0,1682230836),(116,12,163,'半色调印刷','halftone print',NULL,NULL,0,100,1,0,1689161104),(117,12,162,'点刺法绘画','stipple',NULL,NULL,0,100,1,0,1682230836),(118,12,162,'粉笔绘画','chalk drawing',NULL,NULL,0,100,1,0,1689161104),(119,12,163,'树胶印刷','gumoil print',NULL,NULL,0,100,1,0,1689161104),(120,12,158,'陶器','earthenware',NULL,NULL,0,100,1,0,1682230836),(121,12,163,'青色印相','cyanotype print',NULL,NULL,0,100,1,0,1689161104),(122,12,162,'像素绘画','pixel drawing',NULL,NULL,0,100,1,0,1689161104),(124,12,163,'交叉处理印相','cross processing print',NULL,NULL,0,100,1,0,1689161104),(125,12,162,'水彩画','watercolor paint',NULL,NULL,0,100,1,0,1689161104),(127,12,163,'彩石印刷','chromolithography',NULL,NULL,0,100,1,0,1689161104),(128,12,158,'彩绘玻璃','vitrail',NULL,NULL,0,100,1,0,1689161104),(129,12,162,'卷轴画','coil painting',NULL,NULL,0,100,1,0,1685329020),(130,12,163,'胶印','collotype print',NULL,NULL,0,100,1,0,1689161104),(131,14,70,'水下摄影','underwater photography',NULL,NULL,0,100,1,0,1689161104),(132,12,162,'木刻版画','woodblock print',NULL,NULL,0,100,1,0,1689161104),(133,12,163,'碘酒胶印相','collodion print',NULL,NULL,0,100,1,0,1689161104),(134,14,70,'紫外线摄影','ultraviolet photography',NULL,NULL,0,100,1,0,1689161104),(135,12,162,'丙烯画','acrylic painting',NULL,NULL,0,100,1,0,1682230836),(136,15,76,'丽莎·帕克','by lisa parker',NULL,NULL,0,100,1,0,1682230836),(137,16,94,'活力四溢的，充满生机的','alive',NULL,NULL,0,100,1,0,1682230836),(138,12,163,'卡洛塔伊普印相','calotype print',NULL,NULL,0,100,1,0,1689161104),(139,12,162,'中国绘画','chinese painting',NULL,NULL,0,100,1,0,1682230836),(140,12,163,'溴油印相','bromoil print',NULL,NULL,0,100,1,0,1689161104),(141,12,162,'日本绘画','japanese painting',NULL,NULL,0,100,1,0,1682230836),(142,12,163,'水凹版印刷','aquatint print',NULL,NULL,0,100,1,0,1689161104),(143,12,162,'韩国绘画','korean painting',NULL,NULL,0,100,1,0,1682230836),(144,12,163,'花卉印相','anthotype print',NULL,NULL,0,100,1,0,1689161104),(145,12,165,'纸工艺','papercraft',NULL,NULL,0,100,1,0,1689161104),(146,12,162,'印度绘画','indian painting',NULL,NULL,0,100,1,0,1682230836),(147,12,163,'蛋白印相','albumen print',NULL,NULL,0,100,1,0,1689161104),(148,14,70,'延时摄影','time-lapse photography',NULL,NULL,0,100,1,0,1689161104),(149,12,165,'纸雕','paper-mache',NULL,NULL,0,100,1,0,1682230836),(150,12,162,'古罗马绘画','ancient roman painting',NULL,NULL,0,100,1,0,1682230836),(151,12,165,'刚性折纸','rigid origami',NULL,NULL,0,100,1,0,1682230836),(152,12,163,'凹版印刷','intaglio',NULL,NULL,0,100,1,0,1682230836),(153,12,162,'仿真绘画','faux painting',NULL,NULL,0,100,1,0,1682230836),(154,12,165,'纸模型','paper model',NULL,NULL,0,100,1,0,1682230836),(155,12,162,'壁画绘画','fresco painting',NULL,NULL,0,100,1,0,1682230836),(156,12,163,'丝网印刷风格','risograph style',NULL,NULL,0,100,1,0,1682230836),(157,12,165,'中国纸艺','chinese paper art',NULL,NULL,0,100,1,0,1682230836),(158,12,162,'布面绘画','gouache style',NULL,NULL,0,100,1,0,1682230836),(159,12,165,'虹膜折纸','iris-folding',NULL,NULL,0,100,1,0,1682230836),(160,12,162,'热蜡绘画','hot wax painting',NULL,NULL,0,100,1,0,1682230836),(161,12,162,'错觉画','trompe l\'oeil',NULL,NULL,0,100,1,0,1689161104),(162,12,165,'麦片盒风格','cereal box',NULL,NULL,0,100,1,0,1682230836),(163,15,76,'利兹·丹福斯','by liz danforth',NULL,NULL,0,100,1,0,1682230836),(164,12,162,'黑光绘画','blacklight paint',NULL,NULL,0,100,1,0,1689161104),(165,12,165,'麦片盒人物风格','cereal box character',NULL,NULL,0,100,1,0,1682230836),(166,12,162,'锡板印画','tintype print',NULL,NULL,0,100,1,0,1689161104),(167,12,165,'立体书','pop-up book',NULL,NULL,0,100,1,0,1682230836),(168,14,70,'视界摄影','through-the-viewfinder photography',NULL,NULL,0,100,1,0,1689161104),(169,12,165,'纸币折纸','moneygami',NULL,NULL,0,100,1,0,1682230836),(170,12,162,'点彩派绘画','pointillism',NULL,NULL,0,100,1,0,1682230836),(171,12,165,'纸浆塑造','papier-mache',NULL,NULL,0,100,1,0,1689161104),(172,12,162,'卷轴绘画','scroll painting',NULL,NULL,0,100,1,0,1682230836),(173,12,165,'纸板制品','cartonnage',NULL,NULL,0,100,1,0,1689161104),(174,12,162,'网点绘画','screentone',NULL,NULL,0,100,1,0,1682230836),(175,12,165,'折纸','kirigami',NULL,NULL,0,100,1,0,1689161104),(176,12,162,'刮刻绘画','sgraffito painting',NULL,NULL,0,100,1,0,1682230836),(177,12,165,'剪纸','papercutting',NULL,NULL,0,100,1,0,1682230836),(178,12,162,'户外写生绘画','plein air painting',NULL,NULL,0,100,1,0,1682230836),(179,12,165,'纸上拼贴','papier-colle',NULL,NULL,0,100,1,0,1682230836),(180,12,162,'蛋彩绘画','tempera painting',NULL,NULL,0,100,1,0,1682230836),(181,12,165,'方格纸（毫米）','millimeter squared paper',NULL,NULL,0,100,1,0,1689161104),(182,12,162,'涂抹派绘画','tachisme painting',NULL,NULL,0,100,1,0,1682230836),(183,12,56,'海报','poster',NULL,NULL,0,100,1,0,1682230836),(184,12,56,'建筑平面图','architectural plan',NULL,NULL,0,100,1,0,1689161104),(185,12,165,'分层纸','layered paper',NULL,NULL,0,100,1,0,1689161104),(186,12,162,'质感绘画','texture painting',NULL,NULL,0,100,1,0,1682230836),(187,15,76,'路易斯·罗约','by luis royo',NULL,NULL,0,100,1,0,1682230836),(188,12,165,'正交投影','orthographic view',NULL,NULL,0,100,1,0,1689161104),(189,12,162,'面板绘画','panel painting',NULL,NULL,0,100,1,0,1682230836),(190,12,56,'电影海报','movie poster',NULL,NULL,0,100,1,0,1682230836),(191,12,56,'日本复古海报','japanese vintage poster',NULL,NULL,0,100,1,0,1689161104),(192,12,165,'模块折纸','modular origami',NULL,NULL,0,100,1,0,1682230836),(193,12,162,'素描风格绘画','sketch drawing style',NULL,NULL,0,100,1,0,1682230836),(194,12,56,'细胞图','cellular diagram',NULL,NULL,0,100,1,0,1689161104),(195,12,165,'湿折纸','wet-folding',NULL,NULL,0,100,1,0,1682230836),(196,12,162,'石头绘画','stone painting',NULL,NULL,0,100,1,0,1682230836),(197,12,56,'解剖插图','anatomical illustration',NULL,NULL,0,100,1,0,1689161104),(198,12,162,'仰视绘画','sotto in su painting',NULL,NULL,0,100,1,0,1682230836),(199,12,165,'贴纸','sticker',NULL,NULL,0,100,1,0,1682230836),(200,12,56,'截面图','sectional view',NULL,NULL,0,100,1,0,1689161104),(201,12,162,'叶片绘画','leaf painting',NULL,NULL,0,100,1,0,1682230836),(202,12,162,'超现实绘画','metaphysical painting',NULL,NULL,0,100,1,0,1682230836),(203,12,56,'解剖图','anatomical drawing',NULL,NULL,0,100,1,0,1682230836),(204,12,56,'剖面图','cross-section diagram',NULL,NULL,0,100,1,0,1689161104),(205,12,162,'干刷画','dry brush drawing',NULL,NULL,0,100,1,0,1689161104),(206,12,165,'撕纸拼贴','torn paper collage',NULL,NULL,0,100,1,0,1689161104),(207,12,56,'剖面平面图','cross-section plan',NULL,NULL,0,100,1,0,1689161104),(208,12,162,'水墨画','ebru',NULL,NULL,0,100,1,0,1689161104),(209,12,165,'木雕','wood-carving',NULL,NULL,0,100,1,0,1682230836),(210,12,56,'装配图','assembly drawing',NULL,NULL,0,100,1,0,1689161104),(211,12,162,'墨画','ink drawing',NULL,NULL,0,100,1,0,1689161104),(212,12,162,'灰调画','grisaille',NULL,NULL,0,100,1,0,1689161104),(213,12,56,'地质剖面图','geological cross-section',NULL,NULL,0,100,1,0,1689161104),(214,12,165,'木刻','wood engraving',NULL,NULL,0,100,1,0,1689161104),(215,12,162,'荧光画','lite brite art',NULL,NULL,0,100,1,0,1689161104),(216,12,165,'木目金','mokume-gane',NULL,NULL,0,100,1,0,1689161104),(217,12,56,'显微镜图','micrographia',NULL,NULL,0,100,1,0,1689161104),(218,12,165,'曲木','bentwood',NULL,NULL,0,100,1,0,1689161104),(219,12,56,'工程图纸','technical drawing',NULL,NULL,0,100,1,0,1689161104),(220,12,162,'文人画','literati painting',NULL,NULL,0,100,1,0,1682230836),(221,12,56,'植物标本馆','herbarium',NULL,NULL,0,100,1,0,1689161104),(222,14,70,'慢门摄影','slow shutter speed',NULL,NULL,0,100,1,0,1689161104),(223,12,164,'硬石镶嵌','pietra dura',NULL,NULL,0,100,1,0,1682230836),(224,12,165,'木工艺','carpentry',NULL,NULL,0,100,1,0,1682230836),(225,12,165,'雕漆','carved lacquer',NULL,NULL,0,100,1,0,1682230836),(226,12,162,'柔性版印墨','flexographic ink',NULL,NULL,0,100,1,0,1682230836),(227,12,165,'雕刻','carving',NULL,NULL,0,100,1,0,1689161104),(228,12,56,'爆炸图','exploded view',NULL,NULL,0,100,1,0,1689161104),(229,12,165,'木工艺','lath art',NULL,NULL,0,100,1,0,1682230836),(230,12,164,'回纹饰','fretwork',NULL,NULL,0,100,1,0,1682230836),(231,12,56,'专利图纸','patent drawing',NULL,NULL,0,100,1,0,1689161104),(232,12,165,'铁艺','ironwork',NULL,NULL,0,100,1,0,1682230836),(233,12,165,'玛雅雕塑','mayan sculpture',NULL,NULL,0,100,1,0,1682230836),(234,12,165,'刻刀雕刻','whittling',NULL,NULL,0,100,1,0,1682230836),(235,12,165,'木工车削','woodturning',NULL,NULL,0,100,1,0,1682230836),(236,12,165,'刻花','chip-carving',NULL,NULL,0,100,1,0,1682230836),(237,12,165,'锯雕','chainsaw-carving',NULL,NULL,0,100,1,0,1682230836),(238,12,165,'镀金','gilded',NULL,NULL,0,100,1,0,1689161104),(239,12,56,'家谱树','genealogical tree',NULL,NULL,0,100,1,0,1689161104),(240,12,165,'金属刻版','metalcut',NULL,NULL,0,100,1,0,1682230836),(241,12,162,'滴漏油漆','dripping paint',NULL,NULL,0,100,1,0,1682230836),(242,12,56,'树状地图','treemap',NULL,NULL,0,100,1,0,1689161104),(243,12,164,'微小马赛克','micromosaic',NULL,NULL,0,100,1,0,1682230836),(244,12,165,'金箔镀金技术风格','keum boo gilding technique',NULL,NULL,0,100,1,0,1682230836),(245,12,165,'浮雕','bas-relief',NULL,NULL,0,100,1,0,1689161104),(246,12,165,'铁磁液体','ferrofluid',NULL,NULL,0,100,1,0,1689161104),(247,12,56,'功能块图','functional block diagram',NULL,NULL,0,100,1,0,1689161104),(248,12,165,'金缮','kintsugi',NULL,NULL,0,100,1,0,1689161104),(249,11,160,'刮削板艺术','scraperboard art',NULL,NULL,0,100,1,0,1689161104),(250,12,164,'玻璃马赛克','glass mosaic',NULL,NULL,0,100,1,0,1682230836),(251,12,56,'热像图','thermograph',NULL,NULL,0,100,1,0,1689161104),(252,12,164,'印象派马赛克','impressionist mosaic',NULL,NULL,0,100,1,0,1682230836),(253,12,165,'符文雕刻','runic carving',NULL,NULL,0,100,1,0,1682230836),(254,12,56,'水磨纸','marbling',NULL,NULL,0,100,1,0,1689161104),(255,12,162,'面粉糊画','wheatpaste',NULL,NULL,0,100,1,0,1689161104),(256,12,164,'照片马赛克','photographic mosaic',NULL,NULL,0,100,1,0,1682230836),(257,12,165,'浮雕雕刻','relief-carving',NULL,NULL,0,100,1,0,1682230836),(258,15,76,'迈克尔·海格','by michael hague',NULL,NULL,0,100,1,0,1682230836),(259,12,56,'曼陀罗','mandala',NULL,NULL,0,100,1,0,1689161104),(260,12,165,'雕刻','scrimshaw',NULL,NULL,0,100,1,0,1689161104),(261,12,164,'《巴约纹绣》','bayeux tapestry',NULL,NULL,0,100,1,0,1682230836),(262,12,56,'谱图','spectrogram',NULL,NULL,0,100,1,0,1689161104),(263,12,164,'模仿《巴约纹绣》风格','in the style of bayeux tapestry',NULL,NULL,0,100,1,0,1682230836),(264,12,165,'石膏浮雕','lithophane',NULL,NULL,0,100,1,0,1682230836),(265,12,56,'数据可视化','data visualization',NULL,NULL,0,100,1,0,1689161104),(266,12,165,'布偶风格','muppet style',NULL,NULL,0,100,1,0,1689161104),(267,12,164,'千花挂毯','millefleurs tapestry',NULL,NULL,0,100,1,0,1689161104),(268,12,165,'手绘染','shibori',NULL,NULL,0,100,1,0,1689161104),(269,12,56,'垃圾波尔卡','trash polka',NULL,NULL,0,100,1,0,1689161104),(270,12,164,'绿色花卉挂毯','verdure tapestry',NULL,NULL,0,100,1,0,1689161104),(271,12,164,'哥百林挂毯','gobelin tapestry',NULL,NULL,0,100,1,0,1689161104),(272,12,158,'彩色玻璃','stained glass',NULL,NULL,0,100,1,0,1689161104),(273,12,165,'绳饰','soutache',NULL,NULL,0,100,1,0,1689161104),(274,12,56,'手球','temari',NULL,NULL,0,100,1,0,1689161104),(275,12,164,'奇异挂毯','grotesque tapestry',NULL,NULL,0,100,1,0,1689161104),(276,12,165,'根付','netsuke',NULL,NULL,0,100,1,0,1689161104),(277,12,56,'声波图','sound wave diagram',NULL,NULL,0,100,1,0,1689161104),(278,12,165,'针织图案','needlepoint',NULL,NULL,0,100,1,0,1689161104),(279,12,56,'统计图表','statistical graph',NULL,NULL,0,100,1,0,1689161104),(280,12,164,'壁毯','tapestry',NULL,NULL,0,100,1,0,1689161104),(281,12,165,'分子模型','molecular model',NULL,NULL,0,100,1,0,1689161104),(282,12,164,'缝制拼布','quilted',NULL,NULL,0,100,1,0,1689161104),(283,12,56,'沙马书法','sama calligraphy',NULL,NULL,0,100,1,0,1689161104),(284,12,164,'镂空工艺','filigree',NULL,NULL,0,100,1,0,1689161104),(285,12,165,'低多边形','low-poly',NULL,NULL,0,100,1,0,1689161104),(286,12,56,'太阳影像','solargram',NULL,NULL,0,100,1,0,1689161104),(287,12,56,'着色书页','coloring book page',NULL,NULL,0,100,1,0,1689161104),(288,12,165,'光追踪','light tracing',NULL,NULL,0,100,1,0,1689161104),(289,12,56,'填色图纸','coloring-in sheet',NULL,NULL,0,100,1,0,1689161104),(290,12,165,'光绘','light painting',NULL,NULL,0,100,1,0,1689161104),(291,11,160,'版画艺术','scratchboard art',NULL,NULL,0,100,1,0,1689161104),(292,12,165,'卡奇纳娃娃','kachina doll',NULL,NULL,0,100,1,0,1689161104),(293,12,164,'木刻','woodcut',NULL,NULL,0,100,1,0,1682230836),(295,12,165,'齐整摆放','knolling',NULL,NULL,0,100,1,0,1689161104),(296,11,160,'树脂艺术','resin art',NULL,NULL,0,100,1,0,1689161104),(297,12,162,'水彩描线','watercolor with ink pen outline',NULL,NULL,0,100,1,0,1689161104),(298,12,164,'木框装饰','wooden framed',NULL,NULL,0,100,1,0,1682230836),(299,12,56,'涂鸦标签','graffiti tag',NULL,NULL,0,100,1,0,1682230836),(300,12,164,'木框架','wooden frame',NULL,NULL,0,100,1,0,1682230836),(301,12,164,'木刻版画','linocut',NULL,NULL,0,100,1,0,1682230836),(302,12,165,'阿莱布里赫','alebrije',NULL,NULL,0,100,1,0,1689161104),(303,12,164,'带框的','framed',NULL,NULL,0,100,1,0,1682230836),(304,12,165,'高筒袜木偶风格','sock puppet style',NULL,NULL,0,100,1,0,1689161104),(305,12,164,'木偶','puppet',NULL,NULL,0,100,1,0,1682230836),(306,12,165,'3D涂鸦','3d graffiti',NULL,NULL,0,100,1,0,1689161104),(307,12,164,'十字绣','cross-stitching',NULL,NULL,0,100,1,0,1689161104),(308,12,56,'泰森多边形图','voronoi diagram',NULL,NULL,0,100,1,0,1689161104),(309,12,56,'矢量场','vector field',NULL,NULL,0,100,1,0,1689161104),(310,15,76,'纳塔莉亚·苏伦','by nathalia suellen',NULL,NULL,0,100,1,0,1682230836),(311,14,70,'产品摄影','product photography',NULL,NULL,0,100,1,0,1689161104),(312,11,160,'参数化艺术','parametric art',NULL,NULL,0,100,1,0,1689161104),(313,12,56,'天气图','weather map',NULL,NULL,0,100,1,0,1689161104),(314,12,56,'电路图','wiring diagrams',NULL,NULL,0,100,1,0,1689161104),(315,14,70,'肩头视角肖像拍摄','portrait shot over the shoulder',NULL,NULL,0,100,1,0,1689161104),(316,12,56,'侘寂','wabi-sabi',NULL,NULL,0,100,1,0,1689161104),(317,14,70,'顶光肖像拍摄','portrait shot with top lighting',NULL,NULL,0,100,1,0,1689161104),(318,12,164,'条形码','barcode',NULL,NULL,0,100,1,0,1682230836),(319,14,70,'阳光肖像拍摄','portrait shot with sunlight',NULL,NULL,0,100,1,0,1689161104),(320,12,164,'二维码','qr code',NULL,NULL,0,100,1,0,1682230836),(321,14,70,'柔光肖像拍摄','portrait shot with soft lighting',NULL,NULL,0,100,1,0,1689161104),(322,12,165,'线框','wireframe',NULL,NULL,0,100,1,0,1689161104),(323,12,164,'邮票','stamp',NULL,NULL,0,100,1,0,1682230836),(324,14,70,'侧光肖像拍摄','portrait shot with side lighting',NULL,NULL,0,100,1,0,1689161104),(325,12,164,'卡片','card',NULL,NULL,0,100,1,0,1682230836),(326,14,70,'红光肖像拍摄','portrait shot with red light',NULL,NULL,0,100,1,0,1689161104),(327,12,164,'塔罗牌','tarot card',NULL,NULL,0,100,1,0,1682230836),(328,14,70,'桃红与青光肖像拍摄','portrait shot with peach and cyan lighting',NULL,NULL,0,100,1,0,1689161104),(329,15,76,'N·C·怀斯','by n c wyeth',NULL,NULL,0,100,1,0,1682230836),(330,14,70,'霓虹灯光肖像拍摄','portrait shot with neon lighting',NULL,NULL,0,100,1,0,1689161104),(331,14,70,'窗帘光影肖像拍摄','portrait shot with light and shadow from window blinds',NULL,NULL,0,100,1,0,1689161104),(332,14,70,'对比光肖像拍摄','portrait shot with contrasty lighting',NULL,NULL,0,100,1,0,1689161104),(333,12,165,'线框图','wireframe drawing',NULL,NULL,0,100,1,0,1689161104),(334,14,70,'强光肖像拍摄','portrait shot with hard lighting',NULL,NULL,0,100,1,0,1689161104),(335,14,70,'底光肖像拍摄','portrait shot with bottom lighting',NULL,NULL,0,100,1,0,1689161104),(336,14,70,'背光肖像拍摄','portrait shot with back lighting',NULL,NULL,0,100,1,0,1689161104),(337,12,165,'瓦姆贝克花边','vamberk lace',NULL,NULL,0,100,1,0,1689161104),(338,12,162,'刮刻壁画','sgraffito',NULL,NULL,0,100,1,0,1689161104),(339,15,76,'尼尼·托马斯','by nene thomas',NULL,NULL,0,100,1,0,1682230836),(340,12,56,'浮世绘','ukiyo-e',NULL,NULL,0,100,1,0,1689161104),(341,12,56,'拓扑图','topology map',NULL,NULL,0,100,1,0,1689161104),(342,14,70,'影像摄影','photogram',NULL,NULL,0,100,1,0,1689161104),(343,11,160,'纸浆艺术','pulp art',NULL,NULL,0,100,1,0,1689161104),(344,12,162,'点画','stippling',NULL,NULL,0,100,1,0,1689161104),(345,12,164,'冰箱磁贴','fridge magnet',NULL,NULL,0,100,1,0,1682230836),(346,15,76,'帕特里克·J·琼斯','by patrick j jones',NULL,NULL,0,100,1,0,1682230836),(347,11,160,'卵石艺术','pebble art',NULL,NULL,0,100,1,0,1689161104),(348,12,162,'定格动画','stop-motion animation',NULL,NULL,0,100,1,0,1689161104),(349,12,164,'汽车贴纸','bumper sticker',NULL,NULL,0,100,1,0,1682230836),(350,11,160,'拼布艺术','patchwork',NULL,NULL,0,100,1,0,1689161104),(351,12,164,'贴花','decal',NULL,NULL,0,100,1,0,1682230836),(352,12,164,'墙贴','wall decal',NULL,NULL,0,100,1,0,1682230836),(353,12,164,'照片拼贴','fotocollage',NULL,NULL,0,100,1,0,1682230836),(354,11,160,'纸卷艺术','paper quilling',NULL,NULL,0,100,1,0,1689161104),(355,12,56,'电子表格','spreadsheet',NULL,NULL,0,100,1,0,1689161104),(356,12,164,'贴纸轰炸','sticker bomb',NULL,NULL,0,100,1,0,1682230836),(357,12,164,'雕刻','engraving',NULL,NULL,0,100,1,0,1689161104),(358,11,160,'剪纸艺术','paper cutout',NULL,NULL,0,100,1,0,1689161104),(359,12,56,'地震图','seismogram',NULL,NULL,0,100,1,0,1689161104),(360,12,164,'光雕','luminogram',NULL,NULL,0,100,1,0,1689161104),(361,12,56,'示意图','schematic diagram',NULL,NULL,0,100,1,0,1689161104),(362,12,164,'铜版雕刻','copperplate engraving',NULL,NULL,0,100,1,0,1689161104),(363,12,164,'蚀刻','etching',NULL,NULL,0,100,1,0,1689161104),(364,12,56,'方格纸','squared paper',NULL,NULL,0,100,1,0,1689161104),(365,11,160,'单线艺术','one line art',NULL,NULL,0,100,1,0,1689161104),(366,12,56,'模板图形','stencil graphics',NULL,NULL,0,100,1,0,1689161104),(367,12,164,'标牌','sign',NULL,NULL,0,100,1,0,1682230836),(368,15,76,'保罗·邦纳','by paul bonner',NULL,NULL,0,100,1,0,1682230836),(369,16,94,'大胆的，冒失的','brash',NULL,NULL,0,100,1,0,1682230836),(370,12,164,'搪瓷标牌','enamel sign',NULL,NULL,0,100,1,0,1682230836),(371,12,164,'发光标牌','spellbrite',NULL,NULL,0,100,1,0,1682230836),(372,11,160,'折纸艺术','origami',NULL,NULL,0,100,1,0,1689161104),(373,12,162,'摄影动画','rotoscope animation',NULL,NULL,0,100,1,0,1689161104),(374,12,56,'手绘笔记风格','sketchnote style',NULL,NULL,0,100,1,0,1689161104),(375,12,164,'标志系统','signage',NULL,NULL,0,100,1,0,1682230836),(376,12,164,'制造商标志','builder\'s plate',NULL,NULL,0,100,1,0,1682230836),(377,12,56,'坐姿肖像','sitting portrait',NULL,NULL,0,100,1,0,1689161104),(378,12,164,'字母牌','letter board',NULL,NULL,0,100,1,0,1682230836),(379,12,164,'横幅','banner',NULL,NULL,0,100,1,0,1682230836),(380,14,70,'海洋摄影','marine photography',NULL,NULL,0,100,1,0,1689161104),(381,12,164,'视频装置','video installation',NULL,NULL,0,100,1,0,1689161104),(382,12,56,'水流纹','suminagashi',NULL,NULL,0,100,1,0,1689161104),(383,15,76,'拉贾·南德普','by raja nandepu',NULL,NULL,0,100,1,0,1682230836),(384,12,56,'墨绘','sumi-e drawing',NULL,NULL,0,100,1,0,1689161104),(385,12,162,'画架绘画','easel painting',NULL,NULL,0,100,1,0,1682230836),(386,12,162,'帕列赫绘画','palekh',NULL,NULL,0,100,1,0,1689161104),(387,11,160,'镶嵌艺术','marquetry',NULL,NULL,0,100,1,0,1689161104),(388,12,158,'千花玻璃','millefiori glass',NULL,NULL,0,100,1,0,1689161104),(389,12,164,'扎染','tie-dye',NULL,NULL,0,100,1,0,1689161104),(390,15,76,'拉尔夫·麦克奎瑞','by ralph mcquarrie',NULL,NULL,0,100,1,0,1682230836),(391,12,56,'点云','point cloud',NULL,NULL,0,100,1,0,1689161104),(392,12,164,'泰国木偶戏','thai puppet theater',NULL,NULL,0,100,1,0,1689161104),(393,12,56,'参数绘图','parametric drawing',NULL,NULL,0,100,1,0,1689161104),(394,14,70,'长曝光摄影','long exposure photography',NULL,NULL,0,100,1,0,1689161104),(395,12,56,'相图','phase diagram',NULL,NULL,0,100,1,0,1689161104),(396,14,70,'低关键度摄影','low key photography',NULL,NULL,0,100,1,0,1689161104),(397,14,70,'乐摄彩色 100','lomography color 100',NULL,NULL,0,100,1,0,1689161104),(398,15,76,'兰迪·瓦加斯','by randy vargas',NULL,NULL,0,100,1,0,1682230836),(399,12,162,'烙画艺术','pyrography',NULL,NULL,0,100,1,0,1689161104),(400,12,56,'侧面视图','profile view',NULL,NULL,0,100,1,0,1689161104),(401,14,70,'光场摄影','light field photography',NULL,NULL,0,100,1,0,1689161104),(402,15,76,'罗伯·鲍耶','by rob bowyer',NULL,NULL,0,100,1,0,1682230836),(403,11,160,'拿铁艺术','latte art',NULL,NULL,0,100,1,0,1689161104),(404,14,70,'柯达 Portra 160','kodak portra 160',NULL,NULL,0,100,1,0,1689161104),(405,14,70,'柯达 Ultramax 400','kodak ultramax 400',NULL,NULL,0,100,1,0,1689161104),(406,14,70,'柯达 Tri-X 400','kodak tri-x 400',NULL,NULL,0,100,1,0,1689161104),(407,14,70,'柯达 Portra 400','kodak portra 400',NULL,NULL,0,100,1,0,1689161104),(408,15,76,'罗恩·瓦洛茨基','by ron walotsky',NULL,NULL,0,100,1,0,1682230836),(409,14,70,'柯达 Ektar 100','kodak ektar 100',NULL,NULL,0,100,1,0,1689161104),(410,14,70,'柯达 Ektachrome E100','kodak ektachrome e100',NULL,NULL,0,100,1,0,1689161104),(411,12,164,'雪花球','snowglobe',NULL,NULL,0,100,1,0,1689161104),(412,12,164,'放射影像','radiographic image',NULL,NULL,0,100,1,0,1689161104),(413,12,164,'里约狂欢巨型花车','rio carnival float',NULL,NULL,0,100,1,0,1689161104),(414,15,76,'罗斯·尼科尔森','by russ nicholson',NULL,NULL,0,100,1,0,1682230836),(415,12,56,'奥甘文','ogham',NULL,NULL,0,100,1,0,1689161104),(416,12,158,'伊兹尼克瓷砖','iznik tiles',NULL,NULL,0,100,1,0,1689161104),(417,12,165,'激光雕刻','laser engraving',NULL,NULL,0,100,1,0,1689161104),(418,12,56,'闵可夫斯基图','minkowski diagram',NULL,NULL,0,100,1,0,1689161104),(419,14,70,'红外摄影','infrared photography',NULL,NULL,0,100,1,0,1689161104),(420,15,76,'塞琳娜·费内奇','by selina fenech',NULL,NULL,0,100,1,0,1682230836),(421,14,70,'高关键度摄影','high key photography',NULL,NULL,0,100,1,0,1689161104),(422,14,70,'佳能 Holga 摄影','holga photography',NULL,NULL,0,100,1,0,1689161104),(423,15,76,'斯蒂芬妮·劳','by stephanie law',NULL,NULL,0,100,1,0,1682230836),(424,14,70,'全息摄影','holography',NULL,NULL,0,100,1,0,1689161104),(425,12,56,'低角度','low angle',NULL,NULL,0,100,1,0,1689161104),(426,12,56,'宝石鉴赏','lapidary',NULL,NULL,0,100,1,0,1689161104),(427,15,76,'斯蒂芬妮·佩伊-蒙·劳','by stephanie pui-mun law',NULL,NULL,0,100,1,0,1682230836),(428,12,158,'格热尔陶瓷','gzhel ceramic',NULL,NULL,0,100,1,0,1689161104),(429,12,164,'装饰品','ornament',NULL,NULL,0,100,1,0,1689161104),(430,15,76,'斯蒂芬·马尔蒂尼埃尔','by stephan martiniere',NULL,NULL,0,100,1,0,1682230836),(431,16,94,'明亮的，鲜亮的','bright',NULL,NULL,0,100,1,0,1682230836),(432,12,158,'格拉玻璃','graal glass',NULL,NULL,0,100,1,0,1689161104),(433,12,56,'厚涂','impasto',NULL,NULL,0,100,1,0,1689161104),(434,12,56,'生花','ikebana',NULL,NULL,0,100,1,0,1689161104),(435,14,70,'伊尔福 XP2 400','ilford xp2 400',NULL,NULL,0,100,1,0,1689161104),(436,14,70,'伊尔福 HP5+ 400','ilford hp5+ 400',NULL,NULL,0,100,1,0,1689161104),(437,14,70,'伊尔福 FP4 125','ilford fp4 125',NULL,NULL,0,100,1,0,1689161104),(438,12,164,'俄罗斯套娃娃','matryoshka',NULL,NULL,0,100,1,0,1689161104),(439,14,70,'食物摄影','food photography',NULL,NULL,0,100,1,0,1689161104),(440,12,56,'意图相机移动','intentional camera movement',NULL,NULL,0,100,1,0,1689161104),(441,12,164,'穆伊布里奇序列','muybridge sequence',NULL,NULL,0,100,1,0,1689161104),(442,15,76,'斯蒂芬·法比安','by Stephen Fabian',NULL,NULL,0,100,1,0,1682230836),(443,12,56,'信息图','infographic',NULL,NULL,0,100,1,0,1689161104),(444,14,70,'富士黑白胶片','fujifilm neopan 100',NULL,NULL,0,100,1,0,1689161104),(445,11,160,'精美艺术蚀刻','fine art etching',NULL,NULL,0,100,1,0,1689161104),(446,14,70,'富士彩色胶片','fujicolor superia x-tra 400',NULL,NULL,0,100,1,0,1689161104),(447,12,56,'热力图','heat map',NULL,NULL,0,100,1,0,1689161104),(448,14,70,'富士彩色胶片','fujicolor pro 400h',NULL,NULL,0,100,1,0,1689161104),(449,14,70,'富士彩色反转片','fujicolor fujichrome velvia 100',NULL,NULL,0,100,1,0,1689161104),(450,14,70,'富士彩色胶片','fujicolor c200',NULL,NULL,0,100,1,0,1689161104),(451,14,70,'富士彩色反转片','fujichrome provia 100f',NULL,NULL,0,100,1,0,1689161104),(452,12,56,'高角度','high angle',NULL,NULL,0,100,1,0,1689161104),(453,14,70,'富士胶片','fomapan 400',NULL,NULL,0,100,1,0,1689161104),(454,12,56,'高快门速度','high shutter speed',NULL,NULL,0,100,1,0,1689161104),(455,15,76,'特里丝·尼尔森','by Terese Nielsen',NULL,NULL,0,100,1,0,1682230836),(456,12,56,'手工上色照片','hand-colored photograph',NULL,NULL,0,100,1,0,1689161104),(457,12,56,'基因图','genetic map',NULL,NULL,0,100,1,0,1689161104),(458,12,56,'甘特图','gantt chart',NULL,NULL,0,100,1,0,1689161104),(459,12,158,'熔融玻璃','fused glass',NULL,NULL,0,100,1,0,1689161104),(460,12,56,'魚拓','gyotaku',NULL,NULL,0,100,1,0,1689161104),(461,15,76,'蒂姆·怀特','by Tim White',NULL,NULL,0,100,1,0,1682230836),(462,12,56,'团体肖像','group portrait',NULL,NULL,0,100,1,0,1689161104),(463,12,164,'看板墙','kanban wall',NULL,NULL,0,100,1,0,1689161104),(464,12,56,'灰度','grayscale',NULL,NULL,0,100,1,0,1689161104),(465,12,165,'由虹光箔制作','made of iridescent foil',NULL,NULL,0,100,1,0,1689161104),(466,12,164,'苔玉','kokedama',NULL,NULL,0,100,1,0,1689161104),(467,12,165,'埴輪','haniwa',NULL,NULL,0,100,1,0,1689161104),(468,12,158,'热蜡瓷砖','encaustic tile',NULL,NULL,0,100,1,0,1689161104),(469,15,76,'托德·洛克伍德','by Todd Lockwood',NULL,NULL,0,100,1,0,1682230836),(470,12,56,'CCTV录像','footage from cctv',NULL,NULL,0,100,1,0,1689161104),(471,12,162,'哥亚奇画','gouache paint',NULL,NULL,0,100,1,0,1689161104),(472,12,162,'闪光绘画','glitter drawing',NULL,NULL,0,100,1,0,1689161104),(473,12,56,'全身肖像','full body height portrait',NULL,NULL,0,100,1,0,1689161104),(474,12,56,'快门速度','fast shutter speed',NULL,NULL,0,100,1,0,1689161104),(475,12,56,'时尚肖像','fashion portrait',NULL,NULL,0,100,1,0,1689161104),(476,15,76,'托尼·迪特利齐','by Tony DiTerlizzi',NULL,NULL,0,100,1,0,1682230836),(477,12,56,'家庭肖像','family portrait',NULL,NULL,0,100,1,0,1689161104),(478,11,160,'拼贴艺术','decoupage',NULL,NULL,0,100,1,0,1689161104),(479,12,162,'涂鸦','graffiti',NULL,NULL,0,100,1,0,1689161104),(480,12,164,'雛人形','hina doll',NULL,NULL,0,100,1,0,1689161104),(481,12,56,'时尚草图','fashion sketch',NULL,NULL,0,100,1,0,1689161104),(482,15,76,'维·安','by Viet Anh',NULL,NULL,0,100,1,0,1682230836),(483,12,56,'佛兰德挂毯','flemish tapestry',NULL,NULL,0,100,1,0,1689161104),(484,12,56,'电磁频谱图','electromagnetic spectrum chart',NULL,NULL,0,100,1,0,1689161104),(485,12,56,'爆炸装配','exploded assembly',NULL,NULL,0,100,1,0,1689161104),(486,12,56,'立面图','elevation drawing',NULL,NULL,0,100,1,0,1689161104),(487,12,162,'时尚插画','fashion illustration',NULL,NULL,0,100,1,0,1689161104),(488,12,56,'电气布局','electrical layout',NULL,NULL,0,100,1,0,1689161104),(489,12,165,'光纤光绘','fiber optic light painting',NULL,NULL,0,100,1,0,1689161104),(490,12,56,'极端广角肖像','extreme wide portrait',NULL,NULL,0,100,1,0,1689161104),(491,12,56,'极端特写肖像','extreme close-up portrait',NULL,NULL,0,100,1,0,1689161104),(492,15,76,'弗拉基米尔·库什','by Vladimir Kush',NULL,NULL,0,100,1,0,1682230836),(493,12,158,'西布拉克瓷器','cibulak porcelain',NULL,NULL,0,100,1,0,1689161104),(494,12,56,'磨损照片','distressed photo',NULL,NULL,0,100,1,0,1689161104),(495,12,56,'绘图格纸','drawing grid paper',NULL,NULL,0,100,1,0,1689161104),(496,12,56,'贴花','decals',NULL,NULL,0,100,1,0,1689161104),(497,12,56,'透视模型','diorama',NULL,NULL,0,100,1,0,1689161104),(498,15,76,'韦恩·巴洛伊','by Wayne Barlowe',NULL,NULL,0,100,1,0,1682230836),(499,12,56,'杜费彩色照片','dufaycolor photograph',NULL,NULL,0,100,1,0,1689161104),(500,12,162,'热蜡画','encaustic paint',NULL,NULL,0,100,1,0,1689161104),(501,12,56,'达盖尔罗型照片','daguerreotype',NULL,NULL,0,100,1,0,1689161104),(502,12,56,'气候历史图','climate history graph',NULL,NULL,0,100,1,0,1689161104),(503,12,56,'城市规划','city plan',NULL,NULL,0,100,1,0,1689161104),(504,12,56,'等高线图','contour plot',NULL,NULL,0,100,1,0,1689161104),(505,12,56,'化学结构','chemical structure',NULL,NULL,0,100,1,0,1689161104),(506,12,56,'剖视图','cutaway view',NULL,NULL,0,100,1,0,1689161104),(507,15,76,'沃伊切赫·西德马克','by Wojciech Siudmak',NULL,NULL,0,100,1,0,1682230836),(508,12,56,'CAD绘图','cad drawing',NULL,NULL,0,100,1,0,1689161104),(509,12,56,'电路图','circuit diagram',NULL,NULL,0,100,1,0,1689161104),(510,12,56,'坐标系纸','coordinate system paper',NULL,NULL,0,100,1,0,1689161104),(511,12,56,'焦化','charred',NULL,NULL,0,100,1,0,1689161104),(512,12,56,'楔形文字','cuneiform',NULL,NULL,0,100,1,0,1689161104),(513,12,56,'香堤利蕾丝','chantilly lace',NULL,NULL,0,100,1,0,1689161104),(514,15,76,'兹迪斯瓦夫·贝克辛斯基','by Zdzisław Beksiński',NULL,NULL,0,100,1,0,1682230836),(515,16,94,'活力四溢的，爽快的','brisk',NULL,NULL,0,100,1,0,1682230836),(516,12,56,'彩色速写笔记风格','color sketchnote style',NULL,NULL,0,100,1,0,1689161104),(517,12,158,'康沃尔玻璃','carnival glass',NULL,NULL,0,100,1,0,1689161104),(518,12,56,'特写肖像','close-up portrait',NULL,NULL,0,100,1,0,1689161104),(519,12,56,'电影胶片','cinestill 50',NULL,NULL,0,100,1,0,1689161104),(520,12,162,'罗马式绘画','romanesque painting',NULL,NULL,0,100,1,0,1682230836),(521,12,162,'藏传绘画','tibetan painting',NULL,NULL,0,100,1,0,1682230836),(522,12,162,'瓦尔利绘画','warli painting',NULL,NULL,0,100,1,0,1682230836),(523,12,56,'黄昏光线','crepuscular rays',NULL,NULL,0,100,1,0,1689161104),(524,12,162,'卡拉姆卡里绘画','kalamkari painting',NULL,NULL,0,100,1,0,1682230836),(525,12,162,'卡拉瓦乔绘画','caravaggio painting',NULL,NULL,0,100,1,0,1682230836),(526,12,162,'细致绘画','detailed painting',NULL,NULL,0,100,1,0,1682230836),(527,12,162,'色块绘画','color field painting',NULL,NULL,0,100,1,0,1689161104),(528,15,77,'克里斯·奥菲利','by Chris Ofili',NULL,NULL,0,100,1,0,1682230836),(529,12,56,'拼贴','collage',NULL,NULL,0,100,1,0,1689161104),(530,12,56,'明暗对比','chiaroscuro',NULL,NULL,0,100,1,0,1689161104),(531,133,87,'路德维希·密斯·凡·德·罗厄','by Ludwig Mies van der Rohe',NULL,NULL,0,100,1,0,1689161104),(532,133,87,'保罗·门德斯·达·罗查','by Paulo Mendes da Rocha',NULL,NULL,0,100,1,0,1689161104),(533,12,56,'化学图像','chemigram',NULL,NULL,0,100,1,0,1689161104),(534,133,87,'伊赛·温菲尔德','by Isay Weinfeld',NULL,NULL,0,100,1,0,1689161104),(535,133,87,'奥托·瓦格纳','by Otto Wagner',NULL,NULL,0,100,1,0,1689161104),(536,12,56,'卡通风格','cartoon style',NULL,NULL,0,100,1,0,1689161104),(537,12,162,'剪纸动画','cutout animation',NULL,NULL,0,100,1,0,1689161104),(538,133,87,'拉斐尔·维诺利','by Rafael Vinoly',NULL,NULL,0,100,1,0,1689161104),(539,133,87,'CFA 佛伊西','by CFA Voysey',NULL,NULL,0,100,1,0,1689161104),(540,133,87,'罗伯特·文图里','by Robert Venturi',NULL,NULL,0,100,1,0,1689161104),(541,12,56,'桌游','board game',NULL,NULL,0,100,1,0,1689161104),(542,133,87,'比莉·钱','by Billie Tsien',NULL,NULL,0,100,1,0,1689161104),(543,12,158,'阿苏莱霍瓷砖','azulejo',NULL,NULL,0,100,1,0,1689161104),(544,12,162,'连环画风格','comic strip style',NULL,NULL,0,100,1,0,1689161104),(545,133,87,'艾多尔多·特雷索尔迪','by Edoardo Tresoldi',NULL,NULL,0,100,1,0,1689161104),(546,12,56,'鸟瞰图','bird\'s eye view',NULL,NULL,0,100,1,0,1689161104),(547,12,162,'漫画风格','comic book style',NULL,NULL,0,100,1,0,1689161104),(548,12,56,'生物插图','biological illustration',NULL,NULL,0,100,1,0,1689161104),(549,15,77,'格伦·布朗','by Glenn Brown',NULL,NULL,0,100,1,0,1682230836),(550,133,87,'托比亚·斯卡帕','by Tobia Scarpa',NULL,NULL,0,100,1,0,1689161104),(551,133,87,'埃杜瓦多·苏托·莫拉','by Eduardo Souto Moura',NULL,NULL,0,100,1,0,1689161104),(552,133,87,'克劳迪奥·西尔韦斯特林','by Claudio Silvestrin',NULL,NULL,0,100,1,0,1689161104),(553,12,162,'粘土动画','claymation',NULL,NULL,0,100,1,0,1689161104),(554,133,87,'卡罗·斯卡帕','by Carlo Scarpa',NULL,NULL,0,100,1,0,1689161104),(555,12,56,'蓝图','blueprint',NULL,NULL,0,100,1,0,1689161104),(556,133,87,'詹姆斯·斯特灵','by James Stirling',NULL,NULL,0,100,1,0,1689161104),(557,133,87,'埃托雷·索特萨斯','by Ettore Sottsass',NULL,NULL,0,100,1,0,1689161104),(558,133,87,'保罗·索莱里','by Paolo Soleri',NULL,NULL,0,100,1,0,1689161104),(559,12,56,'占星图表','astrological chart',NULL,NULL,0,100,1,0,1689161104),(560,12,56,'天文图表','astronomical chart',NULL,NULL,0,100,1,0,1689161104),(561,133,87,'哈里·赛德勒','by Harry Seidler',NULL,NULL,0,100,1,0,1689161104),(562,12,56,'广告肖像','advertising portrait',NULL,NULL,0,100,1,0,1689161104),(563,12,56,'奥比松挂毯','aubusson tapestry',NULL,NULL,0,100,1,0,1689161104),(564,133,87,'海瑞特·列特威尔德','by Gerrit Rietveld',NULL,NULL,0,100,1,0,1689161104),(565,133,87,'阿尔多·罗西','by Aldo Rossi',NULL,NULL,0,100,1,0,1689161104),(566,133,87,'保罗·鲁道夫','by Paul Rudolph',NULL,NULL,0,100,1,0,1689161104),(567,12,56,'阿拉伯书法','arabic calligraphy',NULL,NULL,0,100,1,0,1689161104),(568,133,87,'安德烈亚·帕拉迪奥','by Andrea Palladio',NULL,NULL,0,100,1,0,1689161104),(569,133,87,'克劳德·帕兰特','by Claude Parent',NULL,NULL,0,100,1,0,1689161104),(570,133,87,'奥古斯特·佩雷','by Auguste Perret',NULL,NULL,0,100,1,0,1689161104),(571,133,87,'贝聿铭','by I. M. Pei',NULL,NULL,0,100,1,0,1689161104),(572,15,77,'姜亨谷','by Kang Hyungkoo',NULL,NULL,0,100,1,0,1682230836),(573,133,87,'约翰·波森','by John Pawson',NULL,NULL,0,100,1,0,1689161104),(574,133,87,'鲁道夫·奥尔贾蒂','by Rudolf Olgiati',NULL,NULL,0,100,1,0,1689161104),(575,133,87,'瓦莱里奥·奥尔贾蒂','by Valerio Olgiati',NULL,NULL,0,100,1,0,1689161104),(576,133,87,'皮尔·路易吉·内尔维','by Pier Luigi Nervi',NULL,NULL,0,100,1,0,1689161104),(577,133,87,'乔治·中岛','by George Nakashima',NULL,NULL,0,100,1,0,1689161104),(578,133,87,'理查德·诺伊特拉','by Richard Neutra',NULL,NULL,0,100,1,0,1689161104),(579,12,162,'蜡染','batik',NULL,NULL,0,100,1,0,1689161104),(580,133,87,'野口勇','by Isamu Noguchi',NULL,NULL,0,100,1,0,1689161104),(581,15,77,'科斯','by Kos Cos',NULL,NULL,0,100,1,0,1682230836),(582,133,87,'牧文彦','by Fumihiko Maki',NULL,NULL,0,100,1,0,1689161104),(583,133,87,'拉斐尔·莫内奥','by Rafael Moneo',NULL,NULL,0,100,1,0,1689161104),(584,12,162,'动画','animation',NULL,NULL,0,100,1,0,1689161104),(585,133,87,'格伦·默卡特','by Glenn Murcutt',NULL,NULL,0,100,1,0,1689161104),(586,133,87,'艾雷斯·马特乌斯','by Aires Mateus',NULL,NULL,0,100,1,0,1689161104),(587,133,87,'汤姆·梅恩','by Thom Mayne',NULL,NULL,0,100,1,0,1689161104),(588,133,87,'伊曼纽尔·穆尔奥','by Emmanuelle Moureaux',NULL,NULL,0,100,1,0,1689161104),(589,133,87,'康斯坦丁·梅尔尼科夫','by Konstantin Melnikov',NULL,NULL,0,100,1,0,1689161104),(590,133,87,'约翰·劳特纳','by John Lautner',NULL,NULL,0,100,1,0,1689161104),(591,133,87,'德尼斯·拉斯杜纳','by Denys Lasduna',NULL,NULL,0,100,1,0,1689161104),(592,15,77,'刘峰','by Liu Feng',NULL,NULL,0,100,1,0,1682230836),(593,133,87,'丹尼尔·利贝斯金','by Daniel Libeskind',NULL,NULL,0,100,1,0,1689161104),(594,12,164,'盆景','bonsai',NULL,NULL,0,100,1,0,1689161104),(595,12,162,'酒精墨水','alcohol ink',NULL,NULL,0,100,1,0,1689161104),(596,133,87,'石上纯也','by Junya Ishigami',NULL,NULL,0,100,1,0,1689161104),(597,133,87,'伊东丰雄','by Toyo Ito',NULL,NULL,0,100,1,0,1689161104),(598,15,77,'利内特·伊亚多姆-博阿凯','by Lynette Yiadom-Boakye',NULL,NULL,0,100,1,0,1682230836),(599,133,87,'汉斯·霍莱因','by Hans Hollein',NULL,NULL,0,100,1,0,1689161104),(600,133,87,'托马斯·希瑟维克','by Thomas Heatherwick',NULL,NULL,0,100,1,0,1689161104),(601,133,87,'约翰·海杜克','by John Hejduk',NULL,NULL,0,100,1,0,1689161104),(602,12,162,'喷漆','aerosol paint',NULL,NULL,0,100,1,0,1689161104),(603,133,87,'维克多·霍尔塔','by Victor Horta',NULL,NULL,0,100,1,0,1689161104),(604,12,162,'丙烯颜料','acrylic paint',NULL,NULL,0,100,1,0,1689161104),(605,133,87,'史蒂文·霍尔','by Steven Holl',NULL,NULL,0,100,1,0,1689161104),(606,133,87,'赫克托·吉玛尔','by Hector Guimard',NULL,NULL,0,100,1,0,1689161104),(607,133,87,'查尔斯·瓜瑟米','by Charles Gwathmey',NULL,NULL,0,100,1,0,1689161104),(608,133,87,'瓦尔特·格罗皮乌斯','by Walter Gropius',NULL,NULL,0,100,1,0,1689161104),(609,15,77,'马克·亚历山大','by Mark Alexander',NULL,NULL,0,100,1,0,1682230836),(610,133,87,'马西米利亚诺·富克萨斯','by Massimiliano Fuksas',NULL,NULL,0,100,1,0,1689161104),(611,133,87,'斯韦尔·芬','by Sverre Fehn',NULL,NULL,0,100,1,0,1689161104),(612,133,87,'藤本壮介','by Sou Fujimoto',NULL,NULL,0,100,1,0,1689161104),(613,133,87,'巴克明斯特·富勒','by Buckminster Fuller',NULL,NULL,0,100,1,0,1689161104),(614,133,87,'古斯塔夫·艾菲尔','by Gustave Eiffel',NULL,NULL,0,100,1,0,1689161104),(615,133,87,'彼得·艾森曼','by Peter Eisenman',NULL,NULL,0,100,1,0,1689161104),(616,133,87,'文森特·卡勒博','by Vincent Callebaut',NULL,NULL,0,100,1,0,1689161104),(617,15,77,'纳塔瓦特·潘塞因','by Nattawat Pansaing',NULL,NULL,0,100,1,0,1682230836),(618,16,94,'多彩的，色彩丰富的','colorful',NULL,NULL,0,100,1,0,1682230836),(619,133,87,'圣地亚哥·卡拉特拉瓦','by Santiago Calatrava',NULL,NULL,0,100,1,0,1689161104),(620,133,87,'大卫·奇普菲尔德','by David Chipperfield',NULL,NULL,0,100,1,0,1689161104),(621,133,87,'路易斯·巴拉甘','by Luis Barragan',NULL,NULL,0,100,1,0,1689161104),(622,133,87,'丽娜·博·巴尔迪','by Lina Bo Bardi',NULL,NULL,0,100,1,0,1689161104),(623,133,87,'彼得·贝伦斯','by Peter Behrens',NULL,NULL,0,100,1,0,1689161104),(624,133,87,'马里奥·博塔','by Mario Botta',NULL,NULL,0,100,1,0,1689161104),(625,133,87,'阿尔贝托·坎波·巴埃萨','by Alberto Campo Baeza',NULL,NULL,0,100,1,0,1689161104),(626,133,87,'弗朗西斯科·博罗米尼','by Francesco Borromini',NULL,NULL,0,100,1,0,1689161104),(627,133,87,'菲利波·布鲁内莱斯基','by Filippo Brunelleschi',NULL,NULL,0,100,1,0,1689161104),(628,15,77,'奈杰尔·库克','by Nigel Cooke',NULL,NULL,0,100,1,0,1682230836),(629,133,87,'里卡多·博菲尔','by Ricardo Bofill',NULL,NULL,0,100,1,0,1689161104),(630,133,87,'亚历杭德罗·阿拉维纳','by Alejandro Aravena',NULL,NULL,0,100,1,0,1689161104),(631,13,62,'C4D渲染引擎','c4d',NULL,NULL,0,100,1,0,1682230836),(632,15,77,'诺里斯·严','by Norris Yim',NULL,NULL,0,100,1,0,1682230836),(633,14,67,'苹果iPhone','shot by apple iphone',NULL,NULL,0,100,1,0,1682230836),(634,14,67,'佳能EOS数字胶片相机','shot by canon eos digital rebel',NULL,NULL,0,100,1,0,1682230836),(635,14,67,'佳能EOS-1D X Mark II','shot by Canon EOS-1D X Mark II',NULL,NULL,0,100,1,0,1689157192),(636,14,67,'佳能EOS 5D Mark IV','shot by Canon EOS 5D Mark IV',NULL,NULL,0,100,1,0,1689156973),(637,14,67,'佳能AE-1相机','shot by canon ae-1',NULL,NULL,0,100,1,0,1682230836),(638,14,67,'尼康D100 (2002)相机','shot by nikon d100 2002',NULL,NULL,0,100,1,0,1682230836),(639,14,67,'尼康D850','shot by Nikon D850',NULL,NULL,0,100,1,0,1689157223),(640,9,98,'鸟瞰视角','birds eye view shot',NULL,NULL,0,100,1,0,1682230836),(641,9,98,'无人机视角','drone shot',NULL,NULL,0,100,1,0,1682230836),(642,14,67,'尼康F2相机','shot by nikon f2',NULL,NULL,0,100,1,0,1682230836),(643,14,67,'尼康F相机','shot by nikon f',NULL,NULL,0,100,1,0,1682230836),(644,14,67,'尼康FE相机','shot by nikon fe',NULL,NULL,0,100,1,0,1682230836),(645,13,63,'极其详细','extremely detailed',NULL,NULL,0,100,1,0,1688267387),(646,14,67,'索尼Mavica相机','shot by sony mavica',NULL,NULL,0,100,1,0,1682230836),(647,14,67,'尼康L35AF相机','shot by nikon l35af',NULL,NULL,0,100,1,0,1682230836),(648,13,63,'极致细节','ultra-detail',NULL,NULL,0,100,1,0,1688814611),(649,14,67,'索尼SLT Alpha-55相机','shot by sony slt alpha-55',NULL,NULL,0,100,1,0,1682230836),(650,14,67,'索尼Alpha A7 III','shot by Sony Alpha A7 III',NULL,NULL,0,100,1,0,1689157096),(651,13,63,'超级细节','super details',NULL,NULL,0,100,1,0,1688814611),(652,14,67,'哈苏X1D','shot by Hasselblad X1D',NULL,NULL,0,100,1,0,1689157153),(653,124,138,'新世纪福音战士 - 碇真司','neon genesis evangelion - shinji ikari',NULL,NULL,0,100,1,0,1688358815),(654,14,67,'莱卡I型相机','shot by leica i',NULL,NULL,0,100,1,0,1682230836),(655,124,138,'新世纪福音战士 - 绫波零','neon genesis evangelion - rei ayanami',NULL,NULL,0,100,1,0,1688358815),(656,14,67,'柯尼卡Hexar AF相机','shot by konica hexar af',NULL,NULL,0,100,1,0,1682230836),(657,124,138,'新世纪福音战士 - 惣流·明日香·兰格雷','neon genesis evangelion - asuka langley soryu',NULL,NULL,0,100,1,0,1688358815),(658,14,67,'莱卡M6相机','shot by leica m6',NULL,NULL,0,100,1,0,1682230836),(659,14,67,'松下Lumix GH5S','shot by Panasonic Lumix GH5S',NULL,NULL,0,100,1,0,1689157275),(660,124,138,'新世纪福音战士 - 葛城美沙代','neon genesis evangelion - misato katsuragi',NULL,NULL,0,100,1,0,1688358815),(661,124,138,'新世纪福音战士 - 碇源堂','neon genesis evangelion - gendo ikari',NULL,NULL,0,100,1,0,1688358815),(662,124,138,'新世纪福音战士 - 赤木律子','neon genesis evangelion - ritsuko akagi',NULL,NULL,0,100,1,0,1688358815),(663,15,77,'阮挺恒','by Reggy Tong Liu',NULL,NULL,0,100,1,0,1682230836),(664,124,138,'新世纪福音战士 - 渚薰','neon genesis evangelion - kaworu nagisa',NULL,NULL,0,100,1,0,1688358815),(665,124,138,'新世纪福音战士 - 碇由衣','neon genesis evangelion - yui ikari',NULL,NULL,0,100,1,0,1688358815),(666,124,138,'新世纪福音战士 - 真希波·玛琳','neon genesis evangelion - mari makinami illustrious',NULL,NULL,0,100,1,0,1688358815),(667,124,138,'新世纪福音战士 - 铃原冬二','neon genesis evangelion - toji suzuhara',NULL,NULL,0,100,1,0,1688358815),(668,124,138,'海贼王 - 蒙奇·D·路飞','one piece - monkey d. luffy',NULL,NULL,0,100,1,0,1688358748),(669,124,138,'海贼王 - 罗罗诺亚·索隆','one piece - roronoa zoro',NULL,NULL,0,100,1,0,1688358748),(670,124,138,'海贼王 - 娜美','one piece - nami',NULL,NULL,0,100,1,0,1688358748),(671,124,138,'海贼王 - 乌索普','one piece - usopp',NULL,NULL,0,100,1,0,1688358748),(672,124,138,'海贼王 - 三治','one piece - sanji',NULL,NULL,0,100,1,0,1688358747),(673,124,138,'海贼王 - 托尼托尼·乔巴','one piece - tony tony chopper',NULL,NULL,0,100,1,0,1688358747),(674,15,77,'西蒙·吴','by Simon Ng',NULL,NULL,0,100,1,0,1682230836),(675,124,138,'海贼王 - 妮可·罗宾','one piece - nico robin',NULL,NULL,0,100,1,0,1688358747),(676,124,138,'海贼王 - 弗兰奇','one piece - franky',NULL,NULL,0,100,1,0,1688358747),(677,124,138,'海贼王 - 布鲁克','one piece - brook',NULL,NULL,0,100,1,0,1688358747),(678,124,138,'海贼王 - 甚平','one piece - jinbe',NULL,NULL,0,100,1,0,1688358747),(679,124,138,'海贼王 - 波特卡斯·D·艾斯','one piece - portgas d. ace',NULL,NULL,0,100,1,0,1688358747),(680,124,138,'海贼王 - 萨博','one piece - sabo',NULL,NULL,0,100,1,0,1688358747),(681,124,138,'海贼王 - 妮娜·霍尔特','one piece - boa hancock',NULL,NULL,0,100,1,0,1688358747),(682,124,138,'海贼王 - 特拉法尔加·D·沃特·罗','one piece - trafalgar d. water law',NULL,NULL,0,100,1,0,1688358747),(683,124,138,'海贼王 - 唐吉诃德·多佛朗明哥','one piece - donquixote doflamingo',NULL,NULL,0,100,1,0,1688358747),(684,124,138,'海贼王 - 布基','one piece - buggy',NULL,NULL,0,100,1,0,1688358747),(685,15,77,'智也','by Tomoya',NULL,NULL,0,100,1,0,1682230836),(686,124,138,'海贼王 - 德拉库拉·米霍克','one piece - dracule mihawk',NULL,NULL,0,100,1,0,1688358747),(687,124,138,'海贼王 - 香克斯','one piece - shanks',NULL,NULL,0,100,1,0,1688358747),(688,124,138,'海贼王 - 黑胡子','one piece - blackbeard',NULL,NULL,0,100,1,0,1688358747),(689,124,138,'海贼王 - 烟鬼','one piece - smoker',NULL,NULL,0,100,1,0,1688358747),(690,124,138,'海贼王 - 黄猿','one piece - kizaru',NULL,NULL,0,100,1,0,1688358747),(691,124,138,'海贼王 - 青雉','one piece - aokiji',NULL,NULL,0,100,1,0,1688358747),(692,124,138,'海贼王 - 红猿','one piece - akainu',NULL,NULL,0,100,1,0,1688358747),(693,124,138,'海贼王 - 布基托拉','one piece - fujitora',NULL,NULL,0,100,1,0,1688358747),(694,124,138,'海贼王 - 战国','one piece - sengoku',NULL,NULL,0,100,1,0,1688358747),(695,15,77,'仙桃','by Xian Tao',NULL,NULL,0,100,1,0,1682230836),(696,124,138,'海贼王 - 盖普','one piece - garp',NULL,NULL,0,100,1,0,1688358747),(697,124,138,'海贼王 - 凯多','one piece - kaido',NULL,NULL,0,100,1,0,1688358747),(698,124,138,'海贼王 - 哥尔·D·罗杰','one piece - big mom',NULL,NULL,0,100,1,0,1688358747),(699,124,138,'海贼王 - 哥尔·D·罗杰','one piece - gol d. roger',NULL,NULL,0,100,1,0,1688358747),(700,124,138,'海贼王 - 白胡子','one piece - shirohige',NULL,NULL,0,100,1,0,1688358747),(701,124,138,'海贼王 - 龙','one piece - dragon',NULL,NULL,0,100,1,0,1688358747),(702,124,138,'海贼王 - 安珀罗·伊万科夫','one piece - emporio ivankov',NULL,NULL,0,100,1,0,1688358747),(703,124,138,'海贼王 - 波萨利诺','one piece - borsalino',NULL,NULL,0,100,1,0,1688358747),(704,124,138,'海贼王 - 扎舵','one piece - tashigi',NULL,NULL,0,100,1,0,1688358747),(705,124,138,'灌篮高手 - 桜木花道','slam dunk - hanamichi sakuragi',NULL,NULL,0,100,1,0,1688358680),(706,15,77,'辛农·王','by Xinnong Wang',NULL,NULL,0,100,1,0,1682230836),(707,124,138,'灌篮高手 - 流川枫','slam dunk - kaede rukawa',NULL,NULL,0,100,1,0,1688358680),(708,124,138,'灌篮高手 - 赤木刚宪','slam dunk - takenori akagi',NULL,NULL,0,100,1,0,1688358680),(709,124,138,'灌篮高手 - 三井寿','slam dunk - hisashi mitsui',NULL,NULL,0,100,1,0,1688358680),(710,124,138,'灌篮高手 - 宫城良田','slam dunk - ryota miyagi',NULL,NULL,0,100,1,0,1688358680),(711,124,138,'灌篮高手 - 小暮公平','slam dunk - kiminobu kogure',NULL,NULL,0,100,1,0,1688358680),(712,124,138,'灌篮高手 - 安西光義','slam dunk - mitsuyoshi anzai',NULL,NULL,0,100,1,0,1688358680),(713,124,138,'灌篮高手 - 清田信长','slam dunk - nobunaga kiyota',NULL,NULL,0,100,1,0,1688358680),(714,124,138,'灌篮高手 - 牧伸一','slam dunk - shinichi maki',NULL,NULL,0,100,1,0,1688358680),(715,124,138,'灌篮高手 - 花形透','slam dunk - toru hanagata',NULL,NULL,0,100,1,0,1688358680),(716,124,138,'灌篮高手 - 福田吉兆','slam dunk - kicchou fukuda',NULL,NULL,0,100,1,0,1688358680),(717,15,77,'亚滕德','by Yatender',NULL,NULL,0,100,1,0,1682230836),(718,124,138,'灌篮高手 - 哲雄','slam dunk - tetsuo',NULL,NULL,0,100,1,0,1688358680),(719,124,138,'灌篮高手 - 森重广志','slam dunk - hiroshi morishige',NULL,NULL,0,100,1,0,1688358680),(720,124,138,'灌篮高手 - 長野充','slam dunk - mitsuru nagano',NULL,NULL,0,100,1,0,1688358680),(721,124,138,'宠物小精灵 - 皮卡丘','pokémon - pikachu',NULL,NULL,0,100,1,0,1688358447),(722,124,138,'宠物小精灵 - 小智','pokémon - ash ketchum',NULL,NULL,0,100,1,0,1688358447),(723,124,138,'宠物小精灵 - 小霞','pokémon - misty',NULL,NULL,0,100,1,0,1688358447),(724,124,138,'宠物小精灵 - 小刚','pokémon - brock',NULL,NULL,0,100,1,0,1688358447),(725,124,138,'宠物小精灵 - 喷火龙','pokémon - charizard',NULL,NULL,0,100,1,0,1688358447),(726,124,138,'宠物小精灵 - 妙蛙种子','pokémon - bulbasaur',NULL,NULL,0,100,1,0,1688358447),(727,124,138,'宠物小精灵 - 杰尼龟','pokémon - squirtle',NULL,NULL,0,100,1,0,1688358447),(728,15,78,'阿尔弗雷德·西斯莱','by Alfred Sisley',NULL,NULL,0,100,1,0,1682230836),(729,16,94,'动态的，充满活力的','dynamic',NULL,NULL,0,100,1,0,1682230836),(730,124,138,'宠物小精灵 - 胖丁','pokémon - jigglypuff',NULL,NULL,0,100,1,0,1688358447),(731,124,138,'宠物小精灵 - 喵喵','pokémon - meowth',NULL,NULL,0,100,1,0,1688358447),(732,124,138,'宠物小精灵 - 可达鸭','pokémon - psyduck',NULL,NULL,0,100,1,0,1688358447),(733,124,138,'宠物小精灵 - 波克比','pokémon - togepi',NULL,NULL,0,100,1,0,1688358447),(734,124,138,'宠物小精灵 - 侦探皮卡丘','pokémon - pikachu (detective)',NULL,NULL,0,100,1,0,1688358447),(735,124,138,'宠物小精灵 - 伊布','pokémon - eevee',NULL,NULL,0,100,1,0,1688358447),(736,124,138,'宠物小精灵 - 喵喵（阿罗拉形态）','pokémon - meowth (alolan form)',NULL,NULL,0,100,1,0,1688358447),(737,124,138,'宠物小精灵 - 超梦','pokémon - mewtwo',NULL,NULL,0,100,1,0,1688358447),(738,124,138,'宠物小精灵 - 小火龙','pokémon - charmander',NULL,NULL,0,100,1,0,1688358447),(739,124,138,'宠物小精灵 - 杰尼龟（杰尼龟小队）','pokémon - squirtle (squirtle squad)',NULL,NULL,0,100,1,0,1688358447),(740,15,78,'阿尔方斯·莫罗','by Alphonse Maureau',NULL,NULL,0,100,1,0,1682230836),(741,124,138,'宠物小精灵 - 卡比兽','pokémon - snorlax',NULL,NULL,0,100,1,0,1688358447),(742,124,138,'宠物小精灵 - 大岩蛇','pokémon - onix',NULL,NULL,0,100,1,0,1688358447),(743,124,138,'宠物小精灵 - 大比鸟','pokémon - pidgeot',NULL,NULL,0,100,1,0,1688358447),(744,124,138,'宠物小精灵 - 巴大蝶','pokémon - butterfree',NULL,NULL,0,100,1,0,1688358447),(745,124,138,'高达 - 阿姆罗·雷','gundam - amuro ray',NULL,NULL,0,100,1,0,1688358326),(746,124,138,'高达 - 查·阿兹纳布尔','gundam - char aznable',NULL,NULL,0,100,1,0,1688358326),(747,124,138,'高达 - 卡米尔·比丹','gundam - kamille bidan',NULL,NULL,0,100,1,0,1688358326),(748,124,138,'高达 - 朱代·阿斯塔','gundam - judau ashta',NULL,NULL,0,100,1,0,1688358326),(749,124,138,'高达 - 基拉·大和','gundam - kira yamato',NULL,NULL,0,100,1,0,1688358326),(750,124,138,'高达 - 亚斯兰·扎拉','gundam - athrun zala',NULL,NULL,0,100,1,0,1688358326),(751,15,78,'阿尔芒·吉约曼','by Armand Guillaumin',NULL,NULL,0,100,1,0,1682230836),(752,124,138,'高达 - 刹那·F·塞尔','gundam - setsuna f. seiei',NULL,NULL,0,100,1,0,1688358326),(753,124,138,'高达 - 修罗·尤','gundam - heero yuy',NULL,NULL,0,100,1,0,1688358326),(754,124,138,'高达 - 洛克昂·斯特拉托斯','gundam - lockon stratos',NULL,NULL,0,100,1,0,1688358326),(755,124,138,'高达 - 多洛·麦斯威尔','gundam - duo maxwell',NULL,NULL,0,100,1,0,1688358326),(756,124,138,'高达 - 特罗瓦·巴顿','gundam - trowa barton',NULL,NULL,0,100,1,0,1688358326),(757,124,138,'高达 - 坎卓·拉贝巴·温奈','gundam - quatre raberba winner',NULL,NULL,0,100,1,0,1688358326),(758,124,138,'高达 - 辛·阿斯卡','gundam - shinn asuka',NULL,NULL,0,100,1,0,1688358326),(759,124,138,'高达 - 刹那·F·塞尔（成年版）','gundam - setsuna f. seiei (adult)',NULL,NULL,0,100,1,0,1688358326),(760,124,138,'高达 - 阿雷路亚·哈普提斯','gundam - allelujah haptism',NULL,NULL,0,100,1,0,1688358326),(761,124,138,'高达 - 洛克昂·斯特拉托斯（尼尔·迪兰迪）','gundam - lockon stratos (neil dylandy)',NULL,NULL,0,100,1,0,1688358326),(762,15,78,'亚瑟·帕顿','by Arthur Parton',NULL,NULL,0,100,1,0,1682230836),(763,124,138,'高达 - 格拉汉姆·艾克','gundam - graham aker',NULL,NULL,0,100,1,0,1688358326),(764,124,138,'高达 - 里贝恩斯·奥马克','gundam - ribbons almark',NULL,NULL,0,100,1,0,1688358326),(765,124,138,'高达 - 提耶娅·艾尔德','gundam - tieria erde',NULL,NULL,0,100,1,0,1688358326),(766,124,138,'高达 - 刹那·F·塞尔（创造者）','gundam - setsuna f. seiei (innovator)',NULL,NULL,0,100,1,0,1688358326),(767,124,138,'银魂 - 坂田银时','gintama - gintoki sakata',NULL,NULL,0,100,1,0,1688358243),(768,124,138,'银魂 - 志村新八','gintama - shinpachi shimura',NULL,NULL,0,100,1,0,1688358243),(769,124,138,'银魂 - 神楽','gintama - kagura',NULL,NULL,0,100,1,0,1688358243),(770,124,138,'银魂 - 桂小太郎','gintama - kotaro katsura',NULL,NULL,0,100,1,0,1688358243),(771,124,138,'银魂 - 土方十四郎','gintama - toshiro hijikata',NULL,NULL,0,100,1,0,1688358243),(772,124,138,'银魂 - 沖田総悟','gintama - sougo okita',NULL,NULL,0,100,1,0,1688358243),(773,15,78,'贝丝·莫里索','by Berthe Morisot',NULL,NULL,0,100,1,0,1682230836),(774,124,138,'银魂 - 神威','gintama - kamui',NULL,NULL,0,100,1,0,1688358243),(775,124,138,'银魂 - 近藤勲','gintama - isao kondo',NULL,NULL,0,100,1,0,1688358243),(776,124,138,'银魂 - 月詠','gintama - tsukuyo',NULL,NULL,0,100,1,0,1688358243),(777,124,138,'银魂 - 猿飛あやめ','gintama - ayame sarutobi',NULL,NULL,0,100,1,0,1688358243),(778,124,138,'银魂 - 柳生九兵衛','gintama - kyubei yagyu',NULL,NULL,0,100,1,0,1688358243),(779,124,138,'银魂 - 木島また子','gintama - matako kijima',NULL,NULL,0,100,1,0,1688358243),(780,124,138,'银魂 - 銀兄','gintama - gintoki\'s older brother',NULL,NULL,0,100,1,0,1688358243),(781,124,138,'银魂 - 高杉晋助','gintama - shinsuke takasugi',NULL,NULL,0,100,1,0,1688358243),(782,124,138,'银魂 - 桂','gintama - katsuo',NULL,NULL,0,100,1,0,1688358243),(783,124,138,'银魂 - お登勢','gintama - otose',NULL,NULL,0,100,1,0,1688358243),(784,15,78,'卡米尔·皮萨罗','by Camille Pissarro',NULL,NULL,0,100,1,0,1682230836),(785,124,138,'银魂 - キャサリン','gintama - catherine',NULL,NULL,0,100,1,0,1688358243),(786,124,138,'银魂 - 志村妙','gintama - tae shimura',NULL,NULL,0,100,1,0,1688358243),(787,124,138,'银魂 - 長谷川泰三','gintama - hasegawa taizo',NULL,NULL,0,100,1,0,1688358243),(788,124,138,'银魂 - 睡虫','gintama - kyoshiro nemuri',NULL,NULL,0,100,1,0,1688358243),(789,124,138,'银魂 - 村田鉄子','gintama - tetsuko murata',NULL,NULL,0,100,1,0,1688358243),(790,124,138,'银魂 - 山崎退','gintama - yamazaki sagaru',NULL,NULL,0,100,1,0,1688358243),(791,124,138,'银魂 - 定春','gintama - sadaharu',NULL,NULL,0,100,1,0,1688358243),(792,124,138,'银魂 - 平賀源外','gintama - gengai hiraga',NULL,NULL,0,100,1,0,1688358243),(793,124,138,'银魂 - 服部全蔵','gintama - hattori zenzou',NULL,NULL,0,100,1,0,1688358243),(794,124,138,'银魂 - 阪本辰太郎','gintama - sakamoto tatsuma',NULL,NULL,0,100,1,0,1688358243),(795,124,138,'银魂 - 雀','gintama - suzuran',NULL,NULL,0,100,1,0,1688358243),(796,124,138,'银魂 - 志村姐','gintama - otae shimura',NULL,NULL,0,100,1,0,1688358243),(797,124,138,'银魂 - 武市変平太','gintama - takechi henpeita',NULL,NULL,0,100,1,0,1688358243),(798,124,138,'银魂 - 土方の母','gintama - hijikata\'s mother',NULL,NULL,0,100,1,0,1688358243),(799,124,138,'火影忍者 - うずまきナルト','naruto - naruto uzumaki',NULL,NULL,0,100,1,0,1688358077),(800,124,138,'火影忍者 - うちはサスケ','naruto - sasuke uchiha',NULL,NULL,0,100,1,0,1688358077),(801,124,138,'火影忍者 - 春野サクラ','naruto - sakura haruno',NULL,NULL,0,100,1,0,1688358077),(802,124,138,'火影忍者 - はたけカカシ','naruto - kakashi hatake',NULL,NULL,0,100,1,0,1688358077),(803,124,138,'火影忍者 - 自来也','naruto - jiraiya',NULL,NULL,0,100,1,0,1688358077),(804,124,138,'火影忍者 - 綱手','naruto - tsunade',NULL,NULL,0,100,1,0,1688358077),(805,124,138,'火影忍者 - うちはイタチ','naruto - itachi uchiha',NULL,NULL,0,100,1,0,1688358077),(806,124,138,'火影忍者 - 我愛羅','naruto - gaara',NULL,NULL,0,100,1,0,1688358077),(807,124,138,'火影忍者 - ロック・リー','naruto - rock lee',NULL,NULL,0,100,1,0,1688358077),(808,124,138,'火影忍者 - 日向ネジ','naruto - neji hyuga',NULL,NULL,0,100,1,0,1688358077),(809,124,138,'火影忍者 - 日向ヒナタ','naruto - hinata hyuga',NULL,NULL,0,100,1,0,1688358077),(810,124,138,'火影忍者 - 奈良シカマル','naruto - shikamaru nara',NULL,NULL,0,100,1,0,1688358077),(811,124,138,'火影忍者 - 秋道チョウジ','naruto - choji akimichi',NULL,NULL,0,100,1,0,1688358077),(812,124,138,'火影忍者 - 山中いの','naruto - ino yamanaka',NULL,NULL,0,100,1,0,1688358077),(813,124,138,'火影忍者 - 油女シノ','naruto - shino aburame',NULL,NULL,0,100,1,0,1688358077),(814,124,138,'火影忍者 - 犬塚キバ','naruto - kiba inuzuka',NULL,NULL,0,100,1,0,1688358077),(815,124,138,'火影忍者 - テンテン','naruto - tenten',NULL,NULL,0,100,1,0,1688358077),(816,124,138,'火影忍者 - テマリ','naruto - temari',NULL,NULL,0,100,1,0,1688358077),(817,124,138,'火影忍者 - カンクロウ','naruto - kankuro',NULL,NULL,0,100,1,0,1688358077),(818,124,138,'火影忍者 - マイト・ガイ','naruto - might guy',NULL,NULL,0,100,1,0,1688358077),(819,124,138,'火影忍者 - 大蛇丸','naruto - orochimaru',NULL,NULL,0,100,1,0,1688358077),(820,124,138,'火影忍者 - 薬師カブト','naruto - kabuto yakushi',NULL,NULL,0,100,1,0,1688358077),(821,124,138,'火影忍者 - サイ','naruto - sai',NULL,NULL,0,100,1,0,1688358077),(822,124,138,'火影忍者 - ヤマト','naruto - yamato',NULL,NULL,0,100,1,0,1688358077),(823,124,138,'火影忍者 - うちはオビト','naruto - obito uchiha',NULL,NULL,0,100,1,0,1688358077),(824,124,138,'火影忍者 - 長門','naruto - nagato',NULL,NULL,0,100,1,0,1688358077),(825,15,78,'埃米尔·雅各布·辛德勒','by Emil Jakob Schindler',NULL,NULL,0,100,1,0,1682230836),(826,124,138,'火影忍者 - 小南','naruto - konan',NULL,NULL,0,100,1,0,1688358077),(827,124,138,'火影忍者 - 波風ミナト','naruto - minato namikaze',NULL,NULL,0,100,1,0,1688358077),(828,124,138,'火影忍者 - うずまきクシナ','naruto - kushina uzumaki',NULL,NULL,0,100,1,0,1688358077),(829,124,138,'火影忍者 - 猿飛ヒルゼン','naruto - hiruzen sarutobi',NULL,NULL,0,100,1,0,1688358077),(830,124,138,'火影忍者 - 志村ダンゾウ','naruto - danzo shimura',NULL,NULL,0,100,1,0,1688358076),(831,124,138,'火影忍者 - うちはマダラ','naruto - madara uchiha',NULL,NULL,0,100,1,0,1688358076),(832,124,138,'火影忍者 - 千手柱間','naruto - hashirama senju',NULL,NULL,0,100,1,0,1688358076),(833,124,138,'火影忍者 - 千手扉間','naruto - tobirama senju',NULL,NULL,0,100,1,0,1688358076),(834,124,138,'一拳超人 - 埼玉','one punch man - saitama',NULL,NULL,0,100,1,0,1688357890),(835,124,138,'一拳超人 - 哲斯','one punch man - genos',NULL,NULL,0,100,1,0,1688357890),(836,15,78,'尤金·布丹','by Eugene Boudin',NULL,NULL,0,100,1,0,1682230836),(837,124,138,'一拳超人 - 托麻鬼','one punch man - tatsumaki',NULL,NULL,0,100,1,0,1688357890),(838,124,138,'一拳超人 - 金王','one punch man - king',NULL,NULL,0,100,1,0,1688357890),(839,124,138,'一拳超人 - 音速索尼克','one punch man - speed-o\'-sound sonic',NULL,NULL,0,100,1,0,1688357890),(840,124,138,'一拳超人 - 无面骑士','one punch man - mumen rider',NULL,NULL,0,100,1,0,1688357890),(841,124,138,'一拳超人 - 牙罗','one punch man - garou',NULL,NULL,0,100,1,0,1688357890),(842,124,138,'一拳超人 - 金属蝙蝠','one punch man - metal bat',NULL,NULL,0,100,1,0,1688357890),(843,124,138,'一拳超人 - 吹雪','one punch man - fubuki',NULL,NULL,0,100,1,0,1688357890),(844,124,138,'一拳超人 - 监狱杂志','one punch man - puri-puri prisoner',NULL,NULL,0,100,1,0,1688357890),(845,124,138,'一拳超人 - 看门狗人','one punch man - watchdog man',NULL,NULL,0,100,1,0,1688357890),(846,124,138,'一拳超人 - 原子武士','one punch man - atomic samurai',NULL,NULL,0,100,1,0,1688357890),(847,15,78,'弗雷德里克·巴兹尔','by Frederic Bazille',NULL,NULL,0,100,1,0,1682230836),(848,124,138,'一拳超人 - 童帝','one punch man - child emperor',NULL,NULL,0,100,1,0,1688357890),(849,124,138,'一拳超人 - 金属骑士','one punch man - metal knight',NULL,NULL,0,100,1,0,1688357890),(850,124,138,'一拳超人 - 不死斋','one punch man - zombieman',NULL,NULL,0,100,1,0,1688357890),(851,124,138,'一拳超人 - 超合金黑亮','one punch man - superalloy darkshine',NULL,NULL,0,100,1,0,1688357890),(852,124,138,'一拳超人 - 驱动骑士','one punch man - drive knight',NULL,NULL,0,100,1,0,1688357890),(853,124,138,'一拳超人 - 紧身背心师傅','one punch man - tanktop master',NULL,NULL,0,100,1,0,1688357890),(854,124,138,'一拳超人 - 甜面具','one punch man - sweet mask',NULL,NULL,0,100,1,0,1688357890),(855,124,138,'一拳超人 - 地狱的暴风雪','one punch man - blizzard of hell',NULL,NULL,0,100,1,0,1688357890),(856,124,138,'一拳超人 - 梅尔泽根德','one punch man - melzalgald',NULL,NULL,0,100,1,0,1688357890),(857,124,138,'一拳超人 - 巨大化的福克斯','one punch man - gouketsu',NULL,NULL,0,100,1,0,1688357890),(858,15,78,'古斯塔夫·凯尔博特','by Gustave Caillebotte',NULL,NULL,0,100,1,0,1682230836),(859,124,138,'一拳超人 - 超级选手','one punch man - choze',NULL,NULL,0,100,1,0,1688357890),(860,124,138,'进击的巨人 - 艾伦·耶格尔','attack on titan - eren yeager',NULL,NULL,0,100,1,0,1688357733),(861,124,138,'进击的巨人 - 米卡·阿克曼','attack on titan - mikasa ackerman',NULL,NULL,0,100,1,0,1688357733),(862,124,138,'进击的巨人 - 阿尔敏·阿鲁莱特','attack on titan - armin arlert',NULL,NULL,0,100,1,0,1688357733),(863,124,138,'进击的巨人 - 利维·阿克曼','attack on titan - levi ackerman',NULL,NULL,0,100,1,0,1688357733),(864,124,138,'进击的巨人 - 厄尔文·史密斯','attack on titan - erwin smith',NULL,NULL,0,100,1,0,1688357733),(865,124,138,'进击的巨人 - 汉吉·琐伊','attack on titan - hange zoë',NULL,NULL,0,100,1,0,1688357733),(866,124,138,'进击的巨人 - 让·基尔斯坦','attack on titan - jean kirstein',NULL,NULL,0,100,1,0,1688357733),(867,124,138,'进击的巨人 - 萨莎·布劳斯','attack on titan - sasha blouse',NULL,NULL,0,100,1,0,1688357733),(868,124,138,'进击的巨人 - 康尼·斯普林格','attack on titan - connie springer',NULL,NULL,0,100,1,0,1688357733),(869,15,78,'哈丽特·巴克尔','by Harriet Backer',NULL,NULL,0,100,1,0,1682230836),(870,124,138,'进击的巨人 - 历史亚·雷斯','attack on titan - historia reiss',NULL,NULL,0,100,1,0,1688357733),(871,124,138,'进击的巨人 - 莱纳·布朗','attack on titan - reiner braun',NULL,NULL,0,100,1,0,1688357733),(872,124,138,'进击的巨人 - 贝尔托特·胡佛','attack on titan - bertholdt hoover',NULL,NULL,0,100,1,0,1688357733),(873,124,138,'进击的巨人 - 安妮·莱昂哈特','attack on titan - annie leonhart',NULL,NULL,0,100,1,0,1688357733),(874,124,138,'进击的巨人 - 齐克·耶格尔','attack on titan - zeke yeager',NULL,NULL,0,100,1,0,1688357733),(875,124,138,'进击的巨人 - 伊米尔','attack on titan - ymir',NULL,NULL,0,100,1,0,1688357733),(876,124,138,'进击的巨人 - 皮克·芬格','attack on titan - pieck finger',NULL,NULL,0,100,1,0,1688357733),(877,124,138,'进击的巨人 - 加比·布劳恩','attack on titan - gabi braun',NULL,NULL,0,100,1,0,1688357733),(878,15,78,'约翰·巴尔索尔德·容金','by Johan Barthold Jongkind',NULL,NULL,0,100,1,0,1682230836),(879,15,78,'约翰·J·恩尼金','by John J. Enneking',NULL,NULL,0,100,1,0,1682230836),(880,15,78,'路易斯·希梅内斯·阿兰达','by Luis Jimenez Aranda',NULL,NULL,0,100,1,0,1682230836),(881,15,78,'玛丽·布拉克蒙','by Marie Bracquemond',NULL,NULL,0,100,1,0,1682230836),(882,15,78,'马丁·里科·伊·奥特加','by Martin Rico y Ortega',NULL,NULL,0,100,1,0,1682230836),(883,15,78,'玛丽·卡萨特','by Mary Cassatt',NULL,NULL,0,100,1,0,1682230836),(884,15,78,'马克斯·利伯曼','by Max Liebermann',NULL,NULL,0,100,1,0,1682230836),(885,16,94,'情感的，感性的','emotional',NULL,NULL,0,100,1,0,1682230836),(886,13,64,'16K','16k',NULL,NULL,0,100,1,0,1688267387),(887,14,139,'专业摄影','professional photography',NULL,NULL,0,100,1,0,1688267387),(889,14,139,'极其详细 HDR','incredibly detailed hdr',NULL,NULL,0,100,1,0,1688267387),(890,14,139,'惊人质量','amazing quality',NULL,NULL,0,100,1,0,1688267387),(891,14,139,'清晰细节','sharp details',NULL,NULL,0,100,1,0,1688267387),(892,15,78,'皮埃尔-奥古斯特·雷诺瓦','by Pierre-Auguste Renoir',NULL,NULL,0,100,1,0,1682230836),(893,13,63,'最大细节','max detail',NULL,NULL,0,100,1,0,1688267387),(894,14,139,'锐化','sharpen',NULL,NULL,0,100,1,0,1688267387),(895,13,63,'最佳质量','best quality',NULL,NULL,0,100,1,0,1688814611),(896,14,139,'超细节','hyperdetailed',NULL,NULL,0,100,1,0,1688267387),(897,13,63,'超高清','ultra hd',NULL,NULL,0,100,1,0,1688267387),(898,14,139,'商业感','business sense',NULL,NULL,0,100,1,0,1688267387),(899,142,101,'白天光','Daylight',NULL,NULL,0,100,1,0,1682230836),(900,13,63,'美丽而新颖的拍摄角度','beautiful and novel shooting angle',NULL,NULL,0,100,1,0,1688267387),(901,142,101,'平面光线','Flat light',NULL,NULL,0,100,1,0,1682230836),(902,142,101,'正面光线','Front lighting',NULL,NULL,0,100,1,0,1682230836),(903,14,139,'独特的美丽','unique beauty',NULL,NULL,0,100,1,0,1688267387),(904,142,101,'半背光','Half-rear lighting',NULL,NULL,0,100,1,0,1682230836),(905,15,78,'斯坦尼斯拉斯·勒平','by Stanislas Lepine',NULL,NULL,0,100,1,0,1682230836),(906,13,63,'闪亮的/光泽的','shiny/glossy',NULL,NULL,0,100,1,0,1688267387),(907,14,139,'纯白背景','pure white background',NULL,NULL,0,100,1,0,1688267387),(908,142,101,'背景光','Background light',NULL,NULL,0,100,1,0,1682230836),(909,142,101,'早晨光线','Morning light',NULL,NULL,0,100,1,0,1685329123),(910,14,139,'采用微妙的单色色调','in the style of subtle monochromatic tones',NULL,NULL,0,100,1,0,1688267387),(911,16,96,'角色肖像最佳质量','character portrait best quality',NULL,NULL,0,100,1,0,1688265999),(912,142,101,'阳光','Sunlight',NULL,NULL,0,100,1,0,1682230836),(913,16,96,'对称 + 详细 + 卡拉瓦乔光线风格','symmetrical + detailed + Caravaggio lighting style',NULL,NULL,0,100,1,0,1688265999),(914,142,101,'金色光线','Golden light',NULL,NULL,0,100,1,0,1682230836),(915,16,96,'光线追踪','ray tracing',NULL,NULL,0,100,1,0,1688265999),(916,142,101,'黄金时光','During golden hour',NULL,NULL,0,100,1,0,1682230836),(917,16,96,'浅景深','shallow depth of field',NULL,NULL,0,100,1,0,1688265999),(918,142,101,'月光','Moonlit',NULL,NULL,0,100,1,0,1682230836),(919,16,96,'高动态范围','HDR',NULL,NULL,0,100,1,0,1688265999),(920,142,101,'轮廓光线','Contour light',NULL,NULL,0,100,1,0,1682230836),(921,16,96,'高分辨率','high resolution',NULL,NULL,0,100,1,0,1688265999),(922,16,96,'丰富的细节','lush detail',NULL,NULL,0,100,1,0,1688265999),(923,15,79,'艾丹·韦查德','by Aidan Weichard',NULL,NULL,0,100,1,0,1682230836),(924,142,101,'镜头耀斑','Lens flare',NULL,NULL,0,100,1,0,1682230836),(925,142,101,'完美照明','Perfect lighting',NULL,NULL,0,100,1,0,1685329123),(926,142,101,'发光暗中','Glow in the dark',NULL,NULL,0,100,1,0,1682230836),(927,16,96,'图片具有冲击力','the picture has impact',NULL,NULL,0,100,1,0,1688265999),(928,142,101,'强调照明','Accent lighting',NULL,NULL,0,100,1,0,1682230836),(929,16,96,'充满细节的角色','characters full of details',NULL,NULL,0,100,1,0,1688265999),(930,142,101,'折射光线','Deflecting light',NULL,NULL,0,100,1,0,1685329123),(931,142,101,'泛光灯','Floodlight',NULL,NULL,0,100,1,0,1682230836),(932,142,101,'强光','Strong light',NULL,NULL,0,100,1,0,1682230836),(933,142,101,'戏剧照明','Dramatic lighting',NULL,NULL,0,100,1,0,1685329123),(934,142,101,'美丽的照明','Beautiful lighting',NULL,NULL,0,100,1,0,1685329123),(935,142,101,'聚光灯','Spotlight',NULL,NULL,0,100,1,0,1682230836),(936,142,101,'经典单色摄影','Classic monochrome photography',NULL,NULL,0,100,1,0,1682230836),(937,142,101,'氛围照明','Atmospheric lighting',NULL,NULL,0,100,1,0,1685329123),(938,142,101,'低光照明','Low light',NULL,NULL,0,100,1,0,1685329123),(939,142,101,'辐射夜晚氛围照明','Radiant night atmospheric lighting',NULL,NULL,0,100,1,0,1685329123),(940,142,101,'清晰光线','Clear light complexion',NULL,NULL,0,100,1,0,1685329123),(941,142,101,'顶部光源','Top light',NULL,NULL,0,100,1,0,1682230836),(942,142,101,'逆光照明','Contre-jour lighting',NULL,NULL,0,100,1,0,1682230836),(943,142,101,'史诗般的照明','Epic lighting',NULL,NULL,0,100,1,0,1685329123),(944,142,101,'红调摄影','Redscale photography',NULL,NULL,0,100,1,0,1682230836),(945,142,101,'红外摄影','Infrared photography',NULL,NULL,0,100,1,0,1682230836),(946,142,101,'柔光','Soft lighting',NULL,NULL,0,100,1,0,1682230836),(947,142,101,'光波效果','Light waves',NULL,NULL,0,100,1,0,1685329123),(948,142,101,'发光效果','Glowing',NULL,NULL,0,100,1,0,1682230836),(949,142,101,'光线效果','Light rays',NULL,NULL,0,100,1,0,1682230836),(950,142,101,'交织明暗','Interlaced light and shadow',NULL,NULL,0,100,1,0,1682230836),(951,142,101,'电影照明','Cinematic lighting',NULL,NULL,0,100,1,0,1682230836),(952,142,101,'柔和照明','Soft illumination',NULL,NULL,0,100,1,0,1682230836),(953,142,101,'圣诞灯光','Christmas lights',NULL,NULL,0,100,1,0,1682230836),(954,142,101,'全局光照','Global illuminations',NULL,NULL,0,100,1,0,1685329123),(955,15,79,'亨利·卢梭','by Henri Rousseau',NULL,NULL,0,100,1,0,1682230836),(956,142,101,'太阳化','Solarised',NULL,NULL,0,100,1,0,1682230836),(957,142,101,'轮廓剪影','Silhouette',NULL,NULL,0,100,1,0,1682230836),(958,142,101,'闪烁光线','Rays of shimmering light',NULL,NULL,0,100,1,0,1682230836),(959,142,101,'温暖照明','Warming lighting',NULL,NULL,0,100,1,0,1685329123),(960,15,79,'葛饰北斋','by Katsushika Hokusai',NULL,NULL,0,100,1,0,1682230836),(961,142,101,'专业肖像照明','Professional portrait lighting',NULL,NULL,0,100,1,0,1688267387),(962,15,79,'埃特尔·阿德南','by Etel Adnan',NULL,NULL,0,100,1,0,1682230836),(963,15,79,'奥普拉·戈尼克','by April Gornik',NULL,NULL,0,100,1,0,1682230836),(964,16,94,'充满活力的，精力充沛的','energetic',NULL,NULL,0,100,1,0,1682230836),(965,16,90,'卓越的细节','superb detail',NULL,NULL,0,100,1,0,1687919500),(966,16,90,'清洁的背景','clean background',NULL,NULL,0,100,1,0,1687919500),(967,15,79,'弗雷德里克·埃德温·丘奇','by Frederic Edwin Church',NULL,NULL,0,100,1,0,1682230836),(968,4,136,'牛','ox',NULL,NULL,0,100,1,0,1685336010),(969,7,135,'白云','puffy clouds',NULL,NULL,0,100,1,0,1685331335),(970,7,135,'黑烟','black smoke',NULL,NULL,0,100,1,0,1685331335),(971,7,135,'光滑的雾','smooth fog',NULL,NULL,0,100,1,0,1685331335),(972,7,135,'阴云','cloudy',NULL,NULL,0,100,1,0,1685331335),(973,7,135,'引人注目的云','dramatic clouds',NULL,NULL,0,100,1,0,1685331335),(974,15,79,'哈罗德·安卡特','by Harold Ancart',NULL,NULL,0,100,1,0,1682230836),(975,7,135,'暴风雨','thunderstorms',NULL,NULL,0,100,1,0,1685331335),(976,7,135,'暴风雨的海面','stormy ocean',NULL,NULL,0,100,1,0,1685331335),(977,7,135,'海洋背景','ocean backdrop',NULL,NULL,0,100,1,0,1685331335),(978,7,135,'落日','dawn',NULL,NULL,0,100,1,0,1685331335),(979,7,135,'日出','sunrise',NULL,NULL,0,100,1,0,1685331335),(980,7,135,'薄雾','ethereal fog',NULL,NULL,0,100,1,0,1685331335),(981,7,135,'冰河','frozen river',NULL,NULL,0,100,1,0,1685331335),(982,7,135,'阴暗的天','gloomy night',NULL,NULL,0,100,1,0,1685331335),(983,7,135,'旋转的尘埃','swirlying dust',NULL,NULL,0,100,1,0,1685331335),(984,7,135,'深渊','abyss',NULL,NULL,0,100,1,0,1685331335),(985,7,135,'非高温发光现象','candoluminescence',NULL,NULL,0,100,1,0,1685331335),(986,7,135,'地平线','skyline',NULL,NULL,0,100,1,0,1685331335),(987,15,79,'因贾拉克艺术','by Injalak Arts',NULL,NULL,0,100,1,0,1682230836),(988,7,135,'地形','terrain',NULL,NULL,0,100,1,0,1685331335),(989,7,135,'旋风漩涡','vortex',NULL,NULL,0,100,1,0,1685331335),(990,15,79,'伊万·艾瓦佐夫斯基','by Ivan Aivazovsky',NULL,NULL,0,100,1,0,1682230836),(991,15,79,'乔安娜·希尔德布兰特','by Johanna Hildebrandt',NULL,NULL,0,100,1,0,1682230836),(992,15,79,'约翰·詹姆斯·奥杜邦','by John James Audubon',NULL,NULL,0,100,1,0,1682230836),(993,142,101,'暗室','Dark room',NULL,NULL,0,100,1,0,1685329124),(994,15,79,'乔纳·金顿','by Jonna Jinton',NULL,NULL,0,100,1,0,1682230836),(995,142,101,'头发光线','Hairlight',NULL,NULL,0,100,1,0,1685329124),(996,142,101,'背景色斑','Color spot background',NULL,NULL,0,100,1,0,1685329124),(997,142,101,'漫射光线','Diffuse light',NULL,NULL,0,100,1,0,1685329123),(998,15,79,'卡伦·科尔','by Karen Coull',NULL,NULL,0,100,1,0,1682230836),(999,142,101,'黑暗','Darkness',NULL,NULL,0,100,1,0,1685329123),(1000,142,101,'夜晚照明','Night lighting',NULL,NULL,0,100,1,0,1682230836),(1001,142,101,'营火照明','Campfire lighting',NULL,NULL,0,100,1,0,1682230836),(1002,11,157,'复古波','retrowave',NULL,NULL,0,100,1,0,1682230836),(1003,142,101,'灯笼','Lantern',NULL,NULL,0,100,1,0,1682230836),(1004,142,101,'烛光','Candlelight',NULL,NULL,0,100,1,0,1682230836),(1005,142,101,'螢光棒','Glow stick',NULL,NULL,0,100,1,0,1682230836),(1006,142,101,'荧光灯','Fluorescent bulb',NULL,NULL,0,100,1,0,1682230836),(1007,142,101,'霓虹灯光','Neon lights',NULL,NULL,0,100,1,0,1685329123),(1008,15,79,'卡特琳娜·阿帕勒','by Katerina Apale',NULL,NULL,0,100,1,0,1682230836),(1009,142,101,'LED灯光','LED lights',NULL,NULL,0,100,1,0,1682230836),(1010,142,101,'顶部照明','Overhead light',NULL,NULL,0,100,1,0,1685329123),(1011,142,101,'悬挂光源','A light suspended',NULL,NULL,0,100,1,0,1685329123),(1012,142,101,'低关键照明','Low key lighting',NULL,NULL,0,100,1,0,1685329123),(1013,142,101,'动态照明','Dynamic lighting',NULL,NULL,0,100,1,0,1685329123),(1014,11,161,'电影风格','cinematic style',NULL,NULL,0,100,1,0,1685329019),(1015,15,79,'基里安·舍恩贝格','by Kilian Schönberger',NULL,NULL,0,100,1,0,1682230836),(1016,11,161,'黑色电影','film noir',NULL,NULL,0,100,1,0,1685329020),(1017,142,101,'卡拉瓦乔风格','Elegance + epic + symmetrical + detailed + Caravaggio lighting style',NULL,NULL,0,100,1,0,1685329123),(1018,133,55,'新巴洛克','neo-baroque',NULL,NULL,0,100,1,0,1682230836),(1019,133,55,'新拜占庭','neo-byzantine',NULL,NULL,0,100,1,0,1682230836),(1020,15,79,'莉莉安娜·吉戈维奇','by Liliana Gigovic',NULL,NULL,0,100,1,0,1682230836),(1021,11,140,'新洛可可','neo-rococo',NULL,NULL,0,100,1,0,1682230836),(1022,15,79,'卢卡斯·阿鲁达','by Lucas Arruda',NULL,NULL,0,100,1,0,1682230836),(1023,16,94,'令人兴奋的，激动人心的','exciting',NULL,NULL,0,100,1,0,1682230836),(1024,11,140,'新印象主义','Neo-Impressionism',NULL,NULL,0,100,1,0,1685329020),(1025,11,48,'可爱','kawaii',NULL,NULL,0,100,1,0,1682230836),(1026,11,48,'未来放克','futurefunk',NULL,NULL,0,100,1,0,1682230836),(1027,15,79,'林恩·库克','by Lyn Cooke',NULL,NULL,0,100,1,0,1682230836),(1028,11,140,'幻觉艺术','Visionary Art',NULL,NULL,0,100,1,0,1685329020),(1029,11,48,'哔哩哔哩','pixiv',NULL,NULL,0,100,1,0,1685329019),(1030,11,48,'数字插图','digital illustration',NULL,NULL,0,100,1,0,1685329020),(1031,11,161,'微型模型电影','miniature model film',NULL,NULL,0,100,1,0,1685329019),(1032,15,79,'玛丽·简·奥利弗','by Mary Jane Oliver',NULL,NULL,0,100,1,0,1682230836),(1033,5,28,'鲜艳的颜色','vivid colours',NULL,NULL,0,100,1,0,1685328935),(1034,15,79,'米兰达·劳埃德','by Miranda Lloyd',NULL,NULL,0,100,1,0,1682230836),(1035,12,162,'水墨画','ink painting',NULL,NULL,0,100,1,0,1685329020),(1036,5,26,'玫瑰花开','rose bloom',NULL,NULL,0,100,1,0,1685328935),(1037,5,26,'紫红色','fuchsia red',NULL,NULL,0,100,1,0,1685328935),(1038,5,26,'紫红色','fuchsia pink',NULL,NULL,0,100,1,0,1685328935),(1039,5,26,'高粱红','kaoliang red',NULL,NULL,0,100,1,0,1685328935),(1040,11,140,'同步主义','synchronism',NULL,NULL,0,100,1,0,1685329019),(1041,5,26,'砖红色','brick red',NULL,NULL,0,100,1,0,1685328935),(1042,15,79,'尼古拉斯·罗里奇','by Nicholas Roerich',NULL,NULL,0,100,1,0,1682230836),(1043,5,26,'橄榄黄','olive yellow',NULL,NULL,0,100,1,0,1685328935),(1044,5,26,'玉米色','maize',NULL,NULL,0,100,1,0,1685328935),(1045,11,160,'概念艺术','concept art',NULL,NULL,0,100,1,0,1685329019),(1046,5,26,'杏黄色','apricot',NULL,NULL,0,100,1,0,1685328935),(1047,5,26,'土黄色','earth yellow',NULL,NULL,0,100,1,0,1685328935),(1048,5,26,'杏仁奶油色','apricot cream',NULL,NULL,0,100,1,0,1685328935),(1049,5,26,'豌豆绿','pea green',NULL,NULL,0,100,1,0,1685328935),(1050,11,48,'沃霍尔','warhol',NULL,NULL,0,100,1,0,1685329019),(1051,5,26,'苔藓绿','moss green',NULL,NULL,0,100,1,0,1685328935),(1052,5,26,'海蓝绿','marine green',NULL,NULL,0,100,1,0,1685328935),(1053,11,48,'非虚构','non-fiction',NULL,NULL,0,100,1,0,1685329019),(1054,5,26,'茄子色','aubergine',NULL,NULL,0,100,1,0,1685328935),(1055,15,79,'保罗·马尔戈西','by Paul Margocsy',NULL,NULL,0,100,1,0,1682230836),(1056,5,26,'葡萄干色','raisin',NULL,NULL,0,100,1,0,1685328935),(1057,5,26,'灰紫色','grey violet',NULL,NULL,0,100,1,0,1685328935),(1058,5,26,'墨黑色','pitch-black',NULL,NULL,0,100,1,0,1685328935),(1059,5,26,'偏白色','off-white',NULL,NULL,0,100,1,0,1685328934),(1060,5,26,'鸽灰色','dove grey',NULL,NULL,0,100,1,0,1685328934),(1061,5,26,'混凝土灰色','concrete grey',NULL,NULL,0,100,1,0,1685328934),(1062,5,26,'烟灰色','smoky grey',NULL,NULL,0,100,1,0,1685328934),(1063,15,79,'皮特·布吕盖尔(老)','by Pieter Bruegel the Elder',NULL,NULL,0,100,1,0,1682230836),(1064,5,26,'红褐色','reddish brown',NULL,NULL,0,100,1,0,1685328934),(1065,15,79,'井上楽','by Raku Inoue',NULL,NULL,0,100,1,0,1682230836),(1066,16,94,'富有表现力的，表情丰富的','expressive',NULL,NULL,0,100,1,0,1682230836),(1067,5,26,'阳光橙','sunny orange',NULL,NULL,0,100,1,0,1685328934),(1068,15,79,'理查德·迪本康','by Richard Diebenkorn',NULL,NULL,0,100,1,0,1682230836),(1069,5,26,'桃花色','peach blossom',NULL,NULL,0,100,1,0,1685328934),(1070,5,26,'樱桃色','cherry',NULL,NULL,0,100,1,0,1685328934),(1071,5,26,'橘红色','tangerine',NULL,NULL,0,100,1,0,1685328934),(1072,5,26,'紫红色','purplish red',NULL,NULL,0,100,1,0,1685328934),(1073,5,26,'辣椒红','capsicum red',NULL,NULL,0,100,1,0,1685328934),(1074,5,26,'流氓红','rogue red',NULL,NULL,0,100,1,0,1685328934),(1075,15,79,'萨莉·布朗','by Sally Browne',NULL,NULL,0,100,1,0,1682230836),(1076,5,26,'玛瑙红','agate red',NULL,NULL,0,100,1,0,1685328934),(1077,5,26,'红宝石红','ruby red',NULL,NULL,0,100,1,0,1685328934),(1078,5,26,'铁锈红','rust red',NULL,NULL,0,100,1,0,1685328934),(1079,5,26,'粉红色','pinkish red',NULL,NULL,0,100,1,0,1685328934),(1080,5,26,'深红色','dark red',NULL,NULL,0,100,1,0,1685328934),(1081,5,26,'猩红色','scarlet',NULL,NULL,0,100,1,0,1685328934),(1082,15,79,'西蒙·贝克','by Simon Beck',NULL,NULL,0,100,1,0,1682230836),(1083,5,26,'阳光黄','sunny yellow',NULL,NULL,0,100,1,0,1685328934),(1084,5,26,'浅黄色','light yellow',NULL,NULL,0,100,1,0,1685328934),(1085,5,26,'豆绿色','bean green',NULL,NULL,0,100,1,0,1685328934),(1086,15,79,'托马斯·科尔','by Thomas Cole',NULL,NULL,0,100,1,0,1682230836),(1087,5,26,'苹果绿','apple green',NULL,NULL,0,100,1,0,1685328934),(1088,5,26,'草绿色','grass green',NULL,NULL,0,100,1,0,1685328934),(1089,5,26,'水晶绿','crystal green',NULL,NULL,0,100,1,0,1685328934),(1090,5,26,'深绿色','blackish green',NULL,NULL,0,100,1,0,1685328934),(1091,5,26,'翡翠绿','emerald green',NULL,NULL,0,100,1,0,1685328934),(1092,15,79,'托马斯·桑切斯','by Tomás Sánchez',NULL,NULL,0,100,1,0,1682230836),(1093,5,26,'花蓝色','flower blue',NULL,NULL,0,100,1,0,1685328934),(1094,5,26,'天蓝色','sky-clearing blue',NULL,NULL,0,100,1,0,1685328934),(1095,5,26,'电蓝色','electric blue',NULL,NULL,0,100,1,0,1685328934),(1096,5,26,'蓝灰色','bluish',NULL,NULL,0,100,1,0,1685328934),(1097,15,79,'维娅·塞尔明斯','by Vija Celmins',NULL,NULL,0,100,1,0,1682230836),(1098,5,26,'酸蓝色','acid blue',NULL,NULL,0,100,1,0,1685328934),(1099,5,26,'鲜蓝色','vivid blue',NULL,NULL,0,100,1,0,1685328934),(1100,5,26,'冰雪蓝','ice-snow blue',NULL,NULL,0,100,1,0,1685328934),(1101,5,26,'孔雀蓝','peacock blue',NULL,NULL,0,100,1,0,1685328934),(1102,5,26,'钴蓝色','cobalt blue',NULL,NULL,0,100,1,0,1685328934),(1103,15,79,'王翚','by Wang Hui',NULL,NULL,0,100,1,0,1682230836),(1104,5,26,'紫蓝色','purplish blue',NULL,NULL,0,100,1,0,1685328934),(1105,5,26,'钴蓝色','ultramarine',NULL,NULL,0,100,1,0,1685328934),(1106,5,26,'葡萄色','grape',NULL,NULL,0,100,1,0,1685328934),(1107,5,26,'玫瑰紫色','rose violet',NULL,NULL,0,100,1,0,1685328934),(1108,15,79,'韦恩·蒂博','by Wayne Thiebaud',NULL,NULL,0,100,1,0,1682230836),(1109,5,26,'深红紫色','dark reddish purple',NULL,NULL,0,100,1,0,1685328934),(1110,5,26,'紫灰色','violet ash',NULL,NULL,0,100,1,0,1685328934),(1111,5,26,'煤黑色','coal black',NULL,NULL,0,100,1,0,1685328934),(1112,5,26,'碳黑色','carbon black',NULL,NULL,0,100,1,0,1685328934),(1113,5,26,'暗黑色','dull black',NULL,NULL,0,100,1,0,1685328934),(1114,5,26,'牡蛎白','oyster white',NULL,NULL,0,100,1,0,1685328934),(1115,5,26,'梨白色','pear white',NULL,NULL,0,100,1,0,1685328934),(1116,5,26,'翡翠白','jade white',NULL,NULL,0,100,1,0,1685328934),(1117,5,26,'银白色','silver white',NULL,NULL,0,100,1,0,1685328934),(1118,5,26,'锌白色','zinc white',NULL,NULL,0,100,1,0,1685328934),(1119,5,26,'贝壳白','shell',NULL,NULL,0,100,1,0,1685328934),(1120,5,26,'乳白色','milky-white',NULL,NULL,0,100,1,0,1685328934),(1121,5,26,'雪白色','snowy white',NULL,NULL,0,100,1,0,1685328934),(1122,16,94,'兴高采烈的，热情洋溢的','exuberant',NULL,NULL,0,100,1,0,1682230836),(1123,5,26,'灰白色','greyish white',NULL,NULL,0,100,1,0,1685328934),(1124,5,26,'纯白色','crisp-white',NULL,NULL,0,100,1,0,1685328934),(1125,5,26,'银灰色','silver grey',NULL,NULL,0,100,1,0,1685328934),(1126,5,26,'铁灰色','iron grey',NULL,NULL,0,100,1,0,1685328934),(1127,5,26,'铅灰色','leaden grey',NULL,NULL,0,100,1,0,1685328934),(1128,5,26,'木炭灰色','charcoal grey',NULL,NULL,0,100,1,0,1685328934),(1129,5,26,'淡紫色','pale lilac',NULL,NULL,0,100,1,0,1685328934),(1130,5,26,'雾灰色','misty grey',NULL,NULL,0,100,1,0,1685328934),(1131,5,26,'钢铁灰色','steel grey',NULL,NULL,0,100,1,0,1685328934),(1132,5,26,'苍白','lividity',NULL,NULL,0,100,1,0,1685328934),(1133,5,26,'淡灰色','pale grey',NULL,NULL,0,100,1,0,1685328934),(1134,5,26,'灰白色','ash grey',NULL,NULL,0,100,1,0,1685328934),(1135,5,26,'乡村棕色','rustic brown',NULL,NULL,0,100,1,0,1685328934),(1136,5,26,'橙褐色','orange brown',NULL,NULL,0,100,1,0,1685328934),(1137,5,26,'橄榄棕色','olive brown',NULL,NULL,0,100,1,0,1685328934),(1138,5,26,'黑褐色','black brown',NULL,NULL,0,100,1,0,1685328934),(1139,5,26,'黄棕色','fulvous',NULL,NULL,0,100,1,0,1685328934),(1140,5,26,'栗色','chestnut brown',NULL,NULL,0,100,1,0,1685328934),(1141,5,26,'褐紫灰色','taupe',NULL,NULL,0,100,1,0,1685328934),(1142,5,26,'黄褐色','umber',NULL,NULL,0,100,1,0,1685328934),(1143,5,26,'古蜜琥珀','succinite',NULL,NULL,0,100,1,0,1685328934),(1144,5,26,'锈色','rust',NULL,NULL,0,100,1,0,1685328934),(1145,15,80,'奥黛丽·弗莱克','by Audrey Flack',NULL,NULL,0,100,1,0,1682230836),(1146,5,26,'黄铜色','brassiness',NULL,NULL,0,100,1,0,1685328934),(1147,5,26,'木头','wood',NULL,NULL,0,100,1,0,1685328934),(1148,5,26,'淡紫色','pale mauve',NULL,NULL,0,100,1,0,1685328934),(1149,5,26,'康乃馨','carnation',NULL,NULL,0,100,1,0,1685328934),(1150,15,80,'查尔斯·贝尔','by Charles Bell',NULL,NULL,0,100,1,0,1682230836),(1151,5,26,'彩虹色','iridescent',NULL,NULL,0,100,1,0,1685328934),(1152,5,26,'彩虹色','rainbow',NULL,NULL,0,100,1,0,1685328934),(1153,5,26,'陶器红色','pottery red',NULL,NULL,0,100,1,0,1685328934),(1154,5,26,'秋季棕色','autumn brown',NULL,NULL,0,100,1,0,1685328934),(1155,5,26,'海上漂流木色','driftwood',NULL,NULL,0,100,1,0,1685328934),(1156,15,80,'查克·克洛斯','by Chuck Close',NULL,NULL,0,100,1,0,1682230836),(1157,5,26,'赭色混合色','sienna blend',NULL,NULL,0,100,1,0,1685328934),(1158,133,134,'配件','accessory',NULL,NULL,0,100,1,0,1685328670),(1159,133,134,'规格齐全','a complete range of specifications',NULL,NULL,0,100,1,0,1685328670),(1160,133,134,'名牌','a good brand',NULL,NULL,0,100,1,0,1685328670),(1161,133,134,'花色繁多种类齐全','a wide selection of colours and designs',NULL,NULL,0,100,1,0,1685328670),(1162,133,134,'嵌饰','abaciscus',NULL,NULL,0,100,1,0,1685328670),(1163,133,134,'遮阳帘','abat vent',NULL,NULL,0,100,1,0,1685328670),(1164,15,80,'大卫·卡桑','by David Kassan',NULL,NULL,0,100,1,0,1682230836),(1166,133,134,'桥台拱座','abutment',NULL,NULL,0,100,1,0,1685328669),(1167,133,134,'邻接房屋','abutting buildings',NULL,NULL,0,100,1,0,1685328669),(1168,133,134,'研究院','academy',NULL,NULL,0,100,1,0,1685328669),(1169,133,134,'叶形装饰','acanthus',NULL,NULL,0,100,1,0,1685328669),(1170,133,134,'过道','access balcony',NULL,NULL,0,100,1,0,1685328669),(1171,133,134,'居住设施','accommodations',NULL,NULL,0,100,1,0,1685328669),(1172,133,134,'隔音板','acoustical screen',NULL,NULL,0,100,1,0,1685328669),(1173,133,134,'广告气球','ad. balloon',NULL,NULL,0,100,1,0,1685328669),(1174,133,134,'残影','after image',NULL,NULL,0,100,1,0,1685328669),(1175,15,80,'迭戈·法齐奥','by Diego Fazio',NULL,NULL,0,100,1,0,1682230836),(1176,133,134,'气床','air bed',NULL,NULL,0,100,1,0,1685328669),(1177,133,134,'便利设施','amenities',NULL,NULL,0,100,1,0,1685328669),(1178,133,134,'古式家具','antique furniture',NULL,NULL,0,100,1,0,1685328669),(1179,133,134,'造型优美','appealing design',NULL,NULL,0,100,1,0,1685328669),(1180,133,40,'竞技场','arena',NULL,NULL,0,100,1,0,1685328669),(1181,133,134,'人造花纹','artificial grain',NULL,NULL,0,100,1,0,1685328669),(1182,133,134,'造型美观','attractive appearance',NULL,NULL,0,100,1,0,1685328669),(1183,133,134,'背视图','back view',NULL,NULL,0,100,1,0,1685328669),(1184,133,134,'逆光','backlighting',NULL,NULL,0,100,1,0,1685328669),(1185,133,134,'后院','backyard',NULL,NULL,0,100,1,0,1685328669),(1186,15,80,'丹·雅克','by Don Jacot',NULL,NULL,0,100,1,0,1682230836),(1187,133,134,'隔板','baffile plate',NULL,NULL,0,100,1,0,1685328669),(1188,133,134,'平衡','balance',NULL,NULL,0,100,1,0,1685328669),(1189,133,134,'阳台','balcony',NULL,NULL,0,100,1,0,1685328669),(1190,133,134,'人行道','banquette',NULL,NULL,0,100,1,0,1685328669),(1191,133,134,'棒式骨架','bar frame',NULL,NULL,0,100,1,0,1685328669),(1192,133,134,'栅栏','barrier railings',NULL,NULL,0,100,1,0,1685328669),(1193,133,134,'澡堂','bath house',NULL,NULL,0,100,1,0,1685328669),(1194,133,134,'浴巾','bath towel',NULL,NULL,0,100,1,0,1685328669),(1195,133,134,'游泳场','bathing beach',NULL,NULL,0,100,1,0,1685328669),(1196,15,80,'伊丽莎白·帕特森','by Elizabeth Patterson',NULL,NULL,0,100,1,0,1682230836),(1198,133,134,'浴室设备','bathroom equipment',NULL,NULL,0,100,1,0,1685328669),(1199,133,134,'浴室盥洗台','bathroom vanity',NULL,NULL,0,100,1,0,1685328669),(1200,133,134,'独立间式汽车库','battery garages',NULL,NULL,0,100,1,0,1685328669),(1201,133,134,'美化','beautification',NULL,NULL,0,100,1,0,1685328669),(1202,133,134,'美容室','beauty parlour',NULL,NULL,0,100,1,0,1685328669),(1203,133,134,'床架床套','bed base',NULL,NULL,0,100,1,0,1685328669),(1204,133,134,'卧室系列家具','bedroom suite',NULL,NULL,0,100,1,0,1685328669),(1205,133,40,'钟楼','bell tower',NULL,NULL,0,100,1,0,1685328669),(1206,133,134,'弯曲','bending',NULL,NULL,0,100,1,0,1685328669),(1207,133,134,'曲木家具','bentwood furniture',NULL,NULL,0,100,1,0,1685328669),(1208,15,80,'伊斯特·库里尼','by Ester Curini',NULL,NULL,0,100,1,0,1682230836),(1209,133,134,'错落式住宅','bi level',NULL,NULL,0,100,1,0,1685328669),(1210,133,134,'两侧对称','bilateral symmetry',NULL,NULL,0,100,1,0,1685328669),(1211,133,134,'招牌广告','billboard',NULL,NULL,0,100,1,0,1685328669),(1212,133,55,'仿生建筑','bionical architecture',NULL,NULL,0,100,1,0,1685328669),(1213,133,134,'桦木门','birch door',NULL,NULL,0,100,1,0,1685328669),(1214,133,134,'黑色假漆','black varnish',NULL,NULL,0,100,1,0,1685328669),(1215,133,134,'黑白片','black-and-white film',NULL,NULL,0,100,1,0,1685328669),(1216,133,134,'没有门窗的墙','blank wall',NULL,NULL,0,100,1,0,1685328669),(1217,133,134,'引爆器','blasting machine',NULL,NULL,0,100,1,0,1685328669),(1218,133,134,'气泡','blister',NULL,NULL,0,100,1,0,1685328669),(1219,15,80,'戈特弗里德·海恩温','by Gottfried Helnwein',NULL,NULL,0,100,1,0,1682230836),(1220,133,134,'膨胀','bloating',NULL,NULL,0,100,1,0,1685328669),(1221,133,40,'街区','block',NULL,NULL,0,100,1,0,1685328669),(1222,133,40,'警戒哨站','block house',NULL,NULL,0,100,1,0,1685328669),(1223,133,134,'斑污现象','blotchy appearance',NULL,NULL,0,100,1,0,1685328669),(1224,133,134,'蓝晒图','blueprint drawing',NULL,NULL,0,100,1,0,1685328669),(1225,133,134,'锅炉房','boiler house',NULL,NULL,0,100,1,0,1685328669),(1226,133,134,'沸腾','boiling',NULL,NULL,0,100,1,0,1685328669),(1227,133,134,'家具用螺钉螺帽','bolts and nuts for furniture',NULL,NULL,0,100,1,0,1685328669),(1228,133,40,'书店','book shop',NULL,NULL,0,100,1,0,1685328669),(1229,133,134,'书柜','bookcase',NULL,NULL,0,100,1,0,1685328669),(1230,15,80,'哈利姆·戈德班','by Halim Ghodbane',NULL,NULL,0,100,1,0,1682230836),(1231,133,40,'植物园','botanical garden',NULL,NULL,0,100,1,0,1685328669),(1232,133,134,'大卵石','boulder',NULL,NULL,0,100,1,0,1685328669),(1233,133,134,'林荫大道','boulevard',NULL,NULL,0,100,1,0,1685328669),(1234,133,134,'弓形门','bow door',NULL,NULL,0,100,1,0,1685328669),(1235,133,134,'支架','bracket',NULL,NULL,0,100,1,0,1685328669),(1236,133,134,'早餐室','breakfast room',NULL,NULL,0,100,1,0,1685328669),(1237,133,134,'砖片','brick bat',NULL,NULL,0,100,1,0,1685328669),(1238,133,134,'砖石建筑物','brick construction',NULL,NULL,0,100,1,0,1685328669),(1239,133,134,'桥梁结构','bridge construction',NULL,NULL,0,100,1,0,1685328669),(1240,133,134,'外观光泽透明','bright and translucent in appearance',NULL,NULL,0,100,1,0,1685328669),(1241,15,80,'约翰·贝德','by John Baeder',NULL,NULL,0,100,1,0,1682230836),(1242,133,134,'建筑工人','build labourer',NULL,NULL,0,100,1,0,1685328669),(1243,133,134,'施工台架','builder\'s staging',NULL,NULL,0,100,1,0,1685328669),(1244,133,134,'商业','business',NULL,NULL,0,100,1,0,1685328669),(1245,133,134,'船用家具','cabin furniture for ships',NULL,NULL,0,100,1,0,1685328669),(1246,133,134,'咖啡馆','cafe',NULL,NULL,0,100,1,0,1685328669),(1247,133,134,'电铃','call bell',NULL,NULL,0,100,1,0,1685328669),(1248,133,134,'旋梯','caracol',NULL,NULL,0,100,1,0,1685328669),(1249,133,134,'框架架子','carcase',NULL,NULL,0,100,1,0,1685328669),(1250,133,134,'瀑布','cascade',NULL,NULL,0,100,1,0,1685328669),(1251,133,134,'洞六','cavern',NULL,NULL,0,100,1,0,1685328669),(1252,15,80,'胡安·弗朗西斯科·卡萨斯·鲁伊斯','by Juan Francisco Casas Ruiz',NULL,NULL,0,100,1,0,1682230836),(1253,133,134,'天花板','ceiling',NULL,NULL,0,100,1,0,1685328669),(1254,133,134,'瓷砖','ceramic tile',NULL,NULL,0,100,1,0,1685328669),(1255,133,134,'荷','chair',NULL,NULL,0,100,1,0,1685328669),(1256,133,134,'环行街道','circuit street',NULL,NULL,0,100,1,0,1685328669),(1257,133,134,'环形楼梯','circular stair',NULL,NULL,0,100,1,0,1685328669),(1258,133,40,'马戏团','circus',NULL,NULL,0,100,1,0,1685328669),(1259,133,40,'城市公园','city park',NULL,NULL,0,100,1,0,1685328669),(1260,133,40,'民用建筑','civil architecture',NULL,NULL,0,100,1,0,1685328669),(1261,133,40,'古典建筑','classic architecture',NULL,NULL,0,100,1,0,1685328669),(1262,133,134,'衣帽间','cloak room',NULL,NULL,0,100,1,0,1685328669),(1263,15,80,'米格尔·安赫尔·努涅斯','by Miguel Angel Nunez',NULL,NULL,0,100,1,0,1682230836),(1264,133,134,'衣帽架','coat stand',NULL,NULL,0,100,1,0,1685328669),(1265,133,40,'露天剧场','coliseum',NULL,NULL,0,100,1,0,1685328669),(1266,133,134,'色彩构图','color composition',NULL,NULL,0,100,1,0,1685328669),(1267,133,134,'彩色玻璃','colored glass',NULL,NULL,0,100,1,0,1685328669),(1268,133,40,'纪念建筑','commemorative architecture',NULL,NULL,0,100,1,0,1685328669),(1269,133,40,'商业建筑','commercial building',NULL,NULL,0,100,1,0,1685328669),(1270,133,134,'会议室','committee room',NULL,NULL,0,100,1,0,1685328669),(1271,133,134,'混凝土','concrete',NULL,NULL,0,100,1,0,1685328669),(1272,133,134,'半圆形屋顶','conch',NULL,NULL,0,100,1,0,1685328669),(1273,133,134,'自然保护','conservation of nature',NULL,NULL,0,100,1,0,1685328669),(1274,15,80,'奥斯卡·乌科努','by Oscar Ukonu',NULL,NULL,0,100,1,0,1682230836),(1275,133,40,'公园建设','construction of park',NULL,NULL,0,100,1,0,1685328669),(1276,133,40,'隧道建设','construction of tunnel',NULL,NULL,0,100,1,0,1685328669),(1277,133,134,'施工场地','construction plant',NULL,NULL,0,100,1,0,1685328669),(1278,133,134,'传送带','conveyor',NULL,NULL,0,100,1,0,1685328669),(1279,133,134,'长沙发椅','couch',NULL,NULL,0,100,1,0,1685328669),(1280,133,134,'郊区住宅','country house',NULL,NULL,0,100,1,0,1685328669),(1281,133,134,'农村道路','country road',NULL,NULL,0,100,1,0,1685328669),(1282,133,134,'法院','court building',NULL,NULL,0,100,1,0,1685328669),(1283,15,80,'佩德罗·坎普斯','by Pedro Campos',NULL,NULL,0,100,1,0,1682230836),(1284,133,134,'工艺','craftsmanship',NULL,NULL,0,100,1,0,1685328669),(1285,133,134,'窄小通道','crawiway',NULL,NULL,0,100,1,0,1685328669),(1286,133,134,'托儿所','creche',NULL,NULL,0,100,1,0,1685328669),(1287,133,134,'十字路','cross road',NULL,NULL,0,100,1,0,1685328669),(1288,133,134,'人行横道','cross walk',NULL,NULL,0,100,1,0,1685328669),(1289,133,134,'涵洞','culvert',NULL,NULL,0,100,1,0,1685328669),(1290,133,134,'自行车道','cycle path',NULL,NULL,0,100,1,0,1685328669),(1291,133,134,'圆柱','cylinder',NULL,NULL,0,100,1,0,1685328669),(1292,133,134,'日光','daylighting',NULL,NULL,0,100,1,0,1685328669),(1293,133,134,'碎石堆','debris',NULL,NULL,0,100,1,0,1685328669),(1294,15,80,'拉尔夫·戈因斯','by Ralph Goings',NULL,NULL,0,100,1,0,1682230836),(1295,133,134,'装饰灯具','decorative lighting',NULL,NULL,0,100,1,0,1685328669),(1296,133,134,'家具金边饰条','decorative trims for furniture',NULL,NULL,0,100,1,0,1685328669),(1297,133,134,'沉淀物','deposit',NULL,NULL,0,100,1,0,1685328669),(1298,133,134,'绘图纸','design paper',NULL,NULL,0,100,1,0,1685328669),(1299,133,134,'设计院','designing institute',NULL,NULL,0,100,1,0,1685328669),(1300,133,134,'蓄洪水库','detention reservoir',NULL,NULL,0,100,1,0,1685328669),(1301,133,134,'图表','diagram',NULL,NULL,0,100,1,0,1685328669),(1302,133,134,'护堤','dike dam',NULL,NULL,0,100,1,0,1685328669),(1303,133,134,'破烂建筑物','dilapidated building',NULL,NULL,0,100,1,0,1685328669),(1304,133,134,'厨房餐间','dining kitchen',NULL,NULL,0,100,1,0,1685328669),(1305,15,80,'拉菲拉·斯宾斯','by Raphaella Spence',NULL,NULL,0,100,1,0,1682230836),(1306,16,94,'衷心的，真诚的','heartfelt',NULL,NULL,0,100,1,0,1682230836),(1307,133,134,'褪色的','discoloring',NULL,NULL,0,100,1,0,1685328669),(1308,133,134,'拆卸式家具','dismantling furniture',NULL,NULL,0,100,1,0,1685328669),(1309,133,134,'清晰的木纹图案','distinct grain pattern',NULL,NULL,0,100,1,0,1685328669),(1310,133,134,'畸变','distortion',NULL,NULL,0,100,1,0,1685328669),(1311,133,134,'沙发床','divan',NULL,NULL,0,100,1,0,1685328669),(1312,133,134,'造船厂','dockyard',NULL,NULL,0,100,1,0,1685328669),(1313,133,134,'生活垃圾','domestic garbage',NULL,NULL,0,100,1,0,1685328669),(1314,133,134,'门窗','door & window',NULL,NULL,0,100,1,0,1685328669),(1315,133,134,'门牌','door plate',NULL,NULL,0,100,1,0,1685328669),(1316,133,134,'门铃','doorbell',NULL,NULL,0,100,1,0,1685328669),(1317,15,80,'理查德·艾斯特斯','by Richard Estes',NULL,NULL,0,100,1,0,1682230836),(1318,133,134,'推拉门','double acting door',NULL,NULL,0,100,1,0,1685328669),(1319,133,134,'双人沙发床','double function sofa-bed',NULL,NULL,0,100,1,0,1685328669),(1320,133,134,'排水道','drain',NULL,NULL,0,100,1,0,1685328669),(1321,133,134,'抽','drawer',NULL,NULL,0,100,1,0,1685328669),(1322,133,134,'圆桶','drum',NULL,NULL,0,100,1,0,1685328669),(1323,133,134,'垃圾箱','dustbin',NULL,NULL,0,100,1,0,1685328669),(1324,133,134,'纺织装饰品','duvets',NULL,NULL,0,100,1,0,1685328669),(1325,133,134,'住宅','dwelling',NULL,NULL,0,100,1,0,1685328669),(1326,133,134,'电灯','electric lamp',NULL,NULL,0,100,1,0,1685328669),(1327,15,80,'罗布·赫弗兰','by Rob Hefferan',NULL,NULL,0,100,1,0,1682230836),(1328,133,134,'堤','embankment',NULL,NULL,0,100,1,0,1685328669),(1329,133,134,'浮雕工艺','embossing',NULL,NULL,0,100,1,0,1685328669),(1330,133,134,'围墙','enclosure wall',NULL,NULL,0,100,1,0,1685328669),(1331,133,134,'茶几','end table',NULL,NULL,0,100,1,0,1685328669),(1332,133,134,'入口门','entrance door',NULL,NULL,0,100,1,0,1685328669),(1333,133,134,'非洲民族风格','ethnic african style',NULL,NULL,0,100,1,0,1685328669),(1334,133,134,'挖掘机','excavator',NULL,NULL,0,100,1,0,1685328669),(1335,133,134,'排气装置','exhaust plant',NULL,NULL,0,100,1,0,1685328669),(1336,133,134,'展览馆','exhibition building',NULL,NULL,0,100,1,0,1685328669),(1337,15,81,'罗梅罗·布里托','by Romero Britto',NULL,NULL,0,100,1,0,1682230836),(1338,133,134,'应急通道','exit route',NULL,NULL,0,100,1,0,1685328669),(1339,133,134,'泡沫塑料','expanded plastics',NULL,NULL,0,100,1,0,1685328669),(1340,133,134,'外部楼梯','exterior stair',NULL,NULL,0,100,1,0,1685328669),(1341,133,134,'灭火器','extinguisher',NULL,NULL,0,100,1,0,1685328669),(1342,133,134,'施工现场','fabricating yard',NULL,NULL,0,100,1,0,1685328669),(1343,133,134,'彩陶','faience ware',NULL,NULL,0,100,1,0,1685328669),(1344,133,134,'家庭','family',NULL,NULL,0,100,1,0,1685328669),(1345,133,134,'柴捆','fascine',NULL,NULL,0,100,1,0,1685328669),(1346,133,134,'龙头','faucet',NULL,NULL,0,100,1,0,1685328669),(1347,15,81,'大卫·席格利','by David Shrigley',NULL,NULL,0,100,1,0,1682230836),(1348,133,134,'涂饰','finshing',NULL,NULL,0,100,1,0,1685328669),(1349,133,134,'消防设备','fire extinguishing equipment',NULL,NULL,0,100,1,0,1685328669),(1350,133,134,'鱼池','fish pond',NULL,NULL,0,100,1,0,1685328669),(1351,133,134,'火焰','flame',NULL,NULL,0,100,1,0,1685328669),(1352,133,134,'平面','flat surface',NULL,NULL,0,100,1,0,1685328669),(1353,133,134,'洪水','flood',NULL,NULL,0,100,1,0,1685328669),(1354,133,134,'花盆','flower pot',NULL,NULL,0,100,1,0,1685328669),(1355,133,134,'水槽','flume',NULL,NULL,0,100,1,0,1685328669),(1356,133,134,'足球比赛场','football playground',NULL,NULL,0,100,1,0,1685328669),(1357,15,81,'朱利安·奥皮','by Julian Opie',NULL,NULL,0,100,1,0,1682230836),(1358,133,134,'人行道','footpath',NULL,NULL,0,100,1,0,1685328669),(1359,133,134,'冰冻','freezing',NULL,NULL,0,100,1,0,1685328669),(1360,133,134,'前视图','front elevation drawing',NULL,NULL,0,100,1,0,1685328669),(1361,133,134,'炉','furnace',NULL,NULL,0,100,1,0,1685328669),(1362,133,134,'家具五金','furniture hardware',NULL,NULL,0,100,1,0,1685328669),(1363,133,134,'门廊','gallery',NULL,NULL,0,100,1,0,1685328669),(1364,133,134,'通道','gangway',NULL,NULL,0,100,1,0,1685328669),(1365,133,134,'车库','garage',NULL,NULL,0,100,1,0,1685328669),(1366,133,134,'庭院','garden',NULL,NULL,0,100,1,0,1685328669),(1367,15,81,'帕特里克·考菲尔德','by Patrick Caulfield',NULL,NULL,0,100,1,0,1682230836),(1368,133,134,'屋顶塔楼','gazebo',NULL,NULL,0,100,1,0,1685328669),(1369,133,134,'高尔夫球场','golf course',NULL,NULL,0,100,1,0,1685328669),(1370,133,134,'仓库','goods shed',NULL,NULL,0,100,1,0,1685328669),(1371,133,134,'小沟','gullet',NULL,NULL,0,100,1,0,1685328669),(1372,133,134,'住房','habitable room',NULL,NULL,0,100,1,0,1685328669),(1373,133,134,'中间平台','halfpace',NULL,NULL,0,100,1,0,1685328669),(1374,133,134,'扶手','hand guard',NULL,NULL,0,100,1,0,1685328669),(1375,133,134,'飞机库','hangar',NULL,NULL,0,100,1,0,1685328669),(1376,133,134,'港口','harbour',NULL,NULL,0,100,1,0,1685328669),(1377,133,134,'高层建筑物','high rise block',NULL,NULL,0,100,1,0,1685328669),(1378,15,81,'艾伦·达卡吉洛','by Allan D\'Arcangelo',NULL,NULL,0,100,1,0,1682230836),(1379,133,134,'历史碑石','historic monument',NULL,NULL,0,100,1,0,1685328669),(1380,133,134,'孔','hole',NULL,NULL,0,100,1,0,1685328669),(1381,133,134,'蜂窝结构','honeycomb structure',NULL,NULL,0,100,1,0,1685328669),(1382,133,134,'医院','hospital',NULL,NULL,0,100,1,0,1685328669),(1383,133,134,'旅社','hotel',NULL,NULL,0,100,1,0,1685328669),(1384,133,134,'住宅区','housing estate',NULL,NULL,0,100,1,0,1685328669),(1385,133,134,'蓄水池','lmpounding reservoir',NULL,NULL,0,100,1,0,1685328669),(1386,133,134,'围墙','inclosure wall',NULL,NULL,0,100,1,0,1685328669),(1387,133,134,'室内游泳池','indoor swimming pool',NULL,NULL,0,100,1,0,1685328669),(1388,15,81,'丹尼尔·阿沙姆','by Daniel Arsham',NULL,NULL,0,100,1,0,1682230836),(1389,133,134,'岭','infilow',NULL,NULL,0,100,1,0,1685328669),(1390,133,134,'内院','lnner garden',NULL,NULL,0,100,1,0,1685328669),(1391,133,134,'工具','instrument',NULL,NULL,0,100,1,0,1685328669),(1392,133,134,'施工现场','job site',NULL,NULL,0,100,1,0,1685328669),(1393,133,134,'梯子','ladder',NULL,NULL,0,100,1,0,1685328669),(1394,133,134,'湖上城市','lake city',NULL,NULL,0,100,1,0,1685328669),(1395,133,134,'灯','lamp',NULL,NULL,0,100,1,0,1685328669),(1397,15,81,'爱德华多·帕奥洛齐','by Eduardo Paolozzi',NULL,NULL,0,100,1,0,1682230836),(1398,133,134,'灯台','lighthouse',NULL,NULL,0,100,1,0,1685328669),(1399,133,134,'避雷针','lightning rod',NULL,NULL,0,100,1,0,1685328669),(1400,133,134,'顶楼层','loft',NULL,NULL,0,100,1,0,1685328669),(1401,133,134,'门廊','loggia',NULL,NULL,0,100,1,0,1685328669),(1402,133,134,'洗衣房','loundry',NULL,NULL,0,100,1,0,1685328669),(1403,133,134,'矮平房','low building',NULL,NULL,0,100,1,0,1685328669),(1404,133,134,'底层','lower layer',NULL,NULL,0,100,1,0,1685328669),(1405,133,134,'屋顶窗','lucarne',NULL,NULL,0,100,1,0,1685328669),(1406,133,134,'磁锁','magnetic-lock',NULL,NULL,0,100,1,0,1685328669),(1407,133,134,'镶嵌装饰品','marquetry work',NULL,NULL,0,100,1,0,1685328669),(1408,15,81,'雷·约翰逊','by Ray Johnson',NULL,NULL,0,100,1,0,1682230836),(1409,16,94,'充满激情的，热情的','impassioned',NULL,NULL,0,100,1,0,1682230836),(1410,133,134,'边缘','margin',NULL,NULL,0,100,1,0,1685328669),(1411,133,134,'海洋建筑物','marine construction',NULL,NULL,0,100,1,0,1685328669),(1412,133,134,'标识器','marker',NULL,NULL,0,100,1,0,1685328669),(1413,133,134,'原材料','material',NULL,NULL,0,100,1,0,1685328669),(1414,133,134,'金属配件','metal fittings',NULL,NULL,0,100,1,0,1685328669),(1415,133,134,'金属拉手','metal handle',NULL,NULL,0,100,1,0,1685328669),(1416,133,134,'地下铁道','metro',NULL,NULL,0,100,1,0,1685328669),(1417,133,134,'镜','mirror',NULL,NULL,0,100,1,0,1685328669),(1418,15,81,'理查德·林德纳','by Richard Lindner',NULL,NULL,0,100,1,0,1682230836),(1419,133,134,'寺院房屋','monastic building',NULL,NULL,0,100,1,0,1685328669),(1420,133,134,'天窗','monitor',NULL,NULL,0,100,1,0,1685328669),(1421,133,134,'汽车路','motorway',NULL,NULL,0,100,1,0,1685328669),(1422,133,134,'多户住宅','multiple dwelling building',NULL,NULL,0,100,1,0,1685328669),(1423,133,134,'复合交叉口','multiway junction',NULL,NULL,0,100,1,0,1685328669),(1424,133,134,'博物馆','museum',NULL,NULL,0,100,1,0,1685328669),(1425,133,134,'窄轨铁路','narrow gauge railway',NULL,NULL,0,100,1,0,1685328669),(1426,133,134,'国道','national highway',NULL,NULL,0,100,1,0,1685328669),(1427,133,134,'天然色','natural color',NULL,NULL,0,100,1,0,1685328669),(1428,15,81,'汤姆·韦瑟尔曼','by Tom Wesselmann',NULL,NULL,0,100,1,0,1682230836),(1429,133,134,'茶几','nest',NULL,NULL,0,100,1,0,1685328669),(1430,133,134,'新城市','new town',NULL,NULL,0,100,1,0,1685328669),(1431,133,134,'办公家具','office furniture',NULL,NULL,0,100,1,0,1685328669),(1432,133,134,'油漆','oil paint',NULL,NULL,0,100,1,0,1685328669),(1433,133,134,'单层房屋','one storey house',NULL,NULL,0,100,1,0,1685328669),(1434,133,134,'装饰玻璃','ornamental glass',NULL,NULL,0,100,1,0,1685328669),(1435,133,134,'外院','outer court',NULL,NULL,0,100,1,0,1685328669),(1436,133,134,'排水口','outfall',NULL,NULL,0,100,1,0,1685328669),(1437,133,134,'郊区','outstreet',NULL,NULL,0,100,1,0,1685328669),(1438,133,55,'公园建筑','park architecture',NULL,NULL,0,100,1,0,1685328669),(1439,15,81,'亚历克斯·多奇','by Alex Dodge',NULL,NULL,0,100,1,0,1682230836),(1440,133,134,'停车场','parking area',NULL,NULL,0,100,1,0,1685328669),(1441,133,134,'通道','passage',NULL,NULL,0,100,1,0,1685328669),(1442,133,134,'人行桥','pedestrian bridge',NULL,NULL,0,100,1,0,1685328669),(1443,133,134,'绿化','planting',NULL,NULL,0,100,1,0,1685328669),(1444,133,134,'塑料家具','plastic furniture',NULL,NULL,0,100,1,0,1685328669),(1445,133,134,'购物中心','plaza',NULL,NULL,0,100,1,0,1685328669),(1446,133,134,'保护区','protected area',NULL,NULL,0,100,1,0,1685328669),(1447,15,81,'高野绫','by Aya Takano',NULL,NULL,0,100,1,0,1682230836),(1448,133,134,'公共设施','public utilities',NULL,NULL,0,100,1,0,1685328669),(1449,133,134,'四合院','quad',NULL,NULL,0,100,1,0,1685328668),(1450,133,134,'躺椅','recliner',NULL,NULL,0,100,1,0,1685328668),(1451,133,134,'饭店','restaurant',NULL,NULL,0,100,1,0,1685328668),(1452,133,134,'河边公园','riverside park',NULL,NULL,0,100,1,0,1685328668),(1453,133,134,'屋顶','roof',NULL,NULL,0,100,1,0,1685328668),(1454,133,134,'农村房屋','rustic home',NULL,NULL,0,100,1,0,1685328668),(1455,133,134,'疗养院','sanatorium',NULL,NULL,0,100,1,0,1685328668),(1456,15,81,'艾伦·琼斯','by Allen Jones',NULL,NULL,0,100,1,0,1682230836),(1457,133,134,'屏风','screen',NULL,NULL,0,100,1,0,1685328668),(1458,133,134,'海岸公园','seaside park',NULL,NULL,0,100,1,0,1685328668),(1459,133,55,'组合式建筑','section construction',NULL,NULL,0,100,1,0,1685328668),(1460,133,134,'木地板','simple boarded floor',NULL,NULL,0,100,1,0,1685328668),(1461,133,134,'简单五金配件','simple connecting fittings',NULL,NULL,0,100,1,0,1685328668),(1462,133,134,'沙发','sofa',NULL,NULL,0,100,1,0,1685328668),(1463,133,134,'太阳热装置','solar plant',NULL,NULL,0,100,1,0,1685328668),(1464,133,134,'屋顶室','soler',NULL,NULL,0,100,1,0,1685328668),(1465,133,134,'体育馆','sports palace',NULL,NULL,0,100,1,0,1685328668),(1466,133,134,'广场','square',NULL,NULL,0,100,1,0,1685328668),(1467,133,134,'车站','station',NULL,NULL,0,100,1,0,1685328668),(1468,133,134,'楼梯间','stair hall',NULL,NULL,0,100,1,0,1685328668),(1469,133,134,'蓄水库','storage reservoir',NULL,NULL,0,100,1,0,1685328668),(1470,133,134,'仓库','store building',NULL,NULL,0,100,1,0,1685328668),(1471,133,134,'火炉','stove',NULL,NULL,0,100,1,0,1685328668),(1472,133,55,'街道建筑','street construction',NULL,NULL,0,100,1,0,1685328668),(1473,133,134,'配电箱','switchbox',NULL,NULL,0,100,1,0,1685328668),(1474,133,134,'电话亭','telephone booth',NULL,NULL,0,100,1,0,1685328668),(1475,15,81,'安杰洛·塞塞隆','by Angelo Cesselon',NULL,NULL,0,100,1,0,1682230836),(1476,133,134,'临时设施','temporory structure',NULL,NULL,0,100,1,0,1685328668),(1477,133,134,'租用房屋','tenement',NULL,NULL,0,100,1,0,1685328668),(1478,133,134,'平台','terrace',NULL,NULL,0,100,1,0,1685328668),(1479,133,134,'地域','territory',NULL,NULL,0,100,1,0,1685328668),(1480,133,134,'剧场','theatre',NULL,NULL,0,100,1,0,1685328668),(1481,133,134,'圆形房物','thole',NULL,NULL,0,100,1,0,1685328668),(1482,133,134,'木房屋','timber building',NULL,NULL,0,100,1,0,1685328668),(1483,133,134,'城市','town',NULL,NULL,0,100,1,0,1685328668),(1484,15,81,'比利·苹果','by Billy Apple',NULL,NULL,0,100,1,0,1682230836),(1485,133,134,'城市绿化区','town greenery',NULL,NULL,0,100,1,0,1685328668),(1486,133,134,'小城镇','townlet',NULL,NULL,0,100,1,0,1685328668),(1487,133,134,'路径','track',NULL,NULL,0,100,1,0,1685328668),(1488,133,134,'城市美术','urban art',NULL,NULL,0,100,1,0,1685328668),(1489,133,134,'市区住宅','urban dwelling',NULL,NULL,0,100,1,0,1685328668),(1490,133,134,'市区改建','urban renewal',NULL,NULL,0,100,1,0,1685328668),(1491,133,134,'空房','vacancy',NULL,NULL,0,100,1,0,1685328668),(1492,133,134,'山谷','valley',NULL,NULL,0,100,1,0,1685328668),(1493,133,134,'展览场地','venue',NULL,NULL,0,100,1,0,1685328668),(1494,15,81,'克里斯汀·王','by Christine Wang',NULL,NULL,0,100,1,0,1682230836),(1495,133,134,'门厅','vestibule',NULL,NULL,0,100,1,0,1685328668),(1496,133,134,'高架桥','viaduct',NULL,NULL,0,100,1,0,1685328668),(1497,133,134,'远景','vista',NULL,NULL,0,100,1,0,1685328668),(1498,133,134,'空隙','voids',NULL,NULL,0,100,1,0,1685328668),(1499,133,134,'墙纸','wall paper',NULL,NULL,0,100,1,0,1685328668),(1500,133,134,'窗','window',NULL,NULL,0,100,1,0,1685328668),(1501,133,134,'木制配件','wood components',NULL,NULL,0,100,1,0,1685328668),(1502,133,134,'木制窗帘杆及吊环','wooden curtain rod and ring',NULL,NULL,0,100,1,0,1685328668),(1503,15,81,'克拉斯·奥尔登堡','by Claes Oldenburg',NULL,NULL,0,100,1,0,1682230836),(1504,16,94,'鼓舞人心的，激发灵感的','inspiring',NULL,NULL,0,100,1,0,1682230836),(1505,133,134,'庭院','yard',NULL,NULL,0,100,1,0,1685328668),(1506,133,134,'松软土地','yielding ground',NULL,NULL,0,100,1,0,1685328668),(1507,133,40,'动物园','zoological garden',NULL,NULL,0,100,1,0,1685328668),(1508,4,132,'白虎','baihu',NULL,NULL,0,100,1,0,1685327379),(1509,4,132,'赑屃（神话乌龟）','bixi a dragon with the shell of a turtle',NULL,NULL,0,100,1,0,1685327379),(1510,4,132,'中国神仙','chinese gods and immortals',NULL,NULL,0,100,1,0,1685327379),(1511,4,132,'中国神话','chinese mythology',NULL,NULL,0,100,1,0,1685327379),(1512,4,132,'邓龙','denglong a mythical creature that acts as messenger betweenheaven and earth',NULL,NULL,0,100,1,0,1685327379),(1513,4,132,'啸天犬','dog in chinese mythology',NULL,NULL,0,100,1,0,1685327379),(1514,4,132,'凤','fenghuang chinese phoenix',NULL,NULL,0,100,1,0,1685327379),(1515,15,81,'戴夫·怀特','by Dave White',NULL,NULL,0,100,1,0,1682230836),(1517,4,132,'石狮子','guardian lion',NULL,NULL,0,100,1,0,1685327379),(1518,4,132,'龙','jiaolong a hornless scaled dragon.',NULL,NULL,0,100,1,0,1685327379),(1519,4,132,'金蟾','jin chan a prosperity toad',NULL,NULL,0,100,1,0,1685327379),(1520,4,132,'精卫','jingwei a bird who is determined to fill up the sea',NULL,NULL,0,100,1,0,1685327379),(1521,4,132,'葵','kui (chinese mythology)',NULL,NULL,0,100,1,0,1685327379),(1522,4,132,'麒麟','kylin kirin',NULL,NULL,0,100,1,0,1685327379),(1523,4,132,'天池水怪','lake tianchi monster',NULL,NULL,0,100,1,0,1685327379),(1525,4,132,'山海经','mountains and seas sutra',NULL,NULL,0,100,1,0,1685327379),(1526,4,132,'神兽','mythical beasts',NULL,NULL,0,100,1,0,1685327379),(1527,4,132,'蚩尤','mythological warrior engaged in fighting with the yellow emperor',NULL,NULL,0,100,1,0,1685327379),(1528,4,132,'年兽','nian a beast related to the chinese new year.',NULL,NULL,0,100,1,0,1685327379),(1529,4,132,'九头鸟','nine-headed bird',NULL,NULL,0,100,1,0,1685327379),(1530,4,132,'龙','panlong (mythology) an aquatic dragon.',NULL,NULL,0,100,1,0,1685327379),(1531,4,132,'穷奇(会飞的老虎)','qiongqi a winged tiger one of the four perils.',NULL,NULL,0,100,1,0,1685327379),(1532,4,132,'饕餮','taotie',NULL,NULL,0,100,1,0,1685327379),(1533,4,132,'妖怪','yaoguai',NULL,NULL,0,100,1,0,1685327379),(1534,15,81,'德里克·博什尔','by Derek Boshier',NULL,NULL,0,100,1,0,1682230836),(1535,15,81,'爱德华·鲁斯查','by Edward Ruscha',NULL,NULL,0,100,1,0,1682230836),(1536,15,81,'埃里克·杨克','by Eric Yahnker',NULL,NULL,0,100,1,0,1682230836),(1537,15,81,'艾薇琳·阿克塞尔','by Evelyne Axell',NULL,NULL,0,100,1,0,1682230836),(1538,15,81,'乔治·塞加尔','by George Segal',NULL,NULL,0,100,1,0,1682230836),(1539,15,81,'吉娜·比弗斯','by Gina Beavers',NULL,NULL,0,100,1,0,1682230836),(1540,15,81,'哈里顿·普什瓦格纳','by Hariton Pushwagner',NULL,NULL,0,100,1,0,1682230836),(1541,16,94,'强烈的，紧张的','intense',NULL,NULL,0,100,1,0,1682230836),(1542,15,81,'詹姆斯·吉尔','by James Gill',NULL,NULL,0,100,1,0,1682230836),(1543,12,131,'文房四宝(笔墨纸砚)','the four treasure of thestudy:brush inkstick paper andink stone',NULL,NULL,0,100,1,0,1685327238),(1544,15,81,'詹姆斯·罗森奎斯特','by James Rosenquist',NULL,NULL,0,100,1,0,1682230836),(1545,12,131,'战国','warring states',NULL,NULL,0,100,1,0,1685327238),(1546,12,131,'水浒传','water margin',NULL,NULL,0,100,1,0,1685327238),(1547,12,131,'红白喜事','weddings and funerals',NULL,NULL,0,100,1,0,1685327238),(1548,12,131,'小品','witty skits',NULL,NULL,0,100,1,0,1685327238),(1549,12,131,'衙门','yamen',NULL,NULL,0,100,1,0,1685327238),(1550,12,131,'阴阳','yin yang',NULL,NULL,0,100,1,0,1685327238),(1551,15,81,'贾斯珀·约翰斯','by Jasper Johns',NULL,NULL,0,100,1,0,1682230836),(1552,12,131,'禅宗','zen buddhism',NULL,NULL,0,100,1,0,1685327238),(1553,12,131,'中国风服装','chinese costume',NULL,NULL,0,100,1,0,1685327238),(1554,12,131,'旗袍','cheongsam',NULL,NULL,0,100,1,0,1685327238),(1555,12,131,'中国龙','loong',NULL,NULL,0,100,1,0,1685327238),(1556,12,131,'中国凤凰','chinese phoenix',NULL,NULL,0,100,1,0,1685327238),(1557,12,131,'麒麟','kylin',NULL,NULL,0,100,1,0,1685327238),(1558,12,131,'灯笼','chinese lanterns',NULL,NULL,0,100,1,0,1685327238),(1559,12,131,'功夫','kung fu',NULL,NULL,0,100,1,0,1685327238),(1560,12,131,'咏春','wing tsun',NULL,NULL,0,100,1,0,1685327238),(1561,12,131,'武侠','wuxia',NULL,NULL,0,100,1,0,1685327238),(1562,12,131,'昆曲','kunqu opera',NULL,NULL,0,100,1,0,1685327238),(1563,12,131,'笛子','flute',NULL,NULL,0,100,1,0,1685327238),(1564,12,131,'麻将','mahjong',NULL,NULL,0,100,1,0,1685327238),(1565,12,131,'景泰蓝','cloisonne',NULL,NULL,0,100,1,0,1685327238),(1566,12,131,'瓷','porcelain',NULL,NULL,0,100,1,0,1685327238),(1567,12,131,'绣花的','enbroidered',NULL,NULL,0,100,1,0,1685327238),(1568,12,131,'园林','gardens',NULL,NULL,0,100,1,0,1685327238),(1569,12,131,'亭子','pavilion',NULL,NULL,0,100,1,0,1685327238),(1570,12,131,'寺庙','xxtemplexx',NULL,NULL,0,100,1,0,1685327238),(1571,12,131,'紫禁城','forbidden city',NULL,NULL,0,100,1,0,1685327238),(1572,12,131,'颐和园','summer palace',NULL,NULL,0,100,1,0,1685327238),(1573,12,131,'牡丹','peony',NULL,NULL,0,100,1,0,1685327238),(1574,12,131,'莲花','lotus',NULL,NULL,0,100,1,0,1685327238),(1575,15,81,'约翰尼·泰勒','by Johnny Taylor',NULL,NULL,0,100,1,0,1682230836),(1576,15,81,'贾斯汀·迈克尔·詹金斯','by Justin Michael Jenkins',NULL,NULL,0,100,1,0,1682230836),(1577,15,81,'拉里·里弗斯','by Larry Rivers',NULL,NULL,0,100,1,0,1682230836),(1578,15,81,'马里索尔·埃斯科巴尔','by Marisol Escobar',NULL,NULL,0,100,1,0,1682230836),(1579,15,81,'玛乔丽·斯特莱德','by Marjorie Strider',NULL,NULL,0,100,1,0,1682230836),(1580,15,81,'梅尔·拉莫斯','by Mel Ramos',NULL,NULL,0,100,1,0,1682230836),(1581,15,81,'米默·罗泰拉','by Mimmo Rotella',NULL,NULL,0,100,1,0,1682230836),(1582,15,81,'脑洗先生','by Mr. Brainwash',NULL,NULL,0,100,1,0,1682230836),(1583,15,81,'尼克·多伊尔','by Nick Doyle',NULL,NULL,0,100,1,0,1682230836),(1584,15,81,'尼克拉斯·卡斯特罗','by Niclas Castello',NULL,NULL,0,100,1,0,1682230836),(1585,15,81,'诺曼·托因顿','by Norman Toynton',NULL,NULL,0,100,1,0,1682230836),(1586,15,81,'保琴·博蒂','by Pauline Boty',NULL,NULL,0,100,1,0,1682230836),(1587,15,81,'彼得·布莱克','by Peter Blake',NULL,NULL,0,100,1,0,1682230836),(1588,16,94,'快乐的，喜悦的','joyful',NULL,NULL,0,100,1,0,1682230836),(1589,16,96,'颅骨形状','skull shape',NULL,NULL,0,100,1,0,1682230836),(1590,15,81,'理查德·哈密尔顿','by Richard Hamilton',NULL,NULL,0,100,1,0,1682230836),(1591,15,81,'罗伯特·印第安纳','by Robert Indiana',NULL,NULL,0,100,1,0,1682230836),(1592,15,81,'罗伯特·劳申伯格','by Robert Rauschenberg',NULL,NULL,0,100,1,0,1682230836),(1593,15,81,'罗莎琳·德雷克斯勒','by Rosalyn Drexler',NULL,NULL,0,100,1,0,1682230836),(1594,15,81,'亚历克斯·达·科特','by Alex Da Corte',NULL,NULL,0,100,1,0,1682230836),(1595,16,90,'纠缠，交织','entanglement',NULL,NULL,0,100,1,0,1685326495),(1596,16,90,'由骨头制成','made of bones',NULL,NULL,0,100,1,0,1685326495),(1597,16,90,'对称的','symmetrical',NULL,NULL,0,100,1,0,1685326495),(1598,16,90,'复杂的，错综复杂的','intricate',NULL,NULL,0,100,1,0,1685326495),(1599,16,90,'细致的装饰','filigree detailing',NULL,NULL,0,100,1,0,1685326495),(1600,16,90,'被烟雾环绕','surrounded by smoke',NULL,NULL,0,100,1,0,1685326495),(1601,109,130,'北京烤鸭','beijing roast duck',NULL,NULL,0,100,1,0,1685326424),(1602,109,130,'盒饭','box lunch',NULL,NULL,0,100,1,0,1685326424),(1603,109,130,'八宝饭','eight-treasure rice pudding',NULL,NULL,0,100,1,0,1685326424),(1604,109,130,'粉丝','glass noodles',NULL,NULL,0,100,1,0,1685326424),(1605,109,130,'锅贴','guotie',NULL,NULL,0,100,1,0,1685326424),(1606,109,130,'火锅','hot pot',NULL,NULL,0,100,1,0,1685326424),(1607,109,130,'豆脑','jellied bean curd',NULL,NULL,0,100,1,0,1685326424),(1608,109,130,'魔芋豆腐','konjak tofu',NULL,NULL,0,100,1,0,1685326424),(1609,109,130,'莲藕','lotus root',NULL,NULL,0,100,1,0,1685326424),(1610,109,130,'米粉','rice noodles',NULL,NULL,0,100,1,0,1685326424),(1611,109,130,'米豆腐','rice tofu',NULL,NULL,0,100,1,0,1685326424),(1612,16,94,'万花筒般的，多姿多彩的','kaleidoscopic',NULL,NULL,0,100,1,0,1682230836),(1613,109,130,'套餐','set meal',NULL,NULL,0,100,1,0,1685326424),(1614,109,130,'春卷','spring roll(s)',NULL,NULL,0,100,1,0,1685326424),(1615,109,130,'花卷','steamed twisted rolls',NULL,NULL,0,100,1,0,1685326424),(1616,109,130,'元宵','tangyuan sweet rice dumpling (soup)',NULL,NULL,0,100,1,0,1685326424),(1617,109,130,'馄饨','wonton',NULL,NULL,0,100,1,0,1685326424),(1618,8,129,'青年节','youth day',NULL,NULL,0,100,1,0,1685274687),(1619,8,129,'妇女节','women\'s day',NULL,NULL,0,100,1,0,1685274687),(1620,8,129,'泼水节','water-splashing day',NULL,NULL,0,100,1,0,1685274687),(1621,8,129,'清明节','tomb sweepingday',NULL,NULL,0,100,1,0,1685274687),(1622,8,129,'教师节','teachers\' day',NULL,NULL,0,100,1,0,1685274687),(1623,8,129,'春节','spring festival',NULL,NULL,0,100,1,0,1685274687),(1624,8,129,'国庆节','national day',NULL,NULL,0,100,1,0,1685274687),(1625,8,129,'中秋节','mid-autumn festival',NULL,NULL,0,100,1,0,1685274687),(1626,8,129,'元宵节','lantern festival',NULL,NULL,0,100,1,0,1685274687),(1627,8,129,'端午节','dragon boat festival',NULL,NULL,0,100,1,0,1685274687),(1628,8,129,'重阳节','double-ninth festiva',NULL,NULL,0,100,1,0,1685274687),(1629,8,129,'除夕','chinese new year\'s eve',NULL,NULL,0,100,1,0,1685274687),(1630,8,129,'儿童节','children\'s day',NULL,NULL,0,100,1,0,1685274687),(1631,124,125,'赛琳','selene',NULL,NULL,0,100,1,0,1685274190),(1632,124,125,'塔那托斯','thanatos',NULL,NULL,0,100,1,0,1685274190),(1633,15,82,'艾米·谢拉德','by Amy Sherald',NULL,NULL,0,100,1,0,1682230836),(1634,124,125,'复仇女神','nemesis',NULL,NULL,0,100,1,0,1685274190),(1635,124,125,'海普诺斯','hypnos',NULL,NULL,0,100,1,0,1685274189),(1636,124,125,'西斯','circe',NULL,NULL,0,100,1,0,1685274189),(1637,124,125,'潘','pan',NULL,NULL,0,100,1,0,1685274189),(1638,124,125,'阿斯克勒庇俄斯','asclepius',NULL,NULL,0,100,1,0,1685274189),(1639,124,125,'赫拉克勒斯','heracles',NULL,NULL,0,100,1,0,1685274189),(1640,124,125,'珀耳塞福涅','persephone',NULL,NULL,0,100,1,0,1685274189),(1641,124,125,'狄俄尼索斯','dionysus',NULL,NULL,0,100,1,0,1685274189),(1642,124,125,'赫斯蒂亚','hestia',NULL,NULL,0,100,1,0,1685274189),(1643,124,125,'赫耳墨斯','hermes',NULL,NULL,0,100,1,0,1685274189),(1644,124,125,'赫斐斯托斯','hephaestus',NULL,NULL,0,100,1,0,1685274189),(1645,124,125,'阿佛洛狄忒','aphrodite',NULL,NULL,0,100,1,0,1685274189),(1646,124,125,'阿瑞斯','ares',NULL,NULL,0,100,1,0,1685274189),(1647,124,125,'阿耳忒弥斯','artemis',NULL,NULL,0,100,1,0,1685274189),(1648,124,125,'阿波罗','apollo',NULL,NULL,0,100,1,0,1685274189),(1649,124,125,'雅典娜','athena',NULL,NULL,0,100,1,0,1685274189),(1650,124,125,'德米特','demeter',NULL,NULL,0,100,1,0,1685274189),(1651,124,125,'哈迪斯','hades',NULL,NULL,0,100,1,0,1685274189),(1652,124,125,'波塞冬','poseidon',NULL,NULL,0,100,1,0,1685274189),(1653,124,125,'赫拉','hera',NULL,NULL,0,100,1,0,1685274189),(1654,15,82,'安杰丽卡·考芬','by Angelica Kauffman',NULL,NULL,0,100,1,0,1682230836),(1655,124,125,'泽索斯','zesus',NULL,NULL,0,100,1,0,1685274189),(1656,124,128,'胜利手势','v',NULL,NULL,0,100,1,0,1685273191),(1657,124,128,'翘大拇指','thumbs_up',NULL,NULL,0,100,1,0,1685273191),(1658,124,128,'比出中指','middle_finger',NULL,NULL,0,100,1,0,1685273191),(1659,124,128,'猫爪手势','cat_pose',NULL,NULL,0,100,1,0,1685273191),(1660,124,128,'手枪手势','finger_gun',NULL,NULL,0,100,1,0,1685273191),(1661,124,128,'嘘手势','shushing',NULL,NULL,0,100,1,0,1685273191),(1662,124,128,'拿着','holding',NULL,NULL,0,100,1,0,1685273191),(1663,124,128,'招手','waving',NULL,NULL,0,100,1,0,1685273191),(1664,124,128,'敬礼','salute',NULL,NULL,0,100,1,0,1685273191),(1665,124,128,'伸懒腰','stretch',NULL,NULL,0,100,1,0,1685273191),(1666,124,128,'抬手','arms_up',NULL,NULL,0,100,1,0,1685273191),(1667,124,128,'张手','spread_arms',NULL,NULL,0,100,1,0,1685273191),(1668,124,128,'手放在嘴边','hand_to_mouth',NULL,NULL,0,100,1,0,1685273191),(1669,124,128,'拉头发','hair_pull',NULL,NULL,0,100,1,0,1685273191),(1670,124,128,'举手露腋','armpits',NULL,NULL,0,100,1,0,1685273191),(1671,124,128,'屈膝礼','curtsy',NULL,NULL,0,100,1,0,1685273191),(1672,124,128,'用手指做出笑脸','fingersmile',NULL,NULL,0,100,1,0,1685273191),(1673,124,128,'手撑着头','chin_rest',NULL,NULL,0,100,1,0,1685273191),(1674,124,128,'用手支撑住','arm_support',NULL,NULL,0,100,1,0,1685273191),(1675,15,82,'阿尔特米西亚·詹蒂莱斯基','by Artemisia Gentileschi',NULL,NULL,0,100,1,0,1682230836),(1676,124,128,'手放在身后','arms_behind_back',NULL,NULL,0,100,1,0,1685273191),(1677,124,128,'手交叉于胸前','arms_crossed',NULL,NULL,0,100,1,0,1685273191),(1678,124,128,'单手插腰','hand_on_hip',NULL,NULL,0,100,1,0,1685273191),(1679,124,128,'双手叉腰','hands_on_hips',NULL,NULL,0,100,1,0,1685273191),(1680,124,128,'调整过膝袜','adjusting_thighhigh',NULL,NULL,0,100,1,0,1685273191),(1681,124,128,'伸手扭腰动作','caramelldansen',NULL,NULL,0,100,1,0,1685273191),(1682,124,128,'牵手','holding_hands',NULL,NULL,0,100,1,0,1685273191),(1683,124,128,'二郎腿','crossed_legs',NULL,NULL,0,100,1,0,1685273191),(1684,124,128,'曲腿至胸','fetal_position',NULL,NULL,0,100,1,0,1685273191),(1685,124,128,'抬一只脚','leg_lift',NULL,NULL,0,100,1,0,1685273191),(1686,124,128,'抬两只脚','legs_up',NULL,NULL,0,100,1,0,1685273191),(1687,124,128,'张腿','spread_legs',NULL,NULL,0,100,1,0,1685273191),(1688,124,128,'公主抱','princess_carry',NULL,NULL,0,100,1,0,1685273191),(1689,124,128,'战斗姿态','fighting_stance',NULL,NULL,0,100,1,0,1685273191),(1690,124,128,'颠倒的','upside-down',NULL,NULL,0,100,1,0,1685273191),(1691,124,128,'向后看','looking_back',NULL,NULL,0,100,1,0,1685273191),(1692,124,128,'趴着','on_stomach',NULL,NULL,0,100,1,0,1685273191),(1693,124,128,'蹲下','squatting',NULL,NULL,0,100,1,0,1685273190),(1694,124,128,'跨坐','straddle',NULL,NULL,0,100,1,0,1685273190),(1695,124,128,'下跪','kneeling',NULL,NULL,0,100,1,0,1685273190),(1696,124,128,'趴着翘臀','top-down_bottom-up',NULL,NULL,0,100,1,0,1685273190),(1697,124,128,'翘臀姿势','bent_over',NULL,NULL,0,100,1,0,1685273190),(1698,124,128,'四肢趴地','all_fours',NULL,NULL,0,100,1,0,1685273190),(1699,124,128,'弓身体','arched_back',NULL,NULL,0,100,1,0,1685273190),(1700,124,128,'坐着','sitting',NULL,NULL,0,100,1,0,1685273190),(1701,124,128,'正坐','seiza',NULL,NULL,0,100,1,0,1685273190),(1702,124,128,'割坐','wariza/w-sitting',NULL,NULL,0,100,1,0,1685273190),(1703,124,128,'侧身坐','yokozuwari',NULL,NULL,0,100,1,0,1685273190),(1704,124,128,'盘腿','indian_style',NULL,NULL,0,100,1,0,1685273190),(1705,124,128,'抱腿','leg_hug',NULL,NULL,0,100,1,0,1685273190),(1706,124,128,'身体前驱','leaning_forward',NULL,NULL,0,100,1,0,1685273190),(1707,124,128,'背对背','back-to-back',NULL,NULL,0,100,1,0,1685273190),(1708,124,128,'胸对胸','symmetrical_docking',NULL,NULL,0,100,1,0,1685273190),(1709,124,128,'手对手','symmetrical_hand_pose',NULL,NULL,0,100,1,0,1685273190),(1710,124,128,'眼对眼（对视）','eye_contact',NULL,NULL,0,100,1,0,1685273190),(1711,124,128,'拥抱','hug',NULL,NULL,0,100,1,0,1685273190),(1712,124,128,'膝枕','lap_pillow',NULL,NULL,0,100,1,0,1685273190),(1713,124,128,'魔鬼身材','curvy',NULL,NULL,0,100,1,0,1685273190),(1714,124,128,'骨感','skinny',NULL,NULL,0,100,1,0,1685273190),(1715,16,94,'敏锐的，热切的','keen',NULL,NULL,0,100,1,0,1682230836),(1716,124,128,'肥胖','plump',NULL,NULL,0,100,1,0,1685273190),(1717,124,128,'洗澡','bathing',NULL,NULL,0,100,1,0,1685273190),(1718,124,128,'湿身','wet',NULL,NULL,0,100,1,0,1685273190),(1719,124,128,'流汗','sweat',NULL,NULL,0,100,1,0,1685273190),(1720,124,128,'掏耳勺','mimikaki',NULL,NULL,0,100,1,0,1685273190),(1721,124,128,'站立','standing',NULL,NULL,0,100,1,0,1685273190),(1722,124,126,'呆毛','ahoge',NULL,NULL,0,100,1,0,1685272978),(1723,124,126,'刘海','bangs',NULL,NULL,0,100,1,0,1685272978),(1724,124,126,'齐刘海','blunt_bangs',NULL,NULL,0,100,1,0,1685272978),(1725,124,126,'卷发','curly_hair',NULL,NULL,0,100,1,0,1685272978),(1726,124,126,'钻头卷/公主卷','drill_hair',NULL,NULL,0,100,1,0,1685272978),(1727,124,126,'包子头','hair_bun',NULL,NULL,0,100,1,0,1685272978),(1728,124,126,'包子头(两个)','double_bun',NULL,NULL,0,100,1,0,1685272978),(1729,124,126,'马尾','ponytail',NULL,NULL,0,100,1,0,1685272978),(1730,124,126,'短马尾','short_ponytail',NULL,NULL,0,100,1,0,1685272978),(1731,124,126,'侧马尾','side_ponytail',NULL,NULL,0,100,1,0,1685272978),(1732,124,126,'双马尾','twintails',NULL,NULL,0,100,1,0,1685272978),(1733,124,126,'凌乱发型','messy_hair',NULL,NULL,0,100,1,0,1685272978),(1734,15,82,'德里克·雅各布斯','by Dirck Jacobsz',NULL,NULL,0,100,1,0,1682230836),(1735,124,126,'姬发式','hime_cut',NULL,NULL,0,100,1,0,1685272978),(1736,124,126,'辫子','braid',NULL,NULL,0,100,1,0,1685272978),(1737,124,126,'双辫子','twin_braids',NULL,NULL,0,100,1,0,1685272978),(1738,124,126,'长鬓角','payot',NULL,NULL,0,100,1,0,1685272978),(1739,124,126,'波浪发型','wavy_hair',NULL,NULL,0,100,1,0,1685272978),(1740,124,126,'金发/金眼','blonde_hair/yellow_eyes',NULL,NULL,0,100,1,0,1685272978),(1741,124,126,'银发/银眼','silver_hair/silver_eyes',NULL,NULL,0,100,1,0,1685272978),(1742,124,126,'灰发/灰眼','grey_hair/grey_eyes',NULL,NULL,0,100,1,0,1685272978),(1743,124,126,'白发/白眼','white_hair/white_eyes',NULL,NULL,0,100,1,0,1685272978),(1744,124,126,'棕发/棕眼','brown_hair/brown_eyes',NULL,NULL,0,100,1,0,1685272978),(1745,124,126,'黑发/黑眼','black_hair/black_eyes',NULL,NULL,0,100,1,0,1685272978),(1746,124,126,'紫发/紫眼','purple_hair/purple_eyes',NULL,NULL,0,100,1,0,1685272978),(1747,124,126,'红发/红眼','red_hair/red_eyes',NULL,NULL,0,100,1,0,1685272978),(1748,124,126,'蓝发/蓝眼','blue_hair/blue_eyes',NULL,NULL,0,100,1,0,1685272978),(1749,124,126,'绿发/绿眼','green_hair/green_eyes',NULL,NULL,0,100,1,0,1685272978),(1750,124,126,'短发','short_hair',NULL,NULL,0,100,1,0,1685272978),(1751,124,126,'长发','long_hair',NULL,NULL,0,100,1,0,1685272978),(1752,124,126,'很长的头发','very_long_hair',NULL,NULL,0,100,1,0,1685272978),(1753,124,126,'没鼻子的','no_nose',NULL,NULL,0,100,1,0,1685272978),(1754,124,126,'尖牙','fangs',NULL,NULL,0,100,1,0,1685272978),(1755,124,126,'舌头','tongue',NULL,NULL,0,100,1,0,1685272978),(1756,124,126,'动物耳朵','animal_ears',NULL,NULL,0,100,1,0,1685272978),(1757,124,126,'狐狸耳朵','fox_ears',NULL,NULL,0,100,1,0,1685272978),(1758,124,126,'兔耳','bunny_ears',NULL,NULL,0,100,1,0,1685272978),(1759,124,126,'猫耳','cat_ears',NULL,NULL,0,100,1,0,1685272978),(1760,124,126,'狗耳','dog_ears',NULL,NULL,0,100,1,0,1685272978),(1761,124,126,'老鼠耳朵','mouse_ears',NULL,NULL,0,100,1,0,1685272978),(1762,124,126,'尖耳','pointy_ears',NULL,NULL,0,100,1,0,1685272978),(1763,124,126,'腋','armpit',NULL,NULL,0,100,1,0,1685272978),(1764,15,82,'伊丽莎白·佩顿','by Elizabeth Peyton',NULL,NULL,0,100,1,0,1682230836),(1765,124,126,'锁骨','collarbone',NULL,NULL,0,100,1,0,1685272978),(1766,124,126,'翅膀/翼','wings',NULL,NULL,0,100,1,0,1685272978),(1767,124,126,'蝙蝠翅膀','bat_wings',NULL,NULL,0,100,1,0,1685272978),(1768,124,126,'蝴蝶翅膀','butterfly_wings',NULL,NULL,0,100,1,0,1685272978),(1769,124,126,'黑色之翼','black_wings',NULL,NULL,0,100,1,0,1685272978),(1770,124,126,'恶魔之翼','demon_wings',NULL,NULL,0,100,1,0,1685272978),(1771,124,126,'肌肉','muscle',NULL,NULL,0,100,1,0,1685272978),(1772,124,126,'胸肌','chest',NULL,NULL,0,100,1,0,1685272978),(1773,124,126,'肚脐','navel',NULL,NULL,0,100,1,0,1685272978),(1774,124,126,'尾巴','tail',NULL,NULL,0,100,1,0,1685272978),(1775,124,126,'大腿','thighs',NULL,NULL,0,100,1,0,1685272978),(1776,124,126,'粗腿','thick_thighs',NULL,NULL,0,100,1,0,1685272978),(1777,124,126,'膝盖内侧','kneepits',NULL,NULL,0,100,1,0,1685272978),(1778,124,126,'脚','foot',NULL,NULL,0,100,1,0,1685272978),(1779,124,126,'脚趾','toes',NULL,NULL,0,100,1,0,1685272978),(1780,124,126,'兽角','horns',NULL,NULL,0,100,1,0,1685272978),(1781,124,126,'晒日线','tan_lines',NULL,NULL,0,100,1,0,1685272978),(1782,124,126,'男性脸部胡须','facial_hair',NULL,NULL,0,100,1,0,1685272978),(1783,124,89,'翻白眼','rolleyes',NULL,NULL,0,100,1,0,1685272795),(1784,124,89,'无表情','expressionless',NULL,NULL,0,100,1,0,1685272795),(1785,124,89,'皱眉头','frown',NULL,NULL,0,100,1,0,1685272795),(1786,124,89,'黑暗人格','dark_persona',NULL,NULL,0,100,1,0,1685272795),(1787,124,89,'喝醉','drunk',NULL,NULL,0,100,1,0,1685272795),(1788,124,89,'困倦','sleepy',NULL,NULL,0,100,1,0,1685272795),(1789,124,89,'脸红','blush',NULL,NULL,0,100,1,0,1685272795),(1790,124,89,'尴尬','embarrassed',NULL,NULL,0,100,1,0,1685272795),(1791,124,89,'疯狂','crazy',NULL,NULL,0,100,1,0,1685272795),(1792,124,89,'凝视','stare',NULL,NULL,0,100,1,0,1685272795),(1793,124,89,'咧嘴笑','grin',NULL,NULL,0,100,1,0,1685272795),(1794,124,89,'微笑','smile',NULL,NULL,0,100,1,0,1685272795),(1795,124,89,'叹息','sigh',NULL,NULL,0,100,1,0,1685272795),(1796,124,89,'噘嘴','pout',NULL,NULL,0,100,1,0,1685272795),(1797,15,82,'朱塞佩·阿尔奇莫尔多','by Giuseppe Arcimboldo',NULL,NULL,0,100,1,0,1682230836),(1798,124,89,'张开嘴巴','open_mouth',NULL,NULL,0,100,1,0,1685272795),(1799,124,89,'咬紧牙关','clenched_teeth',NULL,NULL,0,100,1,0,1685272795),(1800,124,89,'嘴唇','lips',NULL,NULL,0,100,1,0,1685272795),(1801,124,89,'流鼻血','nosebleed',NULL,NULL,0,100,1,0,1685272795),(1802,124,89,'嗅觉','smelling',NULL,NULL,0,100,1,0,1685272795),(1803,124,89,'眼泪','tears',NULL,NULL,0,100,1,0,1685272795),(1804,124,89,'眼球','eyeball',NULL,NULL,0,100,1,0,1685272795),(1805,124,89,'尖眼','tsurime',NULL,NULL,0,100,1,0,1685272795),(1806,124,89,'水绿色的眼睛','aqua_eyes',NULL,NULL,0,100,1,0,1685272795),(1807,124,89,'眼皮拉动','eyelid_pull',NULL,NULL,0,100,1,0,1685272795),(1808,16,94,'生动的，实况的','live',NULL,NULL,0,100,1,0,1682230836),(1809,124,89,'心形瞳孔','heart-shaped_pupils',NULL,NULL,0,100,1,0,1685272795),(1810,124,89,'异色瞳孔','heterochromia',NULL,NULL,0,100,1,0,1685272795),(1811,124,89,'狭缝瞳孔','slit_pupils',NULL,NULL,0,100,1,0,1685272795),(1812,124,89,'皱眉','wince',NULL,NULL,0,100,1,0,1685272795),(1813,124,89,'眨眼','wink/blinking',NULL,NULL,0,100,1,0,1685272795),(1814,124,89,'闭着眼睛','eyes_closed',NULL,NULL,0,100,1,0,1685272795),(1815,124,89,'食物沾在脸上','food_on_face',NULL,NULL,0,100,1,0,1685272795),(1816,124,89,'化妆','makeup',NULL,NULL,0,100,1,0,1685272795),(1817,124,110,'姐妹','sisters',NULL,NULL,0,100,1,0,1685272577),(1818,124,110,'兄弟姐妹','siblings',NULL,NULL,0,100,1,0,1685272577),(1819,124,110,'单人','solo',NULL,NULL,0,100,1,0,1685272577),(1820,124,110,'非人','no_humans',NULL,NULL,0,100,1,0,1685272577),(1821,124,110,'后宫','harem',NULL,NULL,0,100,1,0,1685272577),(1822,124,125,'女巨人','giantess',NULL,NULL,0,100,1,0,1685272577),(1823,124,110,'正太','shota',NULL,NULL,0,100,1,0,1685272577),(1824,124,110,'熟女','milf',NULL,NULL,0,100,1,0,1685272577),(1825,15,82,'汉斯·霍尔拜因','by Hans Holbein the Younger',NULL,NULL,0,100,1,0,1682230836),(1826,124,110,'伪娘','trap/crossdressing',NULL,NULL,0,100,1,0,1685272577),(1827,124,110,'Q版人物','chibi',NULL,NULL,0,100,1,0,1685272577),(1828,124,110,'兽耳萝莉模式','kemonomimi_mode',NULL,NULL,0,100,1,0,1685272577),(1829,124,110,'迷你女孩','minigirl',NULL,NULL,0,100,1,0,1685272577),(1830,124,125,'魔鬼（撒旦）','devil',NULL,NULL,0,100,1,0,1685272577),(1831,124,125,'怪物','monster',NULL,NULL,0,100,1,0,1685272577),(1832,124,125,'天使','angel',NULL,NULL,0,100,1,0,1685272577),(1833,124,110,'兽人/半兽人','furry/orc',NULL,NULL,0,100,1,0,1685272577),(1834,124,110,'魔幻少女(指有魔力的)','multiple_girls',NULL,NULL,0,100,1,0,1685272577),(1835,124,110,'魔法少女','magical_girl',NULL,NULL,0,100,1,0,1685272577),(1836,115,121,'皱边的','frills  ',NULL,NULL,0,100,1,0,1685272062),(1837,115,121,'点装花纹的','polka_dot',NULL,NULL,0,100,1,0,1685272062),(1838,115,121,'横条花纹的','striped',NULL,NULL,0,100,1,0,1685272062),(1839,124,125,'巫女','miko',NULL,NULL,0,100,1,0,1685272577),(1840,124,110,'修女','nun',NULL,NULL,0,100,1,0,1685272577),(1841,115,121,'露双肩','bare_shoulders',NULL,NULL,0,100,1,0,1685272062),(1842,124,125,'女巫','witch',NULL,NULL,0,100,1,0,1685272577),(1843,124,110,'忍者/日本武士','ninja',NULL,NULL,0,100,1,0,1685272577),(1844,115,121,'露单肩','off_shoulder',NULL,NULL,0,100,1,0,1685272062),(1845,124,110,'油库里（馒头样人物，东方系列）','yukkuri_shiteitte_ne',NULL,NULL,0,100,1,0,1685272577),(1846,115,121,'面纹','facepaint',NULL,NULL,0,100,1,0,1685272062),(1847,15,82,'亨利·图卢兹-洛特列克','by Henri de Toulouse-Lautrec',NULL,NULL,0,100,1,0,1682230836),(1848,124,110,'人偶','doll',NULL,NULL,0,100,1,0,1685272577),(1849,115,121,'纹身','tattoo',NULL,NULL,0,100,1,0,1685272062),(1850,124,110,'拉拉队','cheerleader',NULL,NULL,0,100,1,0,1685272577),(1851,115,121,'格子花纹','tartan',NULL,NULL,0,100,1,0,1685272062),(1852,124,110,'女服务员','waitress',NULL,NULL,0,100,1,0,1685272577),(1853,115,121,'绝对领域','zettai_ryouiki',NULL,NULL,0,100,1,0,1685272062),(1854,124,110,'女仆','maid',NULL,NULL,0,100,1,0,1685272577),(1855,115,121,'哥特洛丽塔风格','gothic_lolita',NULL,NULL,0,100,1,0,1685272062),(1856,115,121,'洛丽塔风格','lolita_fashion',NULL,NULL,0,100,1,0,1685272062),(1857,115,123,'套装','outfit',NULL,NULL,0,100,1,0,1685271424),(1858,115,123,'单件产品','piece',NULL,NULL,0,100,1,0,1685271424),(1859,115,123,'灵感','inspiration',NULL,NULL,0,100,1,0,1685271424),(1860,15,82,'詹姆斯·惠斯勒','by James Abbott McNeill Whistler',NULL,NULL,0,100,1,0,1682230836),(1861,115,123,'特别','special',NULL,NULL,0,100,1,0,1685271424),(1862,115,123,'独家','exclusive',NULL,NULL,0,100,1,0,1685271424),(1863,115,123,'独特','unique',NULL,NULL,0,100,1,0,1685271424),(1864,115,123,'潮流','trend',NULL,NULL,0,100,1,0,1685271424),(1865,115,123,'服装','garment',NULL,NULL,0,100,1,0,1685271424),(1866,115,123,'品牌','brand',NULL,NULL,0,100,1,0,1685271424),(1867,115,123,'期刊','issue',NULL,NULL,0,100,1,0,1685271424),(1868,115,123,'特辑','collection',NULL,NULL,0,100,1,0,1685271424),(1869,115,123,'展示','display',NULL,NULL,0,100,1,0,1685271424),(1870,115,123,'直播','live show',NULL,NULL,0,100,1,0,1685271424),(1871,115,123,'模特','model',NULL,NULL,0,100,1,0,1685271424),(1872,115,123,'猫步','catwalk',NULL,NULL,0,100,1,0,1685271424),(1873,115,123,'时装秀','fashion show',NULL,NULL,0,100,1,0,1685271424),(1874,115,123,'春夏','spring/summer',NULL,NULL,0,100,1,0,1685271424),(1875,115,123,'秋冬','autumn/winter',NULL,NULL,0,100,1,0,1685271424),(1876,115,123,'热门','hot item',NULL,NULL,0,100,1,0,1685271424),(1877,115,123,'新品','new arrival',NULL,NULL,0,100,1,0,1685271424),(1878,115,123,'广告款','ad items',NULL,NULL,0,100,1,0,1685271424),(1879,115,123,'主打款','hit items',NULL,NULL,0,100,1,0,1685271424),(1880,115,123,'必备品','must have',NULL,NULL,0,100,1,0,1685271424),(1881,115,123,'促销','promotion',NULL,NULL,0,100,1,0,1685271424),(1882,115,123,'折扣季','discount season',NULL,NULL,0,100,1,0,1685271424),(1883,115,123,'畅销品','bestsellers',NULL,NULL,0,100,1,0,1685271424),(1884,115,123,'精选店','boutique',NULL,NULL,0,100,1,0,1685271424),(1885,115,123,'官方','official',NULL,NULL,0,100,1,0,1685271424),(1886,15,82,'约翰内斯·弗梅尔','by Johannes Vermeer',NULL,NULL,0,100,1,0,1682230836),(1887,15,82,'约翰·辛格·萨金特','by John Singer Sargent',NULL,NULL,0,100,1,0,1682230836),(1888,16,94,'充满活力的，活泼的','lively',NULL,NULL,0,100,1,0,1682230836),(1889,15,82,'凯欣德·怀利','by Kehinde Wiley',NULL,NULL,0,100,1,0,1682230836),(1890,115,122,'耸肩','power shoulder',NULL,NULL,0,100,1,0,1685271239),(1891,115,122,'短袖','short sleeve',NULL,NULL,0,100,1,0,1685271239),(1892,115,122,'长袖','long sleeve',NULL,NULL,0,100,1,0,1685271239),(1893,115,122,'圆领','round neck',NULL,NULL,0,100,1,0,1685271239),(1894,115,122,'V领','v-neck',NULL,NULL,0,100,1,0,1685271239),(1895,115,122,'梭织','woven',NULL,NULL,0,100,1,0,1685271239),(1896,115,122,'雪纺','pu',NULL,NULL,0,100,1,0,1685271239),(1897,115,122,'莱卡','tencel',NULL,NULL,0,100,1,0,1685271239),(1898,115,122,'尼龙','flax',NULL,NULL,0,100,1,0,1685271239),(1899,115,122,'羊毛','wool',NULL,NULL,0,100,1,0,1685271239),(1900,115,122,'皮草','fur',NULL,NULL,0,100,1,0,1685271239),(1901,115,122,'牛仔','denim jeans',NULL,NULL,0,100,1,0,1685271239),(1902,115,122,'超级贴身','second skin super skinny',NULL,NULL,0,100,1,0,1685271239),(1903,115,122,'贴身版型','skinny fit',NULL,NULL,0,100,1,0,1685271239),(1904,115,122,'紧身版型','tight fit',NULL,NULL,0,100,1,0,1685271239),(1905,15,82,'卢西安·弗洛伊德','by Lucian Freud',NULL,NULL,0,100,1,0,1682230836),(1906,115,122,'宽松版型','loose fit',NULL,NULL,0,100,1,0,1685271239),(1907,115,122,'标准版型','regular fit',NULL,NULL,0,100,1,0,1685271239),(1908,115,122,'印花','print',NULL,NULL,0,100,1,0,1685271239),(1909,115,122,'染色','dyed',NULL,NULL,0,100,1,0,1685271239),(1910,115,122,'手工','handcraft',NULL,NULL,0,100,1,0,1685271239),(1911,115,122,'破洞','destruction',NULL,NULL,0,100,1,0,1685271239),(1912,115,122,'曲线','curve',NULL,NULL,0,100,1,0,1685271239),(1913,115,122,'裁剪','cut',NULL,NULL,0,100,1,0,1685271239),(1914,115,122,'廊形','shape',NULL,NULL,0,100,1,0,1685271239),(1915,115,121,'快时尚','fast fashion',NULL,NULL,0,100,1,0,1685271187),(1916,115,121,'廉价','cheap',NULL,NULL,0,100,1,0,1685271187),(1917,115,121,'奢侈','luxury',NULL,NULL,0,100,1,0,1685271187),(1918,115,121,'工装风','worker labor',NULL,NULL,0,100,1,0,1685271187),(1919,115,121,'公路风','highway road',NULL,NULL,0,100,1,0,1685271187),(1920,115,121,'淑女风','lady',NULL,NULL,0,100,1,0,1685271187),(1921,115,121,'中性风','neutral',NULL,NULL,0,100,1,0,1685271187),(1922,115,121,'萝莉风','lolita',NULL,NULL,0,100,1,0,1685271187),(1923,15,82,'莫里茨·康奈利斯·艾舍','by Maurits Cornelis Escher',NULL,NULL,0,100,1,0,1682230836),(1924,115,121,'泳装风','swimming wear',NULL,NULL,0,100,1,0,1685271187),(1925,115,121,'航海风','voyage',NULL,NULL,0,100,1,0,1685271187),(1926,115,121,'探险风','explorer adventure',NULL,NULL,0,100,1,0,1685271187),(1927,115,121,'旅行风','travel',NULL,NULL,0,100,1,0,1685271187),(1928,115,121,'海魂风','navy marine',NULL,NULL,0,100,1,0,1685271187),(1929,115,121,'哥特风','gothic',NULL,NULL,0,100,1,0,1685271187),(1930,115,121,'欧美风','european',NULL,NULL,0,100,1,0,1685271187),(1931,115,121,'牛仔风','cowboy',NULL,NULL,0,100,1,0,1685271187),(1932,115,121,'西部风','western',NULL,NULL,0,100,1,0,1685271187),(1933,15,82,'马克斯·贝克曼','by Max Beckmann',NULL,NULL,0,100,1,0,1682230836),(1934,115,121,'度假风','vacation',NULL,NULL,0,100,1,0,1685271187),(1935,115,121,'海滩风','beach',NULL,NULL,0,100,1,0,1685271187),(1936,115,121,'机车风','motorcycle',NULL,NULL,0,100,1,0,1685271187),(1937,115,121,'空军风','air force',NULL,NULL,0,100,1,0,1685271187),(1938,115,121,'军旅风','military army',NULL,NULL,0,100,1,0,1685271187),(1939,115,121,'漫画','comic',NULL,NULL,0,100,1,0,1685271187),(1940,115,121,'卡通','cartoon',NULL,NULL,0,100,1,0,1685271187),(1941,115,121,'简约','simple',NULL,NULL,0,100,1,0,1685271187),(1942,115,121,'粗犷','rough',NULL,NULL,0,100,1,0,1685271187),(1943,115,121,'男友风','boyfriend',NULL,NULL,0,100,1,0,1685271187),(1944,115,121,'别致','chic',NULL,NULL,0,100,1,0,1685271187),(1945,115,121,'清新','chill',NULL,NULL,0,100,1,0,1685271187),(1946,115,121,'酷感','cool',NULL,NULL,0,100,1,0,1685271187),(1947,115,121,'叛逆','rebelling',NULL,NULL,0,100,1,0,1685271187),(1948,115,121,'秘密','secret',NULL,NULL,0,100,1,0,1685271187),(1949,115,121,'侵略性','aggressive',NULL,NULL,0,100,1,0,1685271187),(1950,115,121,'引诱','temptation',NULL,NULL,0,100,1,0,1685271187),(1951,115,121,'狂野','wild',NULL,NULL,0,100,1,0,1685271187),(1952,115,121,'大胆','bold',NULL,NULL,0,100,1,0,1685271187),(1953,115,121,'基本','basic',NULL,NULL,0,100,1,0,1685271187),(1954,115,121,'传统','traditiona',NULL,NULL,0,100,1,0,1685271187),(1955,115,121,'经典','classic',NULL,NULL,0,100,1,0,1685271187),(1956,115,121,'大地色','earthtone color',NULL,NULL,0,100,1,0,1685271187),(1957,115,121,'裸色','nude',NULL,NULL,0,100,1,0,1685271187),(1958,115,121,'撞色','contrast colored',NULL,NULL,0,100,1,0,1685271187),(1959,115,121,'甜美','sweet',NULL,NULL,0,100,1,0,1685271187),(1960,115,121,'朋克','punk',NULL,NULL,0,100,1,0,1685271187),(1961,115,121,'摇滚','rock & roll',NULL,NULL,0,100,1,0,1685271187),(1962,115,121,'高街','high street',NULL,NULL,0,100,1,0,1685271187),(1963,115,121,'民族风','tribe',NULL,NULL,0,100,1,0,1685271187),(1964,115,121,'刺绣','embroider',NULL,NULL,0,100,1,0,1685271187),(1965,115,121,'豹纹','animal print',NULL,NULL,0,100,1,0,1685271187),(1966,115,121,'碎花','flower print',NULL,NULL,0,100,1,0,1685271187),(1967,115,120,'肩章','knot',NULL,NULL,0,100,1,0,1685270979),(1968,115,120,'领带','tie',NULL,NULL,0,100,1,0,1685270979),(1969,115,120,'太阳帽','cap',NULL,NULL,0,100,1,0,1685270979),(1970,115,120,'帽子/礼帽','hat',NULL,NULL,0,100,1,0,1685270979),(1971,115,120,'手表','watch',NULL,NULL,0,100,1,0,1685270979),(1972,115,120,'耳环','ear rings',NULL,NULL,0,100,1,0,1685270979),(1973,115,120,'钱包/手包','wallet',NULL,NULL,0,100,1,0,1685270979),(1974,115,120,'包','bag',NULL,NULL,0,100,1,0,1685270979),(1975,115,120,'手杖','cane',NULL,NULL,0,100,1,0,1685270979),(1976,115,120,'手铐','handcuffs',NULL,NULL,0,100,1,0,1685270979),(1977,115,120,'手链/手铐','cuffs/shackles',NULL,NULL,0,100,1,0,1685270979),(1978,115,120,'露指手套','fingerless_gloves',NULL,NULL,0,100,1,0,1685270979),(1979,15,82,'拉斐尔','by Raphael',NULL,NULL,0,100,1,0,1682230836),(1980,115,120,'长袖手套','elbow_gloves',NULL,NULL,0,100,1,0,1685270979),(1981,115,120,'手套','gloves',NULL,NULL,0,100,1,0,1685270979),(1982,115,120,'腕饰','wrist_cuffs',NULL,NULL,0,100,1,0,1685270979),(1983,115,120,'锁链','chains',NULL,NULL,0,100,1,0,1685270979),(1984,115,120,'腕带','wristband',NULL,NULL,0,100,1,0,1685270979),(1985,115,120,'臂环','armlet',NULL,NULL,0,100,1,0,1685270979),(1986,115,120,'臂章','armband',NULL,NULL,0,100,1,0,1685270979),(1987,115,120,'领带','necktie/tie',NULL,NULL,0,100,1,0,1685270979),(1988,115,120,'围巾','scarf',NULL,NULL,0,100,1,0,1685270979),(1989,115,120,'项链','necklace',NULL,NULL,0,100,1,0,1685270979),(1990,115,120,'颈带','ribbon_choker',NULL,NULL,0,100,1,0,1685270979),(1991,115,120,'水手领','sailor_collar',NULL,NULL,0,100,1,0,1685270979),(1992,115,120,'颈部饰品','choker',NULL,NULL,0,100,1,0,1685270979),(1993,115,120,'铃铛','bell',NULL,NULL,0,100,1,0,1685270979),(1994,115,120,'项圈','collar',NULL,NULL,0,100,1,0,1685270979),(1995,115,120,'首饰','jewelry',NULL,NULL,0,100,1,0,1685270979),(1996,115,120,'耳环','earrings',NULL,NULL,0,100,1,0,1685270978),(1997,115,120,'面具/眼罩/口罩','mask',NULL,NULL,0,100,1,0,1685270978),(1998,115,120,'眼罩(独眼)','eyepatch',NULL,NULL,0,100,1,0,1685270978),(1999,115,120,'眼罩','blindfold',NULL,NULL,0,100,1,0,1685270978),(2000,115,120,'风镜','goggles',NULL,NULL,0,100,1,0,1685270978),(2001,115,120,'太阳镜','sunglasses',NULL,NULL,0,100,1,0,1685270978),(2002,115,120,'眼镜','glasses',NULL,NULL,0,100,1,0,1685270978),(2003,115,120,'丝带','ribbon',NULL,NULL,0,100,1,0,1685270978),(2004,115,120,'服装饰品/头部饰品','bow',NULL,NULL,0,100,1,0,1685270978),(2005,115,120,'女仆头饰','maid_headdress',NULL,NULL,0,100,1,0,1685270978),(2006,115,120,'蝴蝶结发饰','hair_bow',NULL,NULL,0,100,1,0,1685270978),(2007,115,120,'蝴蝶结','bowtie',NULL,NULL,0,100,1,0,1685270978),(2008,15,82,'沙迪·加迪里安','by Shadi Ghadirian',NULL,NULL,0,100,1,0,1682230836),(2009,115,120,'头饰','hair_ornament',NULL,NULL,0,100,1,0,1685270978),(2010,115,120,'发花','hair_flower',NULL,NULL,0,100,1,0,1685270978),(2011,115,120,'发带','hair_ribbon',NULL,NULL,0,100,1,0,1685270978),(2012,115,120,'发夹','hairclip',NULL,NULL,0,100,1,0,1685270978),(2013,115,120,'发卡','hairband',NULL,NULL,0,100,1,0,1685270978),(2014,115,120,'皇冠','crown',NULL,NULL,0,100,1,0,1685270978),(2015,115,120,'三重冕','tiara',NULL,NULL,0,100,1,0,1685270978),(2016,115,120,'护士帽','nurse_cap',NULL,NULL,0,100,1,0,1685270978),(2017,115,120,'兜帽','hood',NULL,NULL,0,100,1,0,1685270978),(2018,115,120,'贝雷帽','beret',NULL,NULL,0,100,1,0,1685270978),(2019,15,82,'塔玛拉·德·兰庇卡','by Tamara de Lempicka',NULL,NULL,0,100,1,0,1682230836),(2020,115,120,'迷你礼帽','mini_top_hat',NULL,NULL,0,100,1,0,1685270978),(2021,115,120,'东金帽子','tokin_hat',NULL,NULL,0,100,1,0,1685270978),(2022,115,120,'头顶光环','halo',NULL,NULL,0,100,1,0,1685270978),(2023,115,119,'鞋','shoes',NULL,NULL,0,100,1,0,1685270875),(2024,115,119,'马靴','knee_boots',NULL,NULL,0,100,1,0,1685270875),(2025,115,119,'女式学生鞋','uwabaki',NULL,NULL,0,100,1,0,1685270875),(2026,115,119,'玛丽珍鞋','mary_janes',NULL,NULL,0,100,1,0,1685270875),(2027,115,119,'板鞋','vans board shoes',NULL,NULL,0,100,1,0,1685270875),(2028,115,119,'拖鞋','slippers',NULL,NULL,0,100,1,0,1685270875),(2029,115,119,'高跟鞋','high heels',NULL,NULL,0,100,1,0,1685270875),(2030,115,119,'系带靴','cross-laced_footwear',NULL,NULL,0,100,1,0,1685270875),(2031,115,119,'长筒袜','stocking',NULL,NULL,0,100,1,0,1685270875),(2032,115,119,'日式厚底短袜','tabi',NULL,NULL,0,100,1,0,1685270875),(2033,115,119,'损坏了的过膝袜','torn_thighhighs',NULL,NULL,0,100,1,0,1685270875),(2034,115,119,'粉色过膝袜','pink_thighhighs',NULL,NULL,0,100,1,0,1685270875),(2035,115,119,'黑色过膝袜','black_thighhighs',NULL,NULL,0,100,1,0,1685270875),(2036,115,119,'白色过膝袜','white_thighhighs',NULL,NULL,0,100,1,0,1685270875),(2037,115,119,'条纹过膝袜','striped_thighhighs',NULL,NULL,0,100,1,0,1685270875),(2038,115,119,'过膝袜','thighhighs',NULL,NULL,0,100,1,0,1685270875),(2039,115,119,'渔网袜','fishnet_pantyhose',NULL,NULL,0,100,1,0,1685270875),(2040,115,119,'连裤袜','pantyhose',NULL,NULL,0,100,1,0,1685270875),(2041,115,119,'渔网袜','fishnet_stockings',NULL,NULL,0,100,1,0,1685270875),(2042,115,119,'丝袜','stockings',NULL,NULL,0,100,1,0,1685270875),(2043,115,119,'长袜','kneehighs',NULL,NULL,0,100,1,0,1685270875),(2044,115,119,'网袜','fishnets',NULL,NULL,0,100,1,0,1685270875),(2045,115,119,'裹腿','legwear',NULL,NULL,0,100,1,0,1685270875),(2046,115,119,'泡泡袜','loose_socks',NULL,NULL,0,100,1,0,1685270875),(2047,16,94,'强大的，有力的','powerful',NULL,NULL,0,100,1,0,1682230836),(2048,115,119,'横条袜','striped_socks',NULL,NULL,0,100,1,0,1685270875),(2049,115,119,'短袜','socks',NULL,NULL,0,100,1,0,1685270875),(2050,115,119,'连腰吊带袜','garter_belt',NULL,NULL,0,100,1,0,1685270875),(2051,115,119,'吊带袜','garters',NULL,NULL,0,100,1,0,1685270875),(2052,115,119,'袜带','garter_straps',NULL,NULL,0,100,1,0,1685270875),(2053,115,119,'高跟鞋','high_heels',NULL,NULL,0,100,1,0,1685270875),(2054,115,119,'腿部系带','ankle_lace-up',NULL,NULL,0,100,1,0,1685270875),(2055,115,119,'腿部花边环','leg_garter',NULL,NULL,0,100,1,0,1685270875),(2056,115,118,'夏日长裙','summer_dress',NULL,NULL,0,100,1,0,1685270802),(2057,115,118,'迷你裙','miniskirt',NULL,NULL,0,100,1,0,1685270802),(2058,15,82,'伊丽莎白·维杰·勒布伦','by Elisabeth Vigée Le Brun',NULL,NULL,0,100,1,0,1682230836),(2059,115,118,'百褶裙','pleated_skirt',NULL,NULL,0,100,1,0,1685270802),(2060,115,118,'衣带(和服用)','obi',NULL,NULL,0,100,1,0,1685270802),(2061,115,118,'腰带','belt',NULL,NULL,0,100,1,0,1685270802),(2062,115,118,'围裙','apron',NULL,NULL,0,100,1,0,1685270802),(2063,115,118,'紧身褡','corset',NULL,NULL,0,100,1,0,1685270802),(2064,115,118,'抹胸裙','sleeveless dress',NULL,NULL,0,100,1,0,1685270802),(2065,115,118,'吊带裙','singlet dress',NULL,NULL,0,100,1,0,1685270802),(2066,115,118,'礼服裙','evening dress',NULL,NULL,0,100,1,0,1685270802),(2067,15,82,'贝基·布雷','by Beckie Bray',NULL,NULL,0,100,1,0,1682230836),(2068,115,118,'半身长裙','long skirt',NULL,NULL,0,100,1,0,1685270802),(2069,115,118,'迷你裙','mini skirt',NULL,NULL,0,100,1,0,1685270802),(2070,115,118,'半身裙','skirt',NULL,NULL,0,100,1,0,1685270802),(2071,115,118,'连衣裙','dress',NULL,NULL,0,100,1,0,1685270802),(2072,115,117,'尿布','diaper',NULL,NULL,0,100,1,0,1685270733),(2073,115,117,'自行车短裤','bike_shorts',NULL,NULL,0,100,1,0,1685270733),(2074,115,117,'短裤','shorts',NULL,NULL,0,100,1,0,1685270733),(2075,115,117,'灯笼裤','bloomers',NULL,NULL,0,100,1,0,1685270733),(2076,115,117,'喇叭裤','flare',NULL,NULL,0,100,1,0,1685270733),(2077,115,117,'阔腿裤','wide leg',NULL,NULL,0,100,1,0,1685270733),(2078,15,82,'布里吉特·迪茨','by Brigitte Dietz',NULL,NULL,0,100,1,0,1682230836),(2079,115,117,'锥形裤','tapered pants',NULL,NULL,0,100,1,0,1685270733),(2080,115,117,'超紧身裤','pants ss',NULL,NULL,0,100,1,0,1685270733),(2081,115,117,'牛仔打底裤','jeggings',NULL,NULL,0,100,1,0,1685270733),(2082,115,117,'打底裤/袜裤','leggings',NULL,NULL,0,100,1,0,1685270733),(2083,115,117,'哈伦裤','harem pants',NULL,NULL,0,100,1,0,1685270733),(2084,115,117,'热裤','hot pants',NULL,NULL,0,100,1,0,1685270733),(2085,115,117,'休闲裤','pants trousers',NULL,NULL,0,100,1,0,1685270733),(2086,115,117,'添加的尾巴','butt_plug',NULL,NULL,0,100,1,0,1685270733),(2087,115,116,'西装','suit',NULL,NULL,0,100,1,0,1685270324),(2088,15,82,'达瑞尔·贝文','by Darrel Bevan',NULL,NULL,0,100,1,0,1682230836),(2089,115,116,'唐装','chinese_clothes',NULL,NULL,0,100,1,0,1685270324),(2090,115,116,'和服','japanese_clothes',NULL,NULL,0,100,1,0,1685270324),(2091,115,116,'晚礼服','formal',NULL,NULL,0,100,1,0,1685270324),(2092,115,116,'职场制服','business_suit',NULL,NULL,0,100,1,0,1685270324),(2093,115,116,'旗袍','chinadress',NULL,NULL,0,100,1,0,1685270324),(2094,115,116,'学校制服','school_uniform',NULL,NULL,0,100,1,0,1685270324),(2095,115,116,'制服','uniform',NULL,NULL,0,100,1,0,1685270324),(2096,115,116,'婚纱','wedding_dress',NULL,NULL,0,100,1,0,1685270324),(2097,15,82,'德里克·里卡德','by Derek Rickard',NULL,NULL,0,100,1,0,1682230836),(2098,115,116,'圣诞装','santa',NULL,NULL,0,100,1,0,1685270324),(2099,115,116,'运动服','gym_uniform',NULL,NULL,0,100,1,0,1685270324),(2100,115,116,'马甲','waist coat',NULL,NULL,0,100,1,0,1685270324),(2101,115,116,'披风','cloak',NULL,NULL,0,100,1,0,1685270324),(2102,115,116,'长羽绒服','down coat',NULL,NULL,0,100,1,0,1685270324),(2103,115,116,'半身羽绒服','down jacket',NULL,NULL,0,100,1,0,1685270324),(2104,115,116,'风衣','trench',NULL,NULL,0,100,1,0,1685270324),(2105,115,116,'大衣','coat',NULL,NULL,0,100,1,0,1685270324),(2106,115,116,'棉服','padding',NULL,NULL,0,100,1,0,1685270324),(2107,115,116,'开衫','cardigan',NULL,NULL,0,100,1,0,1685270324),(2108,15,82,'希瑟·鲁尼·贝斯特','by Heather Rooney Best',NULL,NULL,0,100,1,0,1682230836),(2109,115,116,'针织套衫','jumper',NULL,NULL,0,100,1,0,1685270324),(2110,115,116,'夹克','jacket',NULL,NULL,0,100,1,0,1685270324),(2111,115,116,'学校泳衣','school_swimsuit',NULL,NULL,0,100,1,0,1685270324),(2112,115,116,'泳装','swimsuit',NULL,NULL,0,100,1,0,1685270324),(2113,115,116,'水手服','serafuku',NULL,NULL,0,100,1,0,1685270324),(2114,115,116,'系带式比基尼','side-tie_bikini',NULL,NULL,0,100,1,0,1685270324),(2115,115,116,'比基尼','bikini',NULL,NULL,0,100,1,0,1685270324),(2116,115,116,'浴衣','yukata',NULL,NULL,0,100,1,0,1685270324),(2117,115,116,'卫衣','hoodie',NULL,NULL,0,100,1,0,1685270324),(2118,115,116,'透明睡衣','babydoll',NULL,NULL,0,100,1,0,1685270324),(2119,15,82,'简·史密斯·猎犬','by Jane Smith Gundog',NULL,NULL,0,100,1,0,1682230836),(2120,115,116,'睡衣','pajamas',NULL,NULL,0,100,1,0,1685270324),(2121,115,116,'露腰上衣','midriff',NULL,NULL,0,100,1,0,1685270324),(2122,115,116,'吊带背心','camisole',NULL,NULL,0,100,1,0,1685270324),(2123,115,116,'内衣','underwear',NULL,NULL,0,100,1,0,1685270324),(2124,115,116,'连紧衣','bodystocking',NULL,NULL,0,100,1,0,1685270324),(2125,115,116,'紧身衣','bodysuit',NULL,NULL,0,100,1,0,1685270324),(2126,115,116,'长袍','robe',NULL,NULL,0,100,1,0,1685270324),(2127,115,116,'披肩/斗篷/披风','cape',NULL,NULL,0,100,1,0,1685270324),(2128,115,116,'女用背心','tank_top',NULL,NULL,0,100,1,0,1685270324),(2129,15,82,'林达·玛丽','by Linda Marie',NULL,NULL,0,100,1,0,1682230836),(2130,115,116,'长袖','long_sleeves',NULL,NULL,0,100,1,0,1685270324),(2131,115,116,'袖肩分离装','detached_sleeves',NULL,NULL,0,100,1,0,1685270324),(2132,115,116,'透明装','see-through',NULL,NULL,0,100,1,0,1685270324),(2133,115,116,'破烂衣服','torn_clothes',NULL,NULL,0,100,1,0,1685270324),(2134,115,116,'运动上装/长款上装','jersey top',NULL,NULL,0,100,1,0,1685270324),(2135,115,116,'胸衣','bra',NULL,NULL,0,100,1,0,1685270324),(2136,115,116,'衬衫','shirt',NULL,NULL,0,100,1,0,1685270324),(2137,115,116,'T恤','t-shirt',NULL,NULL,0,100,1,0,1685270324),(2138,115,116,'马甲/背心','vest',NULL,NULL,0,100,1,0,1685270324),(2139,115,116,'套头衫/卫衣','sweater',NULL,NULL,0,100,1,0,1685270324),(2140,15,82,'丽妮·巴奇','by Renie Bartsch',NULL,NULL,0,100,1,0,1682230836),(2141,115,116,'针织衫','knit',NULL,NULL,0,100,1,0,1685270324),(2142,124,114,'妈祖（海洋女神）','mazu (goddess of the sea)',NULL,NULL,0,100,1,0,1684646887),(2143,124,114,'女娲（创造女神）','nüwa (goddess of creation)',NULL,NULL,0,100,1,0,1684646887),(2144,124,114,'二郎神','erlang shen (erlang god)',NULL,NULL,0,100,1,0,1684646887),(2145,124,114,'哪吒（莲花王子）','nezha (third lotus prince)',NULL,NULL,0,100,1,0,1684646887),(2146,124,114,'保生大帝（药神）','baosheng dadi (god of medicine)',NULL,NULL,0,100,1,0,1684646887),(2147,124,114,'财神（财神）','caishen (god of wealth)',NULL,NULL,0,100,1,0,1684646887),(2148,124,114,'土地公（土地之神）','tudi gong (god of the land)',NULL,NULL,0,100,1,0,1684646887),(2149,124,114,'水神','gonggong (god of water)',NULL,NULL,0,100,1,0,1684646887),(2150,15,82,'苏·弗拉斯克','by Sue Flask',NULL,NULL,0,100,1,0,1682230836),(2151,16,94,'异幻的，迷幻的','psychedelic',NULL,NULL,0,100,1,0,1682230836),(2152,124,114,'伏羲（神祖）','fuxi (divine ancestor)',NULL,NULL,0,100,1,0,1684646887),(2153,124,114,'雷公','lei gong (god of thunder)',NULL,NULL,0,100,1,0,1684646887),(2154,124,114,'火神','zhu rong (god of fire)',NULL,NULL,0,100,1,0,1684646887),(2155,124,114,'玄武','xuanwu (black tortoise)',NULL,NULL,0,100,1,0,1684646887),(2156,124,114,'关羽','guan yu (god of war)',NULL,NULL,0,100,1,0,1684646887),(2157,124,114,'火神祝融','zhurong (god of fire)',NULL,NULL,0,100,1,0,1684646887),(2158,124,114,'神农','shennong (divine farmer)',NULL,NULL,0,100,1,0,1684646887),(2159,124,114,'文昌王','wenchang wang (god of literature)',NULL,NULL,0,100,1,0,1684646887),(2160,124,114,'三清','sanqing (three pure ones)',NULL,NULL,0,100,1,0,1684646887),(2161,124,114,'西王母','xi wangmu (queen mother of the west)',NULL,NULL,0,100,1,0,1684646887),(2162,15,82,'小南','by Xiaonan',NULL,NULL,0,100,1,0,1682230836),(2163,124,114,'东岳大帝','dongyue dadi (great emperor of the eastern peak)',NULL,NULL,0,100,1,0,1684646887),(2164,124,114,'太乙真人','taiyi zhenren (supreme unity immortal)',NULL,NULL,0,100,1,0,1684646887),(2165,124,114,'玉皇大帝','yuhuang dadi (jade emperor)',NULL,NULL,0,100,1,0,1684646887),(2166,124,114,'晓（信使鸟）','xiao (messenger bird)',NULL,NULL,0,100,1,0,1684646887),(2167,124,114,'白素贞（白蛇）','bai su zhen (white snake)',NULL,NULL,0,100,1,0,1684646887),(2168,124,114,'九天玄女（战神）','jiu tian xuannü (goddess of war)',NULL,NULL,0,100,1,0,1684646887),(2169,124,114,'饕餮（贪食怪物）','taotie (gluttonous monster)',NULL,NULL,0,100,1,0,1684646887),(2170,124,114,'邪志（正义野兽）','xiezhi (justice beast)',NULL,NULL,0,100,1,0,1684646887),(2172,124,114,'穷奇','qiongqi (winged beast)',NULL,NULL,0,100,1,0,1684646887),(2173,124,114,'白素贞（白蛇）','xingtian (headless giant)',NULL,NULL,0,100,1,0,1684646887),(2174,124,114,'九天玄女（战神）','kuafu (giant pursuer)',NULL,NULL,0,100,1,0,1684646887),(2176,124,114,'伏羲（神祖）','fu xi (divine ancestor)',NULL,NULL,0,100,1,0,1684646887),(2177,15,83,'克拉拉·皮特尔斯','by Clara Peeters',NULL,NULL,0,100,1,0,1682230836),(2178,124,114,'大禹','yu the great (legendary ruler)',NULL,NULL,0,100,1,0,1684646887),(2179,124,114,'盘古（造物主）','pangu (creator god)',NULL,NULL,0,100,1,0,1684646887),(2180,124,114,'祝融（火神）','zhurong (fire god)',NULL,NULL,0,100,1,0,1684646887),(2181,124,114,'龚（水神）','gonggong (water god)',NULL,NULL,0,100,1,0,1684646887),(2182,124,114,'羲和（太阳女神）','xihe (sun goddess)',NULL,NULL,0,100,1,0,1684646887),(2183,124,114,'嫦娥（月亮女神）','chang\'e (moon goddess)',NULL,NULL,0,100,1,0,1684646887),(2184,124,114,'后羿（弓箭手）','houyi (archer god)',NULL,NULL,0,100,1,0,1684646887),(2185,4,132,'翼龙','winged dragon',NULL,NULL,0,100,1,0,1684646887),(2186,4,132,'烛龙（火龙）','zhulong (torch dragon)',NULL,NULL,0,100,1,0,1684646887),(2187,4,132,'福犬（守护狮子）','fu dog (guardian lion)',NULL,NULL,0,100,1,0,1684646887),(2188,4,132,'年（狮子类生物）','nian (lion-like creature)',NULL,NULL,0,100,1,0,1684646887),(2190,124,114,'白泽','bai ze',NULL,NULL,0,100,1,0,1684646887),(2191,4,132,'玄武（黑乌龟和蛇）','xuanwu (black turtle and snake)',NULL,NULL,0,100,1,0,1684646887),(2192,4,132,'天狗','celestial dog',NULL,NULL,0,100,1,0,1684646887),(2193,124,114,'孙悟空','monkey king (sun wukong)',NULL,NULL,0,100,1,0,1684646887),(2194,4,132,'玉兔','jade rabbit',NULL,NULL,0,100,1,0,1684646887),(2195,4,132,'九尾狐','nine-tailed fox',NULL,NULL,0,100,1,0,1684646887),(2196,4,132,'黑乌龟','black tortoise',NULL,NULL,0,100,1,0,1684646887),(2197,15,83,'盖伊·亚奈','by Guy Yanai',NULL,NULL,0,100,1,0,1682230836),(2198,4,132,'白虎','white tiger',NULL,NULL,0,100,1,0,1684646887),(2199,4,132,'朱雀','vermilion bird',NULL,NULL,0,100,1,0,1684646887),(2200,4,132,'貔貅','pixiu',NULL,NULL,0,100,1,0,1684646887),(2201,4,132,'麒麟','qilin',NULL,NULL,0,100,1,0,1684646887),(2202,124,113,'津巴布韦人','yemeni',NULL,NULL,0,100,1,0,1684646316),(2203,124,113,'土耳其人','trinidadian or tobagonian',NULL,NULL,0,100,1,0,1684646316),(2204,15,83,'克劳迪奥·布拉沃','by Claudio Bravo',NULL,NULL,0,100,1,0,1682230836),(2205,124,113,'乌拉圭人','ugandan',NULL,NULL,0,100,1,0,1684646316),(2206,124,113,'赞比亚人','vietnamese',NULL,NULL,0,100,1,0,1684646316),(2207,124,113,'也门人','venezuelan',NULL,NULL,0,100,1,0,1684646316),(2208,124,113,'越南人','vatican city state',NULL,NULL,0,100,1,0,1684646316),(2209,124,113,'委内瑞拉人','vanuatuan',NULL,NULL,0,100,1,0,1684646316),(2210,124,113,'梵蒂冈城国','uzbek',NULL,NULL,0,100,1,0,1684646316),(2211,124,113,'瓦努阿图人','uruguayan',NULL,NULL,0,100,1,0,1684646316),(2212,124,113,'乌兹别克人','ukrainian',NULL,NULL,0,100,1,0,1684646316),(2213,124,113,'乌克兰人','tuvaluan',NULL,NULL,0,100,1,0,1684646316),(2214,124,113,'乌干达人','turkmen',NULL,NULL,0,100,1,0,1684646316),(2215,15,83,'康纳·沃尔顿','by Conor Walton',NULL,NULL,0,100,1,0,1682230836),(2216,124,113,'图瓦卢人','turkish',NULL,NULL,0,100,1,0,1684646316),(2217,124,113,'土库曼人','tunisian',NULL,NULL,0,100,1,0,1684646316),(2218,124,113,'突尼斯人','tongan',NULL,NULL,0,100,1,0,1684646316),(2219,124,113,'特立尼达或多巴哥人','togolese',NULL,NULL,0,100,1,0,1684646316),(2220,124,113,'汤加人','thai',NULL,NULL,0,100,1,0,1684646316),(2221,124,113,'多哥人','tanzanian',NULL,NULL,0,100,1,0,1684646316),(2222,124,113,'泰国人','tajik',NULL,NULL,0,100,1,0,1684646316),(2223,124,113,'坦桑尼亚人','taiwanese',NULL,NULL,0,100,1,0,1684646316),(2224,124,113,'塔吉克人','syrian',NULL,NULL,0,100,1,0,1684646316),(2226,124,113,'叙利亚人','swedish',NULL,NULL,0,100,1,0,1684646316),(2227,124,113,'瑞士人','swazi',NULL,NULL,0,100,1,0,1684646316),(2228,124,113,'瑞典人','surinamer',NULL,NULL,0,100,1,0,1684646316),(2229,124,113,'斯威士兰人','sudanese',NULL,NULL,0,100,1,0,1684646316),(2230,124,113,'苏里南人','sri lankan',NULL,NULL,0,100,1,0,1684646316),(2231,124,113,'苏丹人','spanish',NULL,NULL,0,100,1,0,1684646316),(2232,124,113,'斯里兰卡人','south african',NULL,NULL,0,100,1,0,1684646316),(2233,124,113,'西班牙人','somali',NULL,NULL,0,100,1,0,1684646316),(2234,124,113,'南方非洲人','solomon islander',NULL,NULL,0,100,1,0,1684646316),(2235,124,113,'索马里人','slovenian',NULL,NULL,0,100,1,0,1684646316),(2236,15,83,'费尔南多·博特罗','by Fernando Botero',NULL,NULL,0,100,1,0,1682230836),(2237,16,94,'富有的，丰富的','rich',NULL,NULL,0,100,1,0,1682230836),(2238,124,113,'所罗门群岛人','slovakian',NULL,NULL,0,100,1,0,1684646316),(2239,124,113,'斯洛文尼亚人','singaporean',NULL,NULL,0,100,1,0,1684646316),(2240,124,113,'斯洛伐克人','sierra leonean',NULL,NULL,0,100,1,0,1684646316),(2241,124,113,'新加坡人','seychellois',NULL,NULL,0,100,1,0,1684646316),(2242,124,113,'塞拉利昂人','serbian',NULL,NULL,0,100,1,0,1684646316),(2243,124,113,'塞舌尔人','senegalese',NULL,NULL,0,100,1,0,1684646316),(2244,124,113,'塞尔维亚人','saudi arabian',NULL,NULL,0,100,1,0,1684646316),(2245,124,113,'塞内加尔人','sao tomean',NULL,NULL,0,100,1,0,1684646316),(2246,124,113,'沙特阿拉伯人','san marinese',NULL,NULL,0,100,1,0,1684646316),(2247,124,113,'圣多美和普林西比人','samoan',NULL,NULL,0,100,1,0,1684646316),(2248,15,83,'弗洛里斯·范·迪克','by Floris van Dyck',NULL,NULL,0,100,1,0,1682230836),(2249,124,113,'圣马力诺人','salvadoran',NULL,NULL,0,100,1,0,1684646316),(2250,124,113,'萨摩亚人','saint lucian',NULL,NULL,0,100,1,0,1684646316),(2251,124,113,'萨尔瓦多人','rwandan',NULL,NULL,0,100,1,0,1684646316),(2252,124,113,'圣卢西亚人','russian',NULL,NULL,0,100,1,0,1684646316),(2253,124,113,'卢旺达人','romanian',NULL,NULL,0,100,1,0,1684646316),(2254,124,113,'俄罗斯人','qatari',NULL,NULL,0,100,1,0,1684646316),(2255,124,113,'罗马尼亚人','portuguese',NULL,NULL,0,100,1,0,1684646316),(2256,124,113,'卡塔尔人','polish',NULL,NULL,0,100,1,0,1684646316),(2257,124,113,'葡萄牙人','philippine',NULL,NULL,0,100,1,0,1684646316),(2258,124,113,'波兰人','peruvian',NULL,NULL,0,100,1,0,1684646316),(2259,124,113,'菲律宾人','paraguayan',NULL,NULL,0,100,1,0,1684646316),(2260,124,113,'秘鲁人','papua new guinean',NULL,NULL,0,100,1,0,1684646316),(2261,124,113,'巴拉圭人','panamanian',NULL,NULL,0,100,1,0,1684646316),(2262,124,113,'巴布亚新几内亚人','palauan',NULL,NULL,0,100,1,0,1684646316),(2263,124,113,'巴拿马人','pakistani',NULL,NULL,0,100,1,0,1684646316),(2264,124,113,'帕劳人','omani',NULL,NULL,0,100,1,0,1684646316),(2265,124,113,'巴基斯坦人','norwegian',NULL,NULL,0,100,1,0,1684646316),(2266,124,113,'阿曼人','nigerian',NULL,NULL,0,100,1,0,1684646316),(2267,124,113,'挪威人','nigerien',NULL,NULL,0,100,1,0,1684646316),(2268,124,113,'尼日利亚人','nicaraguan',NULL,NULL,0,100,1,0,1684646316),(2269,15,83,'弗兰斯·斯尼德斯','by Frans Snyders',NULL,NULL,0,100,1,0,1682230836),(2270,124,113,'尼加拉瓜人','new zealander',NULL,NULL,0,100,1,0,1684646316),(2271,124,113,'新新西兰人','nepalese',NULL,NULL,0,100,1,0,1684646316),(2272,124,113,'尼泊尔人','nauruan',NULL,NULL,0,100,1,0,1684646316),(2273,124,113,'瑙鲁人','namibian',NULL,NULL,0,100,1,0,1684646316),(2274,124,113,'纳米比亚人','mozambican',NULL,NULL,0,100,1,0,1684646316),(2275,124,113,'莫桑比克人','moroccan',NULL,NULL,0,100,1,0,1684646316),(2276,124,113,'摩洛哥人','montenegrin',NULL,NULL,0,100,1,0,1684646316),(2277,124,113,'黑山人','mongolian',NULL,NULL,0,100,1,0,1684646316),(2278,124,113,'蒙古人','monacan',NULL,NULL,0,100,1,0,1684646316),(2279,124,113,'摩纳哥人','moldovan',NULL,NULL,0,100,1,0,1684646316),(2280,15,83,'弗兰斯·伊肯斯','by Frans Ykens',NULL,NULL,0,100,1,0,1682230836),(2281,124,113,'摩尔多瓦人','micronesian',NULL,NULL,0,100,1,0,1684646316),(2282,124,113,'密克罗尼西亚人','mexican',NULL,NULL,0,100,1,0,1684646316),(2283,124,113,'墨西哥人','mauritian',NULL,NULL,0,100,1,0,1684646316),(2284,124,113,'毛里求斯人','mauritanian',NULL,NULL,0,100,1,0,1684646316),(2285,124,113,'毛里塔尼亚人','marshallese',NULL,NULL,0,100,1,0,1684646316),(2286,124,113,'马耳他人','malian',NULL,NULL,0,100,1,0,1684646316),(2287,124,113,'马里人','maldivian',NULL,NULL,0,100,1,0,1684646316),(2288,124,113,'马尔代夫人','malaysian',NULL,NULL,0,100,1,0,1684646316),(2289,124,113,'马来西亚人','malawian',NULL,NULL,0,100,1,0,1684646316),(2290,124,113,'马拉维人','malagasy',NULL,NULL,0,100,1,0,1684646316),(2291,124,113,'马达加斯加人','macedonian',NULL,NULL,0,100,1,0,1684646316),(2292,124,113,'马其顿人','luxembourger',NULL,NULL,0,100,1,0,1684646316),(2293,124,113,'卢森堡人','lithuanian',NULL,NULL,0,100,1,0,1684646316),(2294,124,113,'立陶宛人','liechtensteiner',NULL,NULL,0,100,1,0,1684646316),(2295,124,113,'利比亚人','libyan',NULL,NULL,0,100,1,0,1684646316),(2296,124,113,'利比里亚人','liberian',NULL,NULL,0,100,1,0,1684646316),(2297,124,113,'黎巴嫩人','lebanese',NULL,NULL,0,100,1,0,1684646316),(2298,124,113,'拉脱维亚人','latvian',NULL,NULL,0,100,1,0,1684646316),(2299,124,113,'老挝人','lao',NULL,NULL,0,100,1,0,1684646316),(2300,124,113,'吉尔吉斯斯坦人','kyrgyz',NULL,NULL,0,100,1,0,1684646316),(2301,124,113,'科威特人','kuwaiti',NULL,NULL,0,100,1,0,1684646316),(2302,124,113,'韩国人','south korean',NULL,NULL,0,100,1,0,1684646316),(2303,124,113,'朝鲜人','north korean',NULL,NULL,0,100,1,0,1684646316),(2304,124,113,'基里巴斯人','kiribati',NULL,NULL,0,100,1,0,1684646316),(2305,124,113,'肯尼亚人','kenyan',NULL,NULL,0,100,1,0,1684646316),(2306,124,113,'哈萨克斯坦人','kazakhstani',NULL,NULL,0,100,1,0,1684646316),(2307,124,113,'约旦人','jordanian',NULL,NULL,0,100,1,0,1684646316),(2308,124,113,'日本人','japanese',NULL,NULL,0,100,1,0,1684646316),(2309,124,113,'牙买加人','jamaican',NULL,NULL,0,100,1,0,1684646316),(2310,15,83,'乔治奥·莫兰迪','by Giorgio Morandi',NULL,NULL,0,100,1,0,1682230836),(2311,124,113,'科特迪瓦人','ivorian',NULL,NULL,0,100,1,0,1684646316),(2312,124,113,'意大利人','italian',NULL,NULL,0,100,1,0,1684646316),(2313,124,113,'以色列人','israeli',NULL,NULL,0,100,1,0,1684646316),(2314,124,113,'爱尔兰人','irish',NULL,NULL,0,100,1,0,1684646316),(2315,124,113,'伊拉克人','iraqi',NULL,NULL,0,100,1,0,1684646316),(2316,124,113,'伊朗人','iranian',NULL,NULL,0,100,1,0,1684646316),(2317,124,113,'印尼人','indonesian',NULL,NULL,0,100,1,0,1684646316),(2318,124,113,'印度人','indian',NULL,NULL,0,100,1,0,1684646316),(2319,124,113,'冰岛人','icelandic',NULL,NULL,0,100,1,0,1684646316),(2320,124,113,'匈牙利人','hungarian',NULL,NULL,0,100,1,0,1684646316),(2321,15,83,'格蕾丝·科辛顿·史密斯','by Grace Cossington Smith',NULL,NULL,0,100,1,0,1682230836),(2322,124,113,'洪都拉斯人','honduran',NULL,NULL,0,100,1,0,1684646316),(2323,124,113,'海地人','haitian',NULL,NULL,0,100,1,0,1684646316),(2324,124,113,'圭亚那人','guyanese',NULL,NULL,0,100,1,0,1684646316),(2325,124,113,'几内亚人','guinean',NULL,NULL,0,100,1,0,1684646316),(2326,124,113,'危地马拉人','guatemalan',NULL,NULL,0,100,1,0,1684646316),(2327,124,113,'格林纳达人','grenadian',NULL,NULL,0,100,1,0,1684646316),(2328,124,113,'加纳人','ghanaian',NULL,NULL,0,100,1,0,1684646316),(2329,124,113,'德国人','german',NULL,NULL,0,100,1,0,1684646316),(2330,124,113,'格鲁吉亚人','georgian',NULL,NULL,0,100,1,0,1684646316),(2331,15,83,'哈尔门·斯滕维克','by Harmen Steenwijck',NULL,NULL,0,100,1,0,1682230836),(2332,124,113,'冈比亚人','gambian',NULL,NULL,0,100,1,0,1684646316),(2333,124,113,'加蓬人','gabonese',NULL,NULL,0,100,1,0,1684646316),(2334,124,113,'法国人','french',NULL,NULL,0,100,1,0,1684646316),(2335,124,113,'芬兰人','finnish',NULL,NULL,0,100,1,0,1684646316),(2336,124,113,'菲律宾人','filipino',NULL,NULL,0,100,1,0,1684646316),(2337,124,113,'斐济人','fijian',NULL,NULL,0,100,1,0,1684646316),(2338,124,113,'埃塞俄比亚人','ethiopian',NULL,NULL,0,100,1,0,1684646316),(2339,124,113,'爱沙尼亚人','estonian',NULL,NULL,0,100,1,0,1684646316),(2340,124,113,'厄立特里亚人','eritrean',NULL,NULL,0,100,1,0,1684646316),(2341,124,113,'赤道几内亚人','equatorial guinean',NULL,NULL,0,100,1,0,1684646316),(2342,15,83,'亨利·法旺·拉图尔','by Henri Fantin-Latour',NULL,NULL,0,100,1,0,1682230836),(2343,16,94,'强壮的','robust',NULL,NULL,0,100,1,0,1682230836),(2344,124,113,'阿联酋','emirati',NULL,NULL,0,100,1,0,1684646316),(2345,124,113,'埃及','egyptian',NULL,NULL,0,100,1,0,1684646316),(2346,124,113,'厄瓜多尔','ecuadorian',NULL,NULL,0,100,1,0,1684646316),(2347,124,113,'东帝汶','east timorese',NULL,NULL,0,100,1,0,1684646316),(2348,124,113,'荷兰','dutch',NULL,NULL,0,100,1,0,1684646316),(2349,124,113,'多米尼加','dominican',NULL,NULL,0,100,1,0,1684646316),(2350,124,113,'吉布提','djiboutian',NULL,NULL,0,100,1,0,1684646316),(2351,124,113,'丹麦','danish',NULL,NULL,0,100,1,0,1684646316),(2352,124,113,'捷克','czech',NULL,NULL,0,100,1,0,1684646316),(2353,124,113,'塞浦路斯','cypriot',NULL,NULL,0,100,1,0,1684646316),(2354,124,113,'古巴','cuban',NULL,NULL,0,100,1,0,1684646316),(2355,124,113,'克罗地亚','croatian',NULL,NULL,0,100,1,0,1684646316),(2356,124,113,'哥斯达黎加','costa rican',NULL,NULL,0,100,1,0,1684646316),(2357,124,113,'刚果','congolese',NULL,NULL,0,100,1,0,1684646316),(2358,124,113,'科摩罗','comoran',NULL,NULL,0,100,1,0,1684646316),(2359,124,113,'哥伦比亚','colombian',NULL,NULL,0,100,1,0,1684646316),(2360,124,113,'中国','chinese',NULL,NULL,0,100,1,0,1684646316),(2361,124,113,'智利','chilean',NULL,NULL,0,100,1,0,1684646316),(2362,124,113,'乍得','chadian',NULL,NULL,0,100,1,0,1684646316),(2363,124,113,'中部非洲','central african',NULL,NULL,0,100,1,0,1684646316),(2364,15,83,'希拉里·佩西斯','by Hilary Pecis',NULL,NULL,0,100,1,0,1682230836),(2365,124,113,'佛得角人','cape verdean',NULL,NULL,0,100,1,0,1684646316),(2366,124,113,'加拿大人','canadian',NULL,NULL,0,100,1,0,1684646316),(2367,124,113,'喀麦隆人','cameroonian',NULL,NULL,0,100,1,0,1684646316),(2368,124,113,'柬埔寨人','cambodian',NULL,NULL,0,100,1,0,1684646316),(2369,124,113,'布隆迪人','burundian',NULL,NULL,0,100,1,0,1684646316),(2370,124,113,'布基纳法索人','burkinabe',NULL,NULL,0,100,1,0,1684646316),(2371,124,113,'保加利亚人','bulgarian',NULL,NULL,0,100,1,0,1684646316),(2372,124,113,'文莱人','bruneian',NULL,NULL,0,100,1,0,1684646316),(2373,124,113,'英国人','british',NULL,NULL,0,100,1,0,1684646316),(2374,124,113,'巴西人','brazilian',NULL,NULL,0,100,1,0,1684646316),(2375,15,83,'何莉·库利斯','by Holly Coulis',NULL,NULL,0,100,1,0,1682230836),(2376,124,113,'波斯尼亚人','bosnian',NULL,NULL,0,100,1,0,1684646316),(2377,124,113,'玻利维亚人','bolivian',NULL,NULL,0,100,1,0,1684646316),(2378,124,113,'不丹人','bhutanese',NULL,NULL,0,100,1,0,1684646316),(2379,124,113,'贝宁人','beninese',NULL,NULL,0,100,1,0,1684646316),(2380,124,113,'伯利兹人','belizean',NULL,NULL,0,100,1,0,1684646316),(2381,124,113,'比利时人','belgian',NULL,NULL,0,100,1,0,1684646316),(2382,124,113,'白俄罗斯人','belarusian',NULL,NULL,0,100,1,0,1684646316),(2383,124,113,'巴巴多斯人','barbadian',NULL,NULL,0,100,1,0,1684646316),(2384,124,113,'孟加拉国人','bangladeshi',NULL,NULL,0,100,1,0,1684646316),(2385,124,113,'巴林人','bahraini',NULL,NULL,0,100,1,0,1684646316),(2386,15,83,'伊萨克·索罗','by Isaak Soreau',NULL,NULL,0,100,1,0,1682230836),(2387,124,113,'巴哈马人','bahamian',NULL,NULL,0,100,1,0,1684646316),(2388,124,113,'阿塞拜疆人','azerbaijani',NULL,NULL,0,100,1,0,1684646316),(2389,124,113,'奥地利人','austrian',NULL,NULL,0,100,1,0,1684646316),(2390,124,113,'澳大利亚人','australian',NULL,NULL,0,100,1,0,1684646316),(2391,124,113,'亚美尼亚人','armenian',NULL,NULL,0,100,1,0,1684646316),(2392,124,113,'阿根廷人','argentine',NULL,NULL,0,100,1,0,1684646316),(2393,124,113,'安哥拉人','angolan',NULL,NULL,0,100,1,0,1684646316),(2394,124,113,'安道尔人','andorran',NULL,NULL,0,100,1,0,1684646316),(2395,124,113,'美国人','american',NULL,NULL,0,100,1,0,1684646316),(2396,124,113,'阿尔及利亚人','algerian',NULL,NULL,0,100,1,0,1684646316),(2397,15,83,'雅各布·范·埃斯','by Jacob Foppens van Es',NULL,NULL,0,100,1,0,1682230836),(2398,124,113,'阿尔巴尼亚人','albanian',NULL,NULL,0,100,1,0,1684646316),(2399,124,113,'阿富汗人','afghan',NULL,NULL,0,100,1,0,1684646316),(2400,15,83,'雅克·利纳尔','by Jacques Linard',NULL,NULL,0,100,1,0,1682230836),(2401,15,83,'亚恩·布呂盖尔 (长老)','by Jan Brueghel the Elder',NULL,NULL,0,100,1,0,1682230836),(2402,15,83,'亚恩·达维兹·德·希姆','by Jan Davidsz de Heem',NULL,NULL,0,100,1,0,1682230836),(2403,15,83,'让-巴普蒂斯特·西梅翁·沙尔当','by Jean-Baptiste-Siméon Chardin',NULL,NULL,0,100,1,0,1682230836),(2404,15,83,'胡安·鲍蒂斯塔·德埃斯皮诺萨','by Juan Bautista de Espinosa',NULL,NULL,0,100,1,0,1682230836),(2405,16,96,'多雾的','foggy',NULL,NULL,0,100,1,0,1682230836),(2406,15,83,'路易丝·莫伊隆','by Louise Moillon',NULL,NULL,0,100,1,0,1682230836),(2407,15,83,'吕克·图伊曼斯','by Luc Tuymans',NULL,NULL,0,100,1,0,1682230836),(2408,15,83,'卢西亚·伊耳罗','by Lucia Hierro',NULL,NULL,0,100,1,0,1682230836),(2409,15,83,'奥西亚斯·贝尔特','by Osias Beert',NULL,NULL,0,100,1,0,1682230836),(2410,15,83,'保罗·李瓦','by Paul Liegeois',NULL,NULL,0,100,1,0,1682230836),(2411,15,83,'皮特·克莱斯','by Pieter Claesz',NULL,NULL,0,100,1,0,1682230836),(2412,16,94,'饱和的','saturated',NULL,NULL,0,100,1,0,1682230836),(2413,15,83,'瑞秋·吕伊斯','by Rachel Ruysch',NULL,NULL,0,100,1,0,1682230836),(2414,15,83,'塞巴斯蒂安·斯托斯科普夫','by Sebastian Stoskopff',NULL,NULL,0,100,1,0,1682230836),(2415,15,83,'西蒙·吕迪克休斯','by Simon Luttichuys',NULL,NULL,0,100,1,0,1682230836),(2416,15,83,'斯蒂芬妮·史智','by Stephanie H Shih',NULL,NULL,0,100,1,0,1682230836),(2417,15,83,'威廉·克莱斯·赫达','by Willem Claesz Heda',NULL,NULL,0,100,1,0,1682230836),(2418,15,83,'威廉·卡尔夫','by Willem Kalf',NULL,NULL,0,100,1,0,1682230836),(2419,16,94,'有活力的','spirited',NULL,NULL,0,100,1,0,1682230836),(2420,15,83,'艾伦·麦基','by Alan Magee',NULL,NULL,0,100,1,0,1682230836),(2421,15,83,'亚历克·伊根','by Alec Egan',NULL,NULL,0,100,1,0,1682230836),(2422,15,83,'亚历克斯·卡茨','by Alex Katz',NULL,NULL,0,100,1,0,1682230836),(2423,15,83,'艾莉森·瓦特','by Alison Watt',NULL,NULL,0,100,1,0,1682230836),(2424,15,83,'安娜·瓦尔德兹','by Anna Valdez',NULL,NULL,0,100,1,0,1682230836),(2425,15,83,'本·肖恩赛特','by Ben Schonzeit',NULL,NULL,0,100,1,0,1682230836),(2426,15,83,'克莱尔·伍兹','by Clare Woods',NULL,NULL,0,100,1,0,1682230836),(2427,16,94,'刺激的','stimulating',NULL,NULL,0,100,1,0,1682230836),(2428,15,83,'康奈利厄斯·福尔克','by Cornelius Volker',NULL,NULL,0,100,1,0,1682230836),(2429,15,83,'克里斯托夫·伊沃尔','by Cristof Yvore',NULL,NULL,0,100,1,0,1682230836),(2430,15,83,'加文·特克','by Gavin Turk',NULL,NULL,0,100,1,0,1682230836),(2431,16,94,'强大的','strong',NULL,NULL,0,100,1,0,1682230836),(2432,15,83,'英卡·埃森海','by Inka Essenhigh',NULL,NULL,0,100,1,0,1682230836),(2433,15,83,'詹姆斯·怀特','by James White',NULL,NULL,0,100,1,0,1682230836),(2434,4,25,'黑樱桃树','black cherry   tree',NULL,NULL,0,100,1,0,1682230836),(2435,4,25,'松树','pine tree',NULL,NULL,0,100,1,0,1682230836),(2436,4,25,'山楂树','hawthorn tree',NULL,NULL,0,100,1,0,1682230836),(2437,4,25,'树皮','bark',NULL,NULL,0,100,1,0,1682230836),(2438,4,25,'胡桃树','butternut tree',NULL,NULL,0,100,1,0,1682230836),(2439,4,25,'香脂冷杉','balsam fir tree',NULL,NULL,0,100,1,0,1682230836),(2440,4,25,'椴树','basswood tree',NULL,NULL,0,100,1,0,1682230836),(2441,4,25,'榆树','elm tree',NULL,NULL,0,100,1,0,1682230836),(2442,15,83,'约翰内斯·卡尔斯','by Johannes Kahrs',NULL,NULL,0,100,1,0,1682230836),(2443,4,25,'山毛榉','beech tree',NULL,NULL,0,100,1,0,1682230836),(2444,4,25,'大牙白杨树','bigtooth   aspen tree',NULL,NULL,0,100,1,0,1682230836),(2445,4,25,'苦果仁山核桃树','bitternut   hickory tree',NULL,NULL,0,100,1,0,1682230836),(2446,4,25,'黑白蜡树','black ash tree',NULL,NULL,0,100,1,0,1682230836),(2447,4,25,'黑桦树','black birch tree',NULL,NULL,0,100,1,0,1682230836),(2448,4,25,'刺槐树','black locust   tree',NULL,NULL,0,100,1,0,1682230836),(2449,4,25,'黑栎树','black oak tree',NULL,NULL,0,100,1,0,1682230836),(2450,4,25,'黑胡桃树','black walnut   tree',NULL,NULL,0,100,1,0,1682230836),(2451,4,25,'黑杨柳树','black willow   tree',NULL,NULL,0,100,1,0,1682230836),(2452,4,25,'蓝云杉','blue spruce tree',NULL,NULL,0,100,1,0,1682230836),(2453,15,83,'朱利奥·拉拉兹','by Julio Larraz',NULL,NULL,0,100,1,0,1682230836),(2454,4,25,'樱花树','cherry tree',NULL,NULL,0,100,1,0,1682230836),(2455,4,25,'栗树','chestnut tree',NULL,NULL,0,100,1,0,1682230836),(2456,4,25,'棉白杨叶杨','cottonwood tree',NULL,NULL,0,100,1,0,1682230836),(2457,4,25,'灰桦树','gray birch tree',NULL,NULL,0,100,1,0,1682230836),(2458,4,25,'铁杉','hemlock tree',NULL,NULL,0,100,1,0,1682230836),(2459,4,25,'山核桃树','hickory tree',NULL,NULL,0,100,1,0,1682230836),(2460,4,25,'白杨树','aspen tree',NULL,NULL,0,100,1,0,1682230836),(2461,4,25,'皂荚树','honey locust   tree',NULL,NULL,0,100,1,0,1682230836),(2462,4,25,'落叶松树','larch   tree',NULL,NULL,0,100,1,0,1682230836),(2463,4,25,'枫木树','maple   tree',NULL,NULL,0,100,1,0,1682230836),(2464,15,83,'贾斯汀·莫蒂默','by Justin Mortimer',NULL,NULL,0,100,1,0,1682230836),(2465,4,25,'橡树','oak tree',NULL,NULL,0,100,1,0,1682230836),(2466,4,25,'棕榈树','palm tree',NULL,NULL,0,100,1,0,1682230836),(2467,4,25,'纸桦','paper birch tree',NULL,NULL,0,100,1,0,1682230836),(2468,4,25,'针樱花树','pin cherry tree',NULL,NULL,0,100,1,0,1682230836),(2469,4,25,'红杉树','red cedar tree',NULL,NULL,0,100,1,0,1682230836),(2470,4,25,'红栎树','red oak tree',NULL,NULL,0,100,1,0,1682230836),(2471,4,25,'红松','red pine tree',NULL,NULL,0,100,1,0,1682230836),(2472,4,25,'红云杉','red spruce tree',NULL,NULL,0,100,1,0,1682230836),(2473,4,25,'黄樟','sassafras tree',NULL,NULL,0,100,1,0,1682230836),(2474,4,25,'红橡','scarlet oak tree',NULL,NULL,0,100,1,0,1682230836),(2475,15,83,'金昌烈','by Kim Tschang-Yeul',NULL,NULL,0,100,1,0,1682230836),(2476,4,25,'银枫树','silver maple   tree',NULL,NULL,0,100,1,0,1682230836),(2477,4,25,'滑榆树','slippery elm   tree',NULL,NULL,0,100,1,0,1682230836),(2478,4,25,'糖枫树','sugar maple tree',NULL,NULL,0,100,1,0,1682230836),(2479,4,25,'西卡莫尔','sycamore tree',NULL,NULL,0,100,1,0,1682230836),(2480,4,25,'白色树','white ash tree',NULL,NULL,0,100,1,0,1682230836),(2481,4,25,'番红花','crocus',NULL,NULL,0,100,1,0,1682230836),(2482,4,25,'白色栎树','white oak tree',NULL,NULL,0,100,1,0,1682230836),(2483,4,25,'白松','white pine tree',NULL,NULL,0,100,1,0,1682230836),(2484,4,25,'白色云杉树','white spruce   tree',NULL,NULL,0,100,1,0,1682230836),(2485,4,25,'黄桦树','yellow birch   tree',NULL,NULL,0,100,1,0,1682230836),(2486,4,25,'橡子','acor n',NULL,NULL,0,100,1,0,1682230836),(2487,4,25,'紫菀','aster',NULL,NULL,0,100,1,0,1682230836),(2488,4,25,'杜鹃花','azalea',NULL,NULL,0,100,1,0,1682230836),(2489,4,25,'竹子','bamboo',NULL,NULL,0,100,1,0,1682230836),(2490,4,25,'秋海棠','begonia',NULL,NULL,0,100,1,0,1682230836),(2491,4,25,'黑眼苏珊','black eyed susan',NULL,NULL,0,100,1,0,1682230836),(2492,4,25,'蓝鸽','blue columbine',NULL,NULL,0,100,1,0,1682230836),(2493,4,25,'分支','branches',NULL,NULL,0,100,1,0,1682230836),(2494,4,25,'毛茛','buttercup',NULL,NULL,0,100,1,0,1682230836),(2495,4,25,'仙人掌','cactus',NULL,NULL,0,100,1,0,1682230836),(2496,15,83,'卢卡·潘克拉齐','by Luca Pancrazzi',NULL,NULL,0,100,1,0,1682230836),(2497,4,25,'马蹄莲','calla lily',NULL,NULL,0,100,1,0,1682230836),(2498,4,25,'山茶','camellia',NULL,NULL,0,100,1,0,1682230836),(2499,4,25,'大麻','cannabis',NULL,NULL,0,100,1,0,1682230836),(2500,4,25,'菊花','chrysanthemum',NULL,NULL,0,100,1,0,1682230836),(2501,4,25,'铁线莲','clematis',NULL,NULL,0,100,1,0,1682230836),(2502,4,25,'锥花','coneflower',NULL,NULL,0,100,1,0,1682230836),(2503,4,25,'水仙','daffodil',NULL,NULL,0,100,1,0,1682230836),(2504,4,25,'大丽花','dahlia',NULL,NULL,0,100,1,0,1682230836),(2505,4,25,'雏菊','daisy',NULL,NULL,0,100,1,0,1682230836),(2506,4,25,'翠雀属','delphinium',NULL,NULL,0,100,1,0,1682230836),(2507,15,83,'卢西亚诺·文特隆','by Luciano Ventrone',NULL,NULL,0,100,1,0,1682230836),(2508,4,25,'灰米勒','dusty miller',NULL,NULL,0,100,1,0,1682230836),(2509,4,25,'月见报春花','evening primrose',NULL,NULL,0,100,1,0,1682230836),(2510,4,25,'花的','floral',NULL,NULL,0,100,1,0,1682230836),(2511,4,25,'花','flowers',NULL,NULL,0,100,1,0,1682230836),(2512,4,25,'勿忘我','forget me not',NULL,NULL,0,100,1,0,1682230836),(2513,4,25,'连翘','forsythia',NULL,NULL,0,100,1,0,1682230836),(2514,4,25,'小苍兰','freesia',NULL,NULL,0,100,1,0,1682230836),(2515,4,25,'栀子','gardenia',NULL,NULL,0,100,1,0,1682230836),(2516,4,25,'天竺葵','geranium',NULL,NULL,0,100,1,0,1682230836),(2517,4,25,'唐菖蒲','gladiolus',NULL,NULL,0,100,1,0,1682230836),(2518,15,83,'曼努埃尔·切鲁蒂','by Manuele Cerutti',NULL,NULL,0,100,1,0,1682230836),(2519,16,94,'可行的','viable',NULL,NULL,0,100,1,0,1682230836),(2520,4,25,'草','grass',NULL,NULL,0,100,1,0,1682230836),(2521,4,25,'多草的','grassy',NULL,NULL,0,100,1,0,1682230836),(2522,4,25,'干草','hay',NULL,NULL,0,100,1,0,1682230836),(2523,4,25,'干草垛','hay stack',NULL,NULL,0,100,1,0,1682230836),(2524,4,25,'藜芦','hellebore',NULL,NULL,0,100,1,0,1682230836),(2525,4,25,'大麻','hemp',NULL,NULL,0,100,1,0,1682230836),(2526,4,25,'木槿属','hibiscus',NULL,NULL,0,100,1,0,1682230836),(2527,4,25,'风信子','hyacinth',NULL,NULL,0,100,1,0,1682230836),(2528,4,25,'绣球花','hydrangea',NULL,NULL,0,100,1,0,1682230836),(2529,4,25,'虹膜','iris',NULL,NULL,0,100,1,0,1682230836),(2530,15,83,'马蒂亚斯·魏舍尔','by Matthias Weischer',NULL,NULL,0,100,1,0,1682230836),(2531,4,25,'茉莉花','jasmine',NULL,NULL,0,100,1,0,1682230836),(2532,4,25,'熏衣草','lavender',NULL,NULL,0,100,1,0,1682230836),(2533,4,25,'叶子','leaves',NULL,NULL,0,100,1,0,1682230836),(2534,4,25,'丁香','lilac',NULL,NULL,0,100,1,0,1682230836),(2535,4,25,'金盏花','marigold',NULL,NULL,0,100,1,0,1682230836),(2536,4,25,'大麻','marijuana',NULL,NULL,0,100,1,0,1682230836),(2537,4,25,'苔藓','moss',NULL,NULL,0,100,1,0,1682230836),(2538,4,25,'长春花','periwinkle',NULL,NULL,0,100,1,0,1682230836),(2539,4,25,'矮牵牛','petunia',NULL,NULL,0,100,1,0,1682230836),(2540,4,25,'松果','pinecone',NULL,NULL,0,100,1,0,1682230836),(2541,15,83,'迈克尔·辛普森','by Michael Simpson',NULL,NULL,0,100,1,0,1682230836),(2542,4,25,'植物','plant',NULL,NULL,0,100,1,0,1682230836),(2543,4,25,'一品红','poinsettia',NULL,NULL,0,100,1,0,1682230836),(2544,4,25,'罂粟','poppy',NULL,NULL,0,100,1,0,1682230836),(2545,124,110,'皇后','queen',NULL,NULL,0,100,1,0,1682230836),(2546,4,25,'罂粟花','poppies',NULL,NULL,0,100,1,0,1682230836),(2547,4,25,'安妮花边','annes lace',NULL,NULL,0,100,1,0,1682230836),(2548,4,25,'毛茛属','ranunculus',NULL,NULL,0,100,1,0,1682230836),(2549,4,25,'玫瑰','rose',NULL,NULL,0,100,1,0,1682230836),(2550,4,25,'金鱼草','snapdragon',NULL,NULL,0,100,1,0,1682230836),(2551,4,25,'稻草','straw',NULL,NULL,0,100,1,0,1682230836),(2552,15,83,'迈克尔·博雷曼斯','by Michael Borremans',NULL,NULL,0,100,1,0,1682230836),(2553,4,25,'草砖','straw bale',NULL,NULL,0,100,1,0,1682230836),(2554,4,25,'向日葵','sunflower',NULL,NULL,0,100,1,0,1682230836),(2555,4,25,'向日葵','sunflowers',NULL,NULL,0,100,1,0,1682230836),(2556,4,25,'翻滚杂草','tumble weeds',NULL,NULL,0,100,1,0,1682230836),(2557,4,25,'蔓藤','vines',NULL,NULL,0,100,1,0,1682230836),(2558,4,25,'紫罗兰','violet',NULL,NULL,0,100,1,0,1682230836),(2559,4,25,'杂草','weeds',NULL,NULL,0,100,1,0,1682230836),(2561,4,17,'獒犬','mastiff',NULL,NULL,0,100,1,0,1682230836),(2562,15,83,'米尔西亚·苏丘','by Mircea Suciu',NULL,NULL,0,100,1,0,1682230836),(2563,4,17,'杂种狗','mutt',NULL,NULL,0,100,1,0,1682230836),(2564,4,17,'秋田','akita',NULL,NULL,0,100,1,0,1682230836),(2565,4,17,'巴吉度猎犬','basset hound',NULL,NULL,0,100,1,0,1682230836),(2566,4,17,'小猎犬','beagle',NULL,NULL,0,100,1,0,1682230836),(2567,4,17,'比利时玛利诺犬','belgian malinois',NULL,NULL,0,100,1,0,1682230836),(2568,4,17,'伯尔尼山地犬','bernese mountain dog',NULL,NULL,0,100,1,0,1682230836),(2570,4,17,'边境牧羊犬','border collie',NULL,NULL,0,100,1,0,1682230836),(2571,4,17,'波士顿梗','boston terrier',NULL,NULL,0,100,1,0,1682230836),(2572,4,17,'拳师狗','boxer',NULL,NULL,0,100,1,0,1682230836),(2573,15,83,'尼科尔·戴尔','by Nicole Dyer',NULL,NULL,0,100,1,0,1682230836),(2574,4,17,'斗牛犬','bulldog',NULL,NULL,0,100,1,0,1682230836),(2575,4,17,'科西嘉犬','cane corso',NULL,NULL,0,100,1,0,1682230836),(2576,4,17,'吉娃娃','chihuahua',NULL,NULL,0,100,1,0,1682230836),(2577,4,17,'可卡犬','cocker spaniel',NULL,NULL,0,100,1,0,1682230836),(2578,4,17,'牧羊犬','collie',NULL,NULL,0,100,1,0,1682230836),(2579,4,17,'柯吉','corgi',NULL,NULL,0,100,1,0,1682230836),(2580,4,17,'腊肠犬','dachshund',NULL,NULL,0,100,1,0,1682230836),(2581,4,17,'斑点狗','dalmatian',NULL,NULL,0,100,1,0,1682230836),(2582,4,17,'杜宾犬','doberman',NULL,NULL,0,100,1,0,1682230836),(2583,4,17,'法国斗牛犬','french bulldog',NULL,NULL,0,100,1,0,1682230836),(2584,15,83,'妮基·马鲁夫','by Nikki Maloof',NULL,NULL,0,100,1,0,1682230836),(2585,4,17,'德国牧羊犬','german shepherd',NULL,NULL,0,100,1,0,1682230836),(2586,4,17,'金毛猎犬','golden retriever',NULL,NULL,0,100,1,0,1682230836),(2587,4,17,'大丹犬','great dane',NULL,NULL,0,100,1,0,1682230836),(2588,4,17,'爱斯基摩狗','husky',NULL,NULL,0,100,1,0,1682230836),(2589,4,17,'拉布拉多犬','labrador',NULL,NULL,0,100,1,0,1682230836),(2590,4,17,'马耳他犬','maltese',NULL,NULL,0,100,1,0,1682230836),(2591,4,17,'纽芬兰犬','newfie',NULL,NULL,0,100,1,0,1682230836),(2592,4,17,'比特犬','pit bull',NULL,NULL,0,100,1,0,1682230836),(2593,4,17,'博美犬','pomeranian',NULL,NULL,0,100,1,0,1682230836),(2594,4,17,'卷毛狗','poodle',NULL,NULL,0,100,1,0,1682230836),(2595,15,83,'韩韬','by Raymond Han',NULL,NULL,0,100,1,0,1682230836),(2596,4,17,'哈巴狗','pug',NULL,NULL,0,100,1,0,1682230836),(2597,4,17,'罗威纳犬','rottweiler',NULL,NULL,0,100,1,0,1682230836),(2598,4,17,'柴犬','shiba inu',NULL,NULL,0,100,1,0,1682230836),(2599,4,17,'西施犬','shih tzu',NULL,NULL,0,100,1,0,1682230836),(2600,4,17,'圣伯纳狗','st bernard',NULL,NULL,0,100,1,0,1682230836),(2601,4,17,'维兹拉犬','vizsla',NULL,NULL,0,100,1,0,1682230836),(2602,4,17,'威玛猎犬','weimaraner',NULL,NULL,0,100,1,0,1682230836),(2603,4,17,'约克夏梗','yorkie',NULL,NULL,0,100,1,0,1682230836),(2604,4,17,'猫','cat',NULL,NULL,0,100,1,0,1682230836),(2605,4,17,'小猫','kitten',NULL,NULL,0,100,1,0,1682230836),(2606,4,17,'阿比西尼亚猫','abyssinian cat',NULL,NULL,0,100,1,0,1682230836),(2607,4,17,'美国短毛猫','american shorthair cat',NULL,NULL,0,100,1,0,1682230836),(2608,4,17,'英国短毛猫','british shorthair cat',NULL,NULL,0,100,1,0,1682230836),(2609,4,17,'德文卷毛猫','devon rex cat',NULL,NULL,0,100,1,0,1682230836),(2610,4,17,'外来猫','exotic cat',NULL,NULL,0,100,1,0,1682230836),(2611,4,17,'缅因州浣熊','maine coon cat',NULL,NULL,0,100,1,0,1682230836),(2612,4,17,'波斯猫','persian cat',NULL,NULL,0,100,1,0,1682230836),(2613,4,17,'布娃娃猫','ragdoll cat',NULL,NULL,0,100,1,0,1682230836),(2614,4,17,'折耳猫','scottish fold   cat',NULL,NULL,0,100,1,0,1682230836),(2615,4,17,'暹罗猫','siamese   cat',NULL,NULL,0,100,1,0,1682230836),(2616,15,83,'斯科特·弗雷泽','by Scott Fraser',NULL,NULL,0,100,1,0,1682230836),(2617,4,17,'斯芬克斯猫','sphynx cat',NULL,NULL,0,100,1,0,1682230836),(2618,4,17,'亚马逊乳蛙','amazon milk frog',NULL,NULL,0,100,1,0,1682230836),(2619,4,17,'球蟒','ball python',NULL,NULL,0,100,1,0,1682230836),(2620,4,17,'须龙','bearded dragon',NULL,NULL,0,100,1,0,1682230836),(2621,4,17,'黑泰加 ','black tegu',NULL,NULL,0,100,1,0,1682230836),(2622,4,17,'蓝舌蜥蜴','blue tongued   skink',NULL,NULL,0,100,1,0,1682230836),(2623,4,17,'中国水龙','chinese water dragon',NULL,NULL,0,100,1,0,1682230836),(2624,4,17,'玉米锦蛇','corn snake',NULL,NULL,0,100,1,0,1682230836),(2625,4,17,'凤头壁虎','crested gecko',NULL,NULL,0,100,1,0,1682230836),(2626,4,17,'镖蛙','dart frog',NULL,NULL,0,100,1,0,1682230836),(2627,15,83,'蒂莫西·谢尔斯特拉特','by Timothee Schelstraete',NULL,NULL,0,100,1,0,1682230836),(2628,16,94,'充满活力的','vibrant',NULL,NULL,0,100,1,0,1682230836),(2629,4,17,'火腹蟾蜍','fire bellied toad',NULL,NULL,0,100,1,0,1682230836),(2630,4,17,'绿色变色龙','green anole',NULL,NULL,0,100,1,0,1682230836),(2631,4,17,'绿鬣蜥','green iguanas',NULL,NULL,0,100,1,0,1682230836),(2632,4,17,'豹纹壁虎','leopard gecko',NULL,NULL,0,100,1,0,1682230836),(2633,4,17,'巨蜥','monitor lizard',NULL,NULL,0,100,1,0,1682230836),(2634,4,17,'吃豆蛙','pacman frog',NULL,NULL,0,100,1,0,1682230836),(2636,4,17,'虎螈','tiger salamander',NULL,NULL,0,100,1,0,1682230836),(2637,4,17,'陆龟','tortoise',NULL,NULL,0,100,1,0,1682230836),(2638,4,17,'树蛙','tree frog',NULL,NULL,0,100,1,0,1682230836),(2639,15,83,'威廉·贝利','by William Bailey',NULL,NULL,0,100,1,0,1682230836),(2640,4,17,'龟','turtle',NULL,NULL,0,100,1,0,1682230836),(2641,4,17,'白色泰加','white tegu',NULL,NULL,0,100,1,0,1682230836),(2642,4,17,'水族箱','aquarium',NULL,NULL,0,100,1,0,1682230836),(2643,4,17,'金鱼缸','goldfish bowl',NULL,NULL,0,100,1,0,1682230836),(2644,4,17,'孔雀鱼','guppies',NULL,NULL,0,100,1,0,1682230836),(2645,4,17,'金鱼','goldfish',NULL,NULL,0,100,1,0,1682230836),(2646,4,17,'栗鼠','chinchilla',NULL,NULL,0,100,1,0,1682230836),(2647,4,17,'雪貂','ferret',NULL,NULL,0,100,1,0,1682230836),(2648,4,17,'沙鼠','gerbil',NULL,NULL,0,100,1,0,1682230836),(2649,4,17,'豚鼠','guinea pig',NULL,NULL,0,100,1,0,1682230836),(2650,15,83,'颜培明','by Yan Pei-Ming',NULL,NULL,0,100,1,0,1682230836),(2651,4,17,'仓鼠','hamster',NULL,NULL,0,100,1,0,1682230836),(2652,4,17,'鼠标','mouse',NULL,NULL,0,100,1,0,1682230836),(2653,4,17,'大鼠','rat',NULL,NULL,0,100,1,0,1682230836),(2654,4,17,'兔子','rabbit',NULL,NULL,0,100,1,0,1682230836),(2655,4,17,'兔子','bunny',NULL,NULL,0,100,1,0,1682230836),(2656,4,17,'侏儒兔','dwarf papillon rabbit',NULL,NULL,0,100,1,0,1682230836),(2657,4,17,'法国垂耳兔','french lop rabbit',NULL,NULL,0,100,1,0,1682230836),(2658,4,17,'荷兰垂耳兔','holland lop rabbit',NULL,NULL,0,100,1,0,1682230836),(2659,4,17,'狮子头兔','lionhead rabbit',NULL,NULL,0,100,1,0,1682230836),(2660,4,17,'迷你垂耳兔','mini lop rabbit',NULL,NULL,0,100,1,0,1682230836),(2661,15,83,'杨诘苍','by Yang Jiechang',NULL,NULL,0,100,1,0,1682230836),(2662,4,17,'非洲灰鹦鹉','african gray parrot',NULL,NULL,0,100,1,0,1682230836),(2663,4,17,'亚马逊鹦鹉','amazon parrot',NULL,NULL,0,100,1,0,1682230836),(2664,4,17,'金丝雀','canaries',NULL,NULL,0,100,1,0,1682230836),(2665,4,17,'澳洲鹦鹉','cockatiel',NULL,NULL,0,100,1,0,1682230836),(2666,4,17,'凤头鹦鹉','cockatoo',NULL,NULL,0,100,1,0,1682230836),(2668,4,17,'鸽子','dove',NULL,NULL,0,100,1,0,1682230836),(2669,4,17,'雀','finch',NULL,NULL,0,100,1,0,1682230836),(2670,4,17,'爱情鸟','lovebird',NULL,NULL,0,100,1,0,1682230836),(2671,4,17,'金刚鹦鹉','macaw',NULL,NULL,0,100,1,0,1682230836),(2672,15,83,'杨振宗','by Yang Zhenzong',NULL,NULL,0,100,1,0,1682230836),(2673,4,17,'和尚鹦鹉','monk parakeet',NULL,NULL,0,100,1,0,1682230836),(2675,4,17,'小鹦鹉','parrotlet',NULL,NULL,0,100,1,0,1682230836),(2676,4,17,'鹦鹉','parrots',NULL,NULL,0,100,1,0,1682230836),(2677,4,17,'皮翁鹦鹉','pionus parrot',NULL,NULL,0,100,1,0,1682230836),(2678,4,18,'土豚','aardvark',NULL,NULL,0,100,1,0,1682230836),(2679,4,18,'羊驼毛','alpaca',NULL,NULL,0,100,1,0,1682230836),(2680,4,18,'美国黑熊','american black bear',NULL,NULL,0,100,1,0,1682230836),(2681,4,18,'食蚁兽','anteater',NULL,NULL,0,100,1,0,1682230836),(2682,4,18,'猿','ape',NULL,NULL,0,100,1,0,1682230836),(2683,4,18,'犰狳','armadillo',NULL,NULL,0,100,1,0,1682230836),(2684,4,18,'獾','badger',NULL,NULL,0,100,1,0,1682230836),(2685,4,18,'球棒','bat',NULL,NULL,0,100,1,0,1682230836),(2686,4,18,'熊','bear',NULL,NULL,0,100,1,0,1682230836),(2687,4,18,'海狸','beaver',NULL,NULL,0,100,1,0,1682230836),(2689,4,18,'大角羊 ','big horn sheep',NULL,NULL,0,100,1,0,1682230836),(2690,4,18,'野牛','bison',NULL,NULL,0,100,1,0,1682230836),(2691,4,18,'黑熊','black bear',NULL,NULL,0,100,1,0,1682230836),(2692,4,18,'公猪','boar',NULL,NULL,0,100,1,0,1682230836),(2693,4,18,'山猫','bobcat',NULL,NULL,0,100,1,0,1682230836),(2694,4,18,'棕熊','brown bear',NULL,NULL,0,100,1,0,1682230836),(2695,4,18,'布法罗','buffalo',NULL,NULL,0,100,1,0,1682230836),(2696,4,18,'公牛','bull',NULL,NULL,0,100,1,0,1682230836),(2697,4,18,'驴','burro',NULL,NULL,0,100,1,0,1682230836),(2698,4,18,'丛猴','bush baby',NULL,NULL,0,100,1,0,1682230836),(2699,4,18,'骆驼','camel',NULL,NULL,0,100,1,0,1682230836),(2700,4,18,'水豚','capybara',NULL,NULL,0,100,1,0,1682230836),(2701,4,18,'印度豹','cheetah',NULL,NULL,0,100,1,0,1682230836),(2702,4,18,'鸡','chicken',NULL,NULL,0,100,1,0,1682230836),(2703,4,18,'黑猩猩','chimp',NULL,NULL,0,100,1,0,1682230836),(2704,4,18,'花栗鼠','chipmunk',NULL,NULL,0,100,1,0,1682230836),(2705,4,18,'灵猫','civet',NULL,NULL,0,100,1,0,1682230836),(2706,4,18,'云豹','clouded leopard',NULL,NULL,0,100,1,0,1682230836),(2707,4,18,'美洲狮','cougar',NULL,NULL,0,100,1,0,1682230836),(2708,4,18,'母牛','cow',NULL,NULL,0,100,1,0,1682230836),(2709,4,18,'很多牛','cows',NULL,NULL,0,100,1,0,1682230836),(2710,4,18,'丛林狼','coyote',NULL,NULL,0,100,1,0,1682230836),(2711,4,18,'鹿','deer',NULL,NULL,0,100,1,0,1682230836),(2712,4,18,'澳洲野狗','dingo',NULL,NULL,0,100,1,0,1682230836),(2713,4,18,'海豚','dolphin',NULL,NULL,0,100,1,0,1682230836),(2714,4,18,'驴','donkey',NULL,NULL,0,100,1,0,1682230836),(2715,4,18,'鸭嘴兽','duckbill   platypus',NULL,NULL,0,100,1,0,1682230836),(2716,4,18,'针鼹','echidna',NULL,NULL,0,100,1,0,1682230836),(2717,4,18,'大象','elephant',NULL,NULL,0,100,1,0,1682230836),(2718,4,18,'家畜','farm animals',NULL,NULL,0,100,1,0,1682230836),(2719,4,18,'小鹿','fawn',NULL,NULL,0,100,1,0,1682230836),(2720,4,18,'狐狸','fox',NULL,NULL,0,100,1,0,1682230836),(2721,4,18,'长颈鹿','giraffe',NULL,NULL,0,100,1,0,1682230836),(2722,4,18,'山羊','goat',NULL,NULL,0,100,1,0,1682230836),(2723,4,18,'地鼠','gopher',NULL,NULL,0,100,1,0,1682230836),(2724,4,18,'大猩猩','gorilla',NULL,NULL,0,100,1,0,1682230836),(2725,4,18,'灰熊','grizzly bear',NULL,NULL,0,100,1,0,1682230836),(2726,4,18,'土拨鼠','groundhog',NULL,NULL,0,100,1,0,1682230836),(2727,4,18,'豚鼠','guinea pigs',NULL,NULL,0,100,1,0,1682230836),(2728,4,18,'仓鼠','hamsters',NULL,NULL,0,100,1,0,1682230836),(2729,4,18,'野兔','hare',NULL,NULL,0,100,1,0,1682230836),(2730,4,18,'刺猬','hedgehog',NULL,NULL,0,100,1,0,1682230836),(2731,16,94,'充满活力的','vigorous',NULL,NULL,0,100,1,0,1682230836),(2732,4,18,'河马','hippo',NULL,NULL,0,100,1,0,1682230836),(2733,4,18,'猪','hog',NULL,NULL,0,100,1,0,1682230836),(2734,4,18,'蜜獾','honey badger',NULL,NULL,0,100,1,0,1682230836),(2735,4,18,'马','horse',NULL,NULL,0,100,1,0,1682230836),(2736,4,18,'土狼','hyena',NULL,NULL,0,100,1,0,1682230836),(2737,4,18,'豺狼','jackal',NULL,NULL,0,100,1,0,1682230836),(2738,4,18,'美洲虎','jaguar',NULL,NULL,0,100,1,0,1682230836),(2739,4,18,'袋鼠','kangaroo',NULL,NULL,0,100,1,0,1682230836),(2740,4,18,'无尾熊','koala',NULL,NULL,0,100,1,0,1682230836),(2741,4,18,'狐猴','lemur',NULL,NULL,0,100,1,0,1682230836),(2742,4,18,'豹','leopard',NULL,NULL,0,100,1,0,1682230836),(2743,4,18,'狮子','lion',NULL,NULL,0,100,1,0,1682230836),(2744,4,18,'美洲驼','llama',NULL,NULL,0,100,1,0,1682230836),(2745,4,18,'猫鼬','meercat',NULL,NULL,0,100,1,0,1682230836),(2746,4,18,'鼹鼠','mole',NULL,NULL,0,100,1,0,1682230836),(2747,4,18,'猫鼬','mongoose',NULL,NULL,0,100,1,0,1682230836),(2748,4,18,'猴子','monkey',NULL,NULL,0,100,1,0,1682230836),(2749,4,18,'驼鹿','moose',NULL,NULL,0,100,1,0,1682230836),(2750,4,18,'山地山羊','mountain goat',NULL,NULL,0,100,1,0,1682230836),(2751,4,18,'美洲狮','mountain lion',NULL,NULL,0,100,1,0,1682230836),(2752,4,18,'豹猫','ocelot',NULL,NULL,0,100,1,0,1682230836),(2753,4,18,'负鼠','opossum',NULL,NULL,0,100,1,0,1682230836),(2754,4,18,'虎鲸','orca',NULL,NULL,0,100,1,0,1682230836),(2755,4,18,'鸵鸟','ostriche',NULL,NULL,0,100,1,0,1682230836),(2756,4,18,'水獭','otter',NULL,NULL,0,100,1,0,1682230836),(2757,4,18,'猫头鹰','owl',NULL,NULL,0,100,1,0,1682230836),(2758,4,18,'熊猫','panda',NULL,NULL,0,100,1,0,1682230836),(2759,4,18,'豹','panther',NULL,NULL,0,100,1,0,1682230836),(2760,4,18,'猪','pig',NULL,NULL,0,100,1,0,1682230836),(2761,4,18,'北极熊','polar bear',NULL,NULL,0,100,1,0,1682230836),(2762,4,18,'小马','pony',NULL,NULL,0,100,1,0,1682230836),(2764,4,18,'草原犬鼠','prairie dog',NULL,NULL,0,100,1,0,1682230836),(2765,4,18,'螳螂','praying mantis',NULL,NULL,0,100,1,0,1682230836),(2766,4,18,'灵长类动物','primate',NULL,NULL,0,100,1,0,1682230836),(2767,4,18,'美洲狮','puma',NULL,NULL,0,100,1,0,1682230836),(2768,4,18,'短尾矮袋鼠','quokka',NULL,NULL,0,100,1,0,1682230836),(2769,4,18,'浣熊','raccoon',NULL,NULL,0,100,1,0,1682230836),(2770,15,84,'伊夫·唐吉','by Yves Tanguy',NULL,NULL,0,100,1,0,1682230836),(2771,4,18,'乌鸦','raven',NULL,NULL,0,100,1,0,1682230836),(2772,4,18,'剃刀鲸','razorback',NULL,NULL,0,100,1,0,1682230836),(2773,4,18,'小熊猫','red panda',NULL,NULL,0,100,1,0,1682230836),(2774,4,18,'犀牛','rhino',NULL,NULL,0,100,1,0,1682230836),(2775,4,18,'鬣羚','rino',NULL,NULL,0,100,1,0,1682230836),(2776,4,18,'啮齿动物','rodent',NULL,NULL,0,100,1,0,1682230836),(2777,4,18,'公鸡','rooster',NULL,NULL,0,100,1,0,1682230836),(2778,4,18,'海豹','seal',NULL,NULL,0,100,1,0,1682230836),(2779,4,18,'鲨鱼','shark',NULL,NULL,0,100,1,0,1682230836),(2780,15,84,'维克多·布劳纳','by Victor Brauner',NULL,NULL,0,100,1,0,1682230836),(2781,4,18,'绵羊','sheep',NULL,NULL,0,100,1,0,1682230836),(2782,4,18,'鼩鼱','shrew',NULL,NULL,0,100,1,0,1682230836),(2783,4,18,'臭鼬','skunk',NULL,NULL,0,100,1,0,1682230836),(2784,4,18,'树懒','sloth',NULL,NULL,0,100,1,0,1682230836),(2785,4,18,'松鼠','squirrel',NULL,NULL,0,100,1,0,1682230836),(2786,4,18,'老虎','tiger',NULL,NULL,0,100,1,0,1682230836),(2787,4,18,'小袋鼠','wallaby',NULL,NULL,0,100,1,0,1682230836),(2788,4,18,'水牛','water buffalo',NULL,NULL,0,100,1,0,1682230836),(2789,4,18,'鲸','whale',NULL,NULL,0,100,1,0,1682230836),(2790,4,18,'野生动物','wildlife',NULL,NULL,0,100,1,0,1682230836),(2791,15,84,'亚历山大·考尔德','by Alexander Calder',NULL,NULL,0,100,1,0,1682230836),(2792,4,18,'狼','wolf',NULL,NULL,0,100,1,0,1682230836),(2793,4,18,'金刚狼','wolverine',NULL,NULL,0,100,1,0,1682230836),(2794,4,18,'袋熊','wombat',NULL,NULL,0,100,1,0,1682230836),(2795,4,18,'土拨鼠','woodchuck',NULL,NULL,0,100,1,0,1682230836),(2796,4,18,'斑马','zebra',NULL,NULL,0,100,1,0,1682230836),(2797,4,19,'神仙鱼','angelfish',NULL,NULL,0,100,1,0,1682230836),(2798,4,19,'巴卢加鲸','baluga whale',NULL,NULL,0,100,1,0,1682230836),(2799,4,19,'梭鱼','baracuda',NULL,NULL,0,100,1,0,1682230836),(2800,4,19,'斗鱼','betta',NULL,NULL,0,100,1,0,1682230836),(2801,4,19,'黑鲈','black bass',NULL,NULL,0,100,1,0,1682230836),(2802,15,84,'莱奥诺拉·卡林顿','by Leonora Carrington',NULL,NULL,0,100,1,0,1682230836),(2803,4,19,'蓝鲸','blue whale',NULL,NULL,0,100,1,0,1682230836),(2804,4,19,'蓝鳍金枪鱼','bluefin tuna',NULL,NULL,0,100,1,0,1682230836),(2805,4,19,'宽吻海豚','bottlenose',NULL,NULL,0,100,1,0,1682230836),(2806,4,19,'箱鲀','boxfish',NULL,NULL,0,100,1,0,1682230836),(2807,4,19,'大头鱼','bullhead',NULL,NULL,0,100,1,0,1682230836),(2808,4,19,'鲶鱼','catfish',NULL,NULL,0,100,1,0,1682230836),(2809,4,19,'小丑鱼','clownfish',NULL,NULL,0,100,1,0,1682230836),(2810,4,19,'珊瑚礁','coral reef',NULL,NULL,0,100,1,0,1682230836),(2811,4,19,'蟹','crab',NULL,NULL,0,100,1,0,1682230836),(2812,4,19,'莓鲈','crappie',NULL,NULL,0,100,1,0,1682230836),(2813,15,84,'罗贝托·马塔','by Roberto Matta',NULL,NULL,0,100,1,0,1682230836),(2814,4,19,'墨鱼','cuttlefish',NULL,NULL,0,100,1,0,1682230836),(2815,4,19,'角鲨','dogfish',NULL,NULL,0,100,1,0,1682230836),(2816,4,19,'比目鱼','flounder',NULL,NULL,0,100,1,0,1682230836),(2817,4,19,'巨型太平洋章鱼','giant pacific octopus',NULL,NULL,0,100,1,0,1682230836),(2818,4,19,'大王乌贼','giant squid',NULL,NULL,0,100,1,0,1682230836),(2819,4,19,'大白鲨','great white shark',NULL,NULL,0,100,1,0,1682230836),(2820,4,19,'双髻鲨','hammerhead shark',NULL,NULL,0,100,1,0,1682230836),(2821,4,19,'洪堡鱿鱼','humboldt squid',NULL,NULL,0,100,1,0,1682230836),(2822,4,19,'座头鲸','humpback whale',NULL,NULL,0,100,1,0,1682230836),(2823,15,84,'保罗·纳什','by Paul Nash',NULL,NULL,0,100,1,0,1682230836),(2824,4,19,'水母','jellyfish',NULL,NULL,0,100,1,0,1682230836),(2825,4,19,'虎鲸','killer whale',NULL,NULL,0,100,1,0,1682230836),(2826,4,19,'锦鲤','koi',NULL,NULL,0,100,1,0,1682230836),(2827,4,19,'狮鬃水母','lions mane jellyfish',NULL,NULL,0,100,1,0,1682230836),(2828,4,19,'龙虾','lobster',NULL,NULL,0,100,1,0,1682230836),(2829,4,19,'鬼头刀鱼','mahimahi',NULL,NULL,0,100,1,0,1682230836),(2830,4,19,'海牛','manatees',NULL,NULL,0,100,1,0,1682230836),(2831,4,19,'马林','marlin',NULL,NULL,0,100,1,0,1682230836),(2832,4,19,'白斑狗鱼','northern pike',NULL,NULL,0,100,1,0,1682230836),(2833,4,19,'章鱼','octopus',NULL,NULL,0,100,1,0,1682230836),(2834,15,84,'雷梅迪奥斯·瓦罗','by Remedios Varo',NULL,NULL,0,100,1,0,1682230836),(2835,16,94,'重要的','vital',NULL,NULL,0,100,1,0,1682230836),(2836,4,19,'平底锅鱼','panfish',NULL,NULL,0,100,1,0,1682230836),(2837,4,19,'鼠海豚','porpoise',NULL,NULL,0,100,1,0,1682230836),(2838,4,19,'虹鳟','rainbow trout',NULL,NULL,0,100,1,0,1682230836),(2839,4,19,'鲑鱼','salmon',NULL,NULL,0,100,1,0,1682230836),(2840,4,19,'海马','sea horse',NULL,NULL,0,100,1,0,1682230836),(2841,4,19,'海狮','sea lion',NULL,NULL,0,100,1,0,1682230836),(2842,4,19,'海猴','sea monkey',NULL,NULL,0,100,1,0,1682230836),(2843,15,84,'阿尔贝托·贾科梅蒂','by Alberto Giacometti',NULL,NULL,0,100,1,0,1682230836),(2844,4,19,'暹罗斗鱼','siamese fighting fish',NULL,NULL,0,100,1,0,1682230836),(2845,4,19,'鱿鱼','squid',NULL,NULL,0,100,1,0,1682230836),(2846,4,19,'海星','starfish',NULL,NULL,0,100,1,0,1682230836),(2847,4,19,'硬头鳟','steelhead',NULL,NULL,0,100,1,0,1682230836),(2848,4,19,'魟','stingray',NULL,NULL,0,100,1,0,1682230836),(2849,4,19,'条纹鲈','striped bass',NULL,NULL,0,100,1,0,1682230836),(2850,4,19,'剑鱼','swordfish',NULL,NULL,0,100,1,0,1682230836),(2851,4,19,'虎鱼','tiger fish',NULL,NULL,0,100,1,0,1682230836),(2852,4,19,'虎鲨','tiger shark',NULL,NULL,0,100,1,0,1682230836),(2853,4,19,'鳟鱼','trout',NULL,NULL,0,100,1,0,1682230836),(2854,15,84,'爱德华·沃兹沃思','by Edward Wadsworth',NULL,NULL,0,100,1,0,1682230836),(2855,4,19,'大眼鱼','walleye',NULL,NULL,0,100,1,0,1682230836),(2857,4,20,'洞熊','cave bear',NULL,NULL,0,100,1,0,1682230836),(2858,4,20,'渡渡鸟','dodo bird',NULL,NULL,0,100,1,0,1682230836),(2859,4,20,'巨型短脸熊','giant short faced bear',NULL,NULL,0,100,1,0,1682230836),(2860,4,20,'巨猿 ','gigantopithecus',NULL,NULL,0,100,1,0,1682230836),(2862,4,20,'剑齿猫','saber toothed cat',NULL,NULL,0,100,1,0,1682230836),(2863,4,20,'塔斯马尼亚虎','tasmanian tiger',NULL,NULL,0,100,1,0,1682230836),(2864,15,84,'汉斯·贝尔默','by Hans Bellmer',NULL,NULL,0,100,1,0,1682230836),(2865,4,20,'长毛猛犸','woolly mammoth',NULL,NULL,0,100,1,0,1682230836),(2866,4,20,'丹尼索瓦人','denisova hominin',NULL,NULL,0,100,1,0,1682230836),(2868,4,20,'弗洛雷斯人','flores man',NULL,NULL,0,100,1,0,1682230836),(2870,4,20,'穴居人','neanderthal',NULL,NULL,0,100,1,0,1682230836),(2871,4,20,'异特龙属','allosaurus',NULL,NULL,0,100,1,0,1682230836),(2872,4,20,'安第斯龙属','andesaurus',NULL,NULL,0,100,1,0,1682230836),(2873,4,20,'腕龙','brachiosaur',NULL,NULL,0,100,1,0,1682230836),(2874,4,20,'雷龙','brontosaurus',NULL,NULL,0,100,1,0,1682230836),(2875,15,84,'保罗·德尔沃','by Paul Delvaux',NULL,NULL,0,100,1,0,1682230836),(2876,4,20,'欧洲龙','europasaurus',NULL,NULL,0,100,1,0,1682230836),(2877,4,20,'禽龙 ','iguanodon',NULL,NULL,0,100,1,0,1682230836),(2878,4,20,'翼指龙','pterodactyl',NULL,NULL,0,100,1,0,1682230836),(2879,4,20,'猛禽','raptorex',NULL,NULL,0,100,1,0,1682230836),(2880,4,20,'棘龙','spinosaurus',NULL,NULL,0,100,1,0,1682230836),(2881,4,20,'剑龙','stegosaurus',NULL,NULL,0,100,1,0,1682230836),(2883,4,20,'霸王龙','tyrannosaurus rex',NULL,NULL,0,100,1,0,1682230836),(2884,4,20,'迅猛龙','velociraptor',NULL,NULL,0,100,1,0,1682230836),(2885,4,20,'皱鳃鲨','frilled shark',NULL,NULL,0,100,1,0,1682230836),(2886,15,84,'奥斯卡·多明格斯','by Oscar Domínguez',NULL,NULL,0,100,1,0,1682230836),(2887,4,20,'旋齿鲨','helicoprion',NULL,NULL,0,100,1,0,1682230836),(2888,4,20,'鱼龙','ichthyosaur',NULL,NULL,0,100,1,0,1682230836),(2889,4,20,'巨齿鲨','megalodon',NULL,NULL,0,100,1,0,1682230836),(2890,4,20,'蛇颈龙','plesiosaurs',NULL,NULL,0,100,1,0,1682230836),(2891,4,20,'塔龙属','tylosaurus',NULL,NULL,0,100,1,0,1682230836),(2892,4,21,'阿利科恩','alicorn',NULL,NULL,0,100,1,0,1682230836),(2893,4,21,'女妖','banshee',NULL,NULL,0,100,1,0,1682230836),(2894,4,21,'蛇怪','basilisk',NULL,NULL,0,100,1,0,1682230836),(2895,4,21,'大脚怪','bigfoot',NULL,NULL,0,100,1,0,1682230836),(2896,4,21,'黑犬Black Dog   Monster','black dog   monster',NULL,NULL,0,100,1,0,1682230836),(2897,15,84,'乔纳森·米斯','by Jonathan Meese',NULL,NULL,0,100,1,0,1682230836),(2898,4,21,'黑眼睛的生物','black eyed beings',NULL,NULL,0,100,1,0,1682230836),(2899,4,21,'妖怪','bogeyman',NULL,NULL,0,100,1,0,1682230836),(2900,4,21,'博格勒','bogle',NULL,NULL,0,100,1,0,1682230836),(2901,4,21,'路兽','bray road beast',NULL,NULL,0,100,1,0,1682230836),(2902,4,21,'布鲁斯','bruce',NULL,NULL,0,100,1,0,1682230836),(2903,4,21,'褐蝇','brundlefly',NULL,NULL,0,100,1,0,1682230836),(2904,4,21,'布古尔','bughuul',NULL,NULL,0,100,1,0,1682230836),(2906,4,21,'半人马','centaur',NULL,NULL,0,100,1,0,1682230836),(2907,4,21,'地狱犬','cerberus',NULL,NULL,0,100,1,0,1682230836),(2908,15,84,'阿尔贝托·萨维尼奥','by Alberto Savinio',NULL,NULL,0,100,1,0,1682230836),(2909,4,21,'卡吕布迪斯','charybdis',NULL,NULL,0,100,1,0,1682230836),(2910,4,21,'喀迈拉','chimera',NULL,NULL,0,100,1,0,1682230836),(2911,4,21,'恰基','chucky',NULL,NULL,0,100,1,0,1682230836),(2912,4,21,'卓柏卡布拉','chupacabra',NULL,NULL,0,100,1,0,1682230836),(2913,4,21,'科卡特里切','cockatrice',NULL,NULL,0,100,1,0,1682230836),(2914,4,21,'德古拉伯爵','count dracula',NULL,NULL,0,100,1,0,1682230836),(2915,4,21,'爬行动物','crawlers',NULL,NULL,0,100,1,0,1682230836),(2916,4,21,'独眼巨人','cyclops',NULL,NULL,0,100,1,0,1682230836),(2917,4,21,'狗头人','cynocephalus',NULL,NULL,0,100,1,0,1682230836),(2918,4,21,'恶魔','demon',NULL,NULL,0,100,1,0,1682230836),(2919,15,84,'阿里·迪万达里','by Ali Divandari',NULL,NULL,0,100,1,0,1682230836),(2920,4,21,'恶魔','demons',NULL,NULL,0,100,1,0,1682230836),(2921,4,21,'二重身','doppelganger',NULL,NULL,0,100,1,0,1682230836),(2922,4,21,'龙','dragon',NULL,NULL,0,100,1,0,1682230836),(2923,4,21,'多条龙','dragons',NULL,NULL,0,100,1,0,1682230836),(2924,4,21,'侏儒','dwarf',NULL,NULL,0,100,1,0,1682230836),(2925,4,21,'矮人','dwarves',NULL,NULL,0,100,1,0,1682230836),(2926,4,21,'德布克','dybbuk',NULL,NULL,0,100,1,0,1682230836),(2927,4,21,'埃及神','egyptian gods',NULL,NULL,0,100,1,0,1682230836),(2928,4,21,'小精灵','elf',NULL,NULL,0,100,1,0,1682230836),(2929,4,21,'精灵','elves',NULL,NULL,0,100,1,0,1682230836),(2930,15,84,'安德烈·布勒东','by Andre Breton',NULL,NULL,0,100,1,0,1682230836),(2931,4,21,'抱脸者','facehugger',NULL,NULL,0,100,1,0,1682230836),(2932,4,21,'仙女','fairies',NULL,NULL,0,100,1,0,1682230836),(2933,4,21,'仙女','fairy',NULL,NULL,0,100,1,0,1682230836),(2934,4,21,'弗雷迪·克鲁格','freddy krueger',NULL,NULL,0,100,1,0,1682230836),(2935,4,21,'滴水嘴','gargoyle',NULL,NULL,0,100,1,0,1682230836),(2936,4,21,'鬼','ghost',NULL,NULL,0,100,1,0,1682230836),(2937,4,21,'侏儒','gnome',NULL,NULL,0,100,1,0,1682230836),(2938,4,21,'妖精','goblin',NULL,NULL,0,100,1,0,1682230836),(2939,4,21,'哥斯拉','godzilla',NULL,NULL,0,100,1,0,1682230836),(2940,4,21,'魔像','golem',NULL,NULL,0,100,1,0,1682230836),(2941,16,94,'活力','vitality',NULL,NULL,0,100,1,0,1682230836),(2942,4,21,'戈尔贡','gorgon',NULL,NULL,0,100,1,0,1682230836),(2943,4,21,'拟笔石','graboids',NULL,NULL,0,100,1,0,1682230836),(2944,4,21,'希腊诸神','greek gods',NULL,NULL,0,100,1,0,1682230836),(2945,4,21,'狮鹫','griffin',NULL,NULL,0,100,1,0,1682230836),(2946,4,21,'死神','grim reaper',NULL,NULL,0,100,1,0,1682230836),(2947,4,21,'无头的   骑手','headless   horseman',NULL,NULL,0,100,1,0,1682230836),(2948,4,21,'妖怪','hobgoblin',NULL,NULL,0,100,1,0,1682230836),(2949,4,21,'霍默顿','homerton',NULL,NULL,0,100,1,0,1682230836),(2950,4,21,'水螅','hydra',NULL,NULL,0,100,1,0,1682230836),(2951,4,21,'小恶魔','imp',NULL,NULL,0,100,1,0,1682230836),(2952,15,84,'阿劳夫·莱纳','by Arnulf Rainer',NULL,NULL,0,100,1,0,1682230836),(2953,4,21,'豺狼','jackalope',NULL,NULL,0,100,1,0,1682230836),(2954,4,21,'金派蒙','king paimon',NULL,NULL,0,100,1,0,1682230836),(2955,4,21,'儿玉','kodama',NULL,NULL,0,100,1,0,1682230836),(2956,4,21,'拉东','ladon',NULL,NULL,0,100,1,0,1682230836),(2957,4,21,'妖精','leprechaun',NULL,NULL,0,100,1,0,1682230836),(2958,4,21,'尼斯Loch ness   Monster','loch ness   monster',NULL,NULL,0,100,1,0,1682230836),(2959,4,21,'蝎尾','manticore',NULL,NULL,0,100,1,0,1682230836),(2960,4,21,'水母','medusa',NULL,NULL,0,100,1,0,1682230836),(2961,4,21,'美人鱼','mermaid',NULL,NULL,0,100,1,0,1682230836),(2962,4,21,'人鱼','merman',NULL,NULL,0,100,1,0,1682230836),(2963,15,84,'鲍里斯·马戈','by Boris Margo',NULL,NULL,0,100,1,0,1682230836),(2964,4,21,'迈克尔·迈尔斯','michael myers',NULL,NULL,0,100,1,0,1682230836),(2965,4,21,'牛头怪','minotaur',NULL,NULL,0,100,1,0,1682230836),(2966,4,21,'现代人','moder',NULL,NULL,0,100,1,0,1682230836),(2967,4,21,'蛾人','mothman',NULL,NULL,0,100,1,0,1682230836),(2968,4,21,'木乃伊','mummies',NULL,NULL,0,100,1,0,1682230836),(2969,4,21,'突变体','mutants',NULL,NULL,0,100,1,0,1682230836),(2970,4,21,'神话','myth',NULL,NULL,0,100,1,0,1682230836),(2971,4,21,'尼米亚狮','nemean lion',NULL,NULL,0,100,1,0,1682230836),(2972,4,21,'新泽西魔鬼','new jersey devil',NULL,NULL,0,100,1,0,1682230836),(2973,4,21,'若虫','nymph',NULL,NULL,0,100,1,0,1682230836),(2974,15,84,'大卫·哈尔','by David Hare',NULL,NULL,0,100,1,0,1682230836),(2975,4,21,'食人魔','ogre',NULL,NULL,0,100,1,0,1682230836),(2976,4,21,'奥斯罗斯','orthros',NULL,NULL,0,100,1,0,1682230836),(2977,4,21,'飞马座','pegasus',NULL,NULL,0,100,1,0,1682230836),(2978,4,21,'一分钱一分货','pennywise',NULL,NULL,0,100,1,0,1682230836),(2979,4,21,'凤凰','phoenix',NULL,NULL,0,100,1,0,1682230836),(2980,4,21,'小精灵','pixie',NULL,NULL,0,100,1,0,1682230836),(2981,4,21,'恶作剧鬼','poltergeist',NULL,NULL,0,100,1,0,1682230836),(2982,4,21,'里根麦克尼尔','regan macneil',NULL,NULL,0,100,1,0,1682230836),(2983,4,21,'贞子和   萨马拉','sadako and   samara',NULL,NULL,0,100,1,0,1682230836),(2984,4,21,'大脚野人','sasquatch',NULL,NULL,0,100,1,0,1682230836),(2985,15,84,'多萝西亚·坦宁','by Dorothea Tanning',NULL,NULL,0,100,1,0,1682230836),(2986,4,21,'半羊人','satyr',NULL,NULL,0,100,1,0,1682230836),(2987,4,21,'尖叫熊','screamy bear',NULL,NULL,0,100,1,0,1682230836),(2988,4,21,'锡拉','scylla',NULL,NULL,0,100,1,0,1682230836),(2989,4,21,'海怪','sea monsters',NULL,NULL,0,100,1,0,1682230836),(2990,4,21,'阴影','shade',NULL,NULL,0,100,1,0,1682230836),(2991,4,21,'变形人','shapeshifters',NULL,NULL,0,100,1,0,1682230836),(2992,4,21,'警报器','sirens',NULL,NULL,0,100,1,0,1682230836),(2993,4,21,'狮身人面像','sphinx',NULL,NULL,0,100,1,0,1682230836),(2994,4,21,'精灵','sprite',NULL,NULL,0,100,1,0,1682230836),(2995,4,21,'精灵','sylph',NULL,NULL,0,100,1,0,1682230836),(2996,15,84,'爱德华·戈瑞','by Edward Gorey',NULL,NULL,0,100,1,0,1682230836),(2997,4,21,'巴巴杜克','the babadook',NULL,NULL,0,100,1,0,1682230836),(2998,4,21,'果穆尔','the gwoemul',NULL,NULL,0,100,1,0,1682230836),(2999,4,21,'海妖','the kraken',NULL,NULL,0,100,1,0,1682230836),(3000,4,21,'激光玻璃','the lasser glass',NULL,NULL,0,100,1,0,1682230836),(3001,4,21,'苍白的人','the pale man',NULL,NULL,0,100,1,0,1682230836),(3002,4,21,'捕食者','the predator',NULL,NULL,0,100,1,0,1682230836),(3003,4,21,'触手怪','the tentacle monster',NULL,NULL,0,100,1,0,1682230836),(3005,4,21,'雷鸟','thunderbird',NULL,NULL,0,100,1,0,1682230836),(3006,4,21,'巨魔','trolls',NULL,NULL,0,100,1,0,1682230836),(3007,15,84,'恩里科·多纳蒂','by Enrico Donati',NULL,NULL,0,100,1,0,1682230836),(3008,4,21,'台风','typhon',NULL,NULL,0,100,1,0,1682230836),(3009,4,21,'独角兽','unicorn',NULL,NULL,0,100,1,0,1682230836),(3010,4,21,'瓦拉克','valak',NULL,NULL,0,100,1,0,1682230836),(3011,4,21,'瓦尔基里','valkyries',NULL,NULL,0,100,1,0,1682230836),(3012,4,21,'吸血鬼','vampire',NULL,NULL,0,100,1,0,1682230836),(3013,4,21,'温迪戈','wendigo',NULL,NULL,0,100,1,0,1682230836),(3014,4,21,'狼人','werewolf',NULL,NULL,0,100,1,0,1682230836),(3015,4,21,'幽灵','wraith',NULL,NULL,0,100,1,0,1682230836),(3016,4,21,'异形体','xenomorph',NULL,NULL,0,100,1,0,1682230836),(3017,4,21,'雪人','yeti',NULL,NULL,0,100,1,0,1682230836),(3018,4,21,'僵尸','zombie',NULL,NULL,0,100,1,0,1682230836),(3019,4,22,'鸟类','birds',NULL,NULL,0,100,1,0,1682230836),(3020,4,22,'非洲灰鹦鹉','african grey parrot',NULL,NULL,0,100,1,0,1682230836),(3021,4,22,'秃鹰','bald eagle',NULL,NULL,0,100,1,0,1682230836),(3022,4,22,'蓝脚鲣鸟','blue footed booby',NULL,NULL,0,100,1,0,1682230836),(3023,4,22,'蓝鸲','bluebird',NULL,NULL,0,100,1,0,1682230836),(3024,4,22,'虎皮鹦鹉','budgie',NULL,NULL,0,100,1,0,1682230836),(3025,4,22,'金丝雀','canary',NULL,NULL,0,100,1,0,1682230836),(3026,4,22,'红衣凤头鸟','cardinal',NULL,NULL,0,100,1,0,1682230836),(3027,4,22,'秃鹰','condor',NULL,NULL,0,100,1,0,1682230836),(3028,4,22,'乌鸦','crows',NULL,NULL,0,100,1,0,1682230836),(3029,4,22,'鸭子','duck',NULL,NULL,0,100,1,0,1682230836),(3030,4,22,'雕','eagles',NULL,NULL,0,100,1,0,1682230836),(3031,4,22,'鸸鹋','emu',NULL,NULL,0,100,1,0,1682230836),(3032,4,22,'猎鹰','falcon',NULL,NULL,0,100,1,0,1682230836),(3033,4,22,'雀类','finches',NULL,NULL,0,100,1,0,1682230836),(3034,4,22,'家禽','fowl',NULL,NULL,0,100,1,0,1682230836),(3035,4,22,'鹅','geese',NULL,NULL,0,100,1,0,1682230836),(3036,4,22,'鹰','hawk',NULL,NULL,0,100,1,0,1682230836),(3037,4,22,'母鸡','hen',NULL,NULL,0,100,1,0,1682230836),(3038,4,22,'苍鹭','heron',NULL,NULL,0,100,1,0,1682230836),(3039,4,22,'蜂鸟','hummingbird',NULL,NULL,0,100,1,0,1682230836),(3040,4,22,'野鸭','mallard',NULL,NULL,0,100,1,0,1682230836),(3041,4,22,'鸵鸟','ostrich',NULL,NULL,0,100,1,0,1682230836),(3042,16,94,'活泼的','vivacious',NULL,NULL,0,100,1,0,1682230836),(3043,16,96,'潮湿的','moist',NULL,NULL,0,100,1,0,1682230836),(3044,4,22,'鹦鹉','parrot',NULL,NULL,0,100,1,0,1682230836),(3045,4,22,'孔雀','peacock',NULL,NULL,0,100,1,0,1682230836),(3046,4,22,'企鹅','penguin',NULL,NULL,0,100,1,0,1682230836),(3047,4,22,'猎斑鸠','pidgeon',NULL,NULL,0,100,1,0,1682230836),(3048,4,22,'鹌鹑','quail',NULL,NULL,0,100,1,0,1682230836),(3049,4,22,'知更鸟','robin',NULL,NULL,0,100,1,0,1682230836),(3050,4,22,'鞋嘴鸟','shoebill bird',NULL,NULL,0,100,1,0,1682230836),(3051,4,22,'鸣禽','songbird',NULL,NULL,0,100,1,0,1682230836),(3052,15,84,'汉斯·阿普','by Hans Arp',NULL,NULL,0,100,1,0,1682230836),(3053,4,22,'巨嘴鸟','toucan',NULL,NULL,0,100,1,0,1682230836),(3054,4,22,'火鸡','turkey',NULL,NULL,0,100,1,0,1682230836),(3055,4,22,'秃鹫','vulture',NULL,NULL,0,100,1,0,1682230836),(3056,4,22,'啄木鸟','woodpecker',NULL,NULL,0,100,1,0,1682230836),(3057,4,23,'臭虫','bugs',NULL,NULL,0,100,1,0,1682230836),(3059,4,23,'蚂蚁','ant',NULL,NULL,0,100,1,0,1682230836),(3060,4,23,'蜜蜂','bee',NULL,NULL,0,100,1,0,1682230836),(3061,4,23,'蜂箱','bee hive',NULL,NULL,0,100,1,0,1682230836),(3062,4,23,'甲虫','beetles',NULL,NULL,0,100,1,0,1682230836),(3063,4,23,'黑寡妇蜘蛛','black widow spider',NULL,NULL,0,100,1,0,1682230836),(3064,4,23,'大黄蜂','bumblebee',NULL,NULL,0,100,1,0,1682230836),(3065,4,23,'蝴蝶','butterfly',NULL,NULL,0,100,1,0,1682230836),(3066,4,23,'毛毛虫','caterpillar',NULL,NULL,0,100,1,0,1682230836),(3067,4,23,'蜈蚣','centepede',NULL,NULL,0,100,1,0,1682230836),(3068,4,23,'蟑螂','cockroach',NULL,NULL,0,100,1,0,1682230836),(3069,4,23,'萤火虫','fireflies',NULL,NULL,0,100,1,0,1682230836),(3071,4,23,'小昆虫','gnat',NULL,NULL,0,100,1,0,1682230836),(3073,15,84,'詹姆斯·格里森','by James Gleeson',NULL,NULL,0,100,1,0,1682230836),(3074,4,23,'大黄蜂','hornet',NULL,NULL,0,100,1,0,1682230836),(3075,4,23,'昆虫','insects',NULL,NULL,0,100,1,0,1682230836),(3076,4,23,'瓢虫','ladybug',NULL,NULL,0,100,1,0,1682230836),(3078,4,23,'千足虫','millipede',NULL,NULL,0,100,1,0,1682230836),(3079,4,23,'蚊 ','mosquito',NULL,NULL,0,100,1,0,1682230836),(3080,4,23,'蛾','moth',NULL,NULL,0,100,1,0,1682230836),(3081,4,23,'蝎子','scorpion',NULL,NULL,0,100,1,0,1682230836),(3082,4,23,'蛞蝓','slug',NULL,NULL,0,100,1,0,1682230836),(3083,4,23,'蜗牛','snail',NULL,NULL,0,100,1,0,1682230836),(3084,4,23,'蜘蛛','spider',NULL,NULL,0,100,1,0,1682230836),(3085,4,23,'狼蛛','tarantula',NULL,NULL,0,100,1,0,1682230836),(3086,4,23,'黄蜂','wasp',NULL,NULL,0,100,1,0,1682230836),(3087,4,23,'多个爬行动物','reptiles',NULL,NULL,0,100,1,0,1682230836),(3088,4,23,'短吻鳄','alligator',NULL,NULL,0,100,1,0,1682230836),(3089,4,23,'两栖动物','amphibian',NULL,NULL,0,100,1,0,1682230836),(3090,4,23,'水蟒','anaconda',NULL,NULL,0,100,1,0,1682230836),(3091,4,23,'黑曼巴蛇','black mamba',NULL,NULL,0,100,1,0,1682230836),(3092,4,23,'蟒蛇','boa constrictor',NULL,NULL,0,100,1,0,1682230836),(3093,15,84,'凯·塞奇','by Kay Sage',NULL,NULL,0,100,1,0,1682230836),(3094,4,23,'凯门鳄','caiman',NULL,NULL,0,100,1,0,1682230836),(3095,4,23,'变色龙','chameleon',NULL,NULL,0,100,1,0,1682230836),(3096,4,23,'眼镜蛇','cobra',NULL,NULL,0,100,1,0,1682230836),(3098,4,23,'鳄鱼','crocodile',NULL,NULL,0,100,1,0,1682230836),(3099,4,23,'青蛙','frog',NULL,NULL,0,100,1,0,1682230836),(3101,4,23,'壁虎','gecko',NULL,NULL,0,100,1,0,1682230836),(3102,4,23,'毒蜥','gila monster',NULL,NULL,0,100,1,0,1682230836),(3103,4,23,'鬣蜥','iguana',NULL,NULL,0,100,1,0,1682230836),(3104,15,84,'李·米勒','by Lee Miller',NULL,NULL,0,100,1,0,1682230836),(3105,4,23,'眼镜王蛇','king cobra',NULL,NULL,0,100,1,0,1682230836),(3106,4,23,'科莫多龙','komodo dragon',NULL,NULL,0,100,1,0,1682230836),(3107,4,23,'蜥蜴','lizard',NULL,NULL,0,100,1,0,1682230836),(3108,4,23,'曼巴','mamba',NULL,NULL,0,100,1,0,1682230836),(3109,4,23,'蝾螈','newt',NULL,NULL,0,100,1,0,1682230836),(3110,4,23,'蟒蛇','python',NULL,NULL,0,100,1,0,1682230836),(3111,4,23,'响尾蛇','rattlesnake',NULL,NULL,0,100,1,0,1682230836),(3112,4,23,'爬行动物','reptile',NULL,NULL,0,100,1,0,1682230836),(3113,4,23,'蝾螈','salamander',NULL,NULL,0,100,1,0,1682230836),(3114,15,84,'利昂娜·伍德','by Leona Wood',NULL,NULL,0,100,1,0,1682230836),(3115,4,23,'响尾蛇','sidewinder',NULL,NULL,0,100,1,0,1682230836),(3116,4,23,'蜥蜴','skink',NULL,NULL,0,100,1,0,1682230836),(3117,4,23,'蛇','snake',NULL,NULL,0,100,1,0,1682230836),(3118,4,23,'很多蛇','lot of snakes',NULL,NULL,0,100,1,0,1682230836),(3119,4,23,'蟾蜍','toad',NULL,NULL,0,100,1,0,1682230836),(3120,4,23,'毒蛇','viper',NULL,NULL,0,100,1,0,1682230836),(3121,109,24,'豆子','beans',NULL,NULL,0,100,1,0,1682230836),(3122,109,24,'面包','bread',NULL,NULL,0,100,1,0,1682230836),(3123,109,24,'黄油','butter',NULL,NULL,0,100,1,0,1682230836),(3124,109,24,'饼','cake',NULL,NULL,0,100,1,0,1682230836),(3125,109,24,'蛋糕装饰','cake decorating',NULL,NULL,0,100,1,0,1682230836),(3126,109,24,'糖果','candy',NULL,NULL,0,100,1,0,1682230836),(3127,109,24,'奶油煎饼卷','cannoli',NULL,NULL,0,100,1,0,1682230836),(3128,109,24,'焦糖','caramel',NULL,NULL,0,100,1,0,1682230836),(3129,109,24,'乳酪','cheese',NULL,NULL,0,100,1,0,1682230836),(3130,109,24,'巧克力','chocolate',NULL,NULL,0,100,1,0,1682230836),(3131,109,24,'油条','churros',NULL,NULL,0,100,1,0,1682230836),(3132,109,24,'肉桂','cinnamon',NULL,NULL,0,100,1,0,1682230836),(3133,15,84,'路易斯·布努尔','by Luis Buñuel',NULL,NULL,0,100,1,0,1682230836),(3134,109,24,'咖啡','coffee',NULL,NULL,0,100,1,0,1682230836),(3135,109,24,'奶油','cream',NULL,NULL,0,100,1,0,1682230836),(3136,109,24,'油炸的','deep fried',NULL,NULL,0,100,1,0,1682230836),(3137,109,24,'奶油松饼\n\n','eclair',NULL,NULL,0,100,1,0,1682230836),(3138,109,24,'食用墨水','edible ink',NULL,NULL,0,100,1,0,1682230836),(3139,109,24,'卵','egg',NULL,NULL,0,100,1,0,1682230836),(3140,109,24,'蛋黄','egg yolk',NULL,NULL,0,100,1,0,1682230836),(3141,109,24,'食用色素','food coloring',NULL,NULL,0,100,1,0,1682230836),(3142,109,24,'水果','fruit',NULL,NULL,0,100,1,0,1682230836),(3143,109,24,'明胶','gelatin',NULL,NULL,0,100,1,0,1682230836),(3144,16,94,'生动的','vivid',NULL,NULL,0,100,1,0,1682230836),(3145,109,24,'树胶','gum',NULL,NULL,0,100,1,0,1682230836),(3146,109,24,'蜂巢','honeycomb',NULL,NULL,0,100,1,0,1682230836),(3147,109,24,'冰淇淋','ice cream',NULL,NULL,0,100,1,0,1682230836),(3148,109,24,'胶冻','jelly',NULL,NULL,0,100,1,0,1682230836),(3149,109,24,'番茄酱','ketchup',NULL,NULL,0,100,1,0,1682230836),(3150,109,24,'棒棒糖','lollipop',NULL,NULL,0,100,1,0,1682230836),(3151,109,24,'通心粉','macaroni',NULL,NULL,0,100,1,0,1682230836),(3152,109,24,'枫糖浆','maple syrup',NULL,NULL,0,100,1,0,1682230836),(3153,109,24,'马科尼干酪','marconi and cheese',NULL,NULL,0,100,1,0,1682230836),(3154,109,24,'人造黄油','margarine',NULL,NULL,0,100,1,0,1682230836),(3155,109,24,'蛋黄酱','mayonnaise',NULL,NULL,0,100,1,0,1682230836),(3156,109,24,'芥末','mustard',NULL,NULL,0,100,1,0,1682230836),(3157,109,24,'橄榄油','olive oil',NULL,NULL,0,100,1,0,1682230836),(3158,109,24,'意大利酱料','pasta sauce',NULL,NULL,0,100,1,0,1682230836),(3159,109,24,'椒盐卷饼','pretzel',NULL,NULL,0,100,1,0,1682230836),(3160,109,24,'酱料','sauce',NULL,NULL,0,100,1,0,1682230836),(3161,109,24,'苏打','soda',NULL,NULL,0,100,1,0,1682230836),(3162,109,24,'酸奶油','sour cream',NULL,NULL,0,100,1,0,1682230836),(3163,109,24,'糖浆','syrup',NULL,NULL,0,100,1,0,1682230836),(3164,109,24,'太妃糖','taffy',NULL,NULL,0,100,1,0,1682230836),(3165,15,84,'马塞尔·扬科','by Marcel Janco',NULL,NULL,0,100,1,0,1682230836),(3166,109,24,'茶','tea',NULL,NULL,0,100,1,0,1682230836),(3167,109,24,'植物油','vegetable oil',NULL,NULL,0,100,1,0,1682230836),(3168,109,24,'结婚蛋糕','wedding cake',NULL,NULL,0,100,1,0,1682230836),(3169,109,24,'鲜奶油 ','whipped cream',NULL,NULL,0,100,1,0,1682230836),(3170,5,26,'深粉色','dark-pink',NULL,NULL,0,100,1,0,1682230836),(3171,5,26,'深橙色','dark-orange',NULL,NULL,0,100,1,0,1682230836),(3172,5,26,'深红色','dark-red',NULL,NULL,0,100,1,0,1682230836),(3173,5,26,'深黄色','dark-yellow',NULL,NULL,0,100,1,0,1682230836),(3174,5,26,'深蓝色','dark-blue',NULL,NULL,0,100,1,0,1682230836),(3175,5,26,'深绿色','dark-green',NULL,NULL,0,100,1,0,1682230836),(3176,5,26,'深青色','dark-cyan',NULL,NULL,0,100,1,0,1682230836),(3177,5,26,'深石灰绿色','dark-lime',NULL,NULL,0,100,1,0,1682230836),(3178,5,26,'深洋红色','dark-magenta',NULL,NULL,0,100,1,0,1682230836),(3179,5,26,'深紫色','dark-purple',NULL,NULL,0,100,1,0,1682230836),(3180,5,26,'褐色','tan',NULL,NULL,0,100,1,0,1682230836),(3181,5,26,'紫红色','fuchsia',NULL,NULL,0,100,1,0,1682230836),(3182,15,84,'梅瑞特·奥本海姆','by Meret Oppenheim',NULL,NULL,0,100,1,0,1682230836),(3183,5,26,'浅橙色','light-orange',NULL,NULL,0,100,1,0,1682230836),(3184,5,26,'浅粉色','light-pink',NULL,NULL,0,100,1,0,1682230836),(3185,5,26,'浅黑色','light-black',NULL,NULL,0,100,1,0,1682230836),(3186,5,26,'浅红色','light-red',NULL,NULL,0,100,1,0,1682230836),(3187,5,26,'浅黄色','light-yellow',NULL,NULL,0,100,1,0,1682230836),(3188,5,26,'浅灰色','light-gray',NULL,NULL,0,100,1,0,1682230836),(3189,5,26,'深白色','dark-white',NULL,NULL,0,100,1,0,1682230836),(3190,5,26,'浅蓝色','light-blue',NULL,NULL,0,100,1,0,1682230836),(3191,5,26,'浅栗色','light-maroon',NULL,NULL,0,100,1,0,1682230836),(3192,5,26,'浅石灰绿色','light-lime',NULL,NULL,0,100,1,0,1682230836),(3193,5,26,'浅绿色','light-green',NULL,NULL,0,100,1,0,1682230836),(3194,5,26,'浅青色','light-cyan',NULL,NULL,0,100,1,0,1682230836),(3195,5,26,'浅洋红色','light-magenta',NULL,NULL,0,100,1,0,1682230836),(3196,5,26,'浅紫色','light-purple',NULL,NULL,0,100,1,0,1682230836),(3197,5,26,'浅棕色','light-brown',NULL,NULL,0,100,1,0,1682230836),(3198,15,84,'帕维尔·切利切夫','by Pavel Tchelitchew',NULL,NULL,0,100,1,0,1682230836),(3199,5,26,'深灰色','dark-gray',NULL,NULL,0,100,1,0,1682230836),(3200,5,26,'深栗色','dark-maroon',NULL,NULL,0,100,1,0,1682230836),(3201,5,26,'深棕色','dark-brown',NULL,NULL,0,100,1,0,1682230836),(3202,5,26,'青色','aqua',NULL,NULL,0,100,1,0,1682230836),(3203,5,26,'鲜橙色','vivid-orange',NULL,NULL,0,100,1,0,1682230836),(3204,5,26,'鲜粉色','vivid-pink',NULL,NULL,0,100,1,0,1682230836),(3205,5,26,'鲜红色','vivid-red',NULL,NULL,0,100,1,0,1682230836),(3206,5,26,'鲜黄色','vivid-yellow',NULL,NULL,0,100,1,0,1682230836),(3207,5,26,'鲜蓝色','vivid-blue',NULL,NULL,0,100,1,0,1682230836),(3208,5,26,'鲜栗色','vivid-maroon',NULL,NULL,0,100,1,0,1682230836),(3209,15,84,'皮埃尔·罗伊','by Pierre Roy',NULL,NULL,0,100,1,0,1682230836),(3210,5,26,'鲜绿色','vivid-green',NULL,NULL,0,100,1,0,1682230836),(3211,5,26,'鲜洋红色','vivid-magenta',NULL,NULL,0,100,1,0,1682230836),(3212,5,26,'鲜青色','vivid-cyan',NULL,NULL,0,100,1,0,1682230836),(3213,5,26,'鲜石灰绿色','vivid-lime',NULL,NULL,0,100,1,0,1682230836),(3214,5,26,'鲜紫色','vivid-purple',NULL,NULL,0,100,1,0,1682230836),(3215,15,84,'拉尔','by Ralle',NULL,NULL,0,100,1,0,1682230836),(3216,16,95,'安抚的','calming',NULL,NULL,0,100,1,0,1682230836),(3217,5,26,'栗色','maroon',NULL,NULL,0,100,1,0,1682230836),(3218,5,26,'鸭翠绿色','teal',NULL,NULL,0,100,1,0,1682230836),(3219,5,26,'银色','silver',NULL,NULL,0,100,1,0,1682230836),(3220,5,28,'七十年代配色','70s color combo',NULL,NULL,0,100,1,0,1682230836),(3221,5,28,'无色','achromatic',NULL,NULL,0,100,1,0,1682230836),(3222,5,28,'色调','agfacolor',NULL,NULL,0,100,1,0,1682230836),(3223,5,28,'类似调色板','analogous palette',NULL,NULL,0,100,1,0,1682230836),(3224,5,28,'类似色彩','analogous-colors',NULL,NULL,0,100,1,0,1682230836),(3225,5,28,'自动染色','autochrome',NULL,NULL,0,100,1,0,1682230836),(3226,5,28,'黑白','black and white',NULL,NULL,0,100,1,0,1682230836),(3227,5,28,'大胆现代色彩','bold modern colors',NULL,NULL,0,100,1,0,1682230836),(3228,5,28,'鲜明色彩','bright colors',NULL,NULL,0,100,1,0,1682230836),(3229,5,28,'鲜明霓虹色彩','bright neon colors',NULL,NULL,0,100,1,0,1682230836),(3230,5,28,'绿色感','chloropsia',NULL,NULL,0,100,1,0,1682230836),(3231,5,28,'色度','chroma',NULL,NULL,0,100,1,0,1682230836),(3232,5,28,'色觉失调','chromatopsia',NULL,NULL,0,100,1,0,1682230836),(3233,15,84,'西德尼·诺兰','by Sidney Nolan',NULL,NULL,0,100,1,0,1682230836),(3234,5,28,'清新调色板','clean color palette',NULL,NULL,0,100,1,0,1682230836),(3235,5,28,'颜色','color',NULL,NULL,0,100,1,0,1682230836),(3236,5,28,'色彩混合','color blend',NULL,NULL,0,100,1,0,1682230836),(3237,5,28,'调色板','color palette',NULL,NULL,0,100,1,0,1682230836),(3238,5,28,'色轮','color wheel',NULL,NULL,0,100,1,0,1682230836),(3239,5,28,'彩色化','colorized',NULL,NULL,0,100,1,0,1682230836),(3240,5,28,'互补调色板','complementary palette',NULL,NULL,0,100,1,0,1682230836),(3241,5,28,'互补颜色','complimentary-colors',NULL,NULL,0,100,1,0,1682230836),(3242,5,28,'凉爽调色板','cool color palette',NULL,NULL,0,100,1,0,1682230836),(3243,15,84,'斯文·达尔斯加德','by Sven Dalsgaard',NULL,NULL,0,100,1,0,1682230836),(3244,5,28,'蓝色感','cyanopsia',NULL,NULL,0,100,1,0,1682230836),(3245,5,28,'暗黑美感','dark aesthetic',NULL,NULL,0,100,1,0,1682230836),(3246,5,28,'深色彩','dark colors',NULL,NULL,0,100,1,0,1682230836),(3247,5,28,'暗模式','dark mode',NULL,NULL,0,100,1,0,1682230836),(3248,5,28,'变暗','darkened',NULL,NULL,0,100,1,0,1682230836),(3249,5,28,'褪色的','desaturated',NULL,NULL,0,100,1,0,1682230836),(3250,5,28,'双色觉','dichromatism',NULL,NULL,0,100,1,0,1682230836),(3251,5,28,'肮脏的颜色','dingy colors',NULL,NULL,0,100,1,0,1682230836),(3252,5,28,'不和谐色彩方案','discordance colour scheme',NULL,NULL,0,100,1,0,1682230836),(3253,5,28,'双互补调色板','double split complementary palette',NULL,NULL,0,100,1,0,1682230836),(3254,5,28,'双色彩','double colors',NULL,NULL,0,100,1,0,1682230836),(3255,5,28,'双色','dual colors',NULL,NULL,0,100,1,0,1682230836),(3256,5,28,'双色渐变','duotone gradients',NULL,NULL,0,100,1,0,1682230836),(3257,5,28,'色觉障碍','dyschromatopsia',NULL,NULL,0,100,1,0,1682230836),(3258,5,28,'土色调','earth tones',NULL,NULL,0,100,1,0,1682230836),(3259,5,28,'电光色彩','electric colors',NULL,NULL,0,100,1,0,1682230836),(3260,5,28,'彩光','enchroma',NULL,NULL,0,100,1,0,1682230836),(3261,5,28,'红色感','erythropsia',NULL,NULL,0,100,1,0,1682230836),(3262,5,28,'令人兴奋的颜色','exciting colors',NULL,NULL,0,100,1,0,1682230836),(3263,15,84,'兹迪斯瓦夫·贝克辛斯基','by Zdzisław Beksiński',NULL,NULL,0,100,1,0,1682230836),(3264,5,28,'褪色的','faded',NULL,NULL,0,100,1,0,1682230836),(3265,5,28,'褪色的颜色','faded colors',NULL,NULL,0,100,1,0,1682230836),(3266,5,28,'假彩色','false-color',NULL,NULL,0,100,1,0,1682230836),(3267,5,28,'平面色彩','flat color',NULL,NULL,0,100,1,0,1682230836),(3268,5,28,'阴暗的颜色','gloomy colors',NULL,NULL,0,100,1,0,1682230836),(3269,5,28,'哥特色彩方案','gothic color scheme',NULL,NULL,0,100,1,0,1682230836),(3270,5,28,'渐变','gradient',NULL,NULL,0,100,1,0,1682230836),(3271,5,28,'快乐色彩','happy colors',NULL,NULL,0,100,1,0,1682230836),(3272,5,28,'六色彩','hextuple colors',NULL,NULL,0,100,1,0,1682230836),(3273,15,84,'陈轴','by Chen Zhou',NULL,NULL,0,100,1,0,1682230836),(3274,5,28,'色调','hue',NULL,NULL,0,100,1,0,1682230836),(3275,5,28,'过色觉','hyperchromatopsia',NULL,NULL,0,100,1,0,1682230836),(3276,5,28,'无限多色彩','infinituple colors',NULL,NULL,0,100,1,0,1682230836),(3277,5,28,'反色','inverted colors',NULL,NULL,0,100,1,0,1682230836),(3278,5,28,'动态色彩','kinemacolor',NULL,NULL,0,100,1,0,1682230836),(3279,5,28,'科达克隆','kodachrome',NULL,NULL,0,100,1,0,1682230836),(3280,5,28,'浅蓝背景','light blue background',NULL,NULL,0,100,1,0,1682230836),(3281,5,28,'浅蓝前景','light blue foreground',NULL,NULL,0,100,1,0,1682230836),(3282,5,28,'浅色彩','light colors',NULL,NULL,0,100,1,0,1682230836),(3283,15,84,'冯琼','by Harping Feng',NULL,NULL,0,100,1,0,1682230836),(3284,5,28,'明亮模式','light mode',NULL,NULL,0,100,1,0,1682230836),(3285,5,28,'低饱和度','low saturation',NULL,NULL,0,100,1,0,1682230836),(3286,5,28,'金属色彩','metallic colors',NULL,NULL,0,100,1,0,1682230836),(3287,5,28,'现代调色板','modern color palettes',NULL,NULL,0,100,1,0,1682230836),(3288,5,28,'单色','monochromatic',NULL,NULL,0,100,1,0,1682230836),(3289,5,28,'单色调色板','monochromatic palettes',NULL,NULL,0,100,1,0,1682230836),(3290,5,28,'单色','monochrome',NULL,NULL,0,100,1,0,1682230836),(3291,5,28,'情绪色彩方案','moody color scheme',NULL,NULL,0,100,1,0,1682230836),(3292,5,28,'多彩','multicolored',NULL,NULL,0,100,1,0,1682230836),(3293,5,28,'柔和色调','muted tones',NULL,NULL,0,100,1,0,1682230836),(3294,5,28,'自然色调','natural tones',NULL,NULL,0,100,1,0,1682230836),(3295,5,28,'霓虹色彩','neon color',NULL,NULL,0,100,1,0,1682230836),(3296,5,28,'霓虹粉彩色','neon pastel colors',NULL,NULL,0,100,1,0,1682230836),(3297,5,28,'八色彩','octuple colors',NULL,NULL,0,100,1,0,1682230836),(3298,5,28,'调色板','palette',NULL,NULL,0,100,1,0,1682230836),(3299,5,28,'淡彩色','pastels',NULL,NULL,0,100,1,0,1682230836),(3300,5,28,'颜料','pigment',NULL,NULL,0,100,1,0,1682230836),(3301,15,84,'李智英','by Jee Young Lee',NULL,NULL,0,100,1,0,1682230836),(3302,5,28,'多色调色板','polychromatic palette',NULL,NULL,0,100,1,0,1682230836),(3303,5,28,'多色彩','polychromatic-colors',NULL,NULL,0,100,1,0,1682230836),(3304,5,28,'纯色','pure',NULL,NULL,0,100,1,0,1682230836),(3305,5,28,'纯度','purity',NULL,NULL,0,100,1,0,1682230836),(3306,5,28,'四色彩','quadruple colors',NULL,NULL,0,100,1,0,1682230836),(3307,5,28,'五色彩','quintuple colors',NULL,NULL,0,100,1,0,1682230836),(3308,5,28,'复古调色板','retro palette',NULL,NULL,0,100,1,0,1682230836),(3309,15,84,'朱莉·柯蒂斯','by Julie Curtiss',NULL,NULL,0,100,1,0,1682230836),(3310,5,28,'七色彩','septuple colors',NULL,NULL,0,100,1,0,1682230836),(3311,5,28,'单一颜色','single color',NULL,NULL,0,100,1,0,1682230836),(3312,5,28,'光谱色彩','spectral color',NULL,NULL,0,100,1,0,1682230836),(3313,5,28,'光谱','spectrum',NULL,NULL,0,100,1,0,1682230836),(3314,5,28,'分裂互补调色板','split complementary palette',NULL,NULL,0,100,1,0,1682230836),(3315,5,28,'分裂互补色','split-complementary-colors',NULL,NULL,0,100,1,0,1682230836),(3316,5,28,'补充色','supplementary-colors',NULL,NULL,0,100,1,0,1682230836),(3317,5,28,'四色视觉','tetrachromacy',NULL,NULL,0,100,1,0,1682230836),(3318,5,28,'四色调色板','tetradic palette',NULL,NULL,0,100,1,0,1682230836),(3319,15,84,'玛丽·瑞德·凯利','by Mary Reid Kelley',NULL,NULL,0,100,1,0,1682230836),(3320,5,28,'四色调色','tetradic-colors',NULL,NULL,0,100,1,0,1682230836),(3321,5,28,'色调颜色','tonal colors',NULL,NULL,0,100,1,0,1682230836),(3322,5,28,'色调','tone',NULL,NULL,0,100,1,0,1682230836),(3323,5,28,'黑色色调','tones of black',NULL,NULL,0,100,1,0,1682230836),(3324,5,28,'背景中的黑色色调','tones of black in background',NULL,NULL,0,100,1,0,1682230836),(3325,5,28,'三色调色板','triadic palette',NULL,NULL,0,100,1,0,1682230836),(3326,5,28,'三色调色','triadic-colors',NULL,NULL,0,100,1,0,1682230836),(3327,5,28,'三重颜色','triple colors',NULL,NULL,0,100,1,0,1682230836),(3328,5,28,'真彩色艺术','true color art',NULL,NULL,0,100,1,0,1682230836),(3329,5,28,'价值','value',NULL,NULL,0,100,1,0,1682230836),(3330,15,84,'迈克尔·文森特·马洛','by Michael Vincent Malo',NULL,NULL,0,100,1,0,1682230836),(3331,5,28,'杂色的','variegated',NULL,NULL,0,100,1,0,1682230836),(3332,5,28,'鲜艳度','vibrance',NULL,NULL,0,100,1,0,1682230836),(3333,5,28,'鲜艳的颜色','vibrant colors',NULL,NULL,0,100,1,0,1682230836),(3334,5,28,'暖色调色板','warm color palette',NULL,NULL,0,100,1,0,1682230836),(3335,5,26,'深黑色','darkblack',NULL,NULL,0,100,1,0,1682230836),(3336,5,26,'黑色','black',NULL,NULL,0,100,1,0,1682230836),(3337,5,26,'深灰色','darkgray',NULL,NULL,0,100,1,0,1682230836),(3338,15,84,'明颖','by Ming Ying',NULL,NULL,0,100,1,0,1682230836),(3339,5,26,'灰色','gray',NULL,NULL,0,100,1,0,1682230836),(3340,5,26,'深青灰色','darkslategray',NULL,NULL,0,100,1,0,1682230836),(3341,5,26,'深白色','dark_white',NULL,NULL,0,100,1,0,1682230836),(3342,5,26,'银灰色','silvergray',NULL,NULL,0,100,1,0,1682230836),(3343,5,26,'浅银灰色','light_silvergray',NULL,NULL,0,100,1,0,1682230836),(3344,5,26,'深银灰色','dark_silvergray',NULL,NULL,0,100,1,0,1682230836),(3345,5,26,'暗灰色','dimgray',NULL,NULL,0,100,1,0,1682230836),(3346,15,84,'南达','by Nam Das',NULL,NULL,0,100,1,0,1682230836),(3347,5,26,'青灰色','slategray',NULL,NULL,0,100,1,0,1682230836),(3348,5,26,'浅青灰色','lightslategray',NULL,NULL,0,100,1,0,1682230836),(3349,5,26,'中灰色','mediumgray',NULL,NULL,0,100,1,0,1682230836),(3350,5,26,'浅白色','light_white',NULL,NULL,0,100,1,0,1682230836),(3351,5,26,'白烟色','whitesmoke',NULL,NULL,0,100,1,0,1682230836),(3352,5,26,'亮灰色','gainsboro',NULL,NULL,0,100,1,0,1682230836),(3353,5,26,'中白色','mediumwhite',NULL,NULL,0,100,1,0,1682230836),(3354,5,26,'白色','white',NULL,NULL,0,100,1,0,1682230836),(3355,5,26,'卡其褐色','khakibrown',NULL,NULL,0,100,1,0,1682230836),(3356,15,84,'纳撒尼尔·玛丽·奎恩','by Nathaniel Mary Quinn',NULL,NULL,0,100,1,0,1682230836),(3357,5,26,'褐色','tan',NULL,NULL,0,100,1,0,1682230836),(3358,5,26,'浅褐色','light_tan',NULL,NULL,0,100,1,0,1682230836),(3359,5,26,'中米色','mediumbeige',NULL,NULL,0,100,1,0,1682230836),(3360,5,26,'浅米色','light_beige',NULL,NULL,0,100,1,0,1682230836),(3361,5,26,'深棕色','dark_brown',NULL,NULL,0,100,1,0,1682230836),(3362,5,26,'深褐色','dark_tan',NULL,NULL,0,100,1,0,1682230836),(3363,15,84,'内尔斯里古尔·塞贝索伊','by Nelsligul Cebesoy',NULL,NULL,0,100,1,0,1682230836),(3364,5,26,'鲜褐色','vivid_brown',NULL,NULL,0,100,1,0,1682230836),(3365,5,26,'深栗色','dark_maroon',NULL,NULL,0,100,1,0,1682230836),(3366,5,26,'鲜栗色','vivid_maroon',NULL,NULL,0,100,1,0,1682230836),(3367,5,26,'栗色','maroon',NULL,NULL,0,100,1,0,1682230836),(3368,5,26,'浅栗色','light_maroon',NULL,NULL,0,100,1,0,1682230836),(3369,5,26,'玫瑰褐色','rosybrown',NULL,NULL,0,100,1,0,1682230836),(3370,5,26,'深红色','dark_red',NULL,NULL,0,100,1,0,1682230836),(3371,5,26,'中红色','mediumred',NULL,NULL,0,100,1,0,1682230836),(3372,5,26,'红色','red',NULL,NULL,0,100,1,0,1682230836),(3373,15,84,'塞布·贾尼亚克','by Seb Janiak',NULL,NULL,0,100,1,0,1682230836),(3374,5,26,'鲜红色','vivid_red',NULL,NULL,0,100,1,0,1682230836),(3375,5,26,'深红橙色','dark_redorange',NULL,NULL,0,100,1,0,1682230836),(3376,5,26,'绯红色','crimson',NULL,NULL,0,100,1,0,1682230836),(3377,5,26,'橙红色','orangered',NULL,NULL,0,100,1,0,1682230836),(3378,5,26,'深橙色','darkorange',NULL,NULL,0,100,1,0,1682230836),(3379,15,84,'熊源','by Yuanyu Xiong',NULL,NULL,0,100,1,0,1682230836),(3380,5,26,'中橙色','mediumorange',NULL,NULL,0,100,1,0,1682230836),(3381,5,26,'鲜橙色','vivid_orange',NULL,NULL,0,100,1,0,1682230836),(3382,5,26,'橙色','orange',NULL,NULL,0,100,1,0,1682230836),(3383,5,26,'黄橙色','yelloworange',NULL,NULL,0,100,1,0,1682230836),(3384,5,26,'深金黄色','darkgoldenrod',NULL,NULL,0,100,1,0,1682230836),(3385,5,26,'苍金黄色','palegoldenrod',NULL,NULL,0,100,1,0,1682230836),(3386,5,26,'金黄色','goldenrod',NULL,NULL,0,100,1,0,1682230836),(3387,5,26,'浅金黄色','lightgoldenrodyellow',NULL,NULL,0,100,1,0,1682230836),(3388,5,26,'深黄色','dark_yellow',NULL,NULL,0,100,1,0,1682230836),(3389,5,26,'金色','gold',NULL,NULL,0,100,1,0,1682230836),(3390,5,26,'鲜黄色','vivid_yellow',NULL,NULL,0,100,1,0,1682230836),(3391,5,26,'浅春绿色','light_springgreen',NULL,NULL,0,100,1,0,1682230836),(3392,5,26,'中春绿黄色','mediumgreenyellow',NULL,NULL,0,100,1,0,1682230836),(3393,5,26,'浅黄绿色','light_yellowgreen',NULL,NULL,0,100,1,0,1682230836),(3394,15,85,'玉米面包','by Cornbread',NULL,NULL,0,100,1,0,1682230836),(3395,16,95,'舒适的','cozy',NULL,NULL,0,100,1,0,1682230836),(3396,5,26,'深绿黄色','dark_greenyellow',NULL,NULL,0,100,1,0,1682230836),(3397,5,26,'深黄绿色','dark_yellowgreen',NULL,NULL,0,100,1,0,1682230836),(3398,5,26,'中黄绿色','mediumyellowgreen',NULL,NULL,0,100,1,0,1682230836),(3399,5,26,'黄绿色','chartreusegreen',NULL,NULL,0,100,1,0,1682230836),(3400,5,26,'绿黄色','greenyellow',NULL,NULL,0,100,1,0,1682230836),(3401,5,26,'黄绿色','yellowgreen',NULL,NULL,0,100,1,0,1682230836),(3402,5,26,'深绿色','dark_lime',NULL,NULL,0,100,1,0,1682230836),(3403,5,26,'石灰色','lime',NULL,NULL,0,100,1,0,1682230836),(3404,5,26,'鲜艳的石灰色','vivid_lime',NULL,NULL,0,100,1,0,1682230836),(3405,15,166,'艾塔姆·克鲁','by Etam Cru',NULL,NULL,0,100,1,0,1682230836),(3406,5,26,'酸橙绿','limegreen',NULL,NULL,0,100,1,0,1682230836),(3407,5,26,'深橄榄绿','dark_olivegreen',NULL,NULL,0,100,1,0,1682230836),(3408,5,26,'橄榄绿','olivegreen',NULL,NULL,0,100,1,0,1682230836),(3409,5,26,'浅橄榄绿','light_olivegreen',NULL,NULL,0,100,1,0,1682230836),(3410,5,26,'深草坪绿','dark_lawngreen',NULL,NULL,0,100,1,0,1682230836),(3411,5,26,'鲜艳的绿色','vivid_green',NULL,NULL,0,100,1,0,1682230836),(3412,5,26,'草坪绿','lawngreen',NULL,NULL,0,100,1,0,1682230836),(3413,15,166,'盖亚','by Gaia',NULL,NULL,0,100,1,0,1682230836),(3414,5,26,'苍白的绿色','palegreen',NULL,NULL,0,100,1,0,1682230836),(3415,5,26,'浅森林绿','light_forestgreen',NULL,NULL,0,100,1,0,1682230836),(3416,5,26,'深橄榄绿色','darkolivegreen',NULL,NULL,0,100,1,0,1682230836),(3417,5,26,'春绿色','springgreen',NULL,NULL,0,100,1,0,1682230836),(3418,5,26,'中等春绿色','mediumspringgreen',NULL,NULL,0,100,1,0,1682230836),(3419,5,26,'深绿色','dark_green',NULL,NULL,0,100,1,0,1682230836),(3420,5,26,'深绿色','darkgreen',NULL,NULL,0,100,1,0,1682230836),(3421,15,166,'永不团队','by Nevercrew',NULL,NULL,0,100,1,0,1682230836),(3422,5,26,'森林绿色','forestgreen',NULL,NULL,0,100,1,0,1682230836),(3423,5,26,'深海绿色','darkseagreen',NULL,NULL,0,100,1,0,1682230836),(3424,5,26,'中等海绿色','mediumseagreen',NULL,NULL,0,100,1,0,1682230836),(3425,5,26,'海绿色','seagreen',NULL,NULL,0,100,1,0,1682230836),(3426,5,26,'深春绿色','dark_springgreen',NULL,NULL,0,100,1,0,1682230836),(3427,5,26,'蓝绿色','bluegreen',NULL,NULL,0,100,1,0,1682230836),(3428,5,26,'绿蓝色','greenblue',NULL,NULL,0,100,1,0,1682230836),(3429,5,26,'中等青色','mediumteal',NULL,NULL,0,100,1,0,1682230836),(3430,5,26,'深青色','darkturquoise',NULL,NULL,0,100,1,0,1682230836),(3431,15,166,'奥斯·杰梅奥斯','by Os Gemeos',NULL,NULL,0,100,1,0,1682230836),(3432,5,26,'中等青绿色','mediumturquoise',NULL,NULL,0,100,1,0,1682230836),(3433,5,26,'淡青绿色','paleturquoise',NULL,NULL,0,100,1,0,1682230836),(3434,5,26,'浅海绿色','lightseagreen',NULL,NULL,0,100,1,0,1682230836),(3435,5,26,'深青色','darkteal',NULL,NULL,0,100,1,0,1682230836),(3436,5,26,'青色','teal',NULL,NULL,0,100,1,0,1682230836),(3437,5,26,'浅青色','lightteal',NULL,NULL,0,100,1,0,1682230836),(3438,5,26,'浅水绿色','light_aqua',NULL,NULL,0,100,1,0,1682230836),(3439,15,166,'奥斯·杰梅奥斯','by OsGemeos',NULL,NULL,0,100,1,0,1682230836),(3440,5,26,'深青绿色','darkcyan',NULL,NULL,0,100,1,0,1682230836),(3441,5,26,'青绿色','cyan',NULL,NULL,0,100,1,0,1682230836),(3442,5,26,'浅青绿色','lightcyan',NULL,NULL,0,100,1,0,1682230836),(3443,5,26,'鲜艳的青绿色','vivid_cyan',NULL,NULL,0,100,1,0,1682230836),(3444,5,26,'水绿色','aqua',NULL,NULL,0,100,1,0,1682230836),(3445,5,26,'中等碧绿色','mediumaquamarine',NULL,NULL,0,100,1,0,1682230836),(3446,5,26,'天蓝色','azure',NULL,NULL,0,100,1,0,1682230836),(3447,5,26,'粉蓝色','powderblue',NULL,NULL,0,100,1,0,1682230836),(3448,15,166,'特雷西·168','by Tracy 168',NULL,NULL,0,100,1,0,1682230836),(3449,5,26,'浅靛蓝色','light_indigo',NULL,NULL,0,100,1,0,1682230836),(3450,5,26,'深天蓝色','deepskyblue',NULL,NULL,0,100,1,0,1682230836),(3451,5,26,'浅天蓝色','light_azure',NULL,NULL,0,100,1,0,1682230836),(3452,5,26,'天蓝色','skyblue',NULL,NULL,0,100,1,0,1682230836),(3453,5,26,'钢蓝色','steelblue',NULL,NULL,0,100,1,0,1682230836),(3454,5,26,'浅钢蓝色','lightsteelblue',NULL,NULL,0,100,1,0,1682230836),(3455,5,26,'深靛蓝色','dark_indigo',NULL,NULL,0,100,1,0,1682230836),(3456,5,26,'深蓝色','darkblue',NULL,NULL,0,100,1,0,1682230836),(3457,15,85,'黛西','by Daze',NULL,NULL,0,100,1,0,1682230836),(3458,5,26,'中等板岩蓝色','mediumslateblue',NULL,NULL,0,100,1,0,1682230836),(3459,5,26,'鲜艳的蓝色','vivid_blue',NULL,NULL,0,100,1,0,1682230836),(3460,5,26,'午夜蓝色','midnightblue',NULL,NULL,0,100,1,0,1682230836),(3461,5,26,'中等蓝色','mediumblue',NULL,NULL,0,100,1,0,1682230836),(3462,5,26,'蓝色','blue',NULL,NULL,0,100,1,0,1682230836),(3463,5,26,'皇家蓝色','royalblue',NULL,NULL,0,100,1,0,1682230836),(3464,5,26,'矢车菊蓝色','cornflowerblue',NULL,NULL,0,100,1,0,1682230836),(3465,5,26,'板岩蓝色','slateblue',NULL,NULL,0,100,1,0,1682230836),(3466,5,26,'海军蓝色','navyblue',NULL,NULL,0,100,1,0,1682230836),(3467,5,26,'蓝紫色','blueviolet',NULL,NULL,0,100,1,0,1682230836),(3468,5,26,'蓝紫色','bluepurple',NULL,NULL,0,100,1,0,1682230836),(3469,5,26,'紫蓝色','purpleblue',NULL,NULL,0,100,1,0,1682230836),(3470,5,26,'深紫色','dark_purple',NULL,NULL,0,100,1,0,1682230836),(3471,5,26,'深紫罗兰色','darkviolet',NULL,NULL,0,100,1,0,1682230836),(3472,5,26,'紫色','violet',NULL,NULL,0,100,1,0,1682230836),(3473,5,26,'深兰花紫色','darkorchid',NULL,NULL,0,100,1,0,1682230836),(3474,5,26,'丽贝卡紫色','rebeccapurple',NULL,NULL,0,100,1,0,1682230836),(3475,15,85,'东迪·怀特','by Dondi White',NULL,NULL,0,100,1,0,1682230836),(3476,5,26,'淡紫红色','lavenderblush',NULL,NULL,0,100,1,0,1682230836),(3477,5,26,'紫色','purple',NULL,NULL,0,100,1,0,1682230836),(3478,5,26,'鲜艳的紫色','vivid_purple',NULL,NULL,0,100,1,0,1682230836),(3479,5,26,'中等紫色','mediumpurple',NULL,NULL,0,100,1,0,1682230836),(3480,5,26,'中等紫红色','mediumfuchsia',NULL,NULL,0,100,1,0,1682230836),(3481,5,26,'浅紫红色','light_fuchsia',NULL,NULL,0,100,1,0,1682230836),(3482,5,26,'中等紫红色','mediumvioletred',NULL,NULL,0,100,1,0,1682230836),(3483,5,26,'淡紫红色','palevioletred',NULL,NULL,0,100,1,0,1682230836),(3484,5,26,'深洋红色','dark_magenta',NULL,NULL,0,100,1,0,1682230836),(3485,15,85,'伊蒂','by Inti',NULL,NULL,0,100,1,0,1682230836),(3486,5,26,'深洋红色','darkmagenta',NULL,NULL,0,100,1,0,1682230836),(3487,5,26,'鲜艳的洋红色','vivid_magenta',NULL,NULL,0,100,1,0,1682230836),(3488,5,26,'洋红色','magenta',NULL,NULL,0,100,1,0,1682230836),(3489,5,26,'紫红色','fuchsia',NULL,NULL,0,100,1,0,1682230836),(3490,5,26,'深粉色','dark_pink',NULL,NULL,0,100,1,0,1682230836),(3491,5,26,'鲜艳的粉红色','vivid_pink',NULL,NULL,0,100,1,0,1682230836),(3492,5,26,'深粉红色','deeppink',NULL,NULL,0,100,1,0,1682230836),(3493,5,26,'亮粉红色','hotpink',NULL,NULL,0,100,1,0,1682230836),(3494,15,85,'侵略者','by Invader',NULL,NULL,0,100,1,0,1682230836),(3495,5,26,'浅粉色','light_blush',NULL,NULL,0,100,1,0,1682230836),(3496,5,26,'粉红色','blush',NULL,NULL,0,100,1,0,1682230836),(3497,5,26,'浅粉色','light_pink',NULL,NULL,0,100,1,0,1682230836),(3498,5,26,'爱丽丝蓝色','aliceblue',NULL,NULL,0,100,1,0,1682230836),(3499,5,26,'古董白色','antiquewhite',NULL,NULL,0,100,1,0,1682230836),(3500,5,26,'宝石绿','aquamarine',NULL,NULL,0,100,1,0,1682230836),(3501,5,26,'陶坯色','bisque',NULL,NULL,0,100,1,0,1682230836),(3502,5,26,'发白的杏仁色','blanchedalmond',NULL,NULL,0,100,1,0,1682230836),(3503,5,26,'军校蓝色','cadetblue',NULL,NULL,0,100,1,0,1682230836),(3504,5,26,'玉米丝色','cornsilk',NULL,NULL,0,100,1,0,1682230836),(3505,5,26,'深金黄色','darkgoldenrod',NULL,NULL,0,100,1,0,1682230836),(3506,5,26,'深灰色','darkgrey',NULL,NULL,0,100,1,0,1682230836),(3507,5,26,'深卡其色','darkkhaki',NULL,NULL,0,100,1,0,1682230836),(3508,5,26,'深橙红色','darksalmon',NULL,NULL,0,100,1,0,1682230836),(3509,5,26,'深青灰色','darkslategrey',NULL,NULL,0,100,1,0,1682230836),(3510,5,26,'暗灰色','dimgray',NULL,NULL,0,100,1,0,1682230836),(3511,5,26,'闪蓝色','dodgerblue',NULL,NULL,0,100,1,0,1682230836),(3512,5,26,'火砖红色','firebrick',NULL,NULL,0,100,1,0,1682230836),(3513,5,26,'花白色','floralwhite',NULL,NULL,0,100,1,0,1682230836),(3514,15,85,'女士粉','by Lady Pink',NULL,NULL,0,100,1,0,1682230836),(3515,5,26,'印度红色','indianred',NULL,NULL,0,100,1,0,1682230836),(3516,5,26,'柠檬雪纺色','lemonchiffon',NULL,NULL,0,100,1,0,1682230836),(3517,5,26,'浅珊瑚色','lightcoral',NULL,NULL,0,100,1,0,1682230836),(3518,5,26,'酸橙绿','limegreen',NULL,NULL,0,100,1,0,1682230836),(3519,15,85,'娜塔莉亚·拉克','by Natalia Rak',NULL,NULL,0,100,1,0,1682230836),(3520,5,26,'亚麻色','linen',NULL,NULL,0,100,1,0,1682230836),(3521,5,26,'薄荷奶油色','mintcream',NULL,NULL,0,100,1,0,1682230836),(3522,5,26,'雾玫瑰色','mistyrose',NULL,NULL,0,100,1,0,1682230836),(3523,5,26,'鹿皮色','moccasin',NULL,NULL,0,100,1,0,1682230836),(3524,5,26,'老花边色','oldlace',NULL,NULL,0,100,1,0,1682230836),(3525,5,26,'橄榄褐色','olivedrab',NULL,NULL,0,100,1,0,1682230836),(3526,5,26,'兰花紫色','orchid',NULL,NULL,0,100,1,0,1682230836),(3527,15,85,'罗阿','by Roa',NULL,NULL,0,100,1,0,1682230836),(3528,5,26,'番木瓜色','papayawhip',NULL,NULL,0,100,1,0,1682230836),(3529,5,26,'桃色','peachpuff',NULL,NULL,0,100,1,0,1682230836),(3530,5,26,'玫瑰褐色','rosybrown',NULL,NULL,0,100,1,0,1682230836),(3531,5,26,'鞍褐色','saddlebrown',NULL,NULL,0,100,1,0,1682230836),(3532,5,26,'沙褐色','sandybrown',NULL,NULL,0,100,1,0,1682230836),(3533,15,85,'谢帕德·费尔','by Shepard Fairey',NULL,NULL,0,100,1,0,1682230836),(3534,5,26,'海贝壳色','seashell',NULL,NULL,0,100,1,0,1682230836),(3535,5,26,'黄土赭色','sienna',NULL,NULL,0,100,1,0,1682230836),(3536,5,26,'石板灰色','slategrey',NULL,NULL,0,100,1,0,1682230836),(3537,6,29,'金属的','made by metallic',NULL,NULL,0,100,1,0,1682230836),(3538,6,29,'铁','made by iron',NULL,NULL,0,100,1,0,1682230836),(3539,15,85,'间谍','by Spy',NULL,NULL,0,100,1,0,1682230836),(3540,6,29,'锻铁','made by wrought iron',NULL,NULL,0,100,1,0,1682230836),(3541,6,29,'铁屑','made by iron filings',NULL,NULL,0,100,1,0,1682230836),(3542,6,29,'生锈的','made by rusty',NULL,NULL,0,100,1,0,1682230836),(3543,6,29,'钢','made by steel',NULL,NULL,0,100,1,0,1682230836),(3544,6,29,'不锈钢','made by stainless steel',NULL,NULL,0,100,1,0,1682230836),(3545,6,29,'大马士革钢','made by damascus steel',NULL,NULL,0,100,1,0,1682230836),(3546,6,29,'铝箔','made by foil',NULL,NULL,0,100,1,0,1682230836),(3547,6,29,'钛','made by titanium',NULL,NULL,0,100,1,0,1682230836),(3548,6,29,'阳极氧化钛','made by anodized titanium',NULL,NULL,0,100,1,0,1682230836),(3549,6,29,'玫瑰金','made by rose gold',NULL,NULL,0,100,1,0,1682230836),(3550,15,85,'恍惚','by Swoon',NULL,NULL,0,100,1,0,1682230836),(3551,6,29,'黑金','made by hepatizon',NULL,NULL,0,100,1,0,1682230836),(3552,6,29,'钾','made by potassium',NULL,NULL,0,100,1,0,1682230836),(3553,6,29,'铂','made by platinum',NULL,NULL,0,100,1,0,1682230836),(3554,6,29,'白铅','made by pewter',NULL,NULL,0,100,1,0,1682230836),(3555,6,29,'液态金属','made by liquid metal',NULL,NULL,0,100,1,0,1682230836),(3556,6,29,'铜','made by copper',NULL,NULL,0,100,1,0,1682230836),(3557,15,85,'塔瓦尔·扎瓦奇·阿沃夫','by Tavar Zawacki Above',NULL,NULL,0,100,1,0,1682230836),(3558,6,29,'康斯坦丹合金','made by constantan',NULL,NULL,0,100,1,0,1682230836),(3559,6,29,'硫酸铜','made by copper sulfate',NULL,NULL,0,100,1,0,1682230836),(3560,6,29,'铝','made by aluminum',NULL,NULL,0,100,1,0,1682230836),(3561,6,29,'铝合金','made by aluminum alloy',NULL,NULL,0,100,1,0,1682230836),(3562,6,29,'构造线','made by armature wire',NULL,NULL,0,100,1,0,1682230836),(3563,6,29,'带刺铁丝','made by barbwire',NULL,NULL,0,100,1,0,1682230836),(3564,15,85,'维尔斯','by Vhils',NULL,NULL,0,100,1,0,1682230836),(3565,6,29,'刷铝','made by brushed aluminum',NULL,NULL,0,100,1,0,1682230836),(3566,6,29,'链条','made by chain',NULL,NULL,0,100,1,0,1682230836),(3567,6,29,'链条环节','made by chain link',NULL,NULL,0,100,1,0,1682230836),(3568,6,29,'环形链条围栏','made by chain link fence',NULL,NULL,0,100,1,0,1682230836),(3569,6,29,'小鸡网','made by chicken wire',NULL,NULL,0,100,1,0,1682230836),(3570,6,29,'铬','made by chromium',NULL,NULL,0,100,1,0,1682230836),(3571,6,29,'钴','made by cobalt',NULL,NULL,0,100,1,0,1682230836),(3572,6,29,'方锆石','made by cubic zirconium',NULL,NULL,0,100,1,0,1682230836),(3573,15,86,'亚历克斯·弗莱明','by Alex Fleming',NULL,NULL,0,100,1,0,1682230836),(3574,6,29,'围栏','made by fence',NULL,NULL,0,100,1,0,1682230836),(3575,6,29,'镓','made by gallium',NULL,NULL,0,100,1,0,1682230836),(3576,6,29,'镁','made by magnesium',NULL,NULL,0,100,1,0,1682230836),(3577,6,37,'熔化金属','made by molten gold',NULL,NULL,0,100,1,0,1682230836),(3578,6,29,'汞金属','made by mercury metal',NULL,NULL,0,100,1,0,1682230836),(3579,6,37,'熔岩','made by molten lava',NULL,NULL,0,100,1,0,1682230836),(3580,6,37,'熔化汞','made by molten mercury',NULL,NULL,0,100,1,0,1682230836),(3581,6,29,'金属纤维','made by metallic fiber',NULL,NULL,0,100,1,0,1682230836),(3582,6,29,'钉子','made by nail',NULL,NULL,0,100,1,0,1682230836),(3583,15,86,'卡尔·布伦德斯','by Carl Brenders',NULL,NULL,0,100,1,0,1682230836),(3584,6,29,'针','made by needle',NULL,NULL,0,100,1,0,1682230836),(3585,6,29,'金属夹具','made by paper clips',NULL,NULL,0,100,1,0,1682230836),(3586,6,29,'螺丝','made by screw',NULL,NULL,0,100,1,0,1682230836),(3587,6,29,'钠','made by sodium',NULL,NULL,0,100,1,0,1682230836),(3588,6,29,'焊锡','made by solder',NULL,NULL,0,100,1,0,1682230836),(3589,6,29,'锡','made by tin',NULL,NULL,0,100,1,0,1682230836),(3590,6,29,'钨','made by tungsten',NULL,NULL,0,100,1,0,1682230836),(3591,6,29,'铀','made by uranium',NULL,NULL,0,100,1,0,1682230836),(3592,15,86,'卡尔·伦吉乌斯','by Carl Rungius',NULL,NULL,0,100,1,0,1682230836),(3593,6,29,'锌','made by zinc',NULL,NULL,0,100,1,0,1682230836),(3594,6,29,'铋','made by bismuth',NULL,NULL,0,100,1,0,1682230836),(3595,6,30,'玛瑙','made by agate',NULL,NULL,0,100,1,0,1682230836),(3596,6,30,'血石','made by bloodstone',NULL,NULL,0,100,1,0,1682230836),(3597,6,30,'赤贝珍珠','made by akoya pearl',NULL,NULL,0,100,1,0,1682230836),(3598,6,30,'亚历山大石','made by alexandrite',NULL,NULL,0,100,1,0,1682230836),(3599,15,86,'卡拉·格蕾丝','by Carla Grace',NULL,NULL,0,100,1,0,1682230836),(3600,6,30,'尖晶石','made by almandine garnet',NULL,NULL,0,100,1,0,1682230836),(3601,6,30,'亚马逊石','made by amazonite',NULL,NULL,0,100,1,0,1682230836),(3602,6,30,'紫晶','made by amethyst',NULL,NULL,0,100,1,0,1682230836),(3603,6,30,'磷灰石','made by apatite',NULL,NULL,0,100,1,0,1682230836),(3604,6,30,'阿肯色石','made by arkansas stone',NULL,NULL,0,100,1,0,1682230836),(3605,6,30,'双色托帕石','made by bicolor tourmaline',NULL,NULL,0,100,1,0,1682230836),(3606,6,30,'红色矿石','made by bixbite',NULL,NULL,0,100,1,0,1682230836),(3607,15,166,'查理·哈珀','by Charley Harper',NULL,NULL,0,100,1,0,1682230836),(3608,6,30,'博文石','made by bowenite',NULL,NULL,0,100,1,0,1682230836),(3609,6,30,'方解石','made by calcite',NULL,NULL,0,100,1,0,1682230836),(3610,6,30,'加州绿石','made by californite',NULL,NULL,0,100,1,0,1682230836),(3611,6,30,'红玛瑙','made by carnelian',NULL,NULL,0,100,1,0,1682230836),(3612,6,30,'玛瑙','made by chalcedony',NULL,NULL,0,100,1,0,1682230836),(3613,6,30,'菱铁矿','made by chalybite',NULL,NULL,0,100,1,0,1682230836),(3614,6,30,'车帕石','made by charoite',NULL,NULL,0,100,1,0,1682230836),(3615,6,30,'铬透辉石','made by chrome diopside',NULL,NULL,0,100,1,0,1682230836),(3616,6,30,'铬橄榄石','made by chrome sphene',NULL,NULL,0,100,1,0,1682230836),(3617,6,30,'铬电气石','made by chrome tourmaline',NULL,NULL,0,100,1,0,1682230836),(3618,15,86,'克里斯·罗斯','by Chris Rose',NULL,NULL,0,100,1,0,1682230836),(3619,6,30,'黄水晶','made by citrine',NULL,NULL,0,100,1,0,1682230836),(3620,6,30,'海螺珠','made by conch pearl',NULL,NULL,0,100,1,0,1682230836),(3621,6,30,'科泊松香','made by copal',NULL,NULL,0,100,1,0,1682230836),(3622,6,30,'镁铝榴石','made by cordierite',NULL,NULL,0,100,1,0,1682230836),(3623,6,30,'刚玉','made by corundum',NULL,NULL,0,100,1,0,1682230836),(3624,6,30,'立方氧化锆','made by cubic zirconia',NULL,NULL,0,100,1,0,1682230836),(3625,6,30,'珍珠母','made by cyprine',NULL,NULL,0,100,1,0,1682230836),(3626,6,30,'达托石','made by datolite',NULL,NULL,0,100,1,0,1682230836),(3627,15,86,'克莱尔·帕克斯','by Clare Parkes',NULL,NULL,0,100,1,0,1682230836),(3628,6,30,'祖母绿','made by emerald',NULL,NULL,0,100,1,0,1682230836),(3629,6,30,'钒铬绿宝石','made by emerald vanadium',NULL,NULL,0,100,1,0,1682230836),(3630,6,30,'斜方辉石','made by enstatite',NULL,NULL,0,100,1,0,1682230836),(3631,6,30,'长石','made by feldspar',NULL,NULL,0,100,1,0,1682230836),(3632,6,30,'萤石','made by fluorite',NULL,NULL,0,100,1,0,1682230836),(3633,6,30,'辉石橄榄石','made by forsterite',NULL,NULL,0,100,1,0,1682230836),(3634,6,30,'淡水珍珠','made by freshwater pearl',NULL,NULL,0,100,1,0,1682230836),(3635,6,30,'金石','made by goldstone',NULL,NULL,0,100,1,0,1682230836),(3636,6,30,'白色绿柱石','made by goshenite',NULL,NULL,0,100,1,0,1682230836),(3637,15,86,'大卫·谢泼德','by David Shepherd',NULL,NULL,0,100,1,0,1682230836),(3638,6,30,'绿绿柱石','made by green beryl',NULL,NULL,0,100,1,0,1682230836),(3639,6,30,'绿水晶','made by green quartz',NULL,NULL,0,100,1,0,1682230836),(3640,6,30,'绿缬矿','made by greenovite',NULL,NULL,0,100,1,0,1682230836),(3641,6,30,'棱锰石','made by grossular',NULL,NULL,0,100,1,0,1682230836),(3642,6,30,'哈克曼矿','made by hackmanite',NULL,NULL,0,100,1,0,1682230836),(3643,6,30,'包裹石英','made by inclusion quartz',NULL,NULL,0,100,1,0,1682230836),(3644,6,30,'玉','made by jade',NULL,NULL,0,100,1,0,1682230836),(3645,6,30,'翡翠','made by jadeite',NULL,NULL,0,100,1,0,1682230836),(3646,6,30,'碧玉石','made by jasper gem',NULL,NULL,0,100,1,0,1682230836),(3647,6,30,'科纳绿柱石','made by kornerupine',NULL,NULL,0,100,1,0,1682230836),(3648,15,86,'达斯汀·范·韦切尔','by Dustin Van Wechel',NULL,NULL,0,100,1,0,1682230836),(3649,6,30,'昆采石','made by kunzite',NULL,NULL,0,100,1,0,1682230836),(3650,6,30,'蓝晶石','made by kyanite',NULL,NULL,0,100,1,0,1682230836),(3651,6,30,'闪石','made by labradorite',NULL,NULL,0,100,1,0,1682230836),(3652,6,30,'天青石','made by lapiz lazuli',NULL,NULL,0,100,1,0,1682230836),(3653,6,30,'拉里马石','made by larimar',NULL,NULL,0,100,1,0,1682230836),(3654,6,30,'利迪科绿电气石','made by liddicoatite tourmaline',NULL,NULL,0,100,1,0,1682230836),(3655,6,30,'孔雀石','made by malachite',NULL,NULL,0,100,1,0,1682230836),(3656,6,30,'绿松石','made by maw sit sit',NULL,NULL,0,100,1,0,1682230836),(3657,6,30,'马克希斯绿宝石','made by maxixe beryl',NULL,NULL,0,100,1,0,1682230836),(3658,6,30,'缅甸螺珠','made by melo melo pearl',NULL,NULL,0,100,1,0,1682230836),(3659,15,86,'埃里克·贾布隆斯基','by Eric Jablonowski',NULL,NULL,0,100,1,0,1682230836),(3660,6,30,'碳化硅','made by moissanite',NULL,NULL,0,100,1,0,1682230836),(3661,6,30,'粉晶','made by morganite',NULL,NULL,0,100,1,0,1682230836),(3662,6,30,'缅甸玉','made by nephrite',NULL,NULL,0,100,1,0,1682230836),(3663,6,30,'缟玛瑙','made by onyx',NULL,NULL,0,100,1,0,1682230836),(3664,6,30,'蛋白石','made by opal',NULL,NULL,0,100,1,0,1682230836),(3665,6,30,'巴拉伊巴碧玺','made by paraiba type tourmaline',NULL,NULL,0,100,1,0,1682230836),(3666,6,30,'珍珠','made by pearl',NULL,NULL,0,100,1,0,1682230836),(3667,6,30,'斜长石','made by pectolite',NULL,NULL,0,100,1,0,1682230836),(3668,6,30,'火山榴石','made by pyrope garnet',NULL,NULL,0,100,1,0,1682230836),(3669,15,86,'埃里克·罗比泰','by Eric Robitaille',NULL,NULL,0,100,1,0,1682230836),(3670,6,30,'鸟蛤','made by quahog',NULL,NULL,0,100,1,0,1682230836),(3671,6,30,'石英','made by quartz',NULL,NULL,0,100,1,0,1682230836),(3672,6,30,'晶石','made by rock crystal',NULL,NULL,0,100,1,0,1682230836),(3673,6,30,'粉晶石','made by rose quartz',NULL,NULL,0,100,1,0,1682230836),(3674,6,30,'蓝宝石','made by sapphire',NULL,NULL,0,100,1,0,1682230836),(3675,6,30,'菱铁矿','made by siderite',NULL,NULL,0,100,1,0,1682230836),(3676,6,30,'烟晶','made by smoky quartz',NULL,NULL,0,100,1,0,1682230836),(3677,6,30,'南海珍珠','made by south sea pearl',NULL,NULL,0,100,1,0,1682230836),(3678,6,30,'尖晶石','made by spinel',NULL,NULL,0,100,1,0,1682230836),(3679,15,86,'加里·霍奇斯','by Gary Hodges',NULL,NULL,0,100,1,0,1682230836),(3680,6,30,'太阳石','made by sunstone',NULL,NULL,0,100,1,0,1682230836),(3681,6,30,'绿锆石','made by tanzanite',NULL,NULL,0,100,1,0,1682230836),(3682,6,30,'虎眼石','made by tigereye',NULL,NULL,0,100,1,0,1682230836),(3683,6,30,'钛铁矿','made by titanite',NULL,NULL,0,100,1,0,1682230836),(3684,6,30,'黄玉','made by topaz',NULL,NULL,0,100,1,0,1682230836),(3685,6,30,'碧玺','made by tourmaline',NULL,NULL,0,100,1,0,1682230836),(3686,6,30,'三色碧玺','made by tricolor tourmaline',NULL,NULL,0,100,1,0,1682230836),(3687,6,30,'圣战蓝绿石','made by true blue beryl',NULL,NULL,0,100,1,0,1682230836),(3688,6,30,'绿榴石','made by tsavorite garnet',NULL,NULL,0,100,1,0,1682230836),(3689,15,86,'吉娜·霍克肖','by Gina Hawkshaw',NULL,NULL,0,100,1,0,1682230836),(3690,6,30,'钒绿石','made by vanadium beryl',NULL,NULL,0,100,1,0,1682230836),(3691,6,30,'西瓜碧玺','made by watermelon tourmaline',NULL,NULL,0,100,1,0,1682230836),(3692,6,30,'石灰石','made by limestone',NULL,NULL,0,100,1,0,1682230836),(3693,6,30,'页岩','made by shale',NULL,NULL,0,100,1,0,1682230836),(3694,6,30,'沙岩','made by sandstone',NULL,NULL,0,100,1,0,1682230836),(3695,6,30,'板岩','made by slate',NULL,NULL,0,100,1,0,1682230836),(3696,6,30,'燧石','made by chert',NULL,NULL,0,100,1,0,1682230836),(3697,6,30,'岩浆','made by lava',NULL,NULL,0,100,1,0,1682230836),(3698,6,30,'火山岩','made by volcanic rock',NULL,NULL,0,100,1,0,1682230836),(3699,6,30,'安山岩','made by andesite',NULL,NULL,0,100,1,0,1682230836),(3700,15,86,'盖伊·科海利奇','by Guy Coheleach',NULL,NULL,0,100,1,0,1682230836),(3701,6,30,'花岗岩','made by granite',NULL,NULL,0,100,1,0,1682230836),(3702,6,30,'玄武岩','made by basalt',NULL,NULL,0,100,1,0,1682230836),(3703,6,30,'黑曜石','made by obsidian',NULL,NULL,0,100,1,0,1682230836),(3704,6,30,'大理石','made by marble / marbling',NULL,NULL,0,100,1,0,1682230836),(3705,6,30,'蛇纹岩','made by serpentinite',NULL,NULL,0,100,1,0,1682230836),(3706,6,30,'露台石','made by terrazzo',NULL,NULL,0,100,1,0,1682230836),(3707,6,30,'钙华岩','made by travertine',NULL,NULL,0,100,1,0,1682230836),(3708,6,30,'马赛克','made by mosaic',NULL,NULL,0,100,1,0,1682230836),(3709,6,30,'柱子','made by column',NULL,NULL,0,100,1,0,1682230836),(3710,15,86,'赫尔穆特·科勒','by Helmut Koller',NULL,NULL,0,100,1,0,1682230836),(3711,6,30,'研磨表面','made by hone finished',NULL,NULL,0,100,1,0,1682230836),(3712,6,30,'抛光表面','made by polished finished',NULL,NULL,0,100,1,0,1682230836),(3713,6,30,'混凝土纹理','made by concrete texture',NULL,NULL,0,100,1,0,1682230836),(3714,6,30,'瓷砖','made by tile',NULL,NULL,0,100,1,0,1682230836),(3715,6,30,'鹅卵石','made by cobblestone',NULL,NULL,0,100,1,0,1682230836),(3716,6,30,'天青石','made by celestine',NULL,NULL,0,100,1,0,1682230836),(3717,6,30,'青金石','made by lazurite',NULL,NULL,0,100,1,0,1682230836),(3718,15,86,'简·史密斯','by Jane Smith',NULL,NULL,0,100,1,0,1682230836),(3719,6,30,'水晶','made by crystal',NULL,NULL,0,100,1,0,1682230836),(3720,6,30,'金绿石','made by chrysoberyl',NULL,NULL,0,100,1,0,1682230836),(3721,15,86,'杰森·摩根','by Jason Morgan',NULL,NULL,0,100,1,0,1682230836),(3722,6,30,'橄榄石','made by olivine/peridot',NULL,NULL,0,100,1,0,1682230836),(3723,15,86,'简·普里查德','by Jean Pritchard',NULL,NULL,0,100,1,0,1682230836),(3724,6,30,'蓝铜矿','made by azurite',NULL,NULL,0,100,1,0,1682230836),(3725,6,30,'喷气','made by jet',NULL,NULL,0,100,1,0,1682230836),(3726,6,30,'钙矿石','made by calcentin / korit',NULL,NULL,0,100,1,0,1682230836),(3727,6,30,'硫磺','made by sulfur',NULL,NULL,0,100,1,0,1682230836),(3728,15,86,'吉姆·霍特曼','by Jim Hautman',NULL,NULL,0,100,1,0,1682230836),(3729,16,95,'友好的','friendly',NULL,NULL,0,100,1,0,1682230836),(3730,6,30,'粉红尖晶石','made by pink spinel',NULL,NULL,0,100,1,0,1682230836),(3731,6,30,'煤炭','made by coal',NULL,NULL,0,100,1,0,1682230836),(3732,6,31,'气溶胶','made by aerosol',NULL,NULL,0,100,1,0,1682230836),(3733,6,31,'云','made by clouds',NULL,NULL,0,100,1,0,1682230836),(3734,6,31,'雾霾','made by haze',NULL,NULL,0,100,1,0,1682230836),(3735,6,31,'雾','made by fog',NULL,NULL,0,100,1,0,1682230836),(3736,6,31,'气体','made by gas',NULL,NULL,0,100,1,0,1682230836),(3737,6,31,'薄雾','made by mist',NULL,NULL,0,100,1,0,1682230836),(3738,6,31,'雾霭','made by smog',NULL,NULL,0,100,1,0,1682230836),(3739,15,86,'乔·霍特曼','by Joe Hautman',NULL,NULL,0,100,1,0,1682230836),(3740,6,31,'烟雾','made by smokey',NULL,NULL,0,100,1,0,1682230836),(3741,6,31,'蒸汽','made by vapor',NULL,NULL,0,100,1,0,1682230836),(3742,6,31,'暴风雪','made by blizzard',NULL,NULL,0,100,1,0,1682230836),(3743,6,31,'蓝冰','made by blue ice',NULL,NULL,0,100,1,0,1682230836),(3744,6,31,'干冰','made by dry ice',NULL,NULL,0,100,1,0,1682230836),(3745,6,31,'霜','made by frost',NULL,NULL,0,100,1,0,1682230836),(3746,6,31,'冰','made by ice',NULL,NULL,0,100,1,0,1682230836),(3747,6,31,'冰山','made by iceberg',NULL,NULL,0,100,1,0,1682230836),(3748,6,31,'冰柱','made by icicle',NULL,NULL,0,100,1,0,1682230836),(3749,15,86,'约翰·巴诺维奇','by John Banovich',NULL,NULL,0,100,1,0,1682230836),(3750,6,31,'海冰','made by sea ice',NULL,NULL,0,100,1,0,1682230836),(3751,6,31,'雪花','made by snowflake',NULL,NULL,0,100,1,0,1682230836),(3752,6,32,'燃烧的','made by burning',NULL,NULL,0,100,1,0,1682230836),(3753,6,32,'燃烧','made by burn',NULL,NULL,0,100,1,0,1682230836),(3754,6,32,'电力的','made by electric',NULL,NULL,0,100,1,0,1682230836),(3755,6,32,'电力','made by electricity',NULL,NULL,0,100,1,0,1682230836),(3756,6,32,'电击','made by electrical shock',NULL,NULL,0,100,1,0,1682230836),(3757,6,32,'爆炸','made by explosion',NULL,NULL,0,100,1,0,1682230836),(3758,6,32,'火','made by fire',NULL,NULL,0,100,1,0,1682230836),(3759,6,32,'烟花','made by fireworks',NULL,NULL,0,100,1,0,1682230836),(3760,15,86,'胡安·瓦雷拉','by Juan Varela',NULL,NULL,0,100,1,0,1682230836),(3761,6,32,'大火','made by inferno',NULL,NULL,0,100,1,0,1682230836),(3762,6,32,'闪电','made by lightning',NULL,NULL,0,100,1,0,1682230836),(3763,6,32,'等离子体','made by plasma',NULL,NULL,0,100,1,0,1682230836),(3764,6,32,'火花','made by sparks',NULL,NULL,0,100,1,0,1682230836),(3765,6,32,'闪烁','made by sparkles',NULL,NULL,0,100,1,0,1682230836),(3766,6,33,'胡须','made by beard',NULL,NULL,0,100,1,0,1682230836),(3767,6,33,'灰尘兔','made by dust bunny',NULL,NULL,0,100,1,0,1682230836),(3768,6,33,'羽毛','made by feathers',NULL,NULL,0,100,1,0,1682230836),(3769,6,33,'多毛的','made by furry',NULL,NULL,0,100,1,0,1682230836),(3770,15,86,'卡伦·劳伦斯-罗伊','by Karen Laurence-Rowe',NULL,NULL,0,100,1,0,1682230836),(3771,6,33,'绒毛','made by fuzz',NULL,NULL,0,100,1,0,1682230836),(3773,6,33,'头发','made by hair',NULL,NULL,0,100,1,0,1682230836),(3774,6,33,'多毛的','made by hairy',NULL,NULL,0,100,1,0,1682230836),(3775,6,33,'豹毛','made by jaguar fur',NULL,NULL,0,100,1,0,1682230836),(3776,6,33,'豹纹皮毛','made by leopard fur',NULL,NULL,0,100,1,0,1682230836),(3777,6,33,'胡子','made by mustache',NULL,NULL,0,100,1,0,1682230836),(3778,6,33,'熊猫毛皮','made by panda fur',NULL,NULL,0,100,1,0,1682230836),(3779,6,33,'北极熊毛皮','made by polar bear fur',NULL,NULL,0,100,1,0,1682230836),(3780,15,86,'凯利·奎恩','by Kelly Quinn',NULL,NULL,0,100,1,0,1682230836),(3781,6,33,'虎毛皮','made by tiger fur',NULL,NULL,0,100,1,0,1682230836),(3782,6,33,'斑马毛皮','made by zebra fur',NULL,NULL,0,100,1,0,1682230836),(3783,6,33,'羊毛皮毛','made by wool fur',NULL,NULL,0,100,1,0,1682230836),(3784,6,33,'开壳绒','made by cashmere',NULL,NULL,0,100,1,0,1682230836),(3785,6,33,'丝绸','made by silk',NULL,NULL,0,100,1,0,1682230836),(3786,6,33,'毛马绒','made by mohair',NULL,NULL,0,100,1,0,1682230836),(3787,6,34,'贴布','made by applique',NULL,NULL,0,100,1,0,1682230836),(3788,6,34,'创可贴','made by band aid',NULL,NULL,0,100,1,0,1682230836),(3789,6,34,'绷带','made by bandage',NULL,NULL,0,100,1,0,1682230836),(3790,15,86,'拉扎罗斯·帕斯代基斯','by Lazaros Pasdekis',NULL,NULL,0,100,1,0,1682230836),(3791,6,34,'毯子','made by blanket',NULL,NULL,0,100,1,0,1682230836),(3792,6,34,'帆布','made by canvas',NULL,NULL,0,100,1,0,1682230836),(3793,6,34,'地毯','made by carpet',NULL,NULL,0,100,1,0,1682230836),(3794,6,34,'布料','made by cloth',NULL,NULL,0,100,1,0,1682230836),(3795,6,34,'峡谷布','made by corduroy',NULL,NULL,0,100,1,0,1682230836),(3796,6,34,'棉花','made by cotton',NULL,NULL,0,100,1,0,1682230836),(3797,6,34,'钩针编织','made by crochet',NULL,NULL,0,100,1,0,1682230836),(3798,6,34,'十字绣','made by cross stitch',NULL,NULL,0,100,1,0,1682230836),(3799,6,34,'垫子','made by cushion',NULL,NULL,0,100,1,0,1682230836),(3800,15,86,'马丁·阿弗林','by Martin Aveling',NULL,NULL,0,100,1,0,1682230836),(3801,6,34,'牛仔布','made by denim',NULL,NULL,0,100,1,0,1682230836),(3802,6,34,'刺绣','made by embroidery',NULL,NULL,0,100,1,0,1682230836),(3803,6,34,'毡布','made by felt',NULL,NULL,0,100,1,0,1682230836),(3804,6,34,'毡布','made by felt cloth',NULL,NULL,0,100,1,0,1682230836),(3805,6,34,'纤维','made by fibers',NULL,NULL,0,100,1,0,1682230836),(3806,6,34,'纱布','made by gauze',NULL,NULL,0,100,1,0,1682230836),(3807,6,34,'牛仔裤','made by jeans',NULL,NULL,0,100,1,0,1682230836),(3808,6,34,'凯夫拉','made by kevlar',NULL,NULL,0,100,1,0,1682230836),(3809,6,34,'卡其布','made by khaki',NULL,NULL,0,100,1,0,1682230836),(3810,6,34,'针织','made by knitted',NULL,NULL,0,100,1,0,1682230836),(3811,15,86,'尼克·赛德尔','by Nick Sider',NULL,NULL,0,100,1,0,1682230836),(3812,6,34,'蕾丝','made by lace',NULL,NULL,0,100,1,0,1682230836),(3813,6,34,'皮革','made by leather',NULL,NULL,0,100,1,0,1682230836),(3814,6,34,'绒毛','made by lint',NULL,NULL,0,100,1,0,1682230836),(3815,6,34,'闪光纱','made by lurex',NULL,NULL,0,100,1,0,1682230836),(3816,6,34,'莱赛尔','made by lyocell',NULL,NULL,0,100,1,0,1682230836),(3817,6,34,'编绳艺术','made by macrame',NULL,NULL,0,100,1,0,1682230836),(3818,6,34,'记忆棉','made by memory foam',NULL,NULL,0,100,1,0,1682230836),(3819,6,34,'微纤维','made by microfiber',NULL,NULL,0,100,1,0,1682230836),(3820,6,34,'刺绣','made by needle point',NULL,NULL,0,100,1,0,1682230836),(3821,15,86,'保罗·米勒','by Paul Miller',NULL,NULL,0,100,1,0,1682230836),(3822,6,34,'网布','made by net',NULL,NULL,0,100,1,0,1682230836),(3823,6,34,'网布','made by netting',NULL,NULL,0,100,1,0,1682230836),(3824,6,34,'耐慢燃材料','made by nomex',NULL,NULL,0,100,1,0,1682230836),(3825,6,34,'尼龙','made by nylon',NULL,NULL,0,100,1,0,1682230836),(3826,6,34,'贴片','made by patch',NULL,NULL,0,100,1,0,1682230836),(3827,6,34,'枕头','made by pillow',NULL,NULL,0,100,1,0,1682230836),(3828,6,34,'针插垫','made by pin cushion',NULL,NULL,0,100,1,0,1682230836),(3829,6,34,'聚酯纤维','made by polyester',NULL,NULL,0,100,1,0,1682230836),(3830,6,34,'被子','made by quilt',NULL,NULL,0,100,1,0,1682230836),(3831,6,34,'人造丝绸','made by rayon',NULL,NULL,0,100,1,0,1682230836),(3832,15,86,'罗伯特·吉尔莫尔','by Robert Gillmor',NULL,NULL,0,100,1,0,1682230836),(3833,6,34,'地毯','made by rug',NULL,NULL,0,100,1,0,1682230836),(3834,6,34,'缝纫','made by sewing',NULL,NULL,0,100,1,0,1682230836),(3835,6,34,'弹性纤维','made by spandex',NULL,NULL,0,100,1,0,1682230836),(3836,6,34,'蜘蛛网','made by spider web',NULL,NULL,0,100,1,0,1682230836),(3837,6,34,'毛巾布','made by terry cloth',NULL,NULL,0,100,1,0,1682230836),(3838,6,34,'麻绳','made by twine',NULL,NULL,0,100,1,0,1682230836),(3839,6,34,'天鹅绒','made by velvet',NULL,NULL,0,100,1,0,1682230836),(3840,6,34,'编织','made by weave',NULL,NULL,0,100,1,0,1682230836),(3841,6,34,'纱线','made by yarn',NULL,NULL,0,100,1,0,1682230836),(3842,15,86,'罗伯特·豪特曼','by Robert Hautman',NULL,NULL,0,100,1,0,1682230836),(3843,6,34,'黄麻','made by jute',NULL,NULL,0,100,1,0,1682230836),(3844,6,34,'纸莎草织物','made by papyrus fabric',NULL,NULL,0,100,1,0,1682230836),(3845,6,35,'阿拉伯树木','made by acacia wood',NULL,NULL,0,100,1,0,1682230836),(3846,6,35,'桦木','made by birch wood',NULL,NULL,0,100,1,0,1682230836),(3847,6,35,'硬纸板','made by cardboard',NULL,NULL,0,100,1,0,1682230836),(3848,6,35,'卡纸','made by cardstock',NULL,NULL,0,100,1,0,1682230836),(3849,15,86,'罗素·戈登','by Russell Gordon',NULL,NULL,0,100,1,0,1682230836),(3850,6,35,'雪松木','made by cedar wood',NULL,NULL,0,100,1,0,1682230836),(3851,6,35,'纤维素','made by cellulose',NULL,NULL,0,100,1,0,1682230836),(3852,6,35,'樱桃木','made by cherry wood',NULL,NULL,0,100,1,0,1682230836),(3853,6,35,'施工纸','made by construction paper',NULL,NULL,0,100,1,0,1682230836),(3854,6,35,'软木','made by cork',NULL,NULL,0,100,1,0,1682230836),(3855,6,35,'瓦楞纸板','made by corrugated fiberboard',NULL,NULL,0,100,1,0,1682230836),(3856,6,35,'棉纸','made by cotton paper',NULL,NULL,0,100,1,0,1682230836),(3857,6,35,'信封','made by envelope',NULL,NULL,0,100,1,0,1682230836),(3858,6,35,'方格纸','made by graph paper',NULL,NULL,0,100,1,0,1682230836),(3859,6,35,'大麻纤维','made by hemp fiber',NULL,NULL,0,100,1,0,1682230836),(3860,15,86,'瑞恩·斯基德莫尔','by Ryan Skidmore',NULL,NULL,0,100,1,0,1682230836),(3861,6,35,'大麻纸','made by hemp paper',NULL,NULL,0,100,1,0,1682230836),(3862,6,35,'牛皮纸','made by kraft paper',NULL,NULL,0,100,1,0,1682230836),(3863,6,35,'木材','made by lumber',NULL,NULL,0,100,1,0,1682230836),(3864,6,35,'马尼拉文件夹','made by manila folder',NULL,NULL,0,100,1,0,1682230836),(3865,6,35,'马尼拉纸','made by manila paper',NULL,NULL,0,100,1,0,1682230836),(3866,6,35,'手稿纸','made by manuscript paper',NULL,NULL,0,100,1,0,1682230836),(3867,6,35,'枫木','made by maple wood',NULL,NULL,0,100,1,0,1682230836),(3868,6,35,'中世纪羊皮纸','made by medieval parchment',NULL,NULL,0,100,1,0,1682230836),(3869,6,35,'钉木','made by nailed wood',NULL,NULL,0,100,1,0,1682230836),(3870,6,35,'橡木','made by oak wood',NULL,NULL,0,100,1,0,1682230836),(3871,15,86,'萨布丽娜·鲁普雷希特','by Sabrina Rupprecht',NULL,NULL,0,100,1,0,1682230836),(3872,6,35,'纸张','made by paper',NULL,NULL,0,100,1,0,1682230836),(3873,6,35,'纸巾','made by paper towel',NULL,NULL,0,100,1,0,1682230836),(3874,6,35,'硬纸板','made by paperboard',NULL,NULL,0,100,1,0,1682230836),(3875,6,35,'纸莎草','made by papyrus',NULL,NULL,0,100,1,0,1682230836),(3876,6,35,'羊皮纸','made by parchment paper',NULL,NULL,0,100,1,0,1682230836),(3877,6,35,'刨花板','made by particle board',NULL,NULL,0,100,1,0,1682230836),(3878,6,35,'松木','made by pine wood',NULL,NULL,0,100,1,0,1682230836),(3879,6,35,'木板','made by planks',NULL,NULL,0,100,1,0,1682230836),(3880,6,35,'塑料涂层纸','made by plastic coated paper',NULL,NULL,0,100,1,0,1682230836),(3881,15,86,'斯特拉·梅斯','by Stella Mays',NULL,NULL,0,100,1,0,1682230836),(3882,6,35,'胶合板','made by plywood',NULL,NULL,0,100,1,0,1682230836),(3883,6,35,'卷烟纸','made by rolling paper',NULL,NULL,0,100,1,0,1682230836),(3884,6,35,'锯末','made by sawdust',NULL,NULL,0,100,1,0,1682230836),(3885,6,35,'安全纸','made by security paper',NULL,NULL,0,100,1,0,1682230836),(3886,6,35,'沥青纸','made by tar paper',NULL,NULL,0,100,1,0,1682230836),(3887,6,35,'纸巾纸','made by tissue paper',NULL,NULL,0,100,1,0,1682230836),(3888,6,35,'卫生纸','made by toilet paper',NULL,NULL,0,100,1,0,1682230836),(3889,6,35,'和纸','made by washi',NULL,NULL,0,100,1,0,1682230836),(3890,6,35,'华纸','made by wasli',NULL,NULL,0,100,1,0,1682230836),(3891,6,35,'木材染色剂','made by wood stain',NULL,NULL,0,100,1,0,1682230836),(3892,15,86,'斯蒂芬·D·纳什','by Stephen D Nash',NULL,NULL,0,100,1,0,1682230836),(3893,6,35,'木皮','made by wood veneer',NULL,NULL,0,100,1,0,1682230836),(3894,6,35,'木栅栏','made by wooden fence',NULL,NULL,0,100,1,0,1682230836),(3895,6,35,'木板','made by wooden planks',NULL,NULL,0,100,1,0,1682230836),(3896,6,35,'包装纸','made by wrapping paper',NULL,NULL,0,100,1,0,1682230836),(3897,6,35,'檜木','made by hinoki falsecypress',NULL,NULL,0,100,1,0,1682230836),(3898,6,35,'冷杉','made by fir',NULL,NULL,0,100,1,0,1682230836),(3899,6,35,'雪松','made by spruce',NULL,NULL,0,100,1,0,1682230836),(3900,6,35,'榆树','made by arborvitae',NULL,NULL,0,100,1,0,1682230836),(3901,15,86,'特里·艾萨克','by Terry Isaac',NULL,NULL,0,100,1,0,1682230836),(3902,6,35,'落叶松','made by larch',NULL,NULL,0,100,1,0,1682230836),(3903,6,35,'水杉','made by bald cypress / swamp cypress',NULL,NULL,0,100,1,0,1682230836),(3904,6,35,'道格拉斯冷杉','made by douglas fir',NULL,NULL,0,100,1,0,1682230836),(3905,6,35,'常青树','made by cypress',NULL,NULL,0,100,1,0,1682230836),(3906,6,35,'红檀','made by benihi',NULL,NULL,0,100,1,0,1682230836),(3908,6,35,'杜松树','made by juniper',NULL,NULL,0,100,1,0,1682230836),(3909,6,35,'红杉','made by sequoia',NULL,NULL,0,100,1,0,1682230836),(3910,6,35,'美国白蜡树','made by american white ash',NULL,NULL,0,100,1,0,1682230836),(3911,6,35,'美国红橡树','made by american red oak',NULL,NULL,0,100,1,0,1682230836),(3912,15,86,'特里·雷德林','by Terry Redlin',NULL,NULL,0,100,1,0,1682230836),(3913,6,35,'胡桃木','made by walnut',NULL,NULL,0,100,1,0,1682230836),(3914,6,35,'黄杨木','made by yellow poplar wood',NULL,NULL,0,100,1,0,1682230836),(3915,6,35,'柚木','made by teak',NULL,NULL,0,100,1,0,1682230836),(3916,6,35,'红杉木','made by red grandis',NULL,NULL,0,100,1,0,1682230836),(3917,6,35,'马哈哥尼木','made by mahogany / swietenia',NULL,NULL,0,100,1,0,1682230836),(3918,6,35,'山毛榉木','made by beech',NULL,NULL,0,100,1,0,1682230836),(3919,6,35,'壳斗科木材','made by fagaceae',NULL,NULL,0,100,1,0,1682230836),(3920,6,35,'白桦木','made by birch / betula',NULL,NULL,0,100,1,0,1682230836),(3921,6,35,'橡胶木','made by rubber wood',NULL,NULL,0,100,1,0,1682230836),(3922,15,86,'威廉·D·贝瑞','by William D Berry',NULL,NULL,0,100,1,0,1682230836),(3923,6,35,'乌木','made by ebony',NULL,NULL,0,100,1,0,1682230836),(3924,6,35,'檀香木','made by sandalwood',NULL,NULL,0,100,1,0,1682230836),(3925,6,35,'红木','made by rosewood',NULL,NULL,0,100,1,0,1682230836),(3926,6,36,'鲍鱼壳','made by abalone',NULL,NULL,0,100,1,0,1682230836),(3927,6,36,'极光石','made by aurora borealis',NULL,NULL,0,100,1,0,1682230836),(3928,6,36,'骨头','made by bone',NULL,NULL,0,100,1,0,1682230836),(3929,6,36,'手链','made by bracelet',NULL,NULL,0,100,1,0,1682230836),(3930,6,36,'泡泡','made by bubbles',NULL,NULL,0,100,1,0,1682230836),(3931,6,36,'电缆','made by cables',NULL,NULL,0,100,1,0,1682230836),(3932,133,87,'阿道夫·罗斯','by Adolf Loos',NULL,NULL,0,100,1,0,1682230836),(3933,16,95,'宁静的','halcyon',NULL,NULL,0,100,1,0,1682230836),(3934,16,96,'米其林星级','Michelin star',NULL,NULL,0,100,1,0,1682230836),(3935,6,36,'笼子','made by cage',NULL,NULL,0,100,1,0,1682230836),(3936,6,36,'细胞','made by cells',NULL,NULL,0,100,1,0,1682230836),(3937,6,36,'茧','made by cocoons',NULL,NULL,0,100,1,0,1682230836),(3938,6,36,'二极管','made by diode',NULL,NULL,0,100,1,0,1682230836),(3939,6,36,'渔网','made by fishnet',NULL,NULL,0,100,1,0,1682230836),(3940,6,36,'弹性黏土','made by flubber',NULL,NULL,0,100,1,0,1682230836),(3941,6,36,'螺旋','made by helix',NULL,NULL,0,100,1,0,1682230836),(3942,6,36,'镶嵌','made by inlay',NULL,NULL,0,100,1,0,1682230836),(3943,6,36,'海报胶','made by poster tack',NULL,NULL,0,100,1,0,1682230836),(3944,133,87,'阿尔瓦·阿尔托','by Alvar Aalto',NULL,NULL,0,100,1,0,1682230836),(3945,6,36,'粉末','made by powder',NULL,NULL,0,100,1,0,1682230836),(3946,6,36,'弹性胶泥','made by putty',NULL,NULL,0,100,1,0,1682230836),(3947,6,36,'黏液','made by slime',NULL,NULL,0,100,1,0,1682230836),(3948,6,36,'弹簧','made by slinky',NULL,NULL,0,100,1,0,1682230836),(3949,6,36,'肥皂','made by soap',NULL,NULL,0,100,1,0,1682230836),(3950,6,36,'石笋','made by stalagmites',NULL,NULL,0,100,1,0,1682230836),(3951,6,36,'马桶','made by toilet',NULL,NULL,0,100,1,0,1682230836),(3952,6,36,'龙卷风','made by tornado',NULL,NULL,0,100,1,0,1682230836),(3953,6,36,'晶体管','made by transistor',NULL,NULL,0,100,1,0,1682230836),(3954,133,87,'安托万·普雷多克','by Antoine Predock',NULL,NULL,0,100,1,0,1682230836),(3955,6,36,'垃圾','made by trash',NULL,NULL,0,100,1,0,1682230836),(3956,6,36,'布带','made by webbing',NULL,NULL,0,100,1,0,1682230836),(3957,6,36,'电线','made by wires',NULL,NULL,0,100,1,0,1682230836),(3958,6,36,'黏合剂','made by adhesive',NULL,NULL,0,100,1,0,1682230836),(3959,6,36,'透明胶带','made by clear tape',NULL,NULL,0,100,1,0,1682230836),(3960,6,36,'防水胶带','made by duct tape',NULL,NULL,0,100,1,0,1682230836),(3961,6,36,'胶水','made by elmers glue',NULL,NULL,0,100,1,0,1682230836),(3962,6,36,'环氧树脂','made by epoxy',NULL,NULL,0,100,1,0,1682230836),(3963,6,36,'卡普顿胶带','made by kapton tape',NULL,NULL,0,100,1,0,1682230836),(3964,6,36,'遮光胶带','made by masking tape',NULL,NULL,0,100,1,0,1682230836),(3965,133,87,'安东尼·高迪','by Antoni Gaudi',NULL,NULL,0,100,1,0,1682230836),(3966,6,36,'水珠','made by orbeez',NULL,NULL,0,100,1,0,1682230836),(3967,6,36,'包装胶带','made by packing tape',NULL,NULL,0,100,1,0,1682230836),(3968,6,36,'糊状物','made by paste',NULL,NULL,0,100,1,0,1682230836),(3969,6,36,'聚合物','made by polymer',NULL,NULL,0,100,1,0,1682230836),(3970,6,36,'透明胶带','made by scotch tape',NULL,NULL,0,100,1,0,1682230836),(3971,6,36,'气凝胶','made by aerogel',NULL,NULL,0,100,1,0,1682230836),(3972,6,36,'凝胶','made by gel',NULL,NULL,0,100,1,0,1682230836),(3973,6,36,'二氧化硅胶','made by silica gel',NULL,NULL,0,100,1,0,1682230836),(3974,6,36,'海绵','made by sponge',NULL,NULL,0,100,1,0,1682230836),(3975,133,87,'磯崎新','by Arata Isozaki',NULL,NULL,0,100,1,0,1682230836),(3976,6,36,'多孔的','made by spongy',NULL,NULL,0,100,1,0,1682230836),(3977,6,36,'保鲜膜','made by cling wrap',NULL,NULL,0,100,1,0,1682230836),(3978,6,36,'泡沫','made by foam',NULL,NULL,0,100,1,0,1682230836),(3979,6,36,'乐高','made by lego',NULL,NULL,0,100,1,0,1682230836),(3980,6,36,'塑料','made by plastic',NULL,NULL,0,100,1,0,1682230836),(3981,6,36,'塑料薄膜','made by plastic wrap',NULL,NULL,0,100,1,0,1682230836),(3982,6,36,'聚氨酯','made by polyurethane',NULL,NULL,0,100,1,0,1682230836),(3983,6,36,'聚乙烯','made by polyvinyl',NULL,NULL,0,100,1,0,1682230836),(3984,6,36,'热缩膜','made by shrink wrap',NULL,NULL,0,100,1,0,1682230836),(3985,6,36,'泡沫塑料','made by styrofoam',NULL,NULL,0,100,1,0,1682230836),(3986,133,87,'阿尔内·雅各布森','by Arne Jacobsen',NULL,NULL,0,100,1,0,1682230836),(3987,6,36,'聚四氟乙烯','made by teflon',NULL,NULL,0,100,1,0,1682230836),(3988,6,36,'气球','made by balloon',NULL,NULL,0,100,1,0,1682230836),(3989,6,36,'天然乳胶','made by latex',NULL,NULL,0,100,1,0,1682230836),(3990,6,36,'油毡','made by linoleum',NULL,NULL,0,100,1,0,1682230836),(3991,6,36,'丁腈橡胶','made by nitrile',NULL,NULL,0,100,1,0,1682230836),(3992,6,36,'橡胶','made by rubber',NULL,NULL,0,100,1,0,1682230836),(3993,6,36,'橡皮筋','made by rubber band',NULL,NULL,0,100,1,0,1682230836),(3994,6,36,'橡皮筋球','made by rubber band ball',NULL,NULL,0,100,1,0,1682230836),(3995,6,36,'硅胶','made by silicone',NULL,NULL,0,100,1,0,1682230836),(3996,6,36,'弹力手环','made by silly band',NULL,NULL,0,100,1,0,1682230836),(3997,133,87,'本·范·贝克尔','by Ben van Berkel',NULL,NULL,0,100,1,0,1682230836),(3998,6,36,'聚氯乙烯','made by vinyl',NULL,NULL,0,100,1,0,1682230836),(3999,6,36,'蜂蜡','made by beeswax',NULL,NULL,0,100,1,0,1682230836),(4000,6,36,'蜡烛蜡','made by candle wax',NULL,NULL,0,100,1,0,1682230836),(4001,6,36,'卡尔纳巴蜡','made by carnauba wax',NULL,NULL,0,100,1,0,1682230836),(4002,6,36,'口红','made by lipstick',NULL,NULL,0,100,1,0,1682230836),(4003,6,36,'石蜡','made by paraffin wax',NULL,NULL,0,100,1,0,1682230836),(4004,6,36,'虫胶','made by shellac',NULL,NULL,0,100,1,0,1682230836),(4005,6,36,'蜡','made by wax',NULL,NULL,0,100,1,0,1682230836),(4006,6,36,'蜡纸','made by wax paper',NULL,NULL,0,100,1,0,1682230836),(4007,6,36,'尼龙','made by nylon',NULL,NULL,0,100,1,0,1682230836),(4008,133,87,'伯纳德·楚米','by Bernard Tschumi',NULL,NULL,0,100,1,0,1682230836),(4009,6,36,'丙烯酸塑料','made by acrylic',NULL,NULL,0,100,1,0,1682230836),(4010,6,36,'弹性纤维','made by elastane fiber',NULL,NULL,0,100,1,0,1682230836),(4011,6,36,'模达尔纤维','made by modal',NULL,NULL,0,100,1,0,1682230836),(4012,6,36,'莱卡','made by lycra',NULL,NULL,0,100,1,0,1682230836),(4013,6,36,'定向刨花板','made by oriented strand board',NULL,NULL,0,100,1,0,1682230836),(4014,6,36,'木胶合板','made by wooden plywood',NULL,NULL,0,100,1,0,1682230836),(4015,6,36,'木材芯胶合板','made by lumber core plywood',NULL,NULL,0,100,1,0,1682230836),(4016,6,36,'薄木贴面','made by veneer',NULL,NULL,0,100,1,0,1682230836),(4017,133,87,'比亚克·英格尔斯','by Bjarke Ingels',NULL,NULL,0,100,1,0,1682230836),(4018,6,36,'木基板材','made by wood-based panel',NULL,NULL,0,100,1,0,1682230836),(4019,6,37,'液体','made by liquid',NULL,NULL,0,100,1,0,1682230836),(4020,6,37,'液晶','made by liquid crystal',NULL,NULL,0,100,1,0,1682230836),(4021,6,37,'岩浆','made by magma',NULL,NULL,0,100,1,0,1682230836),(4022,6,37,'矿物油','made by mineral oil',NULL,NULL,0,100,1,0,1682230836),(4023,6,37,'熔岩石','made by molten rock',NULL,NULL,0,100,1,0,1682230836),(4024,6,37,'发动机油','made by motor oil',NULL,NULL,0,100,1,0,1682230836),(4025,6,37,'海洋','made by ocean',NULL,NULL,0,100,1,0,1682230836),(4026,6,37,'油','made by oil',NULL,NULL,0,100,1,0,1682230836),(4027,6,37,'河流','made by river',NULL,NULL,0,100,1,0,1682230836),(4028,133,87,'巴克明斯特·富勒','by Buckminster Fuller',NULL,NULL,0,100,1,0,1682230836),(4029,6,37,'海','made by sea',NULL,NULL,0,100,1,0,1682230836),(4030,6,37,'海泡石','made by sea foam',NULL,NULL,0,100,1,0,1682230836),(4031,6,37,'松香油','made by turpentine',NULL,NULL,0,100,1,0,1682230836),(4032,6,37,'水','made by water',NULL,NULL,0,100,1,0,1682230836),(4033,6,37,'瀑布','made by waterfall',NULL,NULL,0,100,1,0,1682230836),(4034,6,37,'流体','made by fluid',NULL,NULL,0,100,1,0,1682230836),(4035,6,37,'汽油','made by gasoline',NULL,NULL,0,100,1,0,1682230836),(4036,6,37,'湖泊','made by lake',NULL,NULL,0,100,1,0,1682230836),(4037,6,37,'脂质','made by lipid',NULL,NULL,0,100,1,0,1682230836),(4038,133,87,'克里斯蒂安·德·波尔扎姆帕克','by Christian de Portzamparc',NULL,NULL,0,100,1,0,1682230836),(4040,11,48,'中国水墨画风格','chinese black ink',NULL,NULL,0,100,1,0,1682230836),(4041,133,87,'克里斯托弗·雷恩','by Christopher Wren',NULL,NULL,0,100,1,0,1682230836),(4042,133,87,'塞萨尔·佩里','by César Pelli',NULL,NULL,0,100,1,0,1682230836),(4043,133,87,'丹尼尔·伯纳姆','by Daniel Burnham',NULL,NULL,0,100,1,0,1682230836),(4044,12,158,'釉','glaze',NULL,NULL,0,100,1,0,1682230836),(4045,133,87,'大卫·阿贾耶','by David Adjaye',NULL,NULL,0,100,1,0,1682230836),(4046,12,158,'上釉','overglaze',NULL,NULL,0,100,1,0,1682230836),(4047,12,158,'下釉','underglaze',NULL,NULL,0,100,1,0,1682230836),(4048,12,158,'盐釉陶瓷','salt glaze pottery',NULL,NULL,0,100,1,0,1682230836),(4049,12,158,'锡釉陶瓷','tin-glazed pottery',NULL,NULL,0,100,1,0,1682230836),(4050,12,158,'浮雕玻璃','cameo glass',NULL,NULL,0,100,1,0,1682230836),(4051,12,158,'珐琅玻璃','enameled glass',NULL,NULL,0,100,1,0,1682230836),(4052,12,158,'玻璃蚀刻','glass-etching',NULL,NULL,0,100,1,0,1682230836),(4053,12,158,'古陶器','paleolithic pottery',NULL,NULL,0,100,1,0,1682230836),(4054,133,87,'大卫·切尔兹','by David Childs',NULL,NULL,0,100,1,0,1682230836),(4055,12,158,'新石器时代陶瓷','neolithic pottery',NULL,NULL,0,100,1,0,1682230836),(4056,12,158,'埃及彩陶','egyptian faience',NULL,NULL,0,100,1,0,1682230836),(4057,12,158,'流釉陶瓷','slipware',NULL,NULL,0,100,1,0,1682230836),(4058,12,158,'印花瓷器','chintzware',NULL,NULL,0,100,1,0,1682230836),(4059,12,158,'玛瑙陶瓷','agateware',NULL,NULL,0,100,1,0,1682230836),(4060,12,158,'釉彩陶器','lustreware',NULL,NULL,0,100,1,0,1682230836),(4061,12,158,'骨瓷','bone china',NULL,NULL,0,100,1,0,1682230836),(4062,133,87,'埃罗·萨里宁','by Eero Saarinen',NULL,NULL,0,100,1,0,1682230836),(4063,12,164,'乙烯基横幅','vinyl banner',NULL,NULL,0,100,1,0,1682230836),(4064,12,164,'牌匾','nameplate',NULL,NULL,0,100,1,0,1682230836),(4065,133,87,'弗兰克·盖里','by Frank Gehry',NULL,NULL,0,100,1,0,1682230836),(4066,12,164,'广告牌','placard',NULL,NULL,0,100,1,0,1682230836),(4067,133,87,'弗兰克·劳埃德·赖特','by Frank Lloyd Wright',NULL,NULL,0,100,1,0,1682230836),(4068,12,164,'餐具','tableware',NULL,NULL,0,100,1,0,1682230836),(4069,133,87,'戈登·邦夏夫特','by Gordon Bunshaft',NULL,NULL,0,100,1,0,1682230836),(4070,12,164,'照片拼贴','photocollage',NULL,NULL,0,100,1,0,1682230836),(4071,133,87,'贝聿铭','by I M Pei',NULL,NULL,0,100,1,0,1682230836),(4072,11,160,'剪贴簿艺术','scrapbooking',NULL,NULL,0,100,1,0,1682230836),(4073,12,164,'光绘','light painting',NULL,NULL,0,100,1,0,1682230836),(4074,12,164,'工艺美术','arts and crafts',NULL,NULL,0,100,1,0,1682230836),(4075,12,164,'珐琅徽章','enamel pin',NULL,NULL,0,100,1,0,1682230836),(4076,133,87,'伊姆霍特普','by Imhotep',NULL,NULL,0,100,1,0,1682230836),(4077,12,164,'羽毛工艺','featherwork',NULL,NULL,0,100,1,0,1682230836),(4078,12,164,'咖啡渍画','coffee stain',NULL,NULL,0,100,1,0,1682230836),(4079,12,164,'树篱修剪','hedge trimming',NULL,NULL,0,100,1,0,1682230836),(4080,11,160,'烟雾艺术','smoke art',NULL,NULL,0,100,1,0,1682230836),(4081,133,87,'让·努维尔','by Jean Nouvel',NULL,NULL,0,100,1,0,1682230836),(4082,11,160,'制帽艺术','hatmaking',NULL,NULL,0,100,1,0,1682230836),(4083,12,164,'刻花','chip-work',NULL,NULL,0,100,1,0,1682230836),(4084,12,164,'珐琅','vitreous enamel',NULL,NULL,0,100,1,0,1689161104),(4085,133,87,'简妮·冈','by Jeanne Gang',NULL,NULL,0,100,1,0,1682230836),(4086,12,164,'珠宝装饰','bejeweled',NULL,NULL,0,100,1,0,1682230836),(4087,133,87,'约恩·乌松','by Jorn Utzon',NULL,NULL,0,100,1,0,1682230836),(4088,12,164,'刻印宝石','engraved gem',NULL,NULL,0,100,1,0,1682230836),(4089,12,164,'模板','stencil',NULL,NULL,0,100,1,0,1682230836),(4090,11,160,'巨石艺术','megalithic art',NULL,NULL,0,100,1,0,1682230836),(4091,12,164,'弦艺','string-art',NULL,NULL,0,100,1,0,1682230836),(4092,133,87,'隈研吾','by Kengo Kuma',NULL,NULL,0,100,1,0,1682230836),(4093,12,164,'梅佐蒂','mezzotint',NULL,NULL,0,100,1,0,1682230836),(4094,12,164,'水印','aquatint',NULL,NULL,0,100,1,0,1682230836),(4095,12,164,'油毛刷版画','lino print',NULL,NULL,0,100,1,0,1682230836),(4096,12,164,'气球造型','balloon modelling',NULL,NULL,0,100,1,0,1682230836),(4097,7,39,'碱性平原','alkali flat',NULL,NULL,0,100,1,0,1682230836),(4098,12,164,'气球扭制','balloon twisting',NULL,NULL,0,100,1,0,1682230836),(4099,7,39,'高山','alpine',NULL,NULL,0,100,1,0,1682230836),(4100,12,164,'电路','circuit',NULL,NULL,0,100,1,0,1682230836),(4101,7,39,'南极洋','antarctic ocean',NULL,NULL,0,100,1,0,1682230836),(4102,12,164,'电路设计','circuitry',NULL,NULL,0,100,1,0,1682230836),(4103,7,39,'水生生态系统','aquatic ecosystem',NULL,NULL,0,100,1,0,1682230836),(4104,12,164,'计算机芯片','computer chip',NULL,NULL,0,100,1,0,1682230836),(4105,7,39,'大西洋','atlantic ocean',NULL,NULL,0,100,1,0,1682230836),(4106,12,164,'押花','oshibana',NULL,NULL,0,100,1,0,1682230836),(4107,7,39,'恶地','badlands',NULL,NULL,0,100,1,0,1682230836),(4108,133,87,'丹下健三','by Kenzo Tange',NULL,NULL,0,100,1,0,1682230836),(4109,7,39,'盆地','basin',NULL,NULL,0,100,1,0,1682230836),(4110,7,39,'海湾','bay',NULL,NULL,0,100,1,0,1682230836),(4111,7,39,'水体','body of water',NULL,NULL,0,100,1,0,1682230836),(4112,7,39,'小林子','bosque',NULL,NULL,0,100,1,0,1682230836),(4113,7,39,'小溪','brook',NULL,NULL,0,100,1,0,1682230836),(4114,7,39,'灌木丛','brush',NULL,NULL,0,100,1,0,1682230836),(4115,7,39,'灌木','bush',NULL,NULL,0,100,1,0,1682230836),(4116,7,39,'运河','canal',NULL,NULL,0,100,1,0,1682230836),(4117,7,39,'峡谷','canyon',NULL,NULL,0,100,1,0,1682230836),(4118,7,39,'悬崖','cliff',NULL,NULL,0,100,1,0,1682230836),(4119,133,87,'勒·柯布西耶','by Le Corbusier',NULL,NULL,0,100,1,0,1682230836),(4120,7,39,'悬崖边','cliffside',NULL,NULL,0,100,1,0,1682230836),(4121,7,39,'悬崖顶','clifftop',NULL,NULL,0,100,1,0,1682230836),(4122,7,39,'沿海水域','coastal waters',NULL,NULL,0,100,1,0,1682230836),(4123,7,39,'针叶树的','coniferous',NULL,NULL,0,100,1,0,1682230836),(4124,7,39,'大陆','continent',NULL,NULL,0,100,1,0,1682230836),(4125,7,39,'沟壑','coulee',NULL,NULL,0,100,1,0,1682230836),(4126,7,39,'小海湾','cove',NULL,NULL,0,100,1,0,1682230836),(4127,7,39,'小河','creek',NULL,NULL,0,100,1,0,1682230836),(4128,7,39,'裂缝','crevasse',NULL,NULL,0,100,1,0,1682230836),(4129,7,39,'深海水','deep ocean water',NULL,NULL,0,100,1,0,1682230836),(4130,133,87,'路易斯·康','by Louis Kahn',NULL,NULL,0,100,1,0,1682230836),(4131,7,39,'深水','deep water',NULL,NULL,0,100,1,0,1682230836),(4132,7,39,'沙漠','desert',NULL,NULL,0,100,1,0,1682230836),(4133,7,39,'沙漠生态','desert ecology',NULL,NULL,0,100,1,0,1682230836),(4134,7,39,'沙漠星球','desert planet',NULL,NULL,0,100,1,0,1682230836),(4135,7,39,'沙漠沙','desert sand',NULL,NULL,0,100,1,0,1682230836),(4136,7,39,'干湖','dry lake',NULL,NULL,0,100,1,0,1682230836),(4137,7,39,'干旱地区','dry land',NULL,NULL,0,100,1,0,1682230836),(4138,7,39,'干旱地','dryland',NULL,NULL,0,100,1,0,1682230836),(4139,7,39,'沙丘','dune',NULL,NULL,0,100,1,0,1682230836),(4140,7,39,'尘暴','dust storm',NULL,NULL,0,100,1,0,1682230836),(4141,133,87,'路易斯·沙利文','by Louis Sullivan',NULL,NULL,0,100,1,0,1682230836),(4142,7,39,'地球','earth',NULL,NULL,0,100,1,0,1682230836),(4143,7,39,'地球的尽头（天涯海角）','ends of the earth',NULL,NULL,0,100,1,0,1682230836),(4144,7,39,'河口','estuary',NULL,NULL,0,100,1,0,1682230836),(4145,7,39,'田地','field',NULL,NULL,0,100,1,0,1682230836),(4146,7,39,'火海','firestorm',NULL,NULL,0,100,1,0,1682230836),(4147,7,39,'雾漠（云雾荒原）','fog desert',NULL,NULL,0,100,1,0,1682230836),(4148,7,39,'森林','forest',NULL,NULL,0,100,1,0,1682230836),(4149,7,39,'树冠','forest canopy',NULL,NULL,0,100,1,0,1682230836),(4150,7,39,'冰川','glacier',NULL,NULL,0,100,1,0,1682230836),(4151,7,39,'草地','grassland',NULL,NULL,0,100,1,0,1682230836),(4152,133,87,'路德维希·密斯·凡·德·罗','by Ludwig Mies van der Rohe',NULL,NULL,0,100,1,0,1682230836),(4153,16,95,'柔和的','mellow',NULL,NULL,0,100,1,0,1682230836),(4154,7,39,'绿林','greenwood',NULL,NULL,0,100,1,0,1682230836),(4156,7,39,'栖息地','habitat',NULL,NULL,0,100,1,0,1682230836),(4157,7,39,'悬谷','hanging valley',NULL,NULL,0,100,1,0,1682230836),(4158,7,39,'垂藤','hanging vines',NULL,NULL,0,100,1,0,1682230836),(4159,7,39,'地狱般的景色','hellscape',NULL,NULL,0,100,1,0,1682230836),(4160,7,39,'高地','highland',NULL,NULL,0,100,1,0,1682230836),(4161,7,39,'高原','highlands',NULL,NULL,0,100,1,0,1682230836),(4162,7,39,'山丘','hills',NULL,NULL,0,100,1,0,1682230836),(4163,7,39,'山坡','hillsides',NULL,NULL,0,100,1,0,1682230836),(4164,133,87,'马塞尔·布劳尔','by Marcel Breuer',NULL,NULL,0,100,1,0,1682230836),(4165,7,39,'山顶','hilltop',NULL,NULL,0,100,1,0,1682230836),(4166,7,39,'喜马拉雅山脉','himalayas',NULL,NULL,0,100,1,0,1682230836),(4167,7,39,'冰雪景色','icescape',NULL,NULL,0,100,1,0,1682230836),(4168,7,39,'水湾','inlet',NULL,NULL,0,100,1,0,1682230836),(4169,7,39,'岛屿','island',NULL,NULL,0,100,1,0,1682230836),(4170,7,39,'日式花园','japanese gardens',NULL,NULL,0,100,1,0,1682230836),(4171,7,39,'丛林','jungle',NULL,NULL,0,100,1,0,1682230836),(4173,7,39,'迷宫','labyrinth',NULL,NULL,0,100,1,0,1682230836),(4174,7,39,'泻湖','lagoon',NULL,NULL,0,100,1,0,1682230836),(4175,133,87,'迈克尔·格雷夫斯','by Michael Graves',NULL,NULL,0,100,1,0,1682230836),(4176,7,39,'巢穴','lair',NULL,NULL,0,100,1,0,1682230836),(4177,7,39,'湖滨','lakefront',NULL,NULL,0,100,1,0,1682230836),(4178,7,39,'湖岸','lakeshore',NULL,NULL,0,100,1,0,1682230836),(4179,7,39,'湖边','lakeside',NULL,NULL,0,100,1,0,1682230836),(4180,7,39,'陆地','landmass',NULL,NULL,0,100,1,0,1682230836),(4181,7,39,'湖泊','loch',NULL,NULL,0,100,1,0,1682230836),(4182,7,39,'朗斯峰','longs peak',NULL,NULL,0,100,1,0,1682230836),(4184,7,39,'庞大的草原','mammoth steppe',NULL,NULL,0,100,1,0,1682230836),(4185,7,39,'沼泽','marsh',NULL,NULL,0,100,1,0,1682230836),(4186,7,39,'火星的','martian',NULL,NULL,0,100,1,0,1682230836),(4187,7,39,'马特洪峰','matterhorn',NULL,NULL,0,100,1,0,1682230836),(4188,7,39,'牧草地','meadows',NULL,NULL,0,100,1,0,1682230836),(4189,7,39,'苔藓覆盖的','mossy',NULL,NULL,0,100,1,0,1682230836),(4190,7,39,'土堆','mounds',NULL,NULL,0,100,1,0,1682230836),(4191,7,39,'多山的','mountainous',NULL,NULL,0,100,1,0,1682230836),(4192,7,39,'山脉','mountains',NULL,NULL,0,100,1,0,1682230836),(4193,7,39,'山顶','mountaintop',NULL,NULL,0,100,1,0,1682230836),(4194,7,39,'珠穆朗玛峰','mt everest',NULL,NULL,0,100,1,0,1682230836),(4195,133,87,'米马尔·西南','by Mimar Sinan',NULL,NULL,0,100,1,0,1682230836),(4196,7,43,'冥界','netherworld',NULL,NULL,0,100,1,0,1682230836),(4197,7,39,'绿洲','oasis',NULL,NULL,0,100,1,0,1682230836),(4198,7,39,'海底','ocean floor',NULL,NULL,0,100,1,0,1682230836),(4199,7,39,'洋盆','oceanic basin',NULL,NULL,0,100,1,0,1682230836),(4200,7,39,'海洋性','oceanicity',NULL,NULL,0,100,1,0,1682230836),(4201,7,39,'海沟','oceanic trench',NULL,NULL,0,100,1,0,1682230836),(4202,7,39,'海洋学的','oceanographic',NULL,NULL,0,100,1,0,1682230836),(4203,7,39,'海洋','oceans',NULL,NULL,0,100,1,0,1682230836),(4204,7,39,'海洋世界','ocean world',NULL,NULL,0,100,1,0,1682230836),(4205,7,39,'近海的','offshore',NULL,NULL,0,100,1,0,1682230836),(4206,133,87,'莫舍·萨夫迪','by Moshe Safdie',NULL,NULL,0,100,1,0,1682230836),(4207,7,39,'原始森林','old growth',NULL,NULL,0,100,1,0,1682230836),(4208,7,39,'公海','open sea',NULL,NULL,0,100,1,0,1682230836),(4209,7,39,'内地的','outback',NULL,NULL,0,100,1,0,1682230836),(4210,7,39,'太平洋','pacific ocean',NULL,NULL,0,100,1,0,1682230836),(4211,7,39,'牧场','pasture',NULL,NULL,0,100,1,0,1682230836),(4212,7,39,'山峰','peaks',NULL,NULL,0,100,1,0,1682230836),(4213,7,39,'半岛','peninsula',NULL,NULL,0,100,1,0,1682230836),(4214,7,39,'池塘','pond',NULL,NULL,0,100,1,0,1682230836),(4215,7,39,'水池','pool',NULL,NULL,0,100,1,0,1682230836),(4216,7,39,'大草原','prairie',NULL,NULL,0,100,1,0,1682230836),(4217,133,87,'诺曼·福斯特','by Norman Foster',NULL,NULL,0,100,1,0,1682230836),(4218,7,39,'雨林','rainforest',NULL,NULL,0,100,1,0,1682230836),(4219,7,39,'峡谷','ravine',NULL,NULL,0,100,1,0,1682230836),(4220,7,39,'水稻田','rice paddy',NULL,NULL,0,100,1,0,1682230836),(4221,7,39,'山脊','ridge',NULL,NULL,0,100,1,0,1682230836),(4222,7,39,'河岸','riverbank',NULL,NULL,0,100,1,0,1682230836),(4223,7,39,'河流流域','river basin',NULL,NULL,0,100,1,0,1682230836),(4224,7,39,'河床','riverbed',NULL,NULL,0,100,1,0,1682230836),(4225,7,39,'洛矶山脉','rockies',NULL,NULL,0,100,1,0,1682230836),(4226,133,87,'奥斯卡·尼迈耶尔','by Oscar Niemeyer',NULL,NULL,0,100,1,0,1682230836),(4227,7,39,'岩地','rock land',NULL,NULL,0,100,1,0,1682230836),(4228,7,39,'岩石','rocks',NULL,NULL,0,100,1,0,1682230836),(4229,7,39,'岩石山脉','rocky mountains',NULL,NULL,0,100,1,0,1682230836),(4230,7,39,'撒哈拉沙漠','sahara',NULL,NULL,0,100,1,0,1682230836),(4232,7,39,'沙子','sand',NULL,NULL,0,100,1,0,1682230836),(4233,7,39,'沙柱','sand pillar',NULL,NULL,0,100,1,0,1682230836),(4234,7,39,'沙地','sandplain',NULL,NULL,0,100,1,0,1682230836),(4235,7,39,'沙尘暴','sandstorm',NULL,NULL,0,100,1,0,1682230836),(4236,7,39,'热带草原','savanna',NULL,NULL,0,100,1,0,1682230836),(4237,133,87,'彼得·祖姆托尔','by Peter Zumthor',NULL,NULL,0,100,1,0,1682230836),(4238,7,39,'焦土','scorched earth',NULL,NULL,0,100,1,0,1682230836),(4239,7,39,'海底','seabed',NULL,NULL,0,100,1,0,1682230836),(4240,7,39,'海上运输','sealift',NULL,NULL,0,100,1,0,1682230836),(4241,7,39,'海水','seawater',NULL,NULL,0,100,1,0,1682230836),(4242,7,39,'海道','seaway',NULL,NULL,0,100,1,0,1682230836),(4243,7,39,'海岸','shore',NULL,NULL,0,100,1,0,1682230836),(4244,7,39,'海岸线','shoreline',NULL,NULL,0,100,1,0,1682230836),(4245,7,39,'锡耶拉山脉','sierra',NULL,NULL,0,100,1,0,1682230836),(4246,7,39,'海峡','strait',NULL,NULL,0,100,1,0,1682230836),(4247,133,87,'菲利普·约翰逊','by Philip Johnson',NULL,NULL,0,100,1,0,1682230836),(4248,7,39,'溪流','stream',NULL,NULL,0,100,1,0,1682230836),(4249,7,39,'立木','stumpage',NULL,NULL,0,100,1,0,1682230836),(4250,7,39,'亚沙漠','subdesert',NULL,NULL,0,100,1,0,1682230836),(4251,7,39,'此生山地','submountain',NULL,NULL,0,100,1,0,1682230836),(4252,7,39,'山顶','summit',NULL,NULL,0,100,1,0,1682230836),(4253,7,39,'山巅','summits',NULL,NULL,0,100,1,0,1682230836),(4254,7,39,'沼泽地','swamp',NULL,NULL,0,100,1,0,1682230836),(4255,7,39,'台山','table mountain',NULL,NULL,0,100,1,0,1682230836),(4256,7,39,'灌木丛','thicket',NULL,NULL,0,100,1,0,1682230836),(4257,7,39,'木材','timber',NULL,NULL,0,100,1,0,1682230836),(4258,133,87,'雷姆·库哈斯','by Rem Koolhaas',NULL,NULL,0,100,1,0,1682230836),(4259,7,39,'林地','timberland',NULL,NULL,0,100,1,0,1682230836),(4260,7,39,'热带的','tropical',NULL,NULL,0,100,1,0,1682230836),(4262,7,39,'林下植被','undergrowth',NULL,NULL,0,100,1,0,1682230836),(4263,7,39,'水下','underwater',NULL,NULL,0,100,1,0,1682230836),(4265,7,39,'乌拉尔山脉','urals',NULL,NULL,0,100,1,0,1682230836),(4266,7,39,'死亡之谷','valley of death',NULL,NULL,0,100,1,0,1682230836),(4267,7,39,'原始森林','virgin forest',NULL,NULL,0,100,1,0,1682230836),(4268,133,87,'伦佐·皮亚诺','by Renzo Piano',NULL,NULL,0,100,1,0,1682230836),(4269,7,39,'火山的','volcanic',NULL,NULL,0,100,1,0,1682230836),(4270,7,39,'火山','volcano',NULL,NULL,0,100,1,0,1682230836),(4271,7,39,'瀑布','waterfalls',NULL,NULL,0,100,1,0,1682230836),(4272,7,39,'水边','waters edge',NULL,NULL,0,100,1,0,1682230836),(4273,7,39,'分水岭','watershed',NULL,NULL,0,100,1,0,1682230836),(4274,7,39,'水路','waterway',NULL,NULL,0,100,1,0,1682230836),(4275,7,43,'水下坟墓','watery grave',NULL,NULL,0,100,1,0,1682230836),(4276,7,39,'湿地','wetland',NULL,NULL,0,100,1,0,1682230836),(4277,7,39,'急流','whitewater rapids',NULL,NULL,0,100,1,0,1682230836),(4278,133,87,'理查德·迈耶','by Richard Meier',NULL,NULL,0,100,1,0,1682230836),(4279,7,39,'荒野','wilderness',NULL,NULL,0,100,1,0,1682230836),(4280,7,39,'野火','wildfire',NULL,NULL,0,100,1,0,1682230836),(4284,7,39,'树林','woods',NULL,NULL,0,100,1,0,1682230836),(4285,7,39,'多木的','woody',NULL,NULL,0,100,1,0,1682230836),(4286,133,40,'筒仓','silo',NULL,NULL,0,100,1,0,1682230836),(4287,133,40,'遥远的小屋','afar hut',NULL,NULL,0,100,1,0,1682230836),(4288,133,40,'一字形框架','a frame',NULL,NULL,0,100,1,0,1682230836),(4289,133,87,'理查德·罗杰斯','by Richard Rogers',NULL,NULL,0,100,1,0,1682230836),(4290,133,40,'公寓楼','apartment building',NULL,NULL,0,100,1,0,1682230836),(4291,133,40,'公寓','apartments',NULL,NULL,0,100,1,0,1682230836),(4292,133,40,'建筑的','architectural',NULL,NULL,0,100,1,0,1682230836),(4293,133,40,'拱门','archways',NULL,NULL,0,100,1,0,1682230836),(4294,133,40,'军用小屋','army hut',NULL,NULL,0,100,1,0,1682230836),(4295,133,40,'谷仓','barn',NULL,NULL,0,100,1,0,1682230836),(4296,133,40,'兵营','barrack',NULL,NULL,0,100,1,0,1682230836),(4297,133,40,'警察局','bobby station',NULL,NULL,0,100,1,0,1682230836),(4298,133,40,'波马（非洲圆形栅栏）','boma',NULL,NULL,0,100,1,0,1682230836),(4299,133,40,'建筑物','building',NULL,NULL,0,100,1,0,1682230836),(4300,133,87,'圣地亚哥·卡拉特拉瓦','by Santiago Calatrava',NULL,NULL,0,100,1,0,1682230836),(4301,133,40,'平房','bungalow',NULL,NULL,0,100,1,0,1682230836),(4302,133,40,'集体寝室','bunkhouse',NULL,NULL,0,100,1,0,1682230836),(4303,133,40,'小木屋','cabana',NULL,NULL,0,100,1,0,1682230836),(4304,133,40,'小屋','cabin',NULL,NULL,0,100,1,0,1682230836),(4305,133,40,'营地','camp',NULL,NULL,0,100,1,0,1682230836),(4306,133,40,'营地','campsite',NULL,NULL,0,100,1,0,1682230836),(4307,133,40,'校园','campus',NULL,NULL,0,100,1,0,1682230836),(4308,133,40,'木屋','chalet',NULL,NULL,0,100,1,0,1682230836),(4309,133,40,'城市','city',NULL,NULL,0,100,1,0,1682230836),(4310,133,40,'城市街区','city block',NULL,NULL,0,100,1,0,1682230836),(4311,133,87,'板志东','by Shigeru Ban',NULL,NULL,0,100,1,0,1682230836),(4312,133,40,'城市监狱','city jail',NULL,NULL,0,100,1,0,1682230836),(4313,133,40,'城市景观','cityscape',NULL,NULL,0,100,1,0,1682230836),(4314,133,40,'市民中心','civic center',NULL,NULL,0,100,1,0,1682230836),(4315,133,40,'俱乐部会所','clubhouse',NULL,NULL,0,100,1,0,1682230836),(4316,133,40,'社区中心','community center',NULL,NULL,0,100,1,0,1682230836),(4317,133,40,'厨房','cookhouse',NULL,NULL,0,100,1,0,1682230836),(4318,133,40,'鸡舍','coop',NULL,NULL,0,100,1,0,1682230836),(4319,133,40,'村舍','cottage',NULL,NULL,0,100,1,0,1682230836),(4320,133,40,'牛舍','cowshed',NULL,NULL,0,100,1,0,1682230836),(4321,133,40,'小隔间','cubicle',NULL,NULL,0,100,1,0,1682230836),(4322,133,87,'安藤忠雄','by Tadao Ando',NULL,NULL,0,100,1,0,1682230836),(4323,133,40,'路缘','curb',NULL,NULL,0,100,1,0,1682230836),(4324,133,40,'自行车道','cycle track',NULL,NULL,0,100,1,0,1682230836),(4325,133,40,'大使馆','embassy',NULL,NULL,0,100,1,0,1682230836),(4326,133,40,'庄园','estate',NULL,NULL,0,100,1,0,1682230836),(4327,133,40,'外部','exterior',NULL,NULL,0,100,1,0,1682230836),(4328,133,40,'农舍','farmhouse',NULL,NULL,0,100,1,0,1682230836),(4329,133,40,'田野小屋','field hut',NULL,NULL,0,100,1,0,1682230836),(4330,133,40,'消防局','fire department',NULL,NULL,0,100,1,0,1682230836),(4331,133,40,'消防站','fire station',NULL,NULL,0,100,1,0,1682230836),(4332,133,40,'客房','guesthouse',NULL,NULL,0,100,1,0,1682230836),(4333,133,87,'汤姆·赖特','by Tom Wright',NULL,NULL,0,100,1,0,1682230836),(4334,133,40,'健身房','gym',NULL,NULL,0,100,1,0,1682230836),(4335,133,40,'档案馆','hall of records',NULL,NULL,0,100,1,0,1682230836),(4336,133,40,'避风港','haven',NULL,NULL,0,100,1,0,1682230836),(4337,133,40,'鸡舍','henhouse',NULL,NULL,0,100,1,0,1682230836),(4338,133,40,'隐居处','hideaway',NULL,NULL,0,100,1,0,1682230836),(4339,133,40,'隐藏地','hideout',NULL,NULL,0,100,1,0,1682230836),(4340,133,40,'高楼大厦','highrise',NULL,NULL,0,100,1,0,1682230836),(4341,133,40,'哈比屋','hobbit house',NULL,NULL,0,100,1,0,1682230836),(4342,133,40,'住宅','homes',NULL,NULL,0,100,1,0,1682230836),(4343,133,40,'青年旅舍','hostel',NULL,NULL,0,100,1,0,1682230836),(4344,133,87,'威廉·F·兰姆','by William F Lamb',NULL,NULL,0,100,1,0,1682230836),(4345,133,40,'房屋','house',NULL,NULL,0,100,1,0,1682230836),(4346,133,40,'破屋','hovel',NULL,NULL,0,100,1,0,1682230836),(4347,133,40,'小屋','hut',NULL,NULL,0,100,1,0,1682230836),(4348,133,40,'小屋','hutment',NULL,NULL,0,100,1,0,1682230836),(4349,133,40,'冰屋','igloo',NULL,NULL,0,100,1,0,1682230836),(4350,133,40,'内部','interior',NULL,NULL,0,100,1,0,1682230836),(4351,133,40,'飞机跑道','landing strip',NULL,NULL,0,100,1,0,1682230836),(4352,133,40,'地标','landmark',NULL,NULL,0,100,1,0,1682230836),(4353,133,40,'小屋','lodge',NULL,NULL,0,100,1,0,1682230836),(4354,133,40,'圆木屋','log cabin',NULL,NULL,0,100,1,0,1682230836),(4355,133,87,'扎哈·哈迪德','by Zaha Hadid',NULL,NULL,0,100,1,0,1682230836),(4356,133,40,'长屋','longhouse',NULL,NULL,0,100,1,0,1682230836),(4357,133,40,'商场','mall',NULL,NULL,0,100,1,0,1682230836),(4358,133,40,'大厦','mansion',NULL,NULL,0,100,1,0,1682230836),(4359,133,40,'纪念碑','monument',NULL,NULL,0,100,1,0,1682230836),(4360,133,40,'市政建筑','municipal building',NULL,NULL,0,100,1,0,1682230836),(4361,133,40,'蘑菇屋','mushroom home',NULL,NULL,0,100,1,0,1682230836),(4363,133,40,'报社','newspaper agency',NULL,NULL,0,100,1,0,1682230836),(4364,133,40,'办公室','office',NULL,NULL,0,100,1,0,1682230836),(4365,133,40,'办公楼','office building',NULL,NULL,0,100,1,0,1682230836),(4366,133,87,'阿尔瓦罗·西扎','by Alvaro Siza',NULL,NULL,0,100,1,0,1682230836),(4367,16,95,'非暴力的','nonviolent',NULL,NULL,0,100,1,0,1682230836),(4368,133,40,'外屋','outbuilding',NULL,NULL,0,100,1,0,1682230836),(4369,133,40,'厕所','outhouse',NULL,NULL,0,100,1,0,1682230836),(4370,133,40,'宫殿','palace',NULL,NULL,0,100,1,0,1682230836),(4371,133,40,'停车场','parking lot',NULL,NULL,0,100,1,0,1682230836),(4372,133,40,'码头','pier',NULL,NULL,0,100,1,0,1682230836),(4373,133,40,'警察亭','police kiosk',NULL,NULL,0,100,1,0,1682230836),(4374,133,40,'邮局','post office',NULL,NULL,0,100,1,0,1682230836),(4375,133,40,'发电站','power station',NULL,NULL,0,100,1,0,1682230836),(4376,133,40,'监狱','prison',NULL,NULL,0,100,1,0,1682230836),(4377,133,40,'半圆拱形活动房屋','quonset',NULL,NULL,0,100,1,0,1682230836),(4378,133,40,'康复中心','rehabilitation center',NULL,NULL,0,100,1,0,1682230836),(4379,133,40,'住所','residence',NULL,NULL,0,100,1,0,1682230836),(4380,133,40,'住宅的','residential',NULL,NULL,0,100,1,0,1682230836),(4381,133,40,'屋顶','roofs',NULL,NULL,0,100,1,0,1682230836),(4382,133,40,'屋顶','rooftops',NULL,NULL,0,100,1,0,1682230836),(4383,133,40,'小屋','shack',NULL,NULL,0,100,1,0,1682230836),(4384,133,40,'简陋的小屋','shanty',NULL,NULL,0,100,1,0,1682230836),(4385,133,40,'棚子','shed',NULL,NULL,0,100,1,0,1682230836),(4386,133,40,'庇护所','shelter',NULL,NULL,0,100,1,0,1682230836),(4387,133,40,'购物中心','shopping center',NULL,NULL,0,100,1,0,1682230836),(4388,12,88,'阿尔弗雷德·斯蒂格利茨','by Alfred Stieglitz',NULL,NULL,0,100,1,0,1682230836),(4389,133,40,'摩天大楼','skyscraper',NULL,NULL,0,100,1,0,1682230836),(4390,133,40,'马厩','stables',NULL,NULL,0,100,1,0,1682230836),(4391,133,40,'门廊','stoep',NULL,NULL,0,100,1,0,1682230836),(4392,133,40,'商业区','stripmall',NULL,NULL,0,100,1,0,1682230836),(4393,133,40,'锥形帐篷','teepee',NULL,NULL,0,100,1,0,1682230836),(4394,133,40,'寺庙','temple',NULL,NULL,0,100,1,0,1682230836),(4395,133,40,'帐篷','tent',NULL,NULL,0,100,1,0,1682230836),(4396,133,40,'帐篷','tepee',NULL,NULL,0,100,1,0,1682230836),(4397,133,40,'茅草屋顶','thatched roof',NULL,NULL,0,100,1,0,1682230836),(4398,133,40,'小屋','tiny home',NULL,NULL,0,100,1,0,1682230836),(4399,133,40,'锥形帐篷','tipi',NULL,NULL,0,100,1,0,1682230836),(4400,133,40,'树屋','tree house',NULL,NULL,0,100,1,0,1682230836),(4401,133,40,'树屋','treehouse',NULL,NULL,0,100,1,0,1682230836),(4402,133,40,'阳台','veranda',NULL,NULL,0,100,1,0,1682230836),(4403,133,40,'别墅','villa',NULL,NULL,0,100,1,0,1682230836),(4404,133,40,'村庄','village',NULL,NULL,0,100,1,0,1682230836),(4405,133,40,'仓库','warehouse',NULL,NULL,0,100,1,0,1682230836),(4406,133,40,'温迪屋','wendy house',NULL,NULL,0,100,1,0,1682230836),(4407,133,40,'茅草屋','wigwam',NULL,NULL,0,100,1,0,1682230836),(4408,133,40,'蒙古包','yurt',NULL,NULL,0,100,1,0,1682230836),(4409,12,88,'安德烈·科尔特兹','by Andre Kertesz',NULL,NULL,0,100,1,0,1682230836),(4410,7,41,'小巷','alley',NULL,NULL,0,100,1,0,1682230836),(4411,7,41,'马路','carriageway',NULL,NULL,0,100,1,0,1682230836),(4412,7,41,'车道','driveway',NULL,NULL,0,100,1,0,1682230836),(4413,7,41,'高速公路','expressway',NULL,NULL,0,100,1,0,1682230836),(4414,7,41,'步道','foot path',NULL,NULL,0,100,1,0,1682230836),(4415,7,41,'栏杆','footrail',NULL,NULL,0,100,1,0,1682230836),(4416,7,41,'高速公路','freeway',NULL,NULL,0,100,1,0,1682230836),(4417,7,41,'公路','highway',NULL,NULL,0,100,1,0,1682230836),(4418,7,41,'公园大道','parkway',NULL,NULL,0,100,1,0,1682230836),(4419,7,41,'通道','passageway',NULL,NULL,0,100,1,0,1682230836),(4420,7,41,'小路','path',NULL,NULL,0,100,1,0,1682230836),(4423,7,41,'铁路','railroad',NULL,NULL,0,100,1,0,1682230836),(4425,7,41,'斜坡','rampway',NULL,NULL,0,100,1,0,1682230836),(4427,7,41,'路边','roadside',NULL,NULL,0,100,1,0,1682230836),(4428,7,41,'道路','roadway',NULL,NULL,0,100,1,0,1682230836),(4429,7,41,'绳索走廊','ropewalk',NULL,NULL,0,100,1,0,1682230836),(4430,12,88,'安妮·莱博维茨','by Annie Leibovitz',NULL,NULL,0,100,1,0,1682230836),(4431,7,41,'跑道','runway',NULL,NULL,0,100,1,0,1682230836),(4432,7,41,'人行道','sidewalk',NULL,NULL,0,100,1,0,1682230836),(4433,7,41,'楼梯','staircase',NULL,NULL,0,100,1,0,1682230836),(4436,7,41,'街道','street',NULL,NULL,0,100,1,0,1682230836),(4437,7,41,'地铁','subway',NULL,NULL,0,100,1,0,1682230836),(4438,7,41,'滑行道','taxiway',NULL,NULL,0,100,1,0,1682230836),(4439,7,41,'塔楼','tower',NULL,NULL,0,100,1,0,1682230836),(4440,7,41,'交通','traffic',NULL,NULL,0,100,1,0,1682230836),(4441,12,88,'安塞尔·亚当斯','by Ansel Adams',NULL,NULL,0,100,1,0,1682230836),(4443,7,41,'步道','walkway',NULL,NULL,0,100,1,0,1682230836),(4445,7,42,'古罗马庙宇','ancient roman temple',NULL,NULL,0,100,1,0,1682230836),(4449,7,42,'佛教寺庙','buddhist temple',NULL,NULL,0,100,1,0,1682230836),(4450,7,42,'佛塔','candi',NULL,NULL,0,100,1,0,1682230836),(4451,7,42,'大教堂','cathedral',NULL,NULL,0,100,1,0,1682230836),(4452,12,88,'阿诺德·纽曼','by Arnold Newman',NULL,NULL,0,100,1,0,1682230836),(4453,7,42,'窗洞佛塔','chaitya',NULL,NULL,0,100,1,0,1682230836),(4454,7,42,'小礼拜堂','chapel',NULL,NULL,0,100,1,0,1682230836),(4455,7,42,'教堂','church',NULL,NULL,0,100,1,0,1682230836),(4457,7,42,'道观寺庙','daoguan temple',NULL,NULL,0,100,1,0,1682230836),(4458,7,42,'德拉萨尔庙宇','derasar temple',NULL,NULL,0,100,1,0,1682230836),(4459,7,42,'火庙','fire temple',NULL,NULL,0,100,1,0,1682230836),(4460,7,42,'希腊庙宇','greek temple',NULL,NULL,0,100,1,0,1682230836),(4461,7,42,'古尔德瓦拉寺庙','gurdwara temple',NULL,NULL,0,100,1,0,1682230836),(4462,7,42,'印度教寺庙','hindu temple',NULL,NULL,0,100,1,0,1682230836),(4463,12,88,'布拉赛','by Brassai',NULL,NULL,0,100,1,0,1682230836),(4464,7,42,'伊巴达特·哈纳（信仰之屋）','ibadat khana',NULL,NULL,0,100,1,0,1682230836),(4465,7,42,'耆那教寺庙','jain temple',NULL,NULL,0,100,1,0,1682230836),(4468,7,42,'寺庙','mandir',NULL,NULL,0,100,1,0,1682230836),(4470,7,42,'礼拜堂','meeting house',NULL,NULL,0,100,1,0,1682230836),(4471,7,42,'尖塔','minaret',NULL,NULL,0,100,1,0,1682230836),(4472,7,42,'弥特拉神庙','mithraeum',NULL,NULL,0,100,1,0,1682230836),(4473,7,42,'清真寺','mosques',NULL,NULL,0,100,1,0,1682230836),(4474,12,88,'布鲁斯·吉尔登','by Bruce Gilden',NULL,NULL,0,100,1,0,1682230836),(4475,16,95,'有序的','orderly',NULL,NULL,0,100,1,0,1682230836),(4476,7,42,'北欧宫殿','norse hof',NULL,NULL,0,100,1,0,1682230836),(4477,7,42,'北欧异教徒','norse pagan',NULL,NULL,0,100,1,0,1682230836),(4478,7,42,'塔楼','pagoda',NULL,NULL,0,100,1,0,1682230836),(4479,7,42,'圣髑盒','reliquary',NULL,NULL,0,100,1,0,1682230836),(4480,7,42,'罗马庙宇','roman temple',NULL,NULL,0,100,1,0,1682230836),(4481,7,42,'神圣空间','sacred space',NULL,NULL,0,100,1,0,1682230836),(4482,7,42,'苏格兰教堂','scottish kirk',NULL,NULL,0,100,1,0,1682230836),(4483,7,42,'神道教','shinto',NULL,NULL,0,100,1,0,1682230836),(4484,7,42,'神社','shrine',NULL,NULL,0,100,1,0,1682230836),(4485,7,42,'锡克教寺庙','sikhism temple',NULL,NULL,0,100,1,0,1682230836),(4486,12,88,'布鲁斯·韦伯','by Bruce Weber',NULL,NULL,0,100,1,0,1682230836),(4487,7,42,'道教寺庙','taoist temple',NULL,NULL,0,100,1,0,1682230836),(4488,7,42,'越南基督教','Vietnamese Christianity',NULL,NULL,0,100,1,0,1682230836),(4489,7,42,'禅寺','vihara',NULL,NULL,0,100,1,0,1682230836),(4490,7,42,'佛寺','wat',NULL,NULL,0,100,1,0,1682230836),(4491,7,42,'威尔士礼拜堂','welsh capel',NULL,NULL,0,100,1,0,1682230836),(4492,7,44,'房间','room',NULL,NULL,0,100,1,0,1682230836),(4493,7,44,'里面','inside',NULL,NULL,0,100,1,0,1682230836),(4494,7,44,'内部','internal',NULL,NULL,0,100,1,0,1682230836),(4495,7,44,'外面','outside',NULL,NULL,0,100,1,0,1682230836),(4496,7,44,'外部','external',NULL,NULL,0,100,1,0,1682230836),(4497,7,44,'酒店房间','hotelroom',NULL,NULL,0,100,1,0,1682230836),(4498,7,44,'公寓','apartment',NULL,NULL,0,100,1,0,1682230836),(4499,7,44,'客厅','livingroom',NULL,NULL,0,100,1,0,1682230836),(4500,7,44,'休息室','lounge',NULL,NULL,0,100,1,0,1682230836),(4501,7,44,'书房','den',NULL,NULL,0,100,1,0,1682230836),(4502,7,44,'前厅','frontroom',NULL,NULL,0,100,1,0,1682230836),(4503,7,44,'餐厅','diningroom',NULL,NULL,0,100,1,0,1682230836),(4504,7,44,'厨房','kitchen',NULL,NULL,0,100,1,0,1682230836),(4505,12,88,'大卫·贝利','by David Bailey',NULL,NULL,0,100,1,0,1682230836),(4506,7,44,'卧室','bedroom',NULL,NULL,0,100,1,0,1682230836),(4507,7,44,'客房','guestroom',NULL,NULL,0,100,1,0,1682230836),(4508,7,44,'浴室','bathroom',NULL,NULL,0,100,1,0,1682230836),(4509,7,44,'走廊','hallway',NULL,NULL,0,100,1,0,1682230836),(4510,7,44,'温室','greenhouse',NULL,NULL,0,100,1,0,1682230836),(4511,7,44,'中庭','atrium',NULL,NULL,0,100,1,0,1682230836),(4512,7,44,'温室','conservatory',NULL,NULL,0,100,1,0,1682230836),(4513,7,44,'阳光房','sunroom',NULL,NULL,0,100,1,0,1682230836),(4514,7,44,'书房','study',NULL,NULL,0,100,1,0,1682230836),(4515,12,88,'大卫·拉沙贝尔','by David LaChapelle',NULL,NULL,0,100,1,0,1682230836),(4516,7,44,'图书馆','library',NULL,NULL,0,100,1,0,1682230836),(4517,7,44,'家庭办公室','homeoffice',NULL,NULL,0,100,1,0,1682230836),(4518,7,44,'阁楼','attic',NULL,NULL,0,100,1,0,1682230836),(4519,7,44,'狭小空隙','crawlspace',NULL,NULL,0,100,1,0,1682230836),(4520,7,44,'地下室','basement',NULL,NULL,0,100,1,0,1682230836),(4521,7,44,'地窖','cellar',NULL,NULL,0,100,1,0,1682230836),(4522,7,44,'酒窖','winecellar',NULL,NULL,0,100,1,0,1682230836),(4523,7,44,'屋顶','rooftop',NULL,NULL,0,100,1,0,1682230836),(4524,7,44,'地下的','underground',NULL,NULL,0,100,1,0,1682230836),(4525,12,88,'黛安·阿勃斯','by Diane Arbus',NULL,NULL,0,100,1,0,1682230836),(4526,7,44,'储藏室','storageroom',NULL,NULL,0,100,1,0,1682230836),(4527,7,44,'衣橱','closet',NULL,NULL,0,100,1,0,1682230836),(4529,133,55,'巴厘岛建筑','balinese architecture',NULL,NULL,0,100,1,0,1682230836),(4530,7,43,'结构','structure',NULL,NULL,0,100,1,0,1682230836),(4531,7,43,'结构性的','structural',NULL,NULL,0,100,1,0,1682230836),(4532,7,43,'脚手架','scaffolding',NULL,NULL,0,100,1,0,1682230836),(4533,7,43,'制造的','manufactured',NULL,NULL,0,100,1,0,1682230836),(4534,7,43,'临时的','makeshift',NULL,NULL,0,100,1,0,1682230836),(4535,12,88,'大克·埃杰顿','by Doc Edgerton',NULL,NULL,0,100,1,0,1682230836),(4536,7,43,'乐园','funhouse',NULL,NULL,0,100,1,0,1682230836),(4537,11,156,'青铜朋克','bronzepunk',NULL,NULL,0,100,1,0,1682230836),(4538,7,43,'玩具乐园','toyland',NULL,NULL,0,100,1,0,1682230836),(4539,11,156,'钢铁朋克','steelpunk',NULL,NULL,0,100,1,0,1682230836),(4540,7,43,'嘉年华','carnival',NULL,NULL,0,100,1,0,1682230836),(4541,11,156,'时钟朋克','clockpunk',NULL,NULL,0,100,1,0,1682230836),(4542,12,88,'唐·麦卡林','by Don McCullin',NULL,NULL,0,100,1,0,1682230836),(4543,11,156,'小工具朋克','gadgetpunk',NULL,NULL,0,100,1,0,1682230836),(4544,11,156,'废品朋克','salvagepunk',NULL,NULL,0,100,1,0,1682230836),(4545,11,156,'丝绸朋克','silkpunk',NULL,NULL,0,100,1,0,1682230836),(4546,7,43,'阶梯金字塔','ziggurat',NULL,NULL,0,100,1,0,1682230836),(4547,11,156,'凉鞋朋克','sandalpunk',NULL,NULL,0,100,1,0,1682230836),(4548,7,43,'工业设计','industrial design',NULL,NULL,0,100,1,0,1682230836),(4549,11,156,'盒式磁带朋克','cassettepunk',NULL,NULL,0,100,1,0,1682230836),(4550,7,43,'戈基风格','googie',NULL,NULL,0,100,1,0,1682230836),(4551,12,88,'多萝西娅·朗','by Dorothea Lange',NULL,NULL,0,100,1,0,1682230836),(4552,11,156,'弗米卡朋克','formicapunk',NULL,NULL,0,100,1,0,1682230836),(4553,7,43,'物业','property',NULL,NULL,0,100,1,0,1682230836),(4554,7,43,'公司','company',NULL,NULL,0,100,1,0,1682230836),(4555,7,43,'游乐场','playground',NULL,NULL,0,100,1,0,1682230836),(4556,7,43,'游泳池核心','poolcore',NULL,NULL,0,100,1,0,1682230836),(4557,7,43,'实验室核心','labcore',NULL,NULL,0,100,1,0,1682230836),(4558,7,43,'核能的','nuclear',NULL,NULL,0,100,1,0,1682230836),(4559,7,43,'机器','machine',NULL,NULL,0,100,1,0,1682230836),(4560,7,43,'子机','submachine',NULL,NULL,0,100,1,0,1682230836),(4561,7,43,'机械景观','machinescape',NULL,NULL,0,100,1,0,1682230836),(4562,12,88,'爱德华·柯蒂斯','by Edward Curtis',NULL,NULL,0,100,1,0,1682230836),(4563,7,43,'机器人的','robotic',NULL,NULL,0,100,1,0,1682230836),(4564,7,43,'机械人主义','cyborgism',NULL,NULL,0,100,1,0,1682230836),(4565,7,43,'自主的','autonomous',NULL,NULL,0,100,1,0,1682230836),(4566,7,43,'折腾核心','tinkercore',NULL,NULL,0,100,1,0,1682230836),(4567,7,43,'手工核心','craftcore',NULL,NULL,0,100,1,0,1682230836),(4568,7,43,'刺激波','stimwave',NULL,NULL,0,100,1,0,1682230836),(4569,7,43,'虫洞核心','wormcore',NULL,NULL,0,100,1,0,1682230836),(4570,7,43,'城市风景','urban scenery',NULL,NULL,0,100,1,0,1682230836),(4571,12,88,'爱德华·斯泰琴','by Edward Steichen',NULL,NULL,0,100,1,0,1682230836),(4572,16,95,'和平主义的','pacifistic',NULL,NULL,0,100,1,0,1682230836),(4573,7,43,'乡村田园','rural pastoral',NULL,NULL,0,100,1,0,1682230836),(4574,133,55,'宫殿建筑','palace architecture',NULL,NULL,0,100,1,0,1682230836),(4575,7,43,'星夜风景','starry night scenery',NULL,NULL,0,100,1,0,1682230836),(4576,7,43,'海洋风景','ocean scenery',NULL,NULL,0,100,1,0,1682230836),(4577,7,43,'景观','landscape',NULL,NULL,0,100,1,0,1682230836),(4578,7,43,'雪山冰川','snow mountain glacier',NULL,NULL,0,100,1,0,1682230836),(4579,7,43,'自然风景','natural scenery',NULL,NULL,0,100,1,0,1682230836),(4580,7,43,'工业工厂区域','industrial factory area',NULL,NULL,0,100,1,0,1682230836),(4581,7,43,'古堡遗址','ancient castle site',NULL,NULL,0,100,1,0,1682230836),(4582,7,43,'现代建筑','modern architecture',NULL,NULL,0,100,1,0,1682230836),(4583,12,88,'爱德华·韦斯顿','by Edward Weston',NULL,NULL,0,100,1,0,1682230836),(4584,7,43,'反乌托邦','dystopia',NULL,NULL,0,100,1,0,1682230836),(4585,7,43,'幻想','fantasy',NULL,NULL,0,100,1,0,1682230836),(4586,7,43,'现实主义','realism',NULL,NULL,0,100,1,0,1682230836),(4587,7,43,'异想天开地','whimsically',NULL,NULL,0,100,1,0,1682230836),(4588,7,43,'超现实主义','surrealism',NULL,NULL,0,100,1,0,1682230836),(4589,7,43,'超现实主义','hyperrealism',NULL,NULL,0,100,1,0,1682230836),(4590,7,43,'废墟','ruins',NULL,NULL,0,100,1,0,1682230836),(4591,7,43,'废弃城市建筑','deserted city buildings',NULL,NULL,0,100,1,0,1682230836),(4592,7,43,'近未来城市','near-future city',NULL,NULL,0,100,1,0,1682230836),(4593,7,43,'街头风景','street scenery',NULL,NULL,0,100,1,0,1682230836),(4594,7,43,'炼金术实验室','alchemy laboratory',NULL,NULL,0,100,1,0,1682230836),(4595,7,43,'宇宙','universe / cosmos',NULL,NULL,0,100,1,0,1682230836),(4596,7,43,'雨','rain',NULL,NULL,0,100,1,0,1682230836),(4597,7,43,'晨雾中','in the morning mist',NULL,NULL,0,100,1,0,1682230836),(4598,7,43,'充满阳光','full of sunlight',NULL,NULL,0,100,1,0,1682230836),(4599,7,43,'银河','galaxy',NULL,NULL,0,100,1,0,1682230836),(4600,7,43,'星云','nebula',NULL,NULL,0,100,1,0,1682230836),(4601,7,43,'海底，深海','undersea, deep sea',NULL,NULL,0,100,1,0,1682230836),(4602,7,43,'疯狂麦克斯','mad max',NULL,NULL,0,100,1,0,1682230836),(4603,12,88,'艾略特·波特','by Eliot Porter',NULL,NULL,0,100,1,0,1682230836),(4604,7,43,'巴比伦空中花园','hanging gardens of babylon',NULL,NULL,0,100,1,0,1682230836),(4605,7,43,'牧场','meadow',NULL,NULL,0,100,1,0,1682230836),(4606,7,43,'繁茂的自然','overgrown nature',NULL,NULL,0,100,1,0,1682230836),(4607,7,43,'浩劫后','post apocalyptic',NULL,NULL,0,100,1,0,1682230836),(4608,8,45,'20年代','20s',NULL,NULL,0,100,1,0,1682230836),(4609,8,45,'20年代图案','20s pattern',NULL,NULL,0,100,1,0,1682230836),(4610,8,45,'1920年代装饰风格','1920s decor',NULL,NULL,0,100,1,0,1682230836),(4611,8,45,'30年代','30s',NULL,NULL,0,100,1,0,1682230836),(4612,8,45,'30年代图案','30s pattern',NULL,NULL,0,100,1,0,1682230836),(4613,12,88,'艾略特·厄维特','by Elliott Erwitt',NULL,NULL,0,100,1,0,1682230836),(4614,8,45,'1930年代装饰风格','1930s decor',NULL,NULL,0,100,1,0,1682230836),(4615,8,45,'40年代','40s',NULL,NULL,0,100,1,0,1682230836),(4616,8,45,'40年代图案','40s pattern',NULL,NULL,0,100,1,0,1682230836),(4617,8,45,'1940年代装饰风格','1940s decor',NULL,NULL,0,100,1,0,1682230836),(4618,8,45,'50年代','50s',NULL,NULL,0,100,1,0,1682230836),(4619,8,45,'50年代图案','50s pattern',NULL,NULL,0,100,1,0,1682230836),(4620,8,45,'1950年代装饰风格','1950s decor',NULL,NULL,0,100,1,0,1682230836),(4621,8,45,'60年代','60s',NULL,NULL,0,100,1,0,1682230836),(4622,8,45,'60年代图案','60s pattern',NULL,NULL,0,100,1,0,1682230836),(4623,8,45,'1960年代装饰风格','1960s decor',NULL,NULL,0,100,1,0,1682230836),(4624,12,88,'伊芙·阿诺德','by Eve Arnold',NULL,NULL,0,100,1,0,1682230836),(4625,8,45,'70年代','70s',NULL,NULL,0,100,1,0,1682230836),(4626,8,45,'70年代图案','70s pattern',NULL,NULL,0,100,1,0,1682230836),(4627,8,45,'1970年代装饰风格','1970s decor',NULL,NULL,0,100,1,0,1682230836),(4628,8,45,'80年代','80s',NULL,NULL,0,100,1,0,1682230836),(4629,8,45,'80年代图案','80s pattern',NULL,NULL,0,100,1,0,1682230836),(4630,8,45,'1980年代装饰风格','1980s decor',NULL,NULL,0,100,1,0,1682230836),(4631,8,45,'90年代','90s',NULL,NULL,0,100,1,0,1682230836),(4632,8,45,'90年代图案','90s pattern',NULL,NULL,0,100,1,0,1682230836),(4633,8,45,'1990年代装饰风格','1990s decor',NULL,NULL,0,100,1,0,1682230836),(4634,8,45,'Y2K设计','y2k design',NULL,NULL,0,100,1,0,1682230836),(4635,12,88,'弗朗斯·兰廷','by Frans Lanting',NULL,NULL,0,100,1,0,1682230836),(4636,8,45,'Y2K图案','y2k pattern',NULL,NULL,0,100,1,0,1682230836),(4637,8,45,'2000年代图案','2000s pattern',NULL,NULL,0,100,1,0,1682230836),(4638,8,45,'2000年代装饰风格','2000s decor',NULL,NULL,0,100,1,0,1682230836),(4639,8,45,'2010年代装饰风格','2010s decor',NULL,NULL,0,100,1,0,1682230836),(4640,8,45,'2020年代装饰风格','2020s decor',NULL,NULL,0,100,1,0,1682230836),(4641,8,45,'1100年代','1100s',NULL,NULL,0,100,1,0,1682230836),(4642,8,45,'1200年代','1200s',NULL,NULL,0,100,1,0,1682230836),(4643,8,45,'1300年代','1300s',NULL,NULL,0,100,1,0,1682230836),(4644,8,45,'1400年代','1400s',NULL,NULL,0,100,1,0,1682230836),(4645,8,45,'1500年代','1500s',NULL,NULL,0,100,1,0,1682230836),(4646,12,88,'加里·维诺格兰','by Garry Winogrand',NULL,NULL,0,100,1,0,1682230836),(4647,8,45,'1600年代','1600s',NULL,NULL,0,100,1,0,1682230836),(4648,8,45,'1700年代','1700s',NULL,NULL,0,100,1,0,1682230836),(4649,8,45,'1800年代','1800s',NULL,NULL,0,100,1,0,1682230836),(4650,8,45,'1900年代','1900s',NULL,NULL,0,100,1,0,1682230836),(4651,8,45,'1950年代','1950s',NULL,NULL,0,100,1,0,1682230836),(4652,8,45,'1960年代','1960s',NULL,NULL,0,100,1,0,1682230836),(4653,8,45,'1970年代','1970s',NULL,NULL,0,100,1,0,1682230836),(4654,8,45,'1980年代','1980s',NULL,NULL,0,100,1,0,1682230836),(4655,8,45,'1990年代','1990s',NULL,NULL,0,100,1,0,1682230836),(4656,8,45,'2000年代','2000s',NULL,NULL,0,100,1,0,1682230836),(4657,12,88,'赫尔穆特·纽顿','by Helmut Newton',NULL,NULL,0,100,1,0,1682230836),(4658,8,45,'3000年代','3000s',NULL,NULL,0,100,1,0,1682230836),(4659,8,45,'4000年代','4000s',NULL,NULL,0,100,1,0,1682230836),(4660,8,45,'5000年代','5000s',NULL,NULL,0,100,1,0,1682230836),(4661,8,45,'1000年代','1000s',NULL,NULL,0,100,1,0,1682230836),(4662,8,45,'100年代','100s',NULL,NULL,0,100,1,0,1682230836),(4663,8,45,'1910年代','1910s',NULL,NULL,0,100,1,0,1682230836),(4664,8,45,'1940年代','1940s',NULL,NULL,0,100,1,0,1682230836),(4665,8,45,'200年代','200s',NULL,NULL,0,100,1,0,1682230836),(4666,12,88,'亨利·卡蒂埃-布列松','by Henri Cartier Bresson',NULL,NULL,0,100,1,0,1682230836),(4667,8,45,'2010年代','2010s',NULL,NULL,0,100,1,0,1682230836),(4668,8,45,'2020年代','2020s',NULL,NULL,0,100,1,0,1682230836),(4669,8,45,'300年代','300s',NULL,NULL,0,100,1,0,1682230836),(4670,8,45,'400年代','400s',NULL,NULL,0,100,1,0,1682230836),(4671,8,45,'500年代','500s',NULL,NULL,0,100,1,0,1682230836),(4672,8,45,'600年代','600s',NULL,NULL,0,100,1,0,1682230836),(4673,8,45,'700年代','700s',NULL,NULL,0,100,1,0,1682230836),(4674,8,45,'800年代','800s',NULL,NULL,0,100,1,0,1682230836),(4675,8,45,'900年代','900s',NULL,NULL,0,100,1,0,1682230836),(4676,8,45,'启蒙时代','age of enlightenment',NULL,NULL,0,100,1,0,1682230836);
/*!40000 ALTER TABLE `fox_chatgpt_draw_words` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_draw_words_cate`
--

DROP TABLE IF EXISTS `fox_chatgpt_draw_words_cate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_draw_words_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `weight` int(100) DEFAULT NULL,
  `is_show` tinyint(1) DEFAULT '1',
  `is_delete` tinyint(1) DEFAULT '0',
  `icon` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_draw_words_cate`
--

LOCK TABLES `fox_chatgpt_draw_words_cate` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_draw_words_cate` DISABLE KEYS */;
INSERT INTO `fox_chatgpt_draw_words_cate` VALUES (4,0,'动植物',NULL,800,1,0,NULL,1682229582),(5,0,'颜色',NULL,650,1,0,NULL,1682229582),(6,0,'材质',NULL,600,1,0,NULL,1682229582),(7,0,'场景',NULL,500,1,0,NULL,1682229582),(8,0,'时间',NULL,450,1,0,NULL,1682229582),(9,0,'视角',NULL,400,1,0,NULL,1682229582),(11,0,'视觉风格',NULL,300,1,0,NULL,1682229582),(12,0,'艺术形式',NULL,250,1,0,NULL,1682229582),(13,0,'画质渲染',NULL,348,1,0,NULL,1682229582),(14,0,'相机',NULL,350,1,0,NULL,1682229582),(15,0,'画家',NULL,200,1,0,NULL,1682229582),(16,0,'形容词',NULL,92,1,0,NULL,1682229582),(17,4,'宠物',NULL,91,1,0,NULL,1682229582),(18,4,'哺乳动物',NULL,90,1,0,NULL,1682229582),(19,4,'水生动物',NULL,89,1,0,NULL,1682229582),(20,4,'灭绝动物',NULL,80,1,0,NULL,1682229582),(21,4,'国外神话动物',NULL,84,1,0,NULL,1682229582),(22,4,'鸟类',NULL,88,1,0,NULL,1682229582),(23,4,'爬行动物',NULL,87,1,0,NULL,1682229582),(24,109,'食品',NULL,84,1,0,NULL,1682229582),(25,4,'植物',NULL,60,1,0,NULL,1682229582),(26,5,'基本颜色',NULL,82,1,0,NULL,1682229582),(28,5,'颜色方案',NULL,80,1,0,NULL,1682229582),(29,6,'金属',NULL,79,1,0,NULL,1682229582),(30,6,'宝石',NULL,78,1,0,NULL,1682229582),(31,6,'雾雪冰',NULL,77,1,0,NULL,1682229582),(32,6,'火',NULL,76,1,0,NULL,1682229582),(33,6,'毛皮头发',NULL,75,1,0,NULL,1682229582),(34,6,'纺织品',NULL,74,1,0,NULL,1682229582),(35,6,'木材和纸',NULL,73,1,0,NULL,1682229582),(36,6,'人造材料',NULL,72,1,0,NULL,1682229582),(37,6,'液体',NULL,71,1,0,NULL,1682229582),(39,7,'自然环境',NULL,800,1,0,NULL,1682229582),(40,133,'建筑物',NULL,999,1,0,NULL,1682229582),(41,7,'道路',NULL,67,1,0,NULL,1682229582),(42,7,'宗教场所',NULL,66,1,0,NULL,1682229582),(43,7,'其他场景',NULL,10,1,0,NULL,1682229582),(44,7,'房间',NULL,64,1,0,NULL,1682229582),(45,8,'时代',NULL,60,1,0,NULL,1682229582),(46,8,'天气',NULL,80,1,0,NULL,1682229582),(47,8,'时间',NULL,90,1,0,NULL,1682229582),(48,11,'常用风格',NULL,999,1,0,NULL,1682229582),(50,11,'电影风格',NULL,850,1,0,NULL,1682229582),(51,11,'游戏风格',NULL,950,1,0,NULL,1682229582),(52,11,'导演风格',NULL,40,1,0,NULL,1682229582),(53,11,'动画片风格',NULL,900,1,0,NULL,1682229582),(54,11,'动画工作室',NULL,950,1,0,NULL,1682229582),(55,133,'建筑风格',NULL,800,1,0,NULL,1682229582),(56,12,'特殊绘画',NULL,980,1,0,NULL,1682229582),(57,11,'数码艺术',NULL,90,1,0,NULL,1682229582),(58,11,'表现方式',NULL,80,1,0,NULL,1682229582),(59,11,'迷幻分形',NULL,70,1,0,NULL,1682229582),(61,12,'图案纹理',NULL,914,1,0,NULL,1682229582),(62,13,'渲染引擎',NULL,46,1,0,NULL,1682229582),(63,13,'画质形容词',NULL,45,1,0,NULL,1682229582),(64,13,'分辨率',NULL,44,1,0,NULL,1682229582),(65,13,'图像格式',NULL,43,1,0,NULL,1682229582),(67,14,'摄影机类型',NULL,41,1,0,NULL,1682229582),(69,14,'镜片',NULL,39,1,0,NULL,1682229582),(70,14,'摄影风格',NULL,37,1,0,NULL,1682229582),(71,15,'有名艺术家',NULL,37,1,0,NULL,1682229582),(73,15,'现代艺术家',NULL,35,1,0,NULL,1682229582),(74,15,'惊悚艺术家',NULL,34,1,0,NULL,1682229582),(75,15,'立体派艺术家',NULL,33,1,0,NULL,1682229582),(76,15,'幻想艺术家',NULL,32,1,0,NULL,1682229582),(77,15,'比喻艺术家',NULL,31,1,0,NULL,1682229582),(78,15,'印象艺术家',NULL,30,1,0,NULL,1682229582),(79,15,'景观艺术家',NULL,29,1,0,NULL,1682229582),(80,15,'照相写实艺术家',NULL,28,1,0,NULL,1682229582),(81,15,'波普艺术家',NULL,27,1,0,NULL,1682229582),(82,15,'肖像艺术家',NULL,26,1,0,NULL,1682229582),(83,15,'生活艺术家',NULL,25,1,0,NULL,1682229582),(84,15,'超现实主义艺术家',NULL,24,1,0,NULL,1682229582),(85,15,'城市艺术家',NULL,23,1,0,NULL,1682229582),(86,15,'野生动物',NULL,22,1,0,NULL,1682229582),(87,133,'建筑设计师',NULL,700,1,0,NULL,1682229582),(88,12,'摄影',NULL,915,1,0,NULL,1682229582),(89,124,'人物情绪',NULL,650,1,0,NULL,1682229582),(90,16,'细节形容词',NULL,18,1,0,NULL,1682229582),(91,16,'空灵形容词',NULL,17,1,0,NULL,1682229582),(92,16,'阴郁形容词',NULL,16,1,0,NULL,1682229582),(93,16,'漂亮形容词',NULL,15,1,0,NULL,1682229582),(94,16,'活力形容词',NULL,14,1,0,NULL,1682229582),(95,16,'舒适形容词',NULL,13,1,0,NULL,1682229582),(96,16,'常用形容词',NULL,990,1,0,NULL,1682229582),(97,14,'镜头',NULL,40,1,0,NULL,1682229582),(98,9,'视角',NULL,13,1,0,NULL,1682229582),(100,150,'日本漫画',NULL,999,1,0,NULL,1682229582),(101,142,'照明类型',NULL,0,1,0,NULL,1682741110),(109,0,'食物',NULL,700,1,0,NULL,1684643818),(110,124,'人物类型',NULL,900,1,0,NULL,1684645302),(113,124,'所在国家',NULL,14,1,0,NULL,1684646121),(114,124,'中国神话人物',NULL,890,1,0,NULL,1684646811),(115,0,'衣物',NULL,890,1,0,NULL,1685269870),(116,115,'上装',NULL,900,1,0,NULL,1685269993),(117,115,'下装 ',NULL,800,1,0,NULL,1685270004),(118,115,'裙装',NULL,700,1,0,NULL,1685270022),(119,115,'鞋袜',NULL,600,1,0,NULL,1685270044),(120,115,'帽子配饰 ',NULL,500,1,0,NULL,1685270053),(121,115,'风格与潮流',NULL,400,1,0,NULL,1685270069),(122,115,'制衣工艺',NULL,300,1,0,NULL,1685270130),(123,115,'营销文案',NULL,200,1,0,NULL,1685270160),(124,0,'人物',NULL,900,1,0,NULL,1685271822),(125,124,'外国神话人物',NULL,880,1,0,NULL,1685271949),(126,124,'人物发型',NULL,800,1,0,NULL,1685272425),(128,124,'人物姿势',NULL,600,1,0,NULL,1685272446),(129,8,'节日',NULL,70,1,0,NULL,1685274419),(130,109,'中国食物',NULL,0,1,0,NULL,1685326388),(131,12,'中国文化',NULL,0,1,0,NULL,1685326572),(132,4,'中国神话动物',NULL,85,1,0,NULL,1685327312),(133,0,'建筑',NULL,550,1,0,NULL,1685328418),(134,133,'家具家居',NULL,600,1,0,NULL,1685328609),(135,7,'自然现象',NULL,20,1,0,NULL,1685328852),(136,4,'十二生肖',NULL,79,1,0,NULL,1685335946),(138,124,'动漫人物',NULL,899,1,0,NULL,1688097580),(139,14,'摄影相关形容词',NULL,1,1,0,NULL,1688267563),(140,11,'主义派系',NULL,50,1,0,NULL,1689164606),(142,0,'照明',NULL,399,1,0,NULL,1697177211),(143,15,'知名设计师',NULL,990,1,0,NULL,1698316747),(144,12,'服装设计',NULL,913,1,0,NULL,1698316759),(145,150,'其他插画师',NULL,100,1,0,NULL,1698316783),(146,15,'其他画家',NULL,950,1,0,NULL,1698316798),(147,12,'版画',NULL,940,1,0,NULL,1698316812),(148,12,'雕塑风格',NULL,998,1,0,NULL,1698316831),(149,12,'街头艺术',NULL,930,1,0,NULL,1698316847),(150,0,'插画师',NULL,245,1,0,NULL,1698381408),(151,150,'欧美漫画',NULL,900,1,0,NULL,1698381428),(152,150,'知名插画师',NULL,890,1,0,NULL,1698381446),(155,12,'面具艺术',NULL,910,1,0,NULL,1698974868),(156,11,'朋克风格',NULL,750,1,0,NULL,1698975069),(157,11,'核心风格',NULL,700,1,0,NULL,1698976577),(158,12,'陶瓷玻璃',NULL,900,1,0,NULL,1698976885),(160,11,'艺术风格',NULL,975,1,0,NULL,1698981144),(161,11,'时尚风格',NULL,60,1,0,NULL,1698984269),(162,12,'绘画方式',NULL,990,1,0,NULL,1698991606),(163,12,'印刷',NULL,950,1,0,NULL,1698992075),(164,12,'工艺美术',NULL,995,1,0,NULL,1698993437),(165,12,'3D雕塑',NULL,999,1,0,NULL,1698994263),(166,15,'知名画家',NULL,989,1,0,NULL,1699073372);
/*!40000 ALTER TABLE `fox_chatgpt_draw_words_cate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_engine`
--

DROP TABLE IF EXISTS `fox_chatgpt_engine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_engine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT '1',
  `type` varchar(255) DEFAULT NULL,
  `maxlen` int(11) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_engine`
--

LOCK TABLES `fox_chatgpt_engine` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_engine` DISABLE KEYS */;
INSERT INTO `fox_chatgpt_engine` VALUES (1,'gpt-3.5-turbo','gpt-3.5-turbo',1,'openai3',4096),(2,'gpt-3.5-turbo-0613','gpt-3.5-turbo-0613',1,'openai3',4096),(3,'gpt-3.5-turbo-1106','gpt-3.5-turbo-1106',1,'openai3',4096),(4,'gpt-3.5-turbo-16k','gpt-3.5-turbo-16k',1,'openai3',16384),(5,'gpt-3.5-turbo-16k-0613','gpt-3.5-turbo-16k-0613',1,'openai3',16384),(6,'gpt-4','gpt-4',1,'openai4',8192),(7,'gpt-4-0613','gpt-4-0613',1,'openai4',8192),(8,'gpt-4-1106-preview','gpt-4-1106-preview',1,'openai4',8192),(9,'gpt-4-vision-preview','gpt-4-vision-preview',1,'openai4',32768),(10,'gpt-4-32k','gpt-4-32k',1,'openai4',32768),(11,'gpt-4-32k-0613','gpt-4-32k-0613',1,'openai4',32768),(12,'ERNIE-Bot','ERNIE-Bot',1,'wenxin',3000),(13,'ERNIE-Bot-turbo','ERNIE-Bot-turbo',1,'wenxin',3000),(14,'Llama-2-13b-chat','Llama-2-13b-chat',1,'wenxin',3000),(15,'Llama-2-70b-chat','Llama-2-70b-chat',1,'wenxin',3000),(16,'ChatGLM2-6B-32K','ChatGLM2-6B-32K',1,'wenxin',3000),(17,'ERNIE-Bot-4','ERNIE-Bot-4',1,'wenxin4',3000),(18,'gpt-3.5-turbo','gpt-3.5-turbo',1,'lxai',4096),(19,'gpt-3.5-turbo-0613','gpt-3.5-turbo-0613',1,'lxai',4096),(20,'gpt-3.5-turbo-16k','gpt-3.5-turbo-16k',1,'lxai',16384),(21,'gpt-3.5-turbo-16k-0613','gpt-3.5-turbo-16k-0613',1,'lxai',16384),(22,'星火认知大模型V1.5','general',1,'xunfei',4096),(23,'星火认知大模型V2.0','generalv2',1,'xunfei',8192),(24,'星火认知大模型V3.0','generalv3',1,'xunfei',8192),(25,'qwen-turbo','qwen-turbo',1,'tongyi',8192),(26,'qwen-plus','qwen-plus',1,'tongyi',32768),(27,'qwen-max（限时免费）','qwen-max',1,'tongyi',8192),(28,'qwen-max-1201（限时免费）','qwen-max-1201',1,'tongyi',8192),(29,'qwen-max-longcontext（限时免费）','qwen-max-longcontext',1,'tongyi',30720),(30,'ChatGLM-Turbo','chatglm_turbo',1,'zhipu',32768),(31,'claude-2','claude-2',1,'claude2',8192),(32,'claude-1','claude-instant-1',1,'claude2',8192),(33,'gpt-35-turbo','gpt-35-turbo',1,'azure_openai3',4096),(34,'gpt-35-turbo-16k','gpt-35-turbo-16k',1,'azure_openai3',16384),(35,'gpt-4','gpt-4',1,'azure_openai4',8192),(36,'gpt-4-32k','gpt-4-32k',1,'azure_openai4',32768),(37,'gpt-4-vision-preview','gpt-4-vision-preview',1,'azure_openai4',32768);
/*!40000 ALTER TABLE `fox_chatgpt_engine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_feedback`
--

DROP TABLE IF EXISTS `fox_chatgpt_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `content` text,
  `phone` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT '0' COMMENT '0未处理 1已处理',
  `is_delete` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_feedback`
--

LOCK TABLES `fox_chatgpt_feedback` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_goods`
--

DROP TABLE IF EXISTS `fox_chatgpt_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL COMMENT '产品标题',
  `price` int(11) DEFAULT '0' COMMENT '现价',
  `market_price` int(11) DEFAULT '0' COMMENT '市场价',
  `num` int(11) DEFAULT '0' COMMENT '条数',
  `hint` varchar(255) DEFAULT NULL,
  `desc` text,
  `sales` int(11) DEFAULT '0' COMMENT '销量',
  `status` tinyint(1) DEFAULT '1',
  `weight` int(11) DEFAULT '100' COMMENT '越大越靠前',
  `is_default` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_goods`
--

LOCK TABLES `fox_chatgpt_goods` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_goods` DISABLE KEYS */;
INSERT INTO `fox_chatgpt_goods` VALUES (1,1,'10条',200,500,10,NULL,NULL,0,1,100,1,NULL),(2,1,'50条',1000,2500,50,NULL,NULL,0,1,100,0,NULL),(3,1,'100条',2000,5000,100,NULL,NULL,0,1,100,0,NULL);
/*!40000 ALTER TABLE `fox_chatgpt_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_gpt4`
--

DROP TABLE IF EXISTS `fox_chatgpt_gpt4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_gpt4` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL COMMENT '产品标题',
  `price` int(11) DEFAULT '0' COMMENT '现价',
  `market_price` int(11) DEFAULT '0' COMMENT '市场价',
  `num` int(11) DEFAULT '0' COMMENT '条数',
  `hint` varchar(20) DEFAULT NULL,
  `desc` text,
  `sales` int(11) DEFAULT '0' COMMENT '销量',
  `status` tinyint(1) DEFAULT '1',
  `weight` int(11) DEFAULT '100' COMMENT '越大越靠前',
  `is_default` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_gpt4`
--

LOCK TABLES `fox_chatgpt_gpt4` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_gpt4` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_gpt4` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_keys`
--

DROP TABLE IF EXISTS `fox_chatgpt_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `type` varchar(20) DEFAULT 'openai',
  `key` varchar(1000) DEFAULT NULL,
  `state` tinyint(1) DEFAULT '1',
  `stop_reason` varchar(1000) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `last_time` int(11) DEFAULT '0' COMMENT '最后使用时间',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_keys`
--

LOCK TABLES `fox_chatgpt_keys` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_logs`
--

DROP TABLE IF EXISTS `fox_chatgpt_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `content` text,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='系统日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_logs`
--

LOCK TABLES `fox_chatgpt_logs` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_msg`
--

DROP TABLE IF EXISTS `fox_chatgpt_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `group_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `openid` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `message` text,
  `message_input` text,
  `total_tokens` int(11) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='聊天消息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_msg`
--

LOCK TABLES `fox_chatgpt_msg` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_msg` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_msg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_msg_cosplay`
--

DROP TABLE IF EXISTS `fox_chatgpt_msg_cosplay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_msg_cosplay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT '0',
  `role_id` int(11) DEFAULT '0',
  `channel` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `message` longtext,
  `message_input` longtext,
  `audio` varchar(255) DEFAULT NULL,
  `audio_length` int(11) DEFAULT '0',
  `response` longtext,
  `response_input` longtext,
  `total_tokens` int(11) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `user_ip` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='【角色模拟】的聊天消息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_msg_cosplay`
--

LOCK TABLES `fox_chatgpt_msg_cosplay` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_msg_cosplay` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_msg_cosplay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_msg_cosplay_history`
--

DROP TABLE IF EXISTS `fox_chatgpt_msg_cosplay_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_msg_cosplay_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT '0',
  `role_id` int(11) DEFAULT '0',
  `channel` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `message` longtext,
  `message_input` longtext,
  `audio` varchar(255) DEFAULT NULL,
  `audio_length` int(11) DEFAULT '0',
  `response` longtext,
  `response_input` longtext,
  `total_tokens` int(11) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `user_ip` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_msg_cosplay_history`
--

LOCK TABLES `fox_chatgpt_msg_cosplay_history` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_msg_cosplay_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_msg_cosplay_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_msg_draw`
--

DROP TABLE IF EXISTS `fox_chatgpt_msg_draw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_msg_draw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `cate_id` int(11) DEFAULT '0',
  `platform` varchar(20) DEFAULT NULL,
  `channel` varchar(20) DEFAULT NULL,
  `message` text,
  `message_input` text,
  `message_en` text,
  `options` text,
  `task_id` varchar(255) DEFAULT NULL,
  `images` text,
  `size` varchar(20) DEFAULT NULL,
  `num` tinyint(1) DEFAULT '1',
  `state` tinyint(1) DEFAULT '0' COMMENT '0生成中 1成功 2失败',
  `errmsg` varchar(255) DEFAULT NULL,
  `is_share` tinyint(1) DEFAULT '1',
  `is_delete` tinyint(1) DEFAULT '0',
  `is_refund` tinyint(1) DEFAULT '0',
  `user_ip` varchar(255) DEFAULT NULL,
  `finish_time` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_msg_draw`
--

LOCK TABLES `fox_chatgpt_msg_draw` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_msg_draw` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_msg_draw` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_msg_group`
--

DROP TABLE IF EXISTS `fox_chatgpt_msg_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_msg_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `is_delete` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_msg_group`
--

LOCK TABLES `fox_chatgpt_msg_group` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_msg_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_msg_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_msg_pk`
--

DROP TABLE IF EXISTS `fox_chatgpt_msg_pk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_msg_pk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT '0',
  `message` longtext,
  `message_input` longtext,
  `channel_a` varchar(255) DEFAULT NULL,
  `response_a` longtext,
  `total_tokens_a` int(11) DEFAULT '0',
  `channel_b` varchar(255) DEFAULT NULL,
  `response_b` longtext,
  `total_tokens_b` int(11) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `user_ip` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_msg_pk`
--

LOCK TABLES `fox_chatgpt_msg_pk` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_msg_pk` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_msg_pk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_msg_pk_history`
--

DROP TABLE IF EXISTS `fox_chatgpt_msg_pk_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_msg_pk_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT '0',
  `message` longtext,
  `message_input` longtext,
  `channel_a` varchar(255) DEFAULT NULL,
  `response_a` longtext,
  `total_tokens_a` int(11) DEFAULT '0',
  `channel_b` varchar(255) DEFAULT NULL,
  `response_b` longtext,
  `total_tokens_b` int(11) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `user_ip` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_msg_pk_history`
--

LOCK TABLES `fox_chatgpt_msg_pk_history` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_msg_pk_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_msg_pk_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_msg_tool`
--

DROP TABLE IF EXISTS `fox_chatgpt_msg_tool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_msg_tool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `tool` varchar(255) DEFAULT '',
  `channel` varchar(255) DEFAULT NULL,
  `message` text,
  `response` longtext,
  `total_tokens` int(11) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `user_ip` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_msg_tool`
--

LOCK TABLES `fox_chatgpt_msg_tool` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_msg_tool` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_msg_tool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_msg_web`
--

DROP TABLE IF EXISTS `fox_chatgpt_msg_web`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_msg_web` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT '0',
  `topic_id` int(11) DEFAULT '0',
  `activity_id` int(11) DEFAULT '0',
  `prompt_id` int(11) DEFAULT '0',
  `channel` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `message` longtext,
  `message_input` longtext,
  `audio` varchar(255) DEFAULT NULL,
  `audio_length` int(11) DEFAULT '0',
  `response` longtext,
  `response_input` longtext,
  `total_tokens` int(11) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `user_ip` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `group_id` (`group_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='【创作】的聊天消息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_msg_web`
--

LOCK TABLES `fox_chatgpt_msg_web` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_msg_web` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_msg_web` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_msg_web_history`
--

DROP TABLE IF EXISTS `fox_chatgpt_msg_web_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_msg_web_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT '0',
  `topic_id` int(11) DEFAULT '0',
  `activity_id` int(11) DEFAULT '0',
  `prompt_id` int(11) DEFAULT '0',
  `channel` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `message` longtext,
  `message_input` longtext,
  `audio` varchar(255) DEFAULT NULL,
  `audio_length` int(11) DEFAULT '0',
  `response` longtext,
  `response_input` longtext,
  `total_tokens` int(11) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `user_ip` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `group_id` (`group_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_msg_web_history`
--

LOCK TABLES `fox_chatgpt_msg_web_history` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_msg_web_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_msg_web_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_msg_write`
--

DROP TABLE IF EXISTS `fox_chatgpt_msg_write`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_msg_write` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `openid` varchar(255) DEFAULT NULL,
  `topic_id` int(11) DEFAULT '0',
  `activity_id` int(11) DEFAULT '0',
  `prompt_id` int(11) DEFAULT '0',
  `channel` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `message` longtext,
  `message_input` longtext,
  `audio` varchar(255) DEFAULT NULL,
  `audio_length` int(11) DEFAULT '0',
  `response` longtext,
  `response_input` longtext,
  `text_request` longtext,
  `total_tokens` int(11) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `user_ip` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='【对话】的聊天消息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_msg_write`
--

LOCK TABLES `fox_chatgpt_msg_write` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_msg_write` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_msg_write` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_msg_write_history`
--

DROP TABLE IF EXISTS `fox_chatgpt_msg_write_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_msg_write_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `openid` varchar(255) DEFAULT NULL,
  `topic_id` int(11) DEFAULT '0',
  `activity_id` int(11) DEFAULT '0',
  `prompt_id` int(11) DEFAULT '0',
  `channel` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `message` longtext,
  `message_input` longtext,
  `audio` varchar(255) DEFAULT NULL,
  `audio_length` int(11) DEFAULT '0',
  `response` longtext,
  `response_input` longtext,
  `text_request` longtext,
  `total_tokens` int(11) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `user_ip` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_msg_write_history`
--

LOCK TABLES `fox_chatgpt_msg_write_history` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_msg_write_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_msg_write_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_notice`
--

DROP TABLE IF EXISTS `fox_chatgpt_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `platform` varchar(10) DEFAULT NULL COMMENT 'pc/h5',
  `type` varchar(10) DEFAULT NULL COMMENT 'alert/dialog',
  `content` text,
  `start_time` int(11) DEFAULT '0',
  `end_time` int(11) DEFAULT '0',
  `remark` varchar(255) DEFAULT NULL,
  `views` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_notice`
--

LOCK TABLES `fox_chatgpt_notice` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_novel`
--

DROP TABLE IF EXISTS `fox_chatgpt_novel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_novel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `novel_id` varchar(255) DEFAULT NULL,
  `ai` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `prompt` text COMMENT '写作要求',
  `overview` text COMMENT '作品概述',
  `sketch` text COMMENT '作品大纲',
  `count_finished` int(11) DEFAULT '0',
  `count_total` int(11) DEFAULT '0',
  `words` int(11) DEFAULT '0' COMMENT '已生成字数',
  `is_delete` tinyint(1) DEFAULT '0',
  `create_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_novel`
--

LOCK TABLES `fox_chatgpt_novel` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_novel` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_novel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_novel_task`
--

DROP TABLE IF EXISTS `fox_chatgpt_novel_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_novel_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `novel_id` varchar(255) DEFAULT '',
  `title` varchar(255) DEFAULT NULL,
  `overview` text,
  `channel` varchar(255) DEFAULT NULL,
  `response` longtext,
  `total_tokens` int(11) DEFAULT '0',
  `words` int(11) DEFAULT '0' COMMENT '字数',
  `state` tinyint(1) DEFAULT '0',
  `is_delete` tinyint(1) DEFAULT '0',
  `user_ip` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_novel_task`
--

LOCK TABLES `fox_chatgpt_novel_task` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_novel_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_novel_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_order`
--

DROP TABLE IF EXISTS `fox_chatgpt_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `platform` varchar(255) DEFAULT NULL,
  `goods_id` int(11) DEFAULT '0',
  `draw_id` int(11) DEFAULT '0',
  `gpt4_id` int(11) DEFAULT '0',
  `vip_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL COMMENT '支付宝user_id',
  `openid` varchar(255) DEFAULT NULL,
  `out_trade_no` varchar(255) DEFAULT '',
  `transaction_id` varchar(255) DEFAULT '',
  `total_fee` int(11) DEFAULT '0',
  `pay_type` varchar(20) DEFAULT 'alipay' COMMENT 'alipay/wxpay',
  `pay_time` int(11) DEFAULT '0',
  `commission1` int(11) DEFAULT '0' COMMENT '上级分销商id',
  `commission2` int(11) DEFAULT '0' COMMENT '上上级分销商',
  `commission1_fee` int(11) DEFAULT '0' COMMENT '上级佣金金额',
  `commission2_fee` int(11) DEFAULT '0' COMMENT '上上级佣金金额',
  `is_refund` tinyint(1) DEFAULT '0' COMMENT '是否已退款',
  `remark` varchar(255) DEFAULT '',
  `status` tinyint(1) DEFAULT '0' COMMENT '0未付款 1成功',
  `num` int(11) DEFAULT '0' COMMENT '充值条数',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_order`
--

LOCK TABLES `fox_chatgpt_order` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_pclogin`
--

DROP TABLE IF EXISTS `fox_chatgpt_pclogin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_pclogin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `openid` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_pclogin`
--

LOCK TABLES `fox_chatgpt_pclogin` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_pclogin` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_pclogin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_reward_ad`
--

DROP TABLE IF EXISTS `fox_chatgpt_reward_ad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_reward_ad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `reward_num` int(11) DEFAULT '0' COMMENT '奖励条数',
  `ad_unit_id` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_reward_ad`
--

LOCK TABLES `fox_chatgpt_reward_ad` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_reward_ad` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_reward_ad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_reward_invite`
--

DROP TABLE IF EXISTS `fox_chatgpt_reward_invite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_reward_invite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0' COMMENT '邀请人id',
  `share_id` int(11) DEFAULT '0' COMMENT '分享id',
  `way` varchar(255) DEFAULT NULL,
  `newuser_id` int(11) DEFAULT '0' COMMENT '新用户id',
  `reward_num` int(11) DEFAULT '0' COMMENT '奖励条数',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_reward_invite`
--

LOCK TABLES `fox_chatgpt_reward_invite` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_reward_invite` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_reward_invite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_reward_share`
--

DROP TABLE IF EXISTS `fox_chatgpt_reward_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_reward_share` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `way` varchar(255) DEFAULT NULL,
  `is_reward` tinyint(1) DEFAULT '0',
  `views` int(11) DEFAULT '0',
  `invite_num` int(11) DEFAULT '0' COMMENT '邀请到新用户数量',
  `reward_num` int(11) DEFAULT '0' COMMENT '分享奖励条数',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_reward_share`
--

LOCK TABLES `fox_chatgpt_reward_share` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_reward_share` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_reward_share` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_setting`
--

DROP TABLE IF EXISTS `fox_chatgpt_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `ad` text COMMENT '支付后广告',
  `version` varchar(50) DEFAULT NULL COMMENT '系统版本号',
  `system` text COMMENT '系统配置',
  `auth` text,
  `tplnotice` text,
  `wxapp` text,
  `wxapp_upload` text,
  `wxapp_index` text,
  `pay` text,
  `chatgpt` text,
  `gpt4` text,
  `filter` text,
  `reward_share` text,
  `reward_invite` text,
  `reward_ad` text,
  `api` text,
  `about` text,
  `commission` text,
  `web` text,
  `wxmp` text,
  `h5` text,
  `kefu` text,
  `chat` text,
  `draw` text,
  `pk` text,
  `book` text,
  `batch` text,
  `team` text,
  `novel` text,
  `mind` text,
  `storage` text,
  `login` text,
  `sms` text,
  `translate` text,
  `speech` text,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_setting`
--

LOCK TABLES `fox_chatgpt_setting` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_setting` DISABLE KEYS */;
INSERT INTO `fox_chatgpt_setting` VALUES (1,0,NULL,'v2.7.0','{\"system_title\":\"小狐狸AI创作系统\",\"system_logo\":\"\",\"system_icp\":\"\",\"system_gongan\":\"\"}','{\"code\":\"46a00ef5debd933c858dc9073559581a\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `fox_chatgpt_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_share_haibao`
--

DROP TABLE IF EXISTS `fox_chatgpt_share_haibao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_share_haibao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `bg` varchar(255) DEFAULT NULL,
  `bg_w` int(11) DEFAULT '0',
  `bg_h` int(11) DEFAULT '0',
  `hole_w` int(11) DEFAULT '0',
  `hole_h` int(11) DEFAULT '0',
  `hole_x` int(11) DEFAULT '0',
  `hole_y` int(11) DEFAULT '0',
  `state` tinyint(1) DEFAULT '1',
  `is_default` tinyint(1) DEFAULT '0',
  `weight` int(11) DEFAULT '100',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_share_haibao`
--

LOCK TABLES `fox_chatgpt_share_haibao` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_share_haibao` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_share_haibao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_share_text`
--

DROP TABLE IF EXISTS `fox_chatgpt_share_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_share_text` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `content` text,
  `state` tinyint(1) DEFAULT '1',
  `is_default` tinyint(1) DEFAULT '0',
  `weight` int(11) DEFAULT '100',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_share_text`
--

LOCK TABLES `fox_chatgpt_share_text` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_share_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_share_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_site`
--

DROP TABLE IF EXISTS `fox_chatgpt_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '昵称',
  `sitecode` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT '/static/img/avatar.png',
  `remark` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `expire_time` int(11) DEFAULT '0',
  `last_time` int(11) DEFAULT '0' COMMENT '最后登录时间',
  `last_ip` varchar(20) DEFAULT NULL,
  `is_delete` tinyint(1) DEFAULT '0',
  `token` varchar(255) DEFAULT NULL COMMENT '自动登录token',
  `msg_chat_history_count` int(11) DEFAULT '0',
  `msg_write_history_count` int(11) DEFAULT '0',
  `msg_cosplay_history_count` int(11) DEFAULT '0',
  `msg_pk_history_count` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='站点表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_site`
--

LOCK TABLES `fox_chatgpt_site` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_site` DISABLE KEYS */;
INSERT INTO `fox_chatgpt_site` VALUES (1,'默认站点',NULL,'admin','123456','/static/img/avatar.png',NULL,1,0,1677143139,'220.195.75.75',0,'63f726ba8ad4f8899',0,0,0,0,1675991002);
/*!40000 ALTER TABLE `fox_chatgpt_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_smscode`
--

DROP TABLE IF EXISTS `fox_chatgpt_smscode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_smscode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `expire_time` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_smscode`
--

LOCK TABLES `fox_chatgpt_smscode` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_smscode` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_smscode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_super`
--

DROP TABLE IF EXISTS `fox_chatgpt_super`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_super` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(20) DEFAULT '' COMMENT '角色',
  `realname` varchar(255) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) DEFAULT '/static/img/avatar.png',
  `remark` varchar(255) DEFAULT NULL,
  `last_time` int(11) DEFAULT '0' COMMENT '最后登录时间',
  `last_ip` varchar(20) DEFAULT NULL,
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='超级管理员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_super`
--

LOCK TABLES `fox_chatgpt_super` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_super` DISABLE KEYS */;
INSERT INTO `fox_chatgpt_super` VALUES (1,'super','123456','super','超级管理员','/static/img/avatar.png',NULL,1676695437,'127.0.0.1',1676695437);
/*!40000 ALTER TABLE `fox_chatgpt_super` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_user`
--

DROP TABLE IF EXISTS `fox_chatgpt_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `openid` varchar(50) DEFAULT NULL COMMENT '小程序openid',
  `openid_mp` varchar(255) DEFAULT NULL COMMENT '公众号openid',
  `unionid` varchar(255) DEFAULT NULL,
  `balance` int(11) DEFAULT '0' COMMENT '对话余额',
  `balance_draw` int(11) DEFAULT '0' COMMENT '绘画余额',
  `balance_gpt4` bigint(20) DEFAULT '0' COMMENT 'GPT4余额',
  `vip_expire_time` bigint(20) DEFAULT '0' COMMENT 'vip到期时间',
  `avatar` varchar(255) DEFAULT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `tuid` int(11) DEFAULT '0' COMMENT '推荐人ID',
  `commission_level` int(11) DEFAULT '0' COMMENT '分销等级（暂留）',
  `commission_money` int(11) DEFAULT '0' COMMENT '可提现佣金余额',
  `commission_paid` int(11) DEFAULT '0' COMMENT '已提现佣金',
  `commission_frozen` int(11) DEFAULT '0' COMMENT '冻结中的佣金',
  `commission_total` int(11) DEFAULT '0' COMMENT '总佣金',
  `commission_pid` int(11) DEFAULT '0' COMMENT '上级分销商',
  `commission_ppid` int(11) DEFAULT '0' COMMENT '上上级分销商',
  `commission_time` int(11) DEFAULT '0' COMMENT '成为分销商的时间',
  `gender` int(11) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `birthday` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `authcode` varchar(255) DEFAULT NULL,
  `realname` varchar(255) DEFAULT NULL COMMENT '姓名',
  `status` tinyint(1) DEFAULT '1',
  `token` varchar(255) DEFAULT NULL,
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '1：注销',
  `is_freeze` tinyint(1) DEFAULT '0' COMMENT '1：冻结',
  `freeze_time` int(11) DEFAULT '0',
  `last_login_time` int(11) DEFAULT '0',
  `update_time` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_user`
--

LOCK TABLES `fox_chatgpt_user` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_user_balance_draw_logs`
--

DROP TABLE IF EXISTS `fox_chatgpt_user_balance_draw_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_user_balance_draw_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `num` int(11) DEFAULT '0',
  `desc` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_user_balance_draw_logs`
--

LOCK TABLES `fox_chatgpt_user_balance_draw_logs` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_user_balance_draw_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_user_balance_draw_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_user_balance_gpt4_logs`
--

DROP TABLE IF EXISTS `fox_chatgpt_user_balance_gpt4_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_user_balance_gpt4_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `num` bigint(20) DEFAULT '0',
  `desc` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_user_balance_gpt4_logs`
--

LOCK TABLES `fox_chatgpt_user_balance_gpt4_logs` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_user_balance_gpt4_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_user_balance_gpt4_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_user_balance_logs`
--

DROP TABLE IF EXISTS `fox_chatgpt_user_balance_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_user_balance_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `num` int(11) DEFAULT '0',
  `desc` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_user_balance_logs`
--

LOCK TABLES `fox_chatgpt_user_balance_logs` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_user_balance_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_user_balance_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_user_vip_logs`
--

DROP TABLE IF EXISTS `fox_chatgpt_user_vip_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_user_vip_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `vip_expire_time` bigint(20) DEFAULT '0',
  `desc` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_user_vip_logs`
--

LOCK TABLES `fox_chatgpt_user_vip_logs` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_user_vip_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_user_vip_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_vip`
--

DROP TABLE IF EXISTS `fox_chatgpt_vip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_vip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL COMMENT '产品标题',
  `price` int(11) DEFAULT '0' COMMENT '现价',
  `market_price` int(11) DEFAULT '0' COMMENT '市场价',
  `num` int(11) DEFAULT '0' COMMENT '条数',
  `hint` varchar(20) DEFAULT NULL,
  `desc` text,
  `sales` int(11) DEFAULT '0' COMMENT '销量',
  `status` tinyint(1) DEFAULT '1',
  `weight` int(11) DEFAULT '100' COMMENT '越大越靠前',
  `is_default` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_vip`
--

LOCK TABLES `fox_chatgpt_vip` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_vip` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_vip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_write_prompts`
--

DROP TABLE IF EXISTS `fox_chatgpt_write_prompts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_write_prompts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'system/diy',
  `topic_id` int(11) DEFAULT '0',
  `activity_id` int(11) DEFAULT '0',
  `title` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `desc` varchar(1000) CHARACTER SET utf8mb4 DEFAULT NULL,
  `prompt` text CHARACTER SET utf8mb4,
  `hint` varchar(1000) CHARACTER SET utf8mb4 DEFAULT NULL,
  `welcome` varchar(1000) CHARACTER SET utf8mb4 DEFAULT NULL,
  `tips` text CHARACTER SET utf8mb4,
  `votes` int(11) DEFAULT '0',
  `views` int(11) DEFAULT '0',
  `usages` int(11) DEFAULT '0',
  `fake_votes` int(11) DEFAULT '0',
  `fake_views` int(11) DEFAULT '0',
  `fake_usages` int(11) DEFAULT '0',
  `weight` int(11) DEFAULT '100',
  `state` tinyint(1) DEFAULT '1',
  `is_delete` tinyint(1) DEFAULT '0',
  `update_time` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_write_prompts`
--

LOCK TABLES `fox_chatgpt_write_prompts` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_write_prompts` DISABLE KEYS */;
INSERT INTO `fox_chatgpt_write_prompts` VALUES (1,1,'system',1,0,'写一篇文章','用你喜欢的语言写一篇关于任何主题的文章','用[TARGETLANGGE]写一篇关于[PROMPT]的文章','输入文章的主题，然后按发送键',NULL,NULL,0,3,0,0,0,0,100,1,0,NULL,NULL),(2,1,'system',1,0,'按大纲写文章','根据提供的大纲，写一篇文章','我想让你成为一个非常熟练的高端文案作家，以至于能超越其他作家。你的任务是根据提供的大纲：[PROMPT]。写一篇文章。在新段落中为大纲中的每一行写内容，包括使用相关关键字的副标题。所有输出均应为简体中文，且必须为100%的人类书写风格，并修复语法错误。使用[TARGETLANGGE]书写。','输入或粘贴文章大纲到这里','',NULL,0,3,0,30,10,20,100,1,0,1679058985,NULL),(3,1,'system',1,0,'创建博客文章大纲','根据提供的文章标题生成大纲','你是一名SEO专家和内容作家，能说流利的[TARGETLANGGE]。我会给你一个博客标题。你将制定一个包含所有必要细节的大型博客大纲：[PROMPT]。在末尾添加创建关键字列表。','输入文章标题',NULL,NULL,0,3,0,0,0,0,100,1,0,NULL,NULL),(4,1,'system',1,0,'创作短视频脚本','输入视频的简短描述，生成：标题、场景和整个脚本','根据以下描述创建一个引人入胜的短视频脚本：[PROMPT]。','“如何更换轮胎”、“探索喜马拉雅山脉”、“初学者训练狗”等',NULL,NULL,0,4,0,0,0,0,100,1,0,NULL,NULL);
/*!40000 ALTER TABLE `fox_chatgpt_write_prompts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_write_prompts_vote`
--

DROP TABLE IF EXISTS `fox_chatgpt_write_prompts_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_write_prompts_vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT '0',
  `prompt_id` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_write_prompts_vote`
--

LOCK TABLES `fox_chatgpt_write_prompts_vote` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_write_prompts_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_write_prompts_vote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_write_topic`
--

DROP TABLE IF EXISTS `fox_chatgpt_write_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_write_topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `weight` int(11) DEFAULT '100' COMMENT '大的靠前',
  `state` tinyint(1) DEFAULT '1',
  `update_time` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_write_topic`
--

LOCK TABLES `fox_chatgpt_write_topic` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_write_topic` DISABLE KEYS */;
INSERT INTO `fox_chatgpt_write_topic` VALUES (1,1,'文章创作',100,1,1678323600,NULL),(2,1,'工作助手',100,1,1678323600,NULL),(3,1,'生活助手',100,1,1678323600,NULL),(4,1,'编程开发',100,1,1678323600,NULL),(5,1,'其他应用',100,1,1678323600,NULL);
/*!40000 ALTER TABLE `fox_chatgpt_write_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fox_chatgpt_wxmp_keyword`
--

DROP TABLE IF EXISTS `fox_chatgpt_wxmp_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fox_chatgpt_wxmp_keyword` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT '0',
  `keyword` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT 'text/image',
  `content` text,
  `image` varchar(255) DEFAULT NULL,
  `media_id` varchar(255) DEFAULT NULL,
  `is_hit` tinyint(1) DEFAULT '1' COMMENT '是否精准匹配',
  `state` tinyint(1) DEFAULT '1',
  `weight` int(11) DEFAULT '100',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fox_chatgpt_wxmp_keyword`
--

LOCK TABLES `fox_chatgpt_wxmp_keyword` WRITE;
/*!40000 ALTER TABLE `fox_chatgpt_wxmp_keyword` DISABLE KEYS */;
/*!40000 ALTER TABLE `fox_chatgpt_wxmp_keyword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'foxai'
--

--
-- Dumping routines for database 'foxai'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-17 20:09:22
