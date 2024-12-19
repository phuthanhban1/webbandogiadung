-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: gfshop
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (6,'Minh Quang','quangkedo2003@gmail.com','q','0334973459'),(8,'Phùng Công Thành','thanhpc.works@gmail.com','123','0334973454');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL,
  `pid` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid_idx` (`uid`),
  KEY `pid_idx` (`pid`),
  CONSTRAINT `pid` FOREIGN KEY (`pid`) REFERENCES `product` (`pid`),
  CONSTRAINT `uid` FOREIGN KEY (`uid`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `cid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Điện thoại','mobiles.jfif'),(2,'Đồ gia dụng','appliances.jfif'),(3,'Máy tính','laptops.jfif'),(4,'Nội thất','homes.jfif'),(5,'Sách','books.jfif'),(6,'Quần áo & thời trang','clothes.jfif'),(7,'Thiết bị điện tử','electronics.jfif');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderid` varchar(100) DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `paymentType` tinyint DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `totalPrice` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (50,'ORD-20240622103156',3,0,11,'2023-02-22',18039900),(51,'ORD-20240622103309',3,0,11,'2023-03-02',25039980),(52,'ORD-20240622104028',3,1,11,'2023-03-22',7030099),(53,'ORD-20240622104637',3,1,4,'2023-05-11',16740089),(54,'ORD-20240622104701',3,0,4,'2023-05-29',52090000),(55,'ORD-20240622104752',3,0,4,'2023-06-15',21580000),(56,'ORD-20240622104920',3,0,4,'2023-06-28',11539990),(57,'ORD-20240622104947',3,0,4,'2023-06-30',86140089),(58,'ORD-20240622105156',3,1,4,'2023-07-02',6630000),(59,'ORD-20240622105247',3,0,4,'2023-07-12',27039980),(60,'ORD-20240622105341',3,0,4,'2023-08-01',9430099),(61,'ORD-20240622105608',3,0,4,'2023-08-11',15329990),(62,'ORD-20240622105705',3,1,4,'2023-08-23',5240099),(63,'ORD-20240622105739',3,0,4,'2023-08-27',13329990),(64,'ORD-20240622105756',3,0,4,'2023-08-31',2440000),(65,'ORD-20240622110045',3,0,4,'2023-09-17',7640099),(66,'ORD-20240622110330',3,0,4,'2023-10-17',35389900),(67,'ORD-20240622110523',3,0,4,'2023-10-22',9640099),(68,'ORD-20240622110612',3,0,4,'2023-11-20',21829900),(69,'ORD-20240622110748',3,0,4,'2023-12-12',25239999),(70,'ORD-20240622111201',3,0,4,'2023-12-22',46239990),(71,'ORD-20240623100645',3,0,11,'2024-01-03',11539990),(72,'ORD-20240623044409',3,0,9,'2024-01-23',11539990),(73,'ORD-20240623044418',3,0,9,'2024-02-12',5240099),(74,'ORD-20240623044431',3,0,9,'2024-02-23',13539990),(75,'ORD-20240623044456',3,0,9,'2024-03-15',1830000),(76,'ORD-20240623044545',3,0,9,'2024-03-22',37389900),(77,'ORD-20240623044639',3,0,9,'2024-03-27',4840000),(78,'ORD-20240623044647',3,0,9,'2024-04-29',5240099),(79,'ORD-20240623044746',3,0,9,'2024-05-19',4040000),(80,'ORD-20240623044843',3,0,9,'2024-05-15',2440000),(81,'ORD-20240623044921',3,0,9,'2024-04-23',2440000),(82,'ORD-20240623044929',3,0,9,'2024-01-23',17390000),(83,'ORD-20240623044944',3,0,9,'2024-02-21',1830000),(84,'ORD-20240623045046',3,0,9,'2024-03-14',34539970),(85,'ORD-20240623045100',3,0,9,'2024-02-14',1830000),(86,'ORD-20240623045117',3,0,9,'2024-04-20',6040000),(87,'ORD-20240623045137',3,0,9,'2024-04-12',1830000),(88,'ORD-20240623045156',3,0,9,'2024-05-05',2040000),(89,'ORD-20240623045203',3,0,9,'2024-06-11',18039900),(90,'ORD-20240623045253',0,0,9,'2024-06-15',52090000),(91,'ORD-20240623045306',0,0,9,'2024-06-23',10440198),(92,'ORD-20240623094636',0,0,4,'2024-06-23',19790000),(93,'ORD-20240623113841',0,0,4,'2024-06-23',4840000),(94,'ORD-20240627114235',3,0,13,'2024-06-27',18039900);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordered_product`
