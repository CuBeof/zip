-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 10.192.6.202:3306
-- Thời gian đã tạo: Th12 11, 2020 lúc 10:17 AM
-- Phiên bản máy phục vụ: 5.6.27-log
-- Phiên bản PHP: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `koubaiapp`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `app_user`
--

CREATE TABLE `app_user` (
  `id` bigint(20) NOT NULL,
  `sso_id` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `app_user_user_profile`
--

CREATE TABLE `app_user_user_profile` (
  `user_id` bigint(20) NOT NULL,
  `user_profile_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `book`
--

CREATE TABLE `book` (
  `book_id` bigint(20) UNSIGNED NOT NULL,
  `title` text,
  `description` text,
  `author` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `book`
--

INSERT INTO `book` (`book_id`, `title`, `description`, `author`) VALUES
(1, 'Nam Trieu', 'Trang Do Thuy <trang_dt@namtrieu.com.vn>', 'Ms Trang'),
(2, 'Công ty TNHH United Publishers Hà Nội', 'số 3, ngõ 37 Lê Thanh Nghị,Bách Khoa, Hà Nội, Việt Nam', 'Mr.Tuấn'),
(3, 'Công ty TNHH NEC Việt Nam', 'Tầng 15, toàn nhà Icon 4, số 243 La Thành, P.Láng Thượng', 'Mr.Việt anh'),
(4, 'Công ty TNHH KDDI Việt Nam', 'Room 201, 2nd F  HITC, 239 Xuan Thuy Str., Dich Vong Hau Ward, Cau Giay Dist., Hanoi', 'Mr.Jang');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(8, 'IS関係製品/サービス'),
(12, 'その他'),
(3, 'レンタル'),
(5, '医療サービス'),
(4, '印刷'),
(2, '教育/訓練'),
(7, '校正/測定/検定'),
(6, '検討中'),
(1, '物品購入'),
(9, '翻訳・公証'),
(11, '衛星/掃除'),
(10, '輸送サービス');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `request_date` datetime DEFAULT NULL,
  `request_department` text,
  `request_group` text,
  `case_number` text,
  `vendor_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `description` text,
  `description_vn` text,
  `maker` text,
  `model` text,
  `price` int(11) DEFAULT NULL,
  `currency` text,
  `unit` text,
  `quantity` int(11) DEFAULT NULL,
  `rate` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `request_date`, `request_department`, `request_group`, `case_number`, `vendor_id`, `category_id`, `description`, `description_vn`, `maker`, `model`, `price`, `currency`, `unit`, `quantity`, `rate`) VALUES
(2, NULL, 'DR0', 'DR22', 'XY123', 1, 1, 'Nothing', 'số 3, ngõ 37 Lê Thanh Nghị,Bách Khoa, Hà Nội, Việt Nam', 'Nissan', 'PZ1A', 1000, 'VND', 'Pcs', 200, 100),
(3, '2020-12-01 00:00:00', 'DR0', 'DR22', 'XY123', 1, 1, NULL, 'Tầng 15, toàn nhà Icon 4, số 243 La Thành, P.Láng Thượng', 'Nissan', 'PZ1A', 1000, 'VND', 'Pcs', 200, 100);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sub_categories`
--

CREATE TABLE `sub_categories` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `parent_id`, `name`) VALUES
(1, 1, '文房具'),
(2, 1, 'HTCの設備/部品/消耗品'),
(3, 1, '事務設備'),
(4, 1, '食品'),
(5, 1, 'プレゼント'),
(6, 1, '医薬品/薬'),
(7, 1, '化学品'),
(8, 3, 'アパートレンタル'),
(9, 3, '衣服レンタル'),
(10, 3, '設備レンタル'),
(11, 3, 'レンタカー'),
(12, 4, '印刷'),
(13, 5, '保険'),
(14, 5, '健康診断'),
(15, 5, '健康管理'),
(16, 6, '工事'),
(17, 6, '設備メンテナンス'),
(18, 6, '設備修理'),
(19, 7, '校正'),
(20, 7, '測定'),
(21, 7, '検定'),
(22, 8, 'ソフトウェア'),
(23, 8, 'IS　Elearning'),
(24, 8, 'サポートサービス'),
(25, 8, 'ISの設備/消耗品'),
(26, 10, '輸送サービス'),
(27, 11, '衛星/掃除'),
(28, 12, '緊急連絡'),
(29, 12, 'イベント開催'),
(30, 12, '警備'),
(31, 12, '採用'),
(32, 12, 'リーガルサービス'),
(33, 12, '縫製'),
(34, 12, '廃却'),
(35, 2, '日本語教育'),
(36, 2, '英語教育'),
(37, 2, '日本語試験運営'),
(38, 2, '消防訓練'),
(39, 2, '救難救護訓練');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_profile`
--

CREATE TABLE `user_profile` (
  `id` bigint(20) NOT NULL,
  `type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `user_profile`
--

INSERT INTO `user_profile` (`id`, `type`) VALUES
(2, 'ADMIN'),
(3, 'DBA'),
(1, 'USER');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `vendors`
--

CREATE TABLE `vendors` (
  `id` int(11) NOT NULL,
  `﻿name` text,
  `person_in_charge` text,
  `telephone_number` text,
  `website` text,
  `mobile_number` text,
  `email` text,
  `address` text,
  `establish_year` text,
  `number_of_employees` int(6) UNSIGNED ZEROFILL DEFAULT NULL,
  `branch` text,
  `date_of_issue` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `vendors`
--

INSERT INTO `vendors` (`id`, `﻿name`, `person_in_charge`, `telephone_number`, `website`, `mobile_number`, `email`, `address`, `establish_year`, `number_of_employees`, `branch`, `date_of_issue`) VALUES
(1, 'Nam Trieu', 'Ms Trang', '84-24-755 5392', '', '0975 363 505', 'trang_dt@namtrieu.com.vn', '', NULL, NULL, NULL, NULL),
(2, 'Hanu', 'Ms Huong', '', '', '', '', '', NULL, NULL, NULL, NULL),
(3, 'Eikoh', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(4, 'VMG', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(5, 'Kumho', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(6, 'JAC', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(7, 'Đại Bảo An', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(8, 'Thiên thảo nguyên', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(9, 'Quang Dung', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(10, 'GIC', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(11, 'Minh An Nam', '', '', '', '0983 275 079', ' tuyenvpplus@gmail.com', 'Số 36, Lô 1A, Khu ĐTM Trung Yên, Trung Hòa, Cầu Giấy, Hà Nội, Việt Nam', NULL, NULL, NULL, NULL),
(12, 'Quốc Hưng', 'Tiến', '', '', '0902066686', 'lebatien@quochung.vn', '', NULL, NULL, NULL, NULL),
(13, 'Công ty cổ phần TM&DV Ngọc Hà', 'Mr.Tấn', '024.3581.6765', '', '0914.88.18.16', 'leminhtan@ngochatrading.com.vn', 'Số 23 Tằng My , Nam Hồng,  Đông Anh, Hà Nội', NULL, NULL, NULL, NULL),
(14, 'Vimax', 'Nguyễn Thị Ái Linh (Ms.)', '', '', '0966 914 124 or 0919 152 069', 'linhnguyen@vmax.com.vn', '18A/76 Nguyen Thi Minh Khai Street, Da Kao Ward, District 1, HCM City', NULL, NULL, NULL, NULL),
(15, 'Hats', 'Ms Thủy', '', '', '0904 296 869', 'thuynt.hats@gmail.com', 'A17/66 Thong Phong- Ton Duc Thang Str, Dong Da Hanoi,  Viet Nam', NULL, NULL, NULL, NULL),
(16, 'Công ty TNHH United Publishers Hà Nội', 'Mr.Tuấn', '', '', '090 342 2436', 'tuan@upjv.co.jp', 'số 3, ngõ 37 Lê Thanh Nghị,Bách Khoa, Hà Nội, Việt Nam', NULL, NULL, NULL, NULL),
(17, 'Công ty cổ phần ứng dụng phát triển công nghệ Đại Phát', 'Mr.Việt anh', '04 37 835310  ', 'indaiphat.com.vn', '0982 480 085 - 0988 928111', 'indaiphat68@gmail.com', 'Số 63 - Trung Yên 9 -Cầu Giấy -  Hà Nội', NULL, NULL, NULL, NULL),
(18, 'Công ty TNHH Thông tin NTT (Việt Nam)', 'Mr.Jang', '024-3766-8466 (ext.121)', 'www.ntt.com.vn', '', 'youngtae.jang@ntt.com.vn', 'Room 201, 2nd F  HITC, 239 Xuan Thuy Str., Dich Vong Hau Ward, Cau Giay Dist., Hanoi', NULL, NULL, NULL, NULL),
(19, 'Công ty TNHH KDDI Việt Nam', 'Ms.Hạnh', '024-3826 2001 (167)', '', '', '', 'Tầng 15, toàn nhà Icon 4, số 243 La Thành, P.Láng Thượng\nHà Nội, Việt Nam', NULL, NULL, NULL, NULL),
(20, 'Công ty TNHH NEC Việt Nam', 'Ms.Chính', '', '', '0912226749', 'chinhhm@nec.vn', '12F Gelex towerm 52 Lê Đại Hành, Hai Bà Trưng, HN', NULL, NULL, NULL, NULL),
(21, 'NTT Communications Corporation', 'Ms.Yoko', '03-6733-7377', '', '', 'yoko.tsuchiya@ntt.com', 'Tokyo 105-8535, Tokyo, JAPAN', NULL, NULL, NULL, NULL),
(22, 'Cty TNHH TM và công nghệ Hoàng Đạo', 'Mr.Hòa', '024.32007621', '', '0936 56 8686 ', 'hoalx@zttc.vn', 'Tầng 15, toà nhà Zodiac  Phố Duy Tân, Cầu Giấy, Hà Nội, , Việt Nam', NULL, NULL, NULL, NULL),
(23, 'Secom', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(24, 'PTI', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(25, 'Yecxanh', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(26, 'Sakura', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(27, 'Tokyo Clinic', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(28, 'Melatec', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(29, 'Công ty TNHH Fujita Việt Nam', 'Mr.Oota', '84-4-3726-2452', '', '0936-433-568', 'ota@fujitavn.com', 'Room 19-01, 19th Floor, Gelex Tower, 52 Le Dai Hanh Str.,Hai Ba Trung Dist., Ha Noi', NULL, NULL, NULL, NULL),
(30, 'Kandenko', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(31, 'Đất Việt', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(32, 'Hải Hà', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(33, 'Fecon', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(34, 'Trạm quan trắc và phân tích môi trường lao động', 'Ms.Phương', '', '', '0962747651', 'thanhphuongvu81@gmail.com', '99 Trần Quốc Toản, Quận Hoàn Kiếm, Hà Nội, Việt Nam', NULL, NULL, NULL, NULL),
(35, 'Micro Precision Calibration', 'Ms.Đắc', '', 'www.microprecision.com', '0987.295.720', 'dacnghiem@microprecision.com', '', NULL, NULL, NULL, NULL),
(36, 'LMS Technologies', 'Mr.Hiệp', '028-35515894 ', 'www.lmsscientific.com', '0938 627 886', 'khanhhiep_hcmc@lmstech.com.sg', 'Floor 5, Dali Tower, 24C Phan Dang Luu, Ward 6, Binh Thanh District, Ho Chi Minh City, Viet Nam', NULL, NULL, NULL, NULL),
(37, 'QAC', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(38, 'Tamsui', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(39, 'Đa kết nối', 'Thảo', '', '', '0937165185/0908336851', 'daydeothe1@gmail.com', '', NULL, NULL, NULL, NULL),
(40, 'Trung tâm dịch vụ tổng hợp', 'Mr.Bình', '', '', '0986-986-684', '', 'Hòa Lạc', NULL, NULL, NULL, NULL),
(41, 'Hoa Hằng Vui', 'Ms.Hằng', '', '', '0946587989', '', 'Nghĩa Tân, Cầu Giấy, Hà Nội', NULL, NULL, NULL, NULL),
(42, 'Công ty TNHH TMDV Đa Kết Nối', 'Ms.Thảo', '', '', '0937165185', '', '127/99 Ni Sư Huỳnh Liên F10, quận Tân Bình, TP. Hồ Chí Minh, Việt Nam', NULL, NULL, NULL, NULL),
(43, 'Nissan Motor Co. Ltd', '', '', '', '', '', '1-1 Takashima 1-chome Nishi-ku Yokohama-shi, Kanagawa 220-8686', NULL, NULL, NULL, NULL),
(44, 'Công ty TNHH sản xuất kinh doanh Khánh Trúc', 'Mr.Sơn', '02435.528.528', 'baohokhanhtruc.com', '0982.262.113', 'tbbhtuanphong@gmail.com', 'Số 34/328 Lê Trọng Tấn - Hoàng Mai - Hà Nội', NULL, NULL, NULL, NULL),
(45, 'Công ty CP thương mại và Dịch vụ Mai Đến', 'Mr.Thanh', '024.62.51.98.98', 'http://www.maiden.vn', '0904 599 828\n09 43 602 466 ', 'thanhnv@maiden.vn ', 'No. 9, Lot 4, Vinaconex 21 Bld, 804 Quang Trung Str,Ha Dong Dist, Ha Noi, Vietnam ', NULL, NULL, NULL, NULL),
(46, 'Minh Phát', 'a Huy', '', '', '0943 966 304', 'minhphatvietnam@gmail.com', '', NULL, NULL, NULL, NULL),
(47, 'LHP VN', 'a Tùng', '', '', '0907 408 768', 'tung.vu@lhp.vn', '', NULL, NULL, NULL, NULL),
(48, 'Emerson', 'a Nghĩa', '', '', '0983 730 232', 'Manhnghia.Nguyen@Emerson.com', '', NULL, NULL, NULL, NULL),
(49, 'Sinh Liên', 'c Liên', '', '', '098 563 5830', 'noithatsinhlien@yahoo.com.vn', '', NULL, NULL, NULL, NULL),
(50, 'Sàn nhựa Á Đông', 'Hạ', '', '', '0984 511 815', 'haadong.kd@gmail.com', '', NULL, NULL, NULL, NULL),
(51, 'Hành Tinh xanh', 'Nguyệt', '', '', '0986 630 046', 'sales115@hanhtinhxanh.com.vn', '', NULL, NULL, NULL, NULL),
(52, 'ONC', 'Yến', '', '', '0983 797 658', 'yengiao@gmail.com', '', NULL, NULL, NULL, NULL),
(53, 'Thu Thủy', '', '', '', '043 5740537', 'www.thietbiytethuthuy.com.vn', '', NULL, NULL, NULL, NULL),
(54, 'Modern Fare', 'Hạnh', '', '', '0903 954 686', 'contact@mofico.com.vn', '', NULL, NULL, NULL, NULL),
(55, 'xây dựng và sản xuất vật liệu Đại Cát', 'Thuận', '', '', '0978 366 356 /  04.37366298', 'thuan87ht@gmail.com', '', NULL, NULL, NULL, NULL),
(56, 'Osum', 'Loan', '', '', '0976 808 706 ', 'kinhdoanh@osum.com.vn', '', NULL, NULL, NULL, NULL),
(57, 'Hà Thành', 'Bốn', '', '', '0948831666', 'vanbon1983@gmail.com', '', NULL, NULL, NULL, NULL),
(58, 'Diệu Huyền', 'Mai', '', '', '0915366635', '', '', NULL, NULL, NULL, NULL),
(59, 'SAM Nong nghiep', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(60, 'LSP-Santino', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(61, 'NAT', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(62, 'Công ty TNHH thiết bị công nghiệp Nagoya', 'Mr.Thao', '024) 39719262/ 39719263', '', '0917000088', '', 'Số 16 ngõ 96 phố Võ Thị Sáu, Q. Hai Bà Trưng、Hà Nội, Việt Nam', NULL, NULL, NULL, NULL),
(63, 'Nishi Tokyo Chemix Corporation', '', '', '', '', '', '2-5-15 Sotokanda, Chiyoda-ku, JAPAN', NULL, NULL, NULL, NULL),
(64, 'Công ty TNHH Giải pháp Tự động hóa và TM Smartek VN', '', '', '', '', '', '29 ngõ 497 Đ.Nguyễn Trãi, P.Thanh Xuân Nam, Q.Thanh Xuân\nHà Nội, Việt Nam', NULL, NULL, NULL, NULL),
(65, 'Công ty TNHH Keyence Việt Nam', 'Mr.Phương', '04-3772.5555 ', 'http://www.keyence.com.vn', '090-222-4019', 'd.phuong@keyence.com.vn', 'P1624-A6, TT CSC, tháp Icon4, 243A Đê La Thành, P.Láng Thượng, Q.Đống Đa, Hà Nội, Việt Nam', NULL, NULL, NULL, NULL),
(66, 'Công ty Cổ phần GM Thăng Long', '', '', '', '', '', 'số 1 đường Lê Quang Đạo, Mễ Trì, Từ Liêm, Việt Nam', NULL, NULL, NULL, NULL),
(67, 'Tokyo Boeki Techno - System Ltd.', 'Mr.Kobari', '', '', '046-246-3955', 'kobari@tbts.co.jp ', '〒243-0801 神奈川県厚木市上依知1261', NULL, NULL, NULL, NULL),
(68, 'Nissan Trading Co.Ltd', 'Ms.Yasuhira', '', '', '050-3360-2035　 ', 'a.yasuhira@nitco.co.jp', '〒244-0805 神奈川県横浜市戸塚区川上町91-1', NULL, NULL, NULL, NULL),
(69, 'Công ty TNHH Nihon Denkei Việt Nam', 'Mr.Hoàng', '024-3951-6507 ', '', '0973-741-863', 'hoang.th@n-denkei.com.vn', '4th ~ 5th  Floor, No.79, Tran Thai Tong Str, Cau Giay Dist, Hanoi, Vietnam', NULL, NULL, NULL, NULL),
(70, 'Công ty TNHH YOKOGAWA Việt Nam', 'Ms.Nhung', '024 3763 5115 (ext: 8147) ', 'https://www.facebook.com/YokogawaVietnam.TMI/ ', '0983 769 495 ', 'Nhung.TrinhThiHong@vn.yokogawa.com', 'Hàng Bài, Q. Hoàn Kiếm, Hà Nội, Việt Nam', NULL, NULL, NULL, NULL),
(71, 'The Representative Office of Quantum Technologies Global Pte Ltd', 'Mr.Thịnh', '08 6685 3730', '', '090 3381 422', 'pham.ducthinh@quantumsg.com', 'Quantum Technologies Global Pte Ltd', NULL, NULL, NULL, NULL),
(72, 'Yamazen Viet Nam Co., Ltd.', 'Ms.Phương', '0243-728-6292 ', '', '', 'tool-dept@yamazenvn.com', 'Ground Floor, Thien Son Plaza, 800 Nguyen Van Linh St., Tan Phu Ward, District 7, HCM', NULL, NULL, NULL, NULL),
(73, 'Công ty CP AHCOM Long Biên', 'Mr.Thành', '024 73041002 - máy lẻ: 310', 'www.nissan-longbien.com.vn', '091.567.6363', 'thanh.daotrung@nissan-longbien.com.vn', '467 Nguyễn Văn Linh, Phúc Đồng, Q.Long Biên, Việt Nam', NULL, NULL, NULL, NULL),
(74, 'Công ty TNHH Shiogai Seiki Việt Nam', 'Ms.Trang', '0251.3936.450(106)', 'www.shiogai.co.jp', '', 'hcm-admin02@shiogai.co.jp, customerservice@shiogai.co.jp\n', '224/4, đường 24-2, KCN Amata, phường Long Bình, thành phố Biên Hòa, Đồng Nai, Việt Nam', NULL, NULL, NULL, NULL),
(75, 'MMTVN', 'A Huy', '', '', '0936 499 975', 'huylq@mmt.vn', '', NULL, NULL, NULL, NULL),
(76, 'Công ty cổ phần bảo hộ lao động Khánh trúc', 'Sơn ', '', '', '0917 779 610', '', 'soố 4 , ngõ 88, Trần Quag Diệu, Đống Đa, Hà Nội', NULL, NULL, NULL, NULL),
(77, 'Bảo hộ lao động Việt Nam', 'Vinh', '', '', '0912831383', 'info.baohovietnam@gmail.com', '', NULL, NULL, NULL, NULL),
(78, 'Ha Son', 'Ms Miều ', '', '', '', '', '', NULL, NULL, NULL, NULL),
(79, 'KSMC', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(80, 'Vina Taiyo', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(81, 'Tien Tiến', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(82, 'Công ty TNHH Tin Học & Thương Mại Hồng Cơ', 'Phương', '979734920', '', '0979734920', 'phuong.ltt@hongco.com.vn', 'So 04 Nam Quốc Cảng, Hồ Chí Minh, Việt Nam', NULL, NULL, NULL, NULL),
(83, 'Công ty TNHH Điện tử Sharp Việt Nam', 'Ms.Kính', '028-39107499 - Ext: 312', '', '', 'kinh.lethingoc@svn.sharp-world.com', 'Tầng 3, tòa nhà Saigon, số 9 Đinh Tiên Hoàng, Hồ Chí Minh, Việt Nam', NULL, NULL, NULL, NULL),
(84, 'Công ty TNHH Ricoh Việt Nam', 'Ms.Vân Anh', '02437954274', '', '', 'Anh.VuVan@ricoh.com.vn', 'tầng 17, tòa nhà Etowm Central, số 11 Đoàn Văn Bơ, phường 12, quận 4, thành phố HCM', NULL, NULL, NULL, NULL),
(85, 'Công ty cổ phần TM&DV Khai Trí', 'Mr.Khánh', '024.35667311 – Máy lẻ 112     ', '', '0984161166\n0916234499', 'congkhanh@khaitrijsc.com', 'Số 24 ngõ 93/20 Hoàng Văn Thái, Q. Thanh Xuân\nHà Nội, Việt Nam', NULL, NULL, NULL, NULL),
(86, 'Tân Duy Linh', 'a Khánh', '', '', '0903 772 433', 'info@tanduylinh.com', '', NULL, NULL, NULL, NULL),
(87, 'Newday', 'Hưng', '', '', '0948 242 488', 'oanhbui@vietnewday.vn', '', NULL, NULL, NULL, NULL),
(88, 'Samsung', 'a Nam', '', '', '0982 569 899', '', '', NULL, NULL, NULL, NULL),
(89, 'Pico', 'Phương', '', '', '0165 616 8515', 'phuongnh@pico.com.vn', '', NULL, NULL, NULL, NULL),
(90, 'Visco', 'a Kiên', '', '', '0936 282 101', 'duckien@visco-vn.com', '', NULL, NULL, NULL, NULL),
(91, 'FPT', 'Hiếu', '', '', '090 626 7373', 'hieulq@fpt.com.vn', '', NULL, NULL, NULL, NULL),
(92, 'Công ty TNHH Fujitsu Việt Nam', 'Ms.Hằng', '024 2220 3113 ', 'http://vn.fujitsu.com', '0947 795 788', 'hangttt@vn.fujitsu.com', 'P01-03 tầng 17 Keangnam HN, Landmark Tower KĐT mới Cầu Giấy, P.Mễ Trì, Q. Nam Từ Liêm Hà Nội, Việt Nam', NULL, NULL, NULL, NULL),
(93, 'Tuan thanh', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(94, 'CDC', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(95, 'Trung tâm thiết bị PCCC Hà Nội', '', '', '', '', '', '28B Điện Biên Phủ, Ba Đình, ,Hà Nội, Việt Nam', NULL, NULL, NULL, NULL),
(96, 'TT Nghiên cứu Ứng dụng KHKT PCCC', '', '', '', '', '', '243 Khuất Duy Tiến,, Thanh Xuân, Hà Nội, Việt Nam', NULL, NULL, NULL, NULL),
(97, 'Vietsafe', 'Mr.Quang', '', '', '0982612645', '', '', NULL, NULL, NULL, NULL),
(98, 'Công ty TNHH dịch vụ tổng hợp & công nghệ Phúc Bình', '', '', '', '', '', 'Tầng 3, Mỹ Đình plaza, 138 Trần Bình, Hà Nội', NULL, NULL, NULL, NULL),
(99, 'Công ty cổ phần đầu tư và tư vấn xây dựng 306', 'Cô Tứ', '', '', '0983-608-245', '', 'Số 19, tổ 52, P.Dịch Vọng Hậu, Q.Cầu Giấy, Hà Nội, Việt Nam', NULL, NULL, NULL, NULL),
(100, 'TH True Milk', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(101, 'Big C', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(102, 'Uchida Spectrum Inc.', 'Tomoka Yanagisawa', '81-3-5543-6800', 'www.spectrum.co.jp', '', 'Nissan_MS_License_Support@spectrum.co.jp', '1-16-14, Shinkawa, chuo-ku, tokyo, 104-0033', NULL, NULL, NULL, NULL),
(103, 'Mentor Graphics Asia PTE LTD', '', '', '', '', '', '#23-07 Novena Square Tower A\n', NULL, NULL, NULL, NULL),
(104, 'NICS', 'Mr.Sasaoka', '', '', '', 'm-sasaoka@mail.nissan.co.jp', '560-2,Okatsukoku\nAtsugi-shi, Kanagawa 243-0126,Japan\n', NULL, NULL, NULL, NULL),
(105, 'National Instruments Singapore Pte. Ltd', '', '', '', '', '', 'No2 International Business Park, the Strategy Tower 1 #06-03, Singapore 609930', NULL, NULL, NULL, NULL),
(106, 'FTD Solutions PTE Ltd', '', '', '', '', '', '159 Kampong Ampat #06-03 KA Place', NULL, NULL, NULL, NULL),
(107, 'Horiba Ltd.', 'Mr.Koshi Hosokawa', '081 (0)75-313-8123 ', 'http://www.horiba.com/jp/contact-us/worldwide-locations/', '', 'koshi.hosokawa@horiba.com ', 'Miyanohigashi, Kisshoin, Minami-ku, Kyoto, Kyoto', NULL, NULL, NULL, NULL),
(108, 'ETAS GmbH', '', '', '', '', '', '70469 Stuttgart, GERMANY', NULL, NULL, NULL, NULL),
(109, 'Toyota tsusho Nexty electronics (thai) co., ltd', 'Mr.Tsukahara', '(66) 2639-3500', '', '', 'tsukahara@th.nexty-ele.com', '15-16th F, Mercury tower, 540 Ploenchit road, Lumpini, Pathumwan, Bangkok, Thai, 10330', NULL, NULL, NULL, NULL),
(110, 'MSC Software (S) Pte Ltd', 'Mr.Rajesh ', '', 'http://support.mscsoftware.com/servicerequest', '', 'Rajesh.Batumalai@mscsoftware.com', '#16-05 Shaw Tower, 189702, SINGAPORE', NULL, NULL, NULL, NULL),
(111, 'PRQA Programming Research', 'Darren Riley', '44 (0) 1932 707315', '', '+44 (0) 7827 849123', 'Darren_Riley@programmingresearch.com', 'Programming Research Limited, Ashley Park House, 42-50 Hersham Road\nWalton-on-Thames, Surrey KT12 1RZ, United Kingdom', NULL, NULL, NULL, NULL),
(112, 'dSPACE GmbH', 'Ms.Tanja Kilimann', '49 5251 1638-0', 'http://www.dSPACE.com', '', 'TKilimann@dspace.de', 'Rathenaustrasse 26, 33102 Paderborn, Germany, GERMANY', NULL, NULL, NULL, NULL),
(113, 'Imagix Corporation', 'Mr.John', '1.805.781.6002', 'http://www.imagix.com', '', 'johnb@imagix.com', '6025 White Oak Lane San Luis Obispo, CA 93401   USA', NULL, NULL, NULL, NULL),
(114, 'Digital Process Ltd', 'Mr.Yamazaki', '046-225-3924', '', '', 'yamazaki@dipro.co.jp', '2-9-6, Nakacho, Atsugi city Kanagawa, 243-0018 Japan, JAPAN', NULL, NULL, NULL, NULL),
(115, 'New System', 'Ms.Bích', '024-38813189, ', 'http://newsystemvietnam.com/', '0985 299 146', 'le.bich@newsystemvietnam.com', 'R. 101 - Techno Center - Thang Long IP - Kim Chung - Dong Anh - Hanoi - Vietnam', NULL, NULL, NULL, NULL),
(116, 'WorleyParsons Pte Limiteds', 'Ms.Chin Fang', '65 6517 7716', '', '65 6735 8444', 'Chinfang.Goh@worleyparsons.com', '111 Somerset Road #12-05 Singapore 238164', NULL, NULL, NULL, NULL),
(117, 'Mechanical Simulation Corporation', 'Mr.Robert ', '', '', '', 'rmcginnis@carsim.com', '755 Phoenix Drive, Ann Arbor, MI48108, USA', NULL, NULL, NULL, NULL),
(118, 'Nissan Creative Service Co., Ltd', 'Mr.Sasaoka', '', '', '', 'm-sasaoka@mail.nissan.co.jp', '560-2,Okatsukoku\nAtsugi-shi, Kanagawa 243-0126,Japan', NULL, NULL, NULL, NULL),
(119, 'Công ty TNHH Thương Mại Và Dịch Vụ TSG', 'Ms.Dien', '04 7305 0506 (Ext.821)', '', '0989 712 611', 'dien.le@tsg.net.vn ', 'Tầng 2, tòa nhà ATS, 262 Hoàng Quốc Việt, Từ Liêm, HN', NULL, NULL, NULL, NULL),
(120, 'Vector Japan Co.,Ltd', '', '', '', '', '', 'Tennouzu Yusen, Higashi-shinagawa', NULL, NULL, NULL, NULL),
(121, 'Altair Engineering Sdn Bhd Co', '', '', '', '', '', 'Suite #29 Regues, Level 16 1 Sentral, Jalan Stesen Sentral 5 KL Sentral, Việt Nam', NULL, NULL, NULL, NULL),
(122, 'CD- adapco London office', '', '', '', '', '', '200 shepherds bush Road, London', NULL, NULL, NULL, NULL),
(123, 'Vietsoft', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(124, 'Công ty TNHH MTV công nghệ chế tạo máy & hệ thống tự động hóa', '', '', '', '', '', '51 Hàng Bồ, Q. Hoàn Kiếm, Hà Nội, Việt Nam', NULL, NULL, NULL, NULL),
(125, 'Vector Informatik GmbH', '', '', '', '', '', 'Ingersheime Str.24 D-70499 Stuttgart, ', NULL, NULL, NULL, NULL),
(126, 'Japan CDH Corporation', '', '', '', '', '', 'Yokohama, Kanagawa, JAPAN', NULL, NULL, NULL, NULL),
(127, 'Zuken Singapore PTE. LTD', '', '', '', '', '', '152 Beach Road, #22-05, Gateway East, Singapore 189721 ', NULL, NULL, NULL, NULL),
(128, 'AD device co.,ltd', '', '', '', '', '', '7F,20 Kanda Matsunagacho, Chioda-ku, Tokyo', NULL, NULL, NULL, NULL),
(129, 'IDAJ Co., Ltd', '', '', '', '', '', '2-2-1-1 Minato Mirai, Nishi-ku, Yokohama, 220-8137, JAPAN', NULL, NULL, NULL, NULL),
(130, 'Siemens K.K.', '', '', '', '', '', 'Arena Tower 14F,3-1-9 Shinyokohama, Kohoku-Ku, Yokohama, Kanagawa, 222-0033', NULL, NULL, NULL, NULL),
(131, 'Công ty CP Môi trường đô thị & Công nghiệp 10', 'Mr.Trọng', '024.6680.4414', 'www.urenco10.com.vn', '0976.373.763', 'binhtrongvh@gmail.com', 'Số 2, tổ 15 đường An Dương Vương - Tây Hồ - Hà Nội', NULL, NULL, NULL, NULL),
(132, 'Công ty CP Môi trường đô thị & Công nghiệp 11', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(133, 'Hoa Binh', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(134, 'Công ty cổ phần Nibe', '', '', '', '', '', 'Lô C6, khu đô thị mới 15 Đông Quan, P.Quan Hoa, Quận Cầu Giấy, Hà Nội', NULL, NULL, NULL, NULL),
(135, 'Công ty TNHH tư vấn kết nối Nhật Việt', '', '', '', '', '', '4th Floor, VITRANCO Building, 192 Thai Thinh Str., Dong Da Dist., Hanoi', NULL, NULL, NULL, NULL),
(136, 'Tran JV (TTP)', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(137, 'Seikou Ideas', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(138, 'Công ty TNHH Sagawa Express Việt Nam tại HN', 'Ms.Nhung', '1900 545 596', 'www.sagawa-vtm.com.vn.', '0934 464 345', 'thuy_nhung@sgh-global.com', 'No.22-B1,Lê Đức Thọ,Mỹ Đình, Hà Nội, Việt Nam', NULL, NULL, NULL, NULL),
(139, 'Công ty TNHH Quốc tế Delta', '', '', 'www.delta.com.vn', '', '', 'số 1, ngách 49, ngõ Thịnh Hào 1, đường Tôn Đức Thắng, phường Hàng Bột, quận Đống Đa, HN', NULL, NULL, NULL, NULL),
(140, 'TransAZ', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(141, 'K-Lines', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(142, 'Nippon', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(143, 'Thiết bị y tế Đức Anh', 'Huệ', '', '', '(04) 8587 8459', 'thietbiytequynhanh@gmail.com', '', NULL, NULL, NULL, NULL),
(144, 'Pharmacity', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(145, 'Sông Hồng', 'c Thanh', '', '', '01666 844 468', '', '', NULL, NULL, NULL, NULL),
(146, 'CÔNG TY TNHH DỊCH VỤ CÔNG NGHIỆP VINA SAO', 'Mr.Khởi', '024 3 7586 101', '', '0979 211 881', 'khoi.vinasis@gmail.com', 'SN172 đường Tân Xuân,P.Đông Ngạc, Q.Bắc Từ LiêmHà Nội, Việt Nam', NULL, NULL, NULL, NULL),
(147, 'Công ty cổ phân thương mại và dịch vụ làm sạch công nghiệp việt', 'Ms.Nga', '04.2 2431304', 'http://www.vietcleaning.com', '0982 54 66 55', 'trannga@vietcleaning.com.vn', 'VP- Hà Nội: Số 3,100/33 Hoàng Quốc Việt, Nghĩa Đô, Cầu Giấy, Hà Nội', NULL, NULL, NULL, NULL),
(148, 'Trung tâm quản lý hạ tầng HHPD', 'Ms.Tỉnh', '', '', '0978943805', 'phungtinhhm@gmail.com', 'Km29, đại lộ Thăng Long, xã Thạch Hoà, huyện Thạch Thất , tp Hà Nội', NULL, NULL, NULL, NULL),
(149, 'CÔNG TY TNHH VỆ SINH CÔNG NGHIỆP KHÔNG GIAN SẠCH', 'MS.Thao', '', '', '09.1111.3822', 'khonggiansach2588@gmail.com', 'Số 22 ngách 37 ngõ 145 Cổ Nhuế - Từ Liêm - HN', NULL, NULL, NULL, NULL),
(150, 'Hoan My', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(151, 'Công nghệ xanh Châu Á', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(152, 'Công nghệ Biotech', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(153, 'Luật Lincon', 'Mr Quân', '', '', '04. 6285 1114', '', 'Tầng 20, tháp A-HH4, tòa nhà Sông Đà, đường Phạm Hùng, Nam Từ Liêm, Hà Nội.', NULL, NULL, NULL, NULL),
(154, 'Leadco', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(155, 'Beker', '', '', '', '', '', '', NULL, NULL, NULL, NULL),
(156, 'Asahi & Nishimura ', '', '', '', '', '', '21/119/189 Nguyễn Ngọc Vũ, Trung Hòa, Hà Nội, Việt Nam', NULL, NULL, NULL, NULL),
(157, 'Santino', '', '', '', '', '', '', NULL, NULL, NULL, NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `app_user`
--
ALTER TABLE `app_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sso_id` (`sso_id`);

--
-- Chỉ mục cho bảng `app_user_user_profile`
--
ALTER TABLE `app_user_user_profile`
  ADD PRIMARY KEY (`user_id`,`user_profile_id`),
  ADD KEY `FK_USER_PROFILE` (`user_profile_id`);

--
-- Chỉ mục cho bảng `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`book_id`),
  ADD UNIQUE KEY `book_id` (`book_id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_category_id_idx` (`category_id`),
  ADD KEY `fk_vendor_id_idx` (`vendor_id`);

--
-- Chỉ mục cho bảng `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`),
  ADD KEY `fk_parent_caterogy_id_idx` (`parent_id`);

--
-- Chỉ mục cho bảng `user_profile`
--
ALTER TABLE `user_profile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `type` (`type`);

--
-- Chỉ mục cho bảng `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `app_user`
--
ALTER TABLE `app_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `book`
--
ALTER TABLE `book`
  MODIFY `book_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT cho bảng `user_profile`
--
ALTER TABLE `user_profile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=158;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `app_user_user_profile`
--
ALTER TABLE `app_user_user_profile`
  ADD CONSTRAINT `FK_APP_USER` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`),
  ADD CONSTRAINT `FK_USER_PROFILE` FOREIGN KEY (`user_profile_id`) REFERENCES `user_profile` (`id`);

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Các ràng buộc cho bảng `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD CONSTRAINT `fk_parent_caterogy_id` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
