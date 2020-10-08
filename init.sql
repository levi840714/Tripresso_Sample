CREATE DATABASE IF NOT EXISTS `Tripresso` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

use `Tripresso`;

CREATE TABLE `tag` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '標籤名',
  `detail` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'tag細節介紹',
  `hasDetail` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '是否有詳細資訊: ''0''=>''無'',''1''=>''有''',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `tag` (`id`, `name`, `detail`, `hasDetail`, `created_at`, `updated_at`) VALUES
(1, '國內旅遊', NULL, '0', '2020-10-07 17:01:05', '2020-10-07 17:31:44'),
(2, '自理三餐', '行程中由旅客自行安排的餐食，能自由體驗在地美食。(不提供餐費)', '1', '2020-10-07 17:01:05', '2020-10-07 17:31:44'),
(3, '振興三倍券', NULL, '0', '2020-10-07 17:01:05', '2020-10-07 17:31:44');


CREATE TABLE `trip` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '行程號',
  `title` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '標題',
  `region` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '旅遊地區',
  `score` tinyint(3) UNSIGNED NOT NULL COMMENT '評分',
  `tags` text COLLATE utf8mb4_unicode_ci COMMENT '標籤json',
  `people` smallint(10) UNSIGNED NOT NULL COMMENT '總團位數',
  `days` tinyint(3) UNSIGNED NOT NULL COMMENT '旅遊天數',
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '狀態: ''0''=>停用,''1''=>''啟用''',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `trip` (`id`, `code`, `title`, `region`, `score`, `tags`, `people`, `days`, `status`, `created_at`, `updated_at`) VALUES
(1, '17OBURG1', '『太平洋環島』宜蘭葛瑪蘭的故鄉．高雄浪漫港都愛河．台東太平洋海岸巡奇．花東縱谷太魯閣五日', '台灣', 10, '[\"1\",\"2\",\"3\"]', 10, 5, '1', '2020-10-07 16:58:14', '2020-10-07 17:31:28'),
(2, '19TMTCHWGZ', '【天天出發】Together一起旅行．台北武陵農場榮民、長者、學生接駁優惠', '台中', 8, '[\"1\",\"3\"]', 5, 1, '1', '2020-10-08 12:52:56', '2020-10-08 12:53:15');

CREATE TABLE `trip_group` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `trip_id` bigint(20) UNSIGNED NOT NULL COMMENT '行程',
  `start_date` date NOT NULL COMMENT '出發日期',
  `amount` int(11) NOT NULL COMMENT '金額',
  `reward` int(11) NOT NULL COMMENT '回饋咖幣',
  `last_people` smallint(11) UNSIGNED NOT NULL COMMENT '剩餘團位數',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `trip_group` (`id`, `trip_id`, `start_date`, `amount`, `reward`, `last_people`, `created_at`, `updated_at`) VALUES
(1, 1, '2020-10-17', 20200, 1010, 7, '2020-10-07 17:02:35', '2020-10-07 17:02:35'),
(2, 1, '2020-10-18', 20500, 1025, 8, '2020-10-07 17:02:40', '2020-10-07 17:02:35'),
(3, 1, '2020-10-19', 20500, 1025, 9, '2020-10-07 17:02:45', '2020-10-07 17:02:35'),
(4, 1, '2020-10-20', 20500, 1025, 10, '2020-10-07 17:02:50', '2020-10-07 17:02:35'),
(5, 2, '2020-10-15', 400, 20, 4, '2020-10-08 04:59:32', '2020-10-08 04:59:32'),
(6, 2, '2020-10-17', 500, 25, 5, '2020-10-08 04:59:32', '2020-10-08 04:59:32');

ALTER TABLE `tag` ADD PRIMARY KEY (`id`);

ALTER TABLE `trip` ADD PRIMARY KEY (`id`);

ALTER TABLE `trip_group` ADD PRIMARY KEY (`id`),ADD KEY `trip_id` (`trip_id`);