--

DROP TABLE IF EXISTS `ordered_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordered_product` (
  `oid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` int DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `orderid` int DEFAULT NULL,
  PRIMARY KEY (`oid`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordered_product`
--

LOCK TABLES `ordered_product` WRITE;
/*!40000 ALTER TABLE `ordered_product` DISABLE KEYS */;
INSERT INTO `ordered_product` VALUES (26,'Samsung Galaxy S23 5G',1,17999900,'samsung_s23_5g.jfif',50),(27,'OnePlus Y1S Pro 138 cm  Ultra HD (4K) LED Smart Android TV',2,11499990,'adroi_tv.jfif',51),(28,'SAMSUNG Galaxy F14 5G',1,2000000,'samsung_f14_5g.jfif',51),(29,'Men Printed Casual Jacket',1,1790000,'jacket_man.jfif',52),(30,'LG 242 L Frost Free Double Door  Refrigerator',1,5200099,'tulanh_lg.jfif',52),(31,'LG 242 L Frost Free Double Door  Refrigerator',1,5200099,'tulanh_lg.jfif',53),(32,'OnePlus Y1S Pro 138 cm  Ultra HD (4K) LED Smart Android TV',1,11499990,'adroi_tv.jfif',53),(33,'ASUS TUF Gaming A15',3,17350000,'asus_a15.jfif',54),(34,'boAt Airdopes 161 with 40 Hours Playback',1,2400000,'th (1).jfif',55),(35,'Men Printed Casual Jacket',1,1790000,'jacket_man.jfif',55),(36,'ASUS TUF Gaming A15',1,17350000,'asus_a15.jfif',55),(37,'OnePlus Y1S Pro 138 cm  Ultra HD (4K) LED Smart Android TV',1,11499990,'adroi_tv.jfif',56),(38,'ASUS TUF Gaming A15',4,17350000,'asus_a15.jfif',57),(39,'LG 242 L Frost Free Double Door  Refrigerator',1,5200099,'tulanh_lg.jfif',57),(40,'OnePlus Y1S Pro 138 cm  Ultra HD (4K) LED Smart Android TV',1,11499990,'adroi_tv.jfif',57),(41,'boAt Airdopes 161 with 40 Hours Playback',2,2400000,'th (1).jfif',58),(42,'Men Printed Casual Jacket',1,1790000,'jacket_man.jfif',58),(43,'OnePlus Y1S Pro 138 cm  Ultra HD (4K) LED Smart Android TV',2,11499990,'adroi_tv.jfif',59),(44,'SAMSUNG Galaxy F14 5G',2,2000000,'samsung_f14_5g.jfif',59),(45,'boAt Airdopes 161 with 40 Hours Playback',1,2400000,'th (1).jfif',60),(46,'Men Printed Casual Jacket',1,1790000,'jacket_man.jfif',60),(47,'LG 242 L Frost Free Double Door  Refrigerator',1,5200099,'tulanh_lg.jfif',60),(48,'OnePlus Y1S Pro 138 cm  Ultra HD (4K) LED Smart Android TV',1,11499990,'adroi_tv.jfif',61),(49,'SAMSUNG Galaxy F14 5G',1,2000000,'samsung_f14_5g.jfif',61),(50,'Men Printed Casual Jacket',1,1790000,'jacket_man.jfif',61),(51,'LG 242 L Frost Free Double Door  Refrigerator',1,5200099,'tulanh_lg.jfif',62),(52,'Men Printed Casual Jacket',1,1790000,'jacket_man.jfif',63),(53,'OnePlus Y1S Pro 138 cm  Ultra HD (4K) LED Smart Android TV',1,11499990,'adroi_tv.jfif',63),(54,'boAt Airdopes 161 with 40 Hours Playback',1,2400000,'th (1).jfif',64),(55,'boAt Airdopes 161 with 40 Hours Playback',1,2400000,'th (1).jfif',65),(56,'LG 242 L Frost Free Double Door  Refrigerator',1,5200099,'tulanh_lg.jfif',65),(57,'ASUS TUF Gaming A15',1,17350000,'asus_a15.jfif',66),(58,'Samsung Galaxy S23 5G',1,17999900,'samsung_s23_5g.jfif',66),(59,'boAt Airdopes 161 with 40 Hours Playback',1,2400000,'th (1).jfif',67),(60,'LG 242 L Frost Free Double Door  Refrigerator',1,5200099,'tulanh_lg.jfif',67),(61,'SAMSUNG Galaxy F14 5G',1,2000000,'samsung_f14_5g.jfif',67),(62,'Men Printed Casual Jacket',1,1790000,'jacket_man.jfif',68),(63,'Samsung Galaxy S23 5G',1,17999900,'samsung_s23_5g.jfif',68),(64,'SAMSUNG Galaxy F14 5G',1,2000000,'samsung_f14_5g.jfif',68),(65,'LG 242 L Frost Free Double Door  Refrigerator',1,5200099,'tulanh_lg.jfif',69),(66,'SAMSUNG Galaxy F14 5G',1,2000000,'samsung_f14_5g.jfif',69),(67,'Samsung Galaxy S23 5G',1,17999900,'samsung_s23_5g.jfif',69),(68,'ASUS TUF Gaming A15',2,17350000,'asus_a15.jfif',70),(69,'OnePlus Y1S Pro 138 cm  Ultra HD (4K) LED Smart Android TV',1,11499990,'adroi_tv.jfif',70),(70,'OnePlus Y1S Pro 138 cm  Ultra HD (4K) LED Smart Android TV',1,11499990,'adroi_tv.jfif',71),(71,'OnePlus Y1S Pro 138 cm  Ultra HD (4K) LED Smart Android TV',1,11499990,'adroi_tv.jfif',72),(72,'LG 242 L Frost Free Double Door  Refrigerator',1,5200099,'tulanh_lg.jfif',73),(73,'OnePlus Y1S Pro 138 cm  Ultra HD (4K) LED Smart Android TV',1,11499990,'adroi_tv.jfif',74),(74,'SAMSUNG Galaxy F14 5G',1,2000000,'samsung_f14_5g.jfif',74),(75,'Men Printed Casual Jacket',1,1790000,'jacket_man.jfif',75),(76,'Samsung Galaxy S23 5G',1,17999900,'samsung_s23_5g.jfif',76),(77,'SAMSUNG Galaxy F14 5G',1,2000000,'samsung_f14_5g.jfif',76),(78,'ASUS TUF Gaming A15',1,17350000,'asus_a15.jfif',76),(79,'boAt Airdopes 161 with 40 Hours Playback',2,2400000,'th (1).jfif',77),(80,'LG 242 L Frost Free Double Door  Refrigerator',1,5200099,'tulanh_lg.jfif',78),(81,'SAMSUNG Galaxy F14 5G',2,2000000,'samsung_f14_5g.jfif',79),(82,'boAt Airdopes 161 with 40 Hours Playback',1,2400000,'th (1).jfif',80),(83,'boAt Airdopes 161 with 40 Hours Playback',1,2400000,'th (1).jfif',81),(84,'ASUS TUF Gaming A15',1,17350000,'asus_a15.jfif',82),(85,'Men Printed Casual Jacket',1,1790000,'jacket_man.jfif',83),(86,'OnePlus Y1S Pro 138 cm  Ultra HD (4K) LED Smart Android TV',3,11499990,'adroi_tv.jfif',84),(87,'Men Printed Casual Jacket',1,1790000,'jacket_man.jfif',85),(88,'SAMSUNG Galaxy F14 5G',3,2000000,'samsung_f14_5g.jfif',86),(89,'Men Printed Casual Jacket',1,1790000,'jacket_man.jfif',87),(90,'SAMSUNG Galaxy F14 5G',1,2000000,'samsung_f14_5g.jfif',88),(91,'Samsung Galaxy S23 5G',1,17999900,'samsung_s23_5g.jfif',89),(92,'ASUS TUF Gaming A15',3,17350000,'asus_a15.jfif',90),(93,'LG 242 L Frost Free Double Door  Refrigerator',2,5200099,'tulanh_lg.jfif',91),(94,'boAt Airdopes 161 with 40 Hours Playback',1,2400000,'th (1).jfif',92),(95,'ASUS TUF Gaming A15',1,17350000,'asus_a15.jfif',92),(96,'boAt Airdopes 161 with 40 Hours Playback',2,2400000,'th (1).jfif',93),(97,'Samsung Galaxy S23 5G',1,17999900,'samsung_s23_5g.jfif',94);
/*!40000 ALTER TABLE `ordered_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `pid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `price` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `cid` int DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'SAMSUNG Galaxy F14 5G','Điện thoại thông minh Samsung Galaxy F14 sử dụng bộ xử lý 5nm chỉ có trong phân khúc cho phép bạn dễ dàng thực hiện đa nhiệm, chơi game và hơn thế nữa. Nó có pin 6000 mAh cho phép bạn sử dụng lên đến 2 ngày chỉ với một lần sạc. Nó có màn hình lớn khoảng 16,72 cm (6,5) full HD+ cho phép bạn xem đắm chìm. RAM 12 GB với RAM Plus cung cấp đủ dung lượng lưu trữ để lưu trữ tất cả dữ liệu của bạn.',2000000,3,'samsung_f14_5g.jfif',1),(2,'LG 242 L Frost Free Double Door  Refrigerator','Bạn có thể thưởng thức đồ uống mát lạnh và kem que trong mùa hè bằng cách dự trữ chúng trong Tủ lạnh hai cửa không đóng băng LG 242 L. Máy nén biến tần thông minh của nó được thiết kế để mang lại hiệu suất tiết kiệm năng lượng, nhờ đó giúp kiểm tra hóa đơn tiền điện của bạn. Ngoài ra, tính năng Door Cooling+ của tủ lạnh này giữ cho thực phẩm tươi ngon và đồ uống được làm lạnh đồng thời làm lạnh nhanh chóng đồng đều.',5200099,29,'tulanh_lg.jfif',2),(3,'OnePlus Y1S Pro 138 cm  Ultra HD (4K) LED Smart Android TV','Thưởng thức nội dung nghe nhìn phong phú, rõ ràng và chân thực ở dạng chân thực với OnePlus TV rực rỡ, hiểu bạn và cố gắng giúp bạn giải trí liên tục. Trình quản lý thông minh của OnePlus TV này cung cấp một số cải tiến để mang lại trải nghiệm TV thông minh và bền bỉ. Nhờ Công cụ Gamma phức tạp, điều chỉnh hình ảnh một cách thông minh để mang lại nội dung rõ nét và tối đa hóa chất lượng hiển thị, mọi khung cảnh đều trở nên sống động.',11499990,10,'adroi_tv.jfif',2),(8,'Samsung Galaxy S23 5G','Thương hiệu: Samsung\r\nTên: Samsung Galaxy S23\r\nNhà cung cấp dịch vụ mạng đã được mở khóa cho tất cả các nhà cung cấp dịch vụ\r\nHệ điều hành: Android 13.0\r\nCông nghệ di động: 5G',17999900,21,'samsung_s23_5g.jfif',1),(9,'ASUS TUF Gaming A15','15,6 inch Full HD, IPS, Màn hình chống chói, Tỷ lệ khung hình: 16:9, Tốc độ làm mới: 144 Hz, Góc nhìn: 85/85/85/85, Độ sáng: 250nits, Tỷ lệ tương phản: 1:1000, 45% NTSC , SRGB%: 62,5%, Adobe%: 47,34%, Đồng bộ hóa thích ứng\r\nLaptop nhẹ không có ổ đĩa quang\r\nPreloaded with MS Office',17350000,16,'asus_a15.jfif',3),(10,'Men Printed Casual Jacket','Màu sắc\r\nĐen\r\nVải vóc\r\nCotton nguyên chât\r\nMẫu\r\nĐã in\r\nMã kiểu\r\nAvengers_Dây kéo\r\nLý tưởng cho\r\nĐàn ông\r\nTay áo\r\nđầy đủ tay áo\r\nTính cách\r\nSiêu nhân\r\nKhép kín\r\ndây kéo\r\nGói của\r\n1\r\nPhù hợp với\r\nMặc phương Tây\r\nCó thể đảo ngược\r\nKHÔNG\r\ntrùm đầu\r\nĐúng\r\nKiểu\r\nÁo khoác thường ngày\r\nChăm sóc vải\r\nGiặt máy theo Tag\r\nPhù hợp\r\nThường xuyên',1790000,16,'jacket_man.jfif',6),(12,'boAt Airdopes 161 with 40 Hours Playback','Tai nghe Airdopes 161TWS mang đến trải nghiệm nghe tuyệt vời với trình điều khiển 10mm và công nghệ không dây Bluetooth v5.1. Với công nghệ IWP và ASAP Charge, chúng cung cấp thời gian chơi lên tới 180 phút chỉ trong 10 phút. Với cấu trúc chống nước IPX5, chúng mang lại sự linh hoạt cho các buổi tập thể dục cũng như dễ dàng phát lại lệnh và kích hoạt trợ lý giọng nói.',2400000,16,'th (1).jfif',7);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `registerdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `address` varchar(250) DEFAULT NULL,
  `pincode` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `phone_UNIQUE` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (4,'Nguyễn Minh Quang','quangkedo2003@gmail.com','123456','0334973459','Male','2024-06-09 17:16:00','Tổ Văn Trì 4, Minh Khai, Bắc Từ Liêm, Hà Nội','232003'),(6,'Phùng Công Thành','thanh@gmail.com','123456','0334973458','Female','2024-06-10 16:02:48','Ba Vì','202020'),(9,'Nguyễn Xuân Phú','phuthanhban4@gmail.com','a','0342344238','Male','2024-06-10 16:02:48','Thái Bình','22222'),(10,'Nguyễn Minh Lộc','loc@gmail.com','a','0998823212','Male','2024-06-01 16:02:48','Nam Trực, Nam Định','112233'),(11,'Phùng Công Thành','thanhpc.works@gmail.com','123','0988558160','Male','2024-06-22 15:29:18','Sơn Đồng - Hoài Đức - Hà Nội','222222'),(13,'Nguyễn Tuấn Minh','minh43763@gmail.com','123','0334973451','Male','2024-06-27 16:39:49','Ba Vì','164860');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `idwishlist` int NOT NULL AUTO_INCREMENT,
  `iduser` int DEFAULT NULL,
  `idproduct` int DEFAULT NULL,
  PRIMARY KEY (`idwishlist`),
  KEY `idproduct_idx` (`idproduct`),
  KEY `iduser_idx` (`iduser`),
  CONSTRAINT `idproduct` FOREIGN KEY (`idproduct`) REFERENCES `product` (`pid`),
  CONSTRAINT `iduser` FOREIGN KEY (`iduser`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
INSERT INTO `wishlist` VALUES (11,4,10),(13,9,1),(14,11,1),(15,4,2),(16,4,1),(19,13,3);
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-28  0:03:35
