-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 18, 2025 at 01:57 PM
-- Server version: 8.0.36-28
-- PHP Version: 8.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rideon-codecan`
--

-- --------------------------------------------------------

--
-- Table structure for table `add_coupons`
--

CREATE TABLE `add_coupons` (
  `id` bigint UNSIGNED NOT NULL,
  `coupon_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `coupon_subtitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_expiry_date` date DEFAULT NULL,
  `coupon_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_order_amount` decimal(15,2) DEFAULT NULL,
  `coupon_value` decimal(15,2) NOT NULL,
  `coupon_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module` tinyint(1) NOT NULL DEFAULT '2',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `all_packages`
--

CREATE TABLE `all_packages` (
  `id` bigint UNSIGNED NOT NULL,
  `package_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `package_total_day` int NOT NULL,
  `package_price` decimal(15,2) NOT NULL,
  `package_description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `max_item` int NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `module` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `all_packages`
--

INSERT INTO `all_packages` (`id`, `package_name`, `package_total_day`, `package_price`, `package_description`, `max_item`, `status`, `created_at`, `updated_at`, `module`) VALUES
(1, 'Basic', 365, 10.00, '<p>Basic</p>', 30, '1', '2023-07-04 22:49:25', '2024-12-13 18:41:26', NULL),
(2, 'Gold', 365, 150.00, '<p>Gold</p>', 20, '1', '2023-07-04 22:50:15', '2024-08-13 08:35:54', NULL),
(3, 'Silver', 15, 30.00, '<p>Silver</p>', 15, '1', '2023-07-04 22:51:02', '2024-11-02 10:24:08', NULL),
(5, 'Platinum', 30, 1000.00, NULL, 2, '1', '2024-11-02 11:06:40', '2024-11-02 11:06:40', NULL),
(6, 'child seat', 10, 11.00, '<p>child seat 1</p>', 1, '1', '2024-11-08 17:25:49', '2024-11-08 17:25:49', NULL),
(7, 'Testing', 20, 10.00, '<p>tttteessssiinggg</p>', 5, '0', '2024-12-10 16:40:36', '2024-12-10 16:42:37', NULL),
(8, 'Test', 5, 1500.00, NULL, 3, '0', '2024-12-13 02:39:49', '2025-01-13 13:38:16', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `app_users`
--

CREATE TABLE `app_users` (
  `id` bigint UNSIGNED NOT NULL,
  `firestore_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `middle1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `intro1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `langauge1` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country1` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wallet` decimal(15,2) DEFAULT NULL,
  `otp_value` int DEFAULT '0',
  `token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `reset_token` int DEFAULT '0',
  `verified` tinyint DEFAULT NULL,
  `document_verify` tinyint DEFAULT '0',
  `phone_verify` tinyint NOT NULL DEFAULT '0',
  `email_verify` tinyint NOT NULL DEFAULT '0',
  `login_type` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `host_status` enum('0','1','2') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `birthdate_1` date DEFAULT NULL,
  `social_id` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ave_host_rate` decimal(15,2) NOT NULL DEFAULT '0.00',
  `avr_guest_rate` decimal(15,2) NOT NULL DEFAULT '0.00',
  `status` tinyint(1) DEFAULT '1',
  `package_id` bigint UNSIGNED DEFAULT '1',
  `fcm` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `sms_notification1` tinyint NOT NULL DEFAULT '0',
  `email_notification1` tinyint NOT NULL DEFAULT '0',
  `push_notification1` tinyint NOT NULL DEFAULT '0',
  `device_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `app_users_bank_accounts`
--

CREATE TABLE `app_users_bank_accounts` (
  `id` int NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `account_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `iban` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `swift_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `app_user_meta`
--

CREATE TABLE `app_user_meta` (
  `id` bigint NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `meta_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `app_user_otps`
--

CREATE TABLE `app_user_otps` (
  `id` int NOT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `otp_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint UNSIGNED NOT NULL,
  `token` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `itemid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `userid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `host_id` bigint NOT NULL,
  `ride_date` date NOT NULL,
  `status` enum('Pending','Ongoing','Arrived','Accepted','Cancelled','Confirmed','Declined','Expired','Refunded','Completed','Rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price_per_km` decimal(15,2) NOT NULL,
  `base_price` decimal(15,2) NOT NULL,
  `service_charge` decimal(15,2) DEFAULT '0.00',
  `iva_tax` decimal(15,2) DEFAULT '0.00',
  `coupon_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_discount` double(15,2) NOT NULL DEFAULT '0.00',
  `discount_price` double(15,2) NOT NULL DEFAULT '0.00',
  `amount_to_pay` double(15,2) DEFAULT '0.00',
  `total` decimal(15,2) DEFAULT '0.00',
  `admin_commission` decimal(24,2) NOT NULL DEFAULT '0.00',
  `vendor_commission` decimal(24,2) NOT NULL DEFAULT '0.00',
  `vendor_commission_given` tinyint NOT NULL DEFAULT '0',
  `currency_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancellation_reasion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancelled_charge` decimal(15,2) NOT NULL DEFAULT '0.00',
  `transaction` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` enum('notpaid','pending','paid','offline','') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firebase_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `wall_amt` decimal(15,2) DEFAULT '0.00',
  `rating` int NOT NULL DEFAULT '0',
  `module` tinyint NOT NULL DEFAULT '2',
  `cancelled_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deductedAmount` double(15,2) NOT NULL DEFAULT '0.00',
  `refundableAmount` double(15,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `booking_cancellation_policies`
--

CREATE TABLE `booking_cancellation_policies` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `type` enum('fixed','percent','none') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` decimal(15,2) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `module` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cancellation_time` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `booking_cancellation_policies`
--

INSERT INTO `booking_cancellation_policies` (`id`, `name`, `description`, `type`, `value`, `status`, `module`, `created_at`, `updated_at`, `cancellation_time`) VALUES
(1, 'Normal Policy', '0% deduction will apply if canceled at least 24 hours before the rental start time', 'percent', 0.00, 1, 2, '2024-07-12 07:02:22', '2024-12-04 15:50:31', 48),
(8, 'Super Policy', '80% deduction will apply if canceled within 12 hours of the rental start time.', 'percent', 80.00, 1, 2, '2024-11-29 11:39:29', '2024-12-04 15:50:45', 12),
(9, 'Flexible Policy', '50% deduction will be issued if canceled between 24 and 12 hours prior to the rental start time.', 'percent', 50.00, 1, 2, '2024-11-29 11:43:19', '2024-12-04 15:50:13', 24);

-- --------------------------------------------------------

--
-- Table structure for table `booking_cancellation_reasons`
--

CREATE TABLE `booking_cancellation_reasons` (
  `order_cancellation_id` int NOT NULL,
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `module` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `booking_cancellation_reasons`
--

INSERT INTO `booking_cancellation_reasons` (`order_cancellation_id`, `reason`, `user_type`, `status`, `module`, `created_at`, `updated_at`) VALUES
(1, 'Change of plans', 'user', 1, 2, '2024-07-12 06:59:16', '2024-11-02 12:10:49'),
(2, 'Found a better deal', 'user', 1, 2, '2024-07-12 06:59:27', '2024-07-12 06:59:27'),
(3, 'Vehicle not needed anymore', 'user', 1, 2, '2024-07-12 06:59:39', '2024-07-12 06:59:39'),
(4, 'Vehicle already booked', 'host', 1, 2, '2024-07-12 07:00:08', '2024-07-12 07:00:08'),
(5, 'Maintenance issues', 'host', 1, 2, '2024-07-12 07:00:19', '2024-07-12 07:00:19'),
(6, 'Insurance coverage problems', 'host', 1, 2, '2024-07-12 07:00:42', '2025-07-29 08:34:08');

-- --------------------------------------------------------

--
-- Table structure for table `booking_extensions`
--

CREATE TABLE `booking_extensions` (
  `id` bigint UNSIGNED NOT NULL,
  `booking_id` bigint UNSIGNED NOT NULL,
  `ride_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pickup_location` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `dropoff_location` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `estimated_distance_km` decimal(10,2) DEFAULT NULL,
  `estimated_duration_min` int DEFAULT NULL,
  `pick_otp` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `booking_meta`
--

CREATE TABLE `booking_meta` (
  `id` bigint NOT NULL,
  `booking_id` bigint UNSIGNED NOT NULL,
  `meta_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` bigint UNSIGNED NOT NULL,
  `city_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longtitude` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `region` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_us`
--

CREATE TABLE `contact_us` (
  `id` int NOT NULL,
  `tittle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user` int NOT NULL,
  `status` int NOT NULL,
  `module` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `currency`
--

CREATE TABLE `currency` (
  `id` int UNSIGNED NOT NULL,
  `currency_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `currency_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value_against_default_currency` double DEFAULT NULL,
  `currency_symbol` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `currency`
--

INSERT INTO `currency` (`id`, `currency_name`, `currency_code`, `value_against_default_currency`, `currency_symbol`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Thai Baht', 'THB', 34.3457, '฿', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(2, 'Albanian Lek', 'ALL', 93.1414, 'L', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(3, 'Armenian Dram', 'AMD', 394.3745, '֏', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(4, 'Netherlands Antillean Guilder', 'ANG', 1.79, 'ƒ', 1, '2024-07-29 11:30:57', '2024-10-05 14:56:36'),
(6, 'Argentine Peso', 'ARS', 1011.75, '$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(7, 'Australian Dollar', 'AUD', 1.5381, '$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(8, 'Aruban Florin', 'AWG', 1.79, 'ƒ', 1, '2024-07-29 11:30:57', '2024-10-05 14:56:36'),
(9, 'Azerbaijani Manat', 'AZN', 1.7002, '₼', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(10, 'Bosnia-Herzegovina Convertible Mark', 'BAM', 1.8524, 'KM', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(11, 'Barbadian Dollar', 'BBD', 2, '$', 1, '2024-07-29 11:30:57', '2024-10-05 14:56:36'),
(12, 'Bangladeshi Taka', 'BDT', 119.4888, '৳', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(13, 'Bulgarian Lev', 'BGN', 1.8524, 'лв', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(14, 'Bahraini Dinar', 'BHD', 0.376, '.د.ب', 1, '2024-07-29 11:30:57', '2024-10-05 14:56:36'),
(15, 'Burundian Franc', 'BIF', 2930.5659, 'FBu', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(16, 'Bermudan Dollar', 'BMD', 1, '$', 1, '2024-07-29 11:30:57', '2024-10-05 14:56:36'),
(17, 'Brunei Dollar', 'BND', 1.3394, '$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(18, 'Bolivian Boliviano', 'BOB', 6.9137, '$b', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(19, 'Brazilian Real', 'BRL', 5.9862, 'R$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(20, 'Bahamian Dollar', 'BSD', 1, '$', 1, '2024-07-29 11:30:57', '2024-10-05 14:56:36'),
(21, 'Bhutanese Ngultrum', 'BTN', 84.6214, 'Nu.', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(22, 'Botswanan Pula', 'BWP', 13.6266, 'P', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(23, 'New Belarusian Ruble', 'BYN', 3.2754, 'Br', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(24, 'Belize Dollar', 'BZD', 2, 'BZ$', 1, '2024-07-29 11:30:57', '2024-10-05 14:56:36'),
(25, 'Canadian Dollar', 'CAD', 1.4007, '$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(26, 'Congolese Franc', 'CDF', 2854.1544, 'FC', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(27, 'Swiss Franc', 'CHF', 0.8814, 'CHF', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(28, 'Chilean Peso', 'CLP', 977.8676, '$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(29, 'Chinese Yuan', 'CNY', 7.2569, '¥', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(30, 'Colombian Peso', 'COP', 4414.1048, '$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(31, 'Costa Rican Colón', 'CRC', 508.8708, '₡', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(32, 'Cuban Peso', 'CUP', 24, '₱', 1, '2024-07-29 11:30:57', '2024-10-05 14:56:36'),
(33, 'Cape Verdean Escudo', 'CVE', 104.4359, '$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(34, 'Czech Republic Koruna', 'CZK', 23.9276, 'Kč', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(35, 'Djiboutian Franc', 'DJF', 177.721, 'Fdj', 1, '2024-07-29 11:30:57', '2024-10-05 14:56:36'),
(36, 'Danish Krone', 'DKK', 7.0674, 'kr', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(37, 'Dominican Peso', 'DOP', 60.3143, 'RD$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(38, 'Algerian Dinar', 'DZD', 133.4414, 'دج', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(39, 'Egyptian Pound', 'EGP', 49.5863, '£', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(40, 'Eritrean Nakfa', 'ERN', 15, 'Nfk', 1, '2024-07-29 11:30:57', '2024-10-05 14:56:36'),
(41, 'Ethiopian Birr', 'ETB', 124.5949, 'Br', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(42, 'Euro', 'EUR', 0.9472, '€', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(43, 'Fijian Dollar', 'FJD', 2.2662, '$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(44, 'Falkland Islands Pound', 'FKP', 0.7873, '£', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(45, 'Faroese Króna', 'FOK', 7.0667, 'kr', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(46, 'British Pound Sterling', 'GBP', 0.7873, '£', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(47, 'Georgian Lari', 'GEL', 2.7813, '₾', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(48, 'Guernsey Pound', 'GGP', 0.7873, '£', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(49, 'Ghanaian Cedi', 'GHS', 15.3832, '¢', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(50, 'Gibraltar Pound', 'GIP', 0.7873, '£', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(51, 'Gambian Dalasi', 'GMD', 71.8837, 'D', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(52, 'Guinean Franc', 'GNF', 8601.202, 'Fr', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(53, 'Guatemalan Quetzal', 'GTQ', 7.7109, 'Q', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(54, 'Guyanaese Dollar', 'GYD', 209.2041, '$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(55, 'Hong Kong Dollar', 'HKD', 7.7822, '$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(56, 'Honduran Lempira', 'HNL', 25.2812, 'L', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(57, 'Croatian Kuna', 'HRK', 7.1362, 'kn', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(58, 'Haitian Gourde', 'HTG', 131.0987, 'G', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(59, 'Hungarian Forint', 'HUF', 391.2825, 'Ft', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(60, 'Indonesian Rupiah', 'IDR', 15851.4664, 'Rp', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(61, 'Israeli New Sheqel', 'ILS', 3.6336, '₪', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(62, 'Manx pound', 'IMP', 0.7873, '£', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(63, 'Indian Rupee', 'INR', 84.6255, '₹', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(64, 'Iraqi Dinar', 'IQD', 1311.5071, 'ع.د', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(65, 'Iranian Rial', 'IRR', 41959.1659, '﷼', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(66, 'Icelandic Króna', 'ISK', 137.9322, 'kr', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(67, 'Jersey Pound', 'JEP', 0.7873, '£', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(68, 'Jamaican Dollar', 'JMD', 158.8805, 'J$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(69, 'Jordanian Dinar', 'JOD', 0.709, 'د.ا', 1, '2024-07-29 11:30:57', '2024-10-05 14:56:36'),
(70, 'Japanese Yen', 'JPY', 149.9179, '¥', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(71, 'Kenyan Shilling', 'KES', 129.5985, 'KSh', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(72, 'Kyrgystani Som', 'KGS', 86.1646, 'лв', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(73, 'Cambodian Riel', 'KHR', 4033.4761, '៛', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(74, 'Kiribati Dollar', 'KID', 1.538, '$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(75, 'Comorian Franc', 'KMF', 465.9601, 'CF', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(76, 'South Korean Won', 'KRW', 1394.7292, '₩', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(77, 'Kuwaiti Dinar', 'KWD', 0.3073, 'د.ك', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(78, 'Cayman Islands Dollar', 'KYD', 0.8333, '$', 1, '2024-07-29 11:30:57', '2024-10-05 14:56:36'),
(79, 'Kazakhstani Tenge', 'KZT', 515.6733, '₸', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(80, 'Laotian Kip', 'LAK', 21934.0436, '₭', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(81, 'Lebanese Pound', 'LBP', 89500, '£', 1, '2024-07-29 11:30:57', '2024-10-05 14:56:36'),
(82, 'Sri Lankan Rupee', 'LKR', 290.38, '₨', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(83, 'Liberian Dollar', 'LRD', 179.2644, '$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(84, 'Lesotho Loti', 'LSL', 18.0741, 'L', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(85, 'Libyan Dinar', 'LYD', 4.8936, 'ل.د', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(86, 'Moroccan Dirham', 'MAD', 10.0038, 'د.م.', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(87, 'Moldovan Leu', 'MDL', 18.2954, 'L', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(88, 'Malagasy Ariary', 'MGA', 4663.9262, 'Ar', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(89, 'Macedonian Denar', 'MKD', 58.2791, 'ден', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(90, 'Myanmar Kyat', 'MMK', 2098.4077, 'Ks', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(91, 'Mongolian Tugrik', 'MNT', 3407.5983, '₮', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(92, 'Macanese Pataca', 'MOP', 8.0154, 'MOP$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(93, 'Mauritanian Ouguiya', 'MRU', 39.9233, 'UM', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(94, 'Mauritian Rupee', 'MUR', 46.3722, '₨', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(95, 'Maldivian Rufiyaa', 'MVR', 15.4361, '.ރ', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(96, 'Malawian Kwacha', 'MWK', 1743.8614, 'MK', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(97, 'Mexican Peso', 'MXN', 20.3787, '$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(98, 'Malaysian Ringgit', 'MYR', 4.4449, 'RM', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(99, 'Mozambican Metical', 'MZN', 64.2907, 'MT', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(100, 'Namibian Dollar', 'NAD', 18.0741, '$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(101, 'Nigerian Naira', 'NGN', 1682.6035, '₦', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(102, 'Nicaraguan Córdoba', 'NIO', 36.7807, 'C$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(103, 'Norwegian Krone', 'NOK', 11.0586, 'kr', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(104, 'Nepalese Rupee', 'NPR', 135.3942, '₨', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(105, 'New Zealand Dollar', 'NZD', 1.6927, '$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(106, 'Omani Rial', 'OMR', 0.3845, '﷼', 1, '2024-07-29 11:30:57', '2024-10-05 14:56:36'),
(107, 'Panamanian Balboa', 'PAB', 1, 'B/.', 1, '2024-07-29 11:30:57', '2024-10-05 14:56:36'),
(108, 'Peruvian Nuevo Sol', 'PEN', 3.7521, 'S/.', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(109, 'Papua New Guinean Kina', 'PGK', 3.9967, 'K', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(110, 'Philippine Peso', 'PHP', 58.6325, '₱', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(111, 'Pakistani Rupee', 'PKR', 278.2104, '₨', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(112, 'Polish Zloty', 'PLN', 4.0718, 'zł', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(113, 'Paraguayan Guarani', 'PYG', 7800.4242, 'Gs', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(114, 'Qatari Rial', 'QAR', 3.64, '﷼', 1, '2024-07-29 11:30:57', '2024-10-05 14:56:36'),
(115, 'Romanian Leu', 'RON', 4.7136, 'lei', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(116, 'Serbian Dinar', 'RSD', 110.7972, 'Дин.', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(117, 'Russian Ruble', 'RUB', 106.8035, '₽', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(118, 'Rwandan Franc', 'RWF', 1381.4006, 'R₣', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(119, 'Saudi Riyal', 'SAR', 3.75, '﷼', 1, '2024-07-29 11:30:57', '2024-10-05 14:56:36'),
(120, 'Solomon Islands Dollar', 'SBD', 8.5029, '$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(121, 'Seychellois Rupee', 'SCR', 13.8809, '₨', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(122, 'Sudanese Pound', 'SDG', 532.9884, '£', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(123, 'Swedish Krona', 'SEK', 10.9181, 'kr', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(124, 'Singapore Dollar', 'SGD', 1.3399, '$', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(125, 'Saint Helena Pound', 'SHP', 0.7873, '£', 1, '2024-07-29 11:30:57', '2024-12-02 11:29:37'),
(126, 'UAE Dirham', 'AED', 3.6725, 'د.إ', 1, '2024-07-29 11:32:16', '2024-10-05 14:56:36'),
(127, 'Afghan Afghani', 'AFN', 67.9054, '؋', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(128, 'Sierra Leonean Leone', 'SLL', 22732.2912, 'Le', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(129, 'Somali Shilling', 'SOS', 571.3539, 'S', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(130, 'Surinamese Dollar', 'SRD', 35.5256, '$', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(131, 'South Sudanese Pound', 'SSP', 3670.1302, '£', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(132, 'São Tomé and Príncipe Dobra', 'STN', 23.2048, 'Db', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(133, 'Salvadoran Colón', 'SVC', 0.2429, '$', 1, '2024-07-29 11:32:16', '2024-07-29 11:32:16'),
(134, 'Syrian Pound', 'SYP', 12986.2026, '£', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(135, 'Swazi Lilangeni', 'SZL', 18.0741, 'L', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(136, 'Tajikistani Somoni', 'TJS', 10.8958, 'ЅМ', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(137, 'Turkmenistani Manat', 'TMT', 3.5001, 'm', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(138, 'Tunisian Dinar', 'TND', 3.145, 'د.ت', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(139, 'Tongan Paʻanga', 'TOP', 2.3502, 'T$', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(140, 'Turkish Lira', 'TRY', 34.715, '₺', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(141, 'Trinidad and Tobago Dollar', 'TTD', 6.7731, 'TT$', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(142, 'New Taiwan Dollar', 'TWD', 32.4795, 'NT$', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(143, 'Tanzanian Shilling', 'TZS', 2640.0422, 'TSh', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(144, 'Ukrainian Hryvnia', 'UAH', 41.584, '₴', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(145, 'Ugandan Shilling', 'UGX', 3693.4838, 'USh', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(146, 'United States Dollar', 'USD', 1, '$', 1, '2024-07-29 11:32:16', '2024-10-05 14:56:36'),
(147, 'Uruguayan Peso', 'UYU', 42.7834, '$U', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(148, 'Uzbekistan Som', 'UZS', 12833.1935, 'лв', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(151, 'Vanuatu Vatu', 'VUV', 118.5907, 'VT', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(152, 'Samoan Tala', 'WST', 2.7815, 'WS$', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(153, 'CFA Franc BEAC', 'XAF', 621.2801, 'FCFA', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(154, 'East Caribbean Dollar', 'XCD', 2.7, '$', 1, '2024-07-29 11:32:16', '2024-10-05 14:56:36'),
(155, 'CFA Franc BCEAO', 'XOF', 621.2801, 'CFA', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(156, 'CFP Franc', 'XPF', 113.0236, '₣', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(157, 'Yemeni Rial', 'YER', 249.6749, '﷼', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(158, 'South African Rand', 'ZAR', 18.079, 'R', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37'),
(159, 'Zambian Kwacha', 'ZMW', 27.1708, 'ZK', 1, '2024-07-29 11:32:16', '2024-12-02 11:29:37');

-- --------------------------------------------------------

--
-- Table structure for table `email_notification_mappings`
--

CREATE TABLE `email_notification_mappings` (
  `email_type_id` int UNSIGNED NOT NULL,
  `email_sms_notification_id` int UNSIGNED NOT NULL,
  `module` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `email_notification_mappings`
--

INSERT INTO `email_notification_mappings` (`email_type_id`, `email_sms_notification_id`, `module`) VALUES
(1, 1, 2),
(2, 2, 2),
(3, 3, 2),
(4, 4, 2),
(6, 6, 2),
(7, 7, 2),
(8, 8, 2),
(12, 12, 2),
(13, 13, 2),
(10, 14, 2),
(9, 18, 2),
(5, 22, 2),
(11, 26, 2),
(14, 34, 2),
(15, 35, 2),
(16, 36, 2),
(17, 37, 2),
(18, 38, 2),
(19, 39, 2),
(20, 40, 2),
(21, 41, 2),
(22, 42, 2),
(23, 43, 2),
(24, 44, 2),
(25, 45, 2);

-- --------------------------------------------------------

--
-- Table structure for table `email_sms_notification`
--

CREATE TABLE `email_sms_notification` (
  `id` int UNSIGNED NOT NULL,
  `temp_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` tinyint NOT NULL DEFAULT '1',
  `role` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `link_text` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang_id` int DEFAULT '0',
  `sms` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `push_notification` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `emailsent` tinyint(1) DEFAULT '1',
  `smssent` tinyint(1) NOT NULL DEFAULT '1',
  `pushsent` tinyint(1) NOT NULL DEFAULT '1',
  `vendorsubject` varchar(91) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vendorbody` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `vendorpush_notification` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `vendoremailsent` tinyint NOT NULL DEFAULT '0',
  `vendorsmssent` tinyint NOT NULL DEFAULT '0',
  `vendorpushsent` tinyint NOT NULL DEFAULT '0',
  `vendorsms` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `adminsubject` varchar(99) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adminbody` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `adminpush_notification` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `adminemailsent` tinyint NOT NULL DEFAULT '0',
  `adminsmssent` tinyint NOT NULL DEFAULT '0',
  `adminpushsent` tinyint NOT NULL DEFAULT '0',
  `adminsms` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `email_sms_notification`
--

INSERT INTO `email_sms_notification` (`id`, `temp_name`, `module`, `role`, `subject`, `body`, `link_text`, `lang`, `lang_id`, `sms`, `push_notification`, `emailsent`, `smssent`, `pushsent`, `vendorsubject`, `vendorbody`, `vendorpush_notification`, `vendoremailsent`, `vendorsmssent`, `vendorpushsent`, `vendorsms`, `adminsubject`, `adminbody`, `adminpush_notification`, `adminemailsent`, `adminsmssent`, `adminpushsent`, `adminsms`, `status`, `created_at`, `updated_at`) VALUES
(1, 'User Registration', 1, 'user#admin', 'Registration Successful - Welcome to {{website_name}}', '<p>Hi <strong>{{first_name}} {{last_name}}</strong>, </p><p>You\'re now registered with  {{website_name}}. </p><p><strong>Email: {{email}}</strong></p><p><strong>Phone:{{phone}} </strong></p><p>Log in, explore, and enjoy! Need help? Contact us at {{support_email}}. </p><p>Cheers,</p><p>{{website_name}} Team</p>', 'abc', 'en', 1, 'Welcome to  {{website_name}}! You\'re successfully registered. Email:{{email}}. Any issues? Contact {{website_name}}.', 'Registration successful! Welcome to  {{website_name}}. 🎉', 1, 0, 1, 'Vendor Subject', '', 'Vendor Push', 1, 0, 1, 'Vendor Message', 'New User Registration Alert for  {{website_name}}', '<p><strong>Dear Admin, </strong></p><p>We are pleased to inform you that a new user has successfully registered on {{website_name}}, </p><p><strong>Details:</strong></p><p>Name: {{first_name}} {{last_name}} </p><p>Email: {{email}} </p><p>Phone: {{phone}} </p><p>Please monitor their activities and provide assistance if required.Thank you for ensuring the smooth functioning of our platform.</p><p>Best Regards,</p><p>{{website_name}} Team</p>', 'Admin Push Notification', 1, 0, 1, 'Admin Message', 1, '2023-08-30 16:41:50', '2025-07-30 12:27:12'),
(2, 'Signup OTP', 1, 'user', 'Your OTP {{OTP}}', '<p>Hi,</p><p>Your OTP : {{OTP}}</p><p>If you didn\'t request this, please ignore.</p><p>Thanks,</p><p>{{website_name}}</p>', 'abc', 'en', 1, 'Your OTP: {{OTP}}. If not requested, ignore. -   {{website_name}}', 'OTP: {{OTP}}. If not requested, please ignore.', 0, 1, 1, 'Vendor  Signup', 'Vendor Email Enable', 'Vendor Push', 0, 0, 1, 'Vendor Message', '', '', '', 0, 0, 0, '', 1, '2023-08-30 16:42:54', '2025-08-06 10:36:22'),
(3, 'Forgot Password OTP', 1, 'user', '🔒 Secure OTP for  {{website_name}} Password Update', '<p>Dear {{first_name}} {{last_name}},</p><p>We received a request to reset your password for your  {{website_name}}</p><p>account.🔐 Your One-Time Password (OTP): <strong> {{OTP}}</strong></p><p>Please use this OTP to reset your password. It\'s valid for the next 10 minutes. </p><p>Warm regards, </p><p>{{website_name}} Team</p>', 'abc', 'en', 1, 'OTP for password reset: {{OTP}}. Valid for 10 mins. Don\'t share!', 'Hey there! 🙋‍♂️ Your OTP to reset your password is: {{OTP}}. Please enter it within the next 10 minutes. ⏳ Stay secure! 👍', 1, 0, 1, '', '', '', 0, 0, 0, '', '', '', '', 0, 0, 0, '', 0, '2023-08-30 16:52:11', '2025-05-14 06:26:30'),
(4, 'Payout Request', 1, 'user#admin', 'Payout Request Submitted', '<p>Dear {{first_name}} {{last_name}},</p><p>We hope this email finds you well. This is to confirm that we have received your payout request at {{website_name}}.</p><p>Payout Details:</p><p>- Amount: {{currency_code}} <strong>{{payout_amount}}</strong></p><p>- Requested Date: {{payout_date}}</p><p>Please note that your payout request is currently being processed. Our team at {{website_name}} is working diligently to review and approve your request. Once approved, the funds will be transferred to your designated payment account.</p><p>If you have any questions or need further assistance, please don\'t hesitate to reach out to our support team at {{support_email}}. We are here to help you.</p><p> </p><p>Thank you for your patience and trust in {{website_name}}.</p><p>Best regards,</p><p>{{website_name}} Team</p>', 'abc', 'en', 1, '{{first_name}}, your {{website_name}} payout request of {{payout_amount}} is being processed. We\'ll notify you once approved.', '{{first_name}}, your payout request of {{payout_amount}} has been received at {{website_name}} and is being processed. We\'ll notify you once it\'s approved.', 1, 0, 1, '', '', '', 0, 0, 0, '', 'New Payout Request from {{first_name}} {{last_name}}', '<p><strong>Dear Admin,</strong></p><p>I hope this email finds you well. This is to notify you that we have received a new payout request from one of our users at {{website_name}}.</p><p><strong>User Details:</strong></p><p>- Name: {{first_name}} {{last_name}}</p><p>- Email: {{email}}</p><p>- Phone: {{phone}}</p><p> </p><p><strong>Payout Request Details:</strong></p><p>- Amount: {{currency_code}} {{payout_amount}}</p><p>- Requested Date: {{payout_date}}</p><p> </p><p>Please review the payout request and take the necessary actions to process it. Here are the steps to follow:</p><p>1. Verify the user\'s account and ensure they meet the eligibility criteria for payouts.</p><p>2. Check the payout amount and payment method for accuracy.</p><p>3. Approve or reject the payout request based on your assessment.</p><p>4. If approved, initiate the fund transfer to the user\'s designated payment account.</p><p>5. Update the payout request status in our system.</p><p>6. Send a confirmation email to the user about the status of their payout request.</p><p> </p><p>If you have any questions or need further information, please don\'t hesitate to reach out to the user directly using the provided contact details.</p><p>Thank you for your prompt attention to this matter.</p><p><strong>Best regards,</strong></p><p>{{website_name}} Team</p>', '', 1, 0, 0, '', 0, '2023-08-30 18:51:21', '2025-07-30 12:26:08'),
(6, 'Payment Sent', 1, 'user#admin', 'Payment Processed Successfully', '<p><strong>Dear {{first_name}} {{last_name}},</strong></p><p>We hope this email finds you well. This is to confirm that your payout request has been successfully processed and the payment has been sent.</p><p>Please check your original payment method or wallet for the transaction details.</p><p><strong>Payout Details:</strong></p><ul><li><strong>Amount:</strong> {{currency_code}} <strong>{{payout_amount}}</strong></li><li><strong>Payment Date:</strong> {{payout_date}}</li></ul><p>Thank you for your patience and for choosing {{website_name}}. If you have any questions or need further assistance, please feel free to reach out.</p><p><strong>Best regards,</strong></p><p><strong>{{website_name}} Team</strong></p>', 'abc', 'en', 1, 'Good news! Your payment has been sent. Please check your wallet or payment method', 'Good news! Your payment has been sent. Please check your wallet or payment method', 1, 0, 0, '', '', '', 0, 0, 0, '', 'Payout Request Successfully Processed', '<p><strong>Dear Admin,</strong></p><p>I hope this email finds you well. We are pleased to inform you that a payout request has been successfully processed for one of our users at {{website_name}}.</p><p><strong>User Details:</strong></p><ul><li><strong>Name:</strong> {{first_name}} {{last_name}}</li><li><strong>Email:</strong> {{email}}</li><li><strong>Phone:</strong> {{phone}}</li></ul><p><strong>Payout Details:</strong></p><ul><li><strong>Amount:</strong>{{currency_code}} {{payout_amount}}</li><li><strong>Payment Date:</strong> {{payout_date}}</li></ul><p>Thank you for your attention to this matter.</p><p>Best regards,<br>{{website_name}} Team</p>', '', 0, 0, 0, '', 0, '2023-09-01 11:50:21', '2025-01-22 17:30:42'),
(7, 'Wallet Transaction', 1, 'user', 'Wallet Transaction Alert', '<p>Dear {{first_name}} {{last_name}},</p><p>We hope this email finds you well. We are writing to inform you that a recent transaction has occurred in your wallet. Please find the details below:</p><p><strong>Transaction Type: {{transaction_type}}</strong></p><p><strong>Payout Details:</strong></p><ul><li><strong>Amount:</strong> {{currency_code}} {{payout_amount}}</li><li><strong>Transaction Date:</strong> {{payout_date}}</li></ul><p>Your account has been<strong> {{transaction_type}}ed </strong>with the amount of {{currency_code}} <strong>{{payout_amount}}</strong>. Please check your wallet or account statement for further details</p><p>Thank you for choosing {{website_name}}. If you have any questions or need further assistance, please feel free to reach out.</p><p>Best regards,</p><p>{{website_name}} Team</p>', 'abc', 'en', 1, 'payment send message', 'Wallet Transaction Alert ! Your account has been {{transaction_type}}ed with the amount of {{currency_code}} {{payout_amount}}.', 1, 0, 0, '', '', '', 0, 0, 0, '', '', '', '', 0, 0, 0, '', 0, '2023-09-01 12:42:54', '2024-12-04 17:17:48'),
(8, 'Message', 1, 'user', 'New Message from {{sender}}', '<p>wallet transaction email</p>', 'abc', 'en', 1, 'wallet transaction Message', '{{sender}} sent you a new message: \'{{message}}...\'', 1, 0, 1, '', '', '', 0, 0, 0, '', '', '', '', 0, 0, 0, '', 0, '2023-09-01 12:53:31', '2024-08-07 07:17:52'),
(12, 'Review by Driver\r\n', 1, 'user#vendor', 'Review Received for {{item_name}}', '<p>Dear {{first_name}} {{last_name}},</p><p>We are pleased to inform you that <strong>{{vendor_name}}</strong> has reviewed you for <strong>{{item_name}}</strong>.</p><p>Booking Reference: {{bookingid}}</p><p>Pick-up: {{check_in}}</p><p>Return: {{check_out}}</p><p>Amount: {{currency_code}} {{amount}}</p><p> </p><p>We look forward to hosting you. If you have any questions or special requests, please don\'t hesitate to contact us.</p><p>Warm regards,</p><p>{{website_name}}</p><p> </p>', 'abc', 'en', 1, '{{vendor_name}} has reviewed you for {{item_name}} Ref: {{bookingid}} on {{website_name}}', '{{vendor_name}} has reviewed you for {{item_name}} Ref: {{bookingid}} on {{website_name}}', 1, 0, 1, 'Review Submitted for {{item_name}}', '<p>Dear {{vendor_name}},</p><p>You have reviewed the product {{item_name}}</p><p>Booking Reference: {{bookingid}}</p><p>Pick-up: {{check_in}}</p><p>Return: {{check_out}}</p><p>Amount: {{currency_code}} {{amount}}</p><p> </p><p>We look forward to hosting you. If you have any questions or special requests, please don\'t hesitate to contact us.</p><p>Warm regards,</p><p>{{website_name}}</p>', 'Review Submitted for {{item_name}} Ref: {{bookingid}}', 1, 0, 0, 'Review Submitted for {{item_name}} Ref: {{bookingid}}', 'New Booking Confirmed for {{item_name}} #{{bookingid}}', '<p>Dear Admin,</p><p>A new booking has been confirmed on our platform:</p><p>Vehicle: {{item_name}}</p><p>Guest: {{first_name}} {{last_name}}</p><p>Booking Reference: {{bookingid}}</p><p>Check-in: {{check_in}}</p><p>Check-out: {{check_out}}</p><p>Amount: {{currency_code}} {{amount}}</p><p> </p><p>Please oversee the process to ensure a smooth experience for all parties.</p><p> </p><p>Warm regards,</p><p>UniBooker.com</p><p> </p>', '', 0, 0, 0, '', 0, '2023-09-01 12:53:31', '2025-07-30 12:25:03'),
(13, 'Review by Rider', 1, 'user#vendor', 'Review Submitted for {{item_name}}', '<p>Dear {{first_name}} {{last_name}},</p><p>You have reviewed the booking of {{item_name}}</p><p>Booking Reference: {{bookingid}}</p><p>Check-in: {{check_in}}</p><p>Check-out: {{check_out}}</p><p>Amount: {{currency_code}} {{amount}}</p><p> </p><p>We look forward to hosting you. If you have any questions or special requests, please don\'t hesitate to contact us.</p><p>Warm regards,</p><p>{{website_name}}</p><p> </p>', 'abc', 'en', 1, 'Review Submitted for {{item_name}} Ref: {{bookingid}}', 'Review Submitted for {{item_name}} Ref: {{bookingid}}', 1, 0, 1, 'Review Received for {{item_name}}', '<p>Dear {{vendor_name}},</p><p>We are pleased to inform you that {{first_name}} {{last_name}} has reviewed you for <strong>{{item_name}}</strong>.</p><p>Booking Reference: {{bookingid}}</p><p>Pick-up: {{check_in}}</p><p>Return: {{check_out}}</p><p>Amount: {{currency_code}} {{amount}}</p><p> </p><p>We look forward to hosting you. If you have any questions or special requests, please don\'t hesitate to contact us.</p><p>Warm regards,</p><p>{{website_name}}</p>', '{{first_name}} {{last_name}} has reviewed you for {{item_name}} Ref: {{bookingid}} on {{website_name}}', 1, 0, 0, '{{first_name}} {{last_name}} has reviewed you for {{item_name}} Ref: {{bookingid}} on {{website_name}}', 'New Booking Confirmed for {{item_name}} #{{bookingid}}', '<p>Dear Admin,</p><p>A new booking has been confirmed on our platform:</p><p>Vehicle: {{item_name}}</p><p>Guest: {{first_name}} {{last_name}}</p><p>Booking Reference: {{bookingid}}</p><p>Check-in: {{check_in}}</p><p>Check-out: {{check_out}}</p><p>Amount: {{currency_code}} {{amount}}</p><p> </p><p>Please oversee the process to ensure a smooth experience for all parties.</p><p> </p><p>Warm regards,</p><p>UniBooker.com</p><p> </p>', '', 0, 0, 0, '', 0, '2023-09-01 12:53:31', '2025-07-30 12:24:45'),
(14, 'Booking Completed', 2, 'user#vendor#admin', 'Thanks for booking {{item_name}} #{{bookingid}}', '<p>Dear <strong>{{first_name}} {{last_name}},</strong></p><p>We are pleased to inform you of a new booking of {{item_name}}. Below are the details for your records: </p><ul><li><strong>Booking Reference :</strong>  #{{bookingid}}</li><li><strong>Pickup :</strong> {{check_in}} {{start_time}}</li><li><strong>Return : </strong>{{check_out}} {{end_time}}</li><li><strong>Total Amount:</strong>  {{currency_code}} {{amount}}</li><li><strong>Payment Status:</strong>  {{payment_status}}</li></ul><p><strong>Address:</strong><br><strong>{{item_address}}</strong></p><p><strong>Vendor Contact Details:</strong><br>Phone: {{phone_country}} {{vendor_phone}}<br>Email:  {{vendor_email}}</p><p>Should you require any further assistance or have any special requests, please don\'t hesitate to reach out to support : {{support_email}}</p><p>Thank you for choosing {{item_name}}. We look forward to hosting you!</p><p>Warm regards,<br><strong>{{website_name}}</strong></p>', 'abc', 'en', 1, 'Hello {first_name} {last_name},\r\n\r\nYour booking at  {{item_name}} is confirmed!\r\n\r\nPickup Date: {{check_in}} {{start_time}}\r\nReturn Date: {{check_out}} {{end_time}}\r\nRef:  {{bookingid}}\r\nQuestions? Contact us at  {{vendor_phone}} Safe travels!', 'Your booking with {{item_name}} at {{item_address}} from {{check_in}} to {{check_out}} is confirmed. Ref: {{bookingid}} Looking forward to hosting you!', 1, 0, 1, 'New Booking Alert for {{item_name}} # {{bookingid}}', '<p>Dear <strong>{{vendor_name}},</strong></p><p>We are delighted to confirm a booking by a customer for {{item_name}}. Here are the details:</p><ul><li><strong>Booking Reference:</strong>  #{{bookingid}}</li><li><strong>Pickup :</strong> {{check_in}} {{start_time}}</li><li><strong>Return : </strong>{{check_out}} {{end_time}}</li><li><strong>Total Amount:</strong>  {{currency_code}} {{amount}}</li><li><strong>Payment Status:</strong>  {{payment_status}}</li></ul><p><strong>Address:</strong><br><strong>{{item_address}}</strong></p><p><strong>Customer Contact Details:</strong><br>Phone: {{user_phone_country}} {{user_phone}}<br>Email:  {{user_email}}</p><p>Should you require any further assistance or have any special requests, please don\'t hesitate to reach out to support: {{support_email}}.</p><p>Warm regards,<br>{{website_name}}</p>', 'Customer {{first_name}} {{last_name}} has booked {{item_name}}.Pick-up : {{check_in}}, Return : {{check_out}}. Ref: {{bookingid}}', 1, 0, 0, 'New Booking Alert!\r\nBooked By: {{first_name}} {{last_name}}\r\nItem: {{item_name}}\r\nPickup: {{check_in}}\r\nReturn: {{check_out}}\r\nReference: {{bookingid}}\r\nFor details, check your dashboard or email.', 'New Booking Received for {{item_name}} # {{bookingid}}', '<p>Dear Admin,</p><p>We are pleased to inform you of a new booking on our platform. Below are the details:</p><p>**Customer Information:**</p><p>- Full Name: {{first_name}} {{last_name}}</p><p>- Email: {{user_email}}</p><p>- Phone: {{user_phone_country}}{{user_phone}}</p><p>**Booking Details:**</p><p>- Item name : {{item_name}}</p><p>- Booking Reference: #{{bookingid}}</p><p><strong>- </strong>Pickup <strong>:</strong> {{check_in}} {{start_time}}</p><p><strong>- </strong>Return <strong>: </strong>{{check_out}} {{end_time}}</p><p>- Total Amount: {{currency_code}} {{amount}}</p><p>- Payment Status: {{payment_status}}</p><p> </p><p>**Vendor Information:**</p><p>- Vendor Name: {{vendor_name}}</p><p>- Vendor Phone: {{vendor_phone}}</p><p>- Vendor Email: {{vendor_email}}</p><p> </p><p>Please ensure that the necessary procedures are followed to ensure a smooth experience for the guest. Should any issues or concerns arise, liaise with the vendor or reach out to the guest as necessary.</p><p> </p><p>Thank you for ensuring our platform continues to deliver outstanding service to all parties involved.</p><p> </p><p>Warm regards,</p><p>{{website_name}}</p>', NULL, 0, 0, 0, NULL, 0, NULL, '2024-12-04 17:25:08'),
(18, 'Booking Accept by Driver', 2, 'user#vendor#admin', 'Booking Confirmed for {{item_name}} #{{bookingid}}', '<p>Dear {{first_name}} {{last_name}},</p><p>Your booking at {{item_name}} has been confirmed! Here are the details:</p><p>Booking Reference: {{bookingid}}</p><p>Pick-up: {{check_in}} {{start_time}}</p><p>Return: {{check_out}} {{end_time}}</p><p>Amount: {{currency_code}} {{amount}}</p><p> </p><p>We look forward to hosting you. If you have any questions or special requests, please don\'t hesitate to contact us.</p><p>Warm regards,</p><p>{{website_name}}</p><p> </p>', 'abc', 'en', 1, 'Booking Confirmed! \r\nFor {{item_name}}\r\nPick-up: {{check_in}}, Return: {{check_out}}\r\nRef: {{bookingid}}', 'Booking Confirmed!  Pick-up: {{check_in}}, Return: {{check_out}}. Ref: {{bookingid}}', 1, 0, 1, 'Confirmation: New Booking for {{item_name}} #{{bookingid}}', '<p>Dear {{vendor_name}},</p><p>A new booking has been confirmed for {{item_name}}. Here are the details:</p><p>Guest: {{first_name}} {{last_name}}</p><p>Booking Reference: #{{bookingid}}</p><p>Pick-up: {{check_in}} {{start_time}}</p><p>Return: {{check_out}} {{end_time}}</p><p>Amount: {{currency_code}} {{amount}}</p><p>Please ensure everything is in order for the customer\'s arrival.</p><p>Warm regards,</p><p>{{website_name}}</p>', 'Booking Confirmed for {{item_name}} #{{bookingid}} ! Booked By : {{first_name}} {{last_name}}. Pick-up: {{check_in}}, Return: {{check_out}}.', 0, 0, 0, 'New Booking Alert for {{item_name}}!\r\nBooked By: {{first_name}} {{last_name}}\r\nPick-up: {{check_in}}, Return: {{check_out}}\r\nRef: {{bookingid}}', 'New Booking Confirmed for {{item_name}} #{{bookingid}}', '<p>Dear Admin,</p><p>A new booking has been confirmed on our platform:</p><p>Vehicle: {{item_name}}</p><p>Booked By: {{first_name}} {{last_name}}</p><p>Booking Reference: {{bookingid}}</p><p>Pick-up: {{check_in}}</p><p>Return: {{check_out}}</p><p>Amount: {{currency_code}} {{amount}}</p><p> </p><p>Please oversee the process to ensure a smooth experience for all parties.</p><p> </p><p>Warm regards,</p><p>{{website_name}}</p><p> </p>', '', 0, 0, 0, '', 0, '2023-09-01 12:53:31', '2025-07-30 12:25:14'),
(22, 'Booking Cancellation by Guest Vehicle', 2, 'user#vendor#admin', 'Booking Cancellation Confirmation for {{item_name}}', '<p>Dear {{first_name}} {{last_name}},</p><p>You have cancelled the booking. The details of your cancelled booking are as follows:</p><p>Booking Details:</p><p>- Booking ID: #{{bookingid}}</p><p>- Vehicle Name: {{item_name}}</p><p>- Pick-up Date: {{check_in}} {{start_time}}</p><p>- Return Date: {{check_out}} {{end_time}}</p><p>Please note that any refund, if applicable, will be processed according to our cancellation policy. The refund amount will be credited back to your Wallet.</p><p>If you have any questions or need further assistance, please don\'t hesitate to reach out to our customer support team at {{support_email}} or by calling {{support_phone}}. We are here to help you.</p><p>Thank you for your understanding.</p><p> </p><p>Best regards,</p><p>{{website_name}} Team</p>', 'abc', 'en', 1, '{{first_name}}, your booking #{{bookingid}} at {{item_name}} has been cancelled. Any applicable refund will be processed. Contact us at {{support_phone}} for assistance.', 'Your booking #{{bookingid}} at {{item_name}} has been cancelled. Refund, if applicable, will be processed. Tap for more details.', 1, 0, 1, 'Booking Cancellation Notification for {{item_name}}', '<p>Dear {{vendor_name}},</p><p>We would like to inform you that a booking has been cancelled by the customer. The details of the cancelled booking are as follows:</p><p>Booking Details:</p><p>- Booking ID: #{{bookingid}}</p><p>- Vehicle Name: {{item_name}}</p><p>- Pick-up Date: {{check_in}}</p><p>- Return Date: {{check_out}}</p><p>- Customer Name: {{first_name}} {{last_name}}</p><p> </p><p>Please take note of this cancellation and update your records accordingly.</p><p>If you have any questions or need further information, please don\'t hesitate to reach out to our  support team at {{support_email}} or by calling {{support_phone}}. We are here to assist you.</p><p>Thank you for your cooperation.</p><p>Best regards,</p><p>{{website_name}} Team</p>', 'Booking #{{bookingid}} at {{item_name}} has been cancelled by the customer. Tap for more details.', 1, 0, 0, '{{vendor_name}}, booking #{{bookingid}} at {{item_name}} has been cancelled by the guest. Please update your records. Contact us at {{vendor_support_phone}} for assistance.', 'Booking Cancellation Notification - Admin', '<p>Dear Admin,</p><p>We would like to inform you that a booking has been cancelled by the customer. The details of the cancelled booking are as follows:</p><p> </p><p>Booking Details:</p><p>- Booking ID: #{{bookingid}}</p><p>- Vehicle Name: {{item_name}}</p><p>- Pick-up Date: {{check_in}}</p><p>- Return Date: {{check_out}}</p><p>- Customer Name: {{first_name}} {{last_name}}</p><p>- Vendor Name: {{vendor_name}}</p><p> </p><p>Thank you for your prompt attention to this matter.</p><p>Best regards,</p><p>{{website_name}}</p>', '', 0, 0, 0, '', 0, '2023-09-01 11:32:00', '2024-12-18 12:03:14'),
(26, 'Booking Decline by Vendor Vehicle', 2, 'user#vendor#admin', 'Booking Rejected: {{item_name}} #{{bookingid}}', '<p>Dear {{first_name}} {{last_name}},</p><p>Your booking at {{item_name}} has been Rejected ! Here are the details:</p><p>Booking Reference: #{{bookingid}}</p><p>Pick-up: {{check_in}}</p><p>Return: {{check_out}}</p><p>Amount: {{currency_code}} {{amount}}</p><p>Payment Status:  {{payment_status}}</p><p> </p><p>We look forward to hosting you. If you have any questions or special requests, please don\'t hesitate to contact us.</p><p>Warm regards,</p><p>{{website_name}}</p><p> </p>', 'abc', 'en', 1, 'Booking Rejected! For {{item_name}}\r\nPick-up: {{check_in}}, Return: {{check_out}}\r\nRef: {{bookingid}}', '{{first_name}}, your booking #{{bookingid}} at {{item_name}} has been rejected. Any applicable refund will be processed. Contact us at {{support_phone}} for assistance.', 1, 0, 1, 'Rejected: Booking for {{item_name}} {{bookingid}}', '<p>Dear {{vendor_name}},</p><p>You have Rejected one booking of {{item_name}}. Here are the details:</p><p>Customer: {{first_name}} {{last_name}}</p><p>Booking Reference: #{{bookingid}}</p><p>Pick-up: {{check_in}}</p><p>Return: {{check_out}}</p><p>Amount: {{currency_code}} {{amount}}</p><p>Payment Status:  {{payment_status}}</p><p>Please ensure everything is in order for the guest\'s arrival.</p><p>Warm regards,</p><p>{{website_name}}</p>', '{{vendor_name}}, your have rejected booking #{{bookingid}} at {{item_name}}.Contact us at {{support_phone}} for assistance.', 1, 0, 0, 'Booking Rejected for {{item_name}}!\r\nBooked by: {{first_name}} {{last_name}}\r\nPick-up: {{check_in}}, Return: {{check_out}}\r\nRef: {{bookingid}}', 'Booking Rejected for {{item_name}} #{{bookingid}}', '<p>Dear Admin,</p><p>A  booking has been Rejected on our platform:</p><p>Vehicle: {{item_name}}</p><p>Customer: {{first_name}} {{last_name}}</p><p>Vendor: {{vendor_name}}</p><p>Booking Reference: #{{bookingid}}</p><p>Pick-up: {{check_in}}</p><p>Return: {{check_out}}</p><p>Amount: {{currency_code}} {{amount}}</p><p>Payment Status:  {{payment_status}}</p><p>Please oversee the process to ensure a smooth experience for all parties.</p><p> </p><p>Warm regards,</p><p>{{website_name}}</p>', '', 1, 0, 0, '', 0, '2023-09-01 12:53:31', '2024-11-29 15:58:53'),
(34, 'Driver Request', 2, 'user#admin', 'Host Request Submitted for {{website_name}}', '<p>Hi <strong>{{first_name}} {{last_name}}</strong>, </p><p>Thank you for submitting your host request for {{website_name}}. We are excited to have you on board!</p><p><strong>Email: {{email}}</strong></p><p><strong>Phone:{{phone}} </strong></p><p>Log in, explore, and enjoy! Need help? Contact us at  {{support_email}}. </p><p>Cheers,</p><p>{{website_name}} Team</p>', 'abc', 'en', 1, 'You have successfully submitted your host request for {{website_name}}. Your Email:{{email}}. Any issues? Contact{{support_email}}.', 'Host request submitted successfully. Thank You 🎉', 1, 0, 1, 'Vendor Subject', '', 'Vendor Push', 1, 0, 1, 'Vendor Message', 'Host Request Submitted for {{website_name}}', '<p><strong>Dear Admin, </strong></p><p>We are pleased to inform you that a new user has requested to become a host on {{website_name}}.</p><p><strong>Details:</strong></p><p>Name: {{first_name}} {{last_name}} </p><p>Email: {{email}} </p><p>Phone: {{phone}} </p><p>Please monitor their activities and provide assistance if required.Thank you for ensuring the smooth functioning of our platform.</p><p>Best Regards,</p><p>{{website_name}} Team</p>', 'Admin Push Notification', 1, 0, 1, 'Admin Message', 1, '2023-08-30 16:41:50', '2024-12-16 17:19:15'),
(35, 'Approved Driver Request', 2, 'user', 'Host Request Approved with {{website_name}}', '<p>Hi <strong>{{first_name}} {{last_name}}</strong>, </p><p>Congratulations ! Your Host request with {{website_name}} has been approved successfully. </p><p><strong>Email: {{email}}</strong></p><p><strong>Phone:{{phone}} </strong></p><p>Log in, explore, and enjoy! Need help? Contact us at {{support_email}}. </p><p>Cheers,</p><p>{{website_name}} Team</p>', 'abc', 'en', 1, 'Congratulations!  Your Host request with {{website_name}} has been approved. Email:{{email}}.', 'Congratulations! Host request approved with {{website_name}} . 🎉', 1, 0, 1, 'Vendor Subject', '', 'Vendor Push', 1, 0, 0, '', '', '', '', 0, 0, 0, '0', 1, '2023-08-30 16:41:50', '2024-12-17 10:14:01'),
(36, 'Email change OTP', 1, 'user', 'Your Email Change OTP {{OTP}}', '<p>Hi,</p><p>Your Email Change OTP : {{OTP}}</p><p>If you didn\'t request this, please ignore.</p><p>Thanks,</p><p>{{website_name}}</p>', 'abc', 'en', 1, 'Your OTP: {{OTP}}. If not requested, ignore. -   {{website_name}}', 'OTP: {{OTP}}. If not requested, please ignore.', 1, 0, 1, 'Vendor  Signup', 'Vendor Email Enable', 'Vendor Push', 0, 0, 1, 'Vendor Message', '', '', '', 0, 0, 0, '', 1, '2023-08-30 16:42:54', '2025-05-14 06:26:57'),
(37, 'Resend OTP', 1, 'user', '🔒Resend OTP', '<p>Dear {{first_name}} {{last_name}},</p><p>🔐 Your (OTP): <strong> {{OTP}}</strong></p><p>Please use this OTP . It\'s valid for the next 10 minutes. </p><p>Warm regards, </p><p>{{website_name}} Team</p>', 'abc', 'en', 1, 'OTP : {{OTP}}. Valid for 10 mins. Don\'t share!', 'Hey there! 🙋‍♂️ Your OTP is: {{OTP}}. Please enter it within the next 10 minutes. ⏳ Stay secure! 👍', 0, 1, 1, '', '', '', 0, 0, 0, '', '', '', '', 0, 0, 0, '', 1, '2023-08-30 16:52:11', '2025-08-06 10:35:53'),
(38, 'Change Mobile OTP', 1, 'user', 'Your Mobile Change OTP {{OTP}}', '<p>Hi,</p><p>Your Mobile Change OTP : {{OTP}}</p><p>If you didn\'t request this, please ignore.</p><p>Thanks,</p><p>{{website_name}}</p>', 'abc', 'en', 1, 'Your OTP: {{OTP}}. If not requested, ignore. -   {{website_name}}', 'OTP: {{OTP}}. If not requested, please ignore.', 1, 0, 1, 'Vendor  Signup', 'Vendor Email Enable', 'Vendor Push', 0, 0, 1, 'Vendor Message', '', '', '', 0, 0, 0, '', 1, '2023-08-30 16:42:54', '2025-05-14 06:27:17'),
(39, 'Item Publish Notification', 2, 'user', 'Item Publish with {{website_name}}', '<p>Hi <strong>{{first_name}} {{last_name}}</strong>, </p><p>Congratulations ! Your Item \"{{title}}\" has been published with {{website_name}} .</p><p><strong>Email: {{email}}</strong></p><p><strong>Phone:{{phone}} </strong></p><p>Log in, explore, and enjoy! Need help? Contact us at [{{website_name}}]. </p><p>Cheers,</p><p>{{website_name}} Team</p>', 'abc', 'en', 1, 'Congratulations!  Your Item has been published with {{website_name}} . Email:{{email}}. Any issues? Contact {{website_name}}.', 'Congratulations! Your Item \"{{title}}\" has been published with {{website_name}} . 🎉', 1, 0, 1, 'Vendor Subject', '', 'Vendor Push', 1, 0, 0, '', '', '', '', 0, 0, 0, '0', 0, '2023-08-30 16:41:50', '2024-12-04 19:01:19'),
(40, 'Item Unpublish Notification', 2, 'user', 'Item Unpublished with {{website_name}}', '<p>Hi <strong>{{first_name}} {{last_name}}</strong>, </p><p>Sorry ! Your Item \"{{title}}\" has been unpublished with {{website_name}}.</p><p><strong>Email: {{email}}</strong></p><p><strong>Phone:{{phone}} </strong></p><p>Log in, explore, and enjoy! Need help? Contact us at [{{website_name}}]. </p><p>Cheers,</p><p>{{website_name}} Team</p>', 'abc', 'en', 1, 'Sorry ! Your Item \"{{title}}\" has been unpublished with {{website_name}}.. Email:{{email}}. Any issues? Contact {{website_name}}.', 'Sorry ! Your Item \"{{title}}\" has been unpublished with {{website_name}}.', 1, 0, 1, 'Vendor Subject', '', 'Vendor Push', 1, 0, 0, '', '', '', '', 0, 0, 0, '0', 0, '2023-08-30 16:41:50', '2024-12-04 19:01:31'),
(41, 'Ticket Reply By User', 1, 'user#admin', 'Your Support Ticket with {{website_name}}', '<p>Hi {{first_name}} {{last_name}},</p><p>We wanted to inform you about your support ticket with {{website_name}}.</p><h4>Ticket Details:</h4><ul><li><strong>Ticket ID:</strong> {{ticket_id}}</li><li><strong>Subject</strong>: {{subject}}</li><li><strong>Last Modified on:</strong> {{update_date}}</li></ul><p>We’ve received your request and are currently working on it. We’ll keep you updated with any significant developments. If you have further questions or need to provide additional information, please reply to this email or contact us at {{website_name}}.</p>', 'abc', 'en', 1, 'Ticket Submitted at {{website_name}}.Ticket ID: {{ticket_id}}, Email:{{email}}. Any issues? Contact {{website_name}}.', 'Ticket Submitted at {{website_name}}. Ticket ID: {{ticket_id}}', 0, 0, 0, 'Vendor Subject', '', 'Vendor Push', 1, 0, 0, 'Vendor Message', 'New Support Ticket / Reply Notification at {{website_name}}', '<p>Hi Admin,</p><p>A support ticket has been received or updated at {{website_name}}.</p><h3>Ticket Details:</h3><ul><li><strong>Ticket ID:</strong> {{ticket_id}}</li><li><strong>Subject</strong>: {{subject}}</li><li><strong>Submitted by:</strong> {{first_name}} {{last_name}}</li><li><strong>Last Modified on:</strong> {{update_date}}</li></ul><p>Please review the ticket details and take the necessary action through the admin panel. If you have any questions or need assistance, feel free to contact the support team.</p><p>Thank you for your attention.</p>', 'Admin Push Notification', 1, 0, 1, 'Admin Message', 0, '2023-08-30 16:41:50', '2024-12-20 14:58:47'),
(42, 'Ticket Reply By Admin', 1, 'user#admin', 'Update on Your Support Ticket at {{website_name}}', '<p>Hi {{first_name}} {{last_name}},</p><p>We wanted to inform you that there has been a new reply to your support ticket. Please review the details below:</p><h4>Ticket Details:</h4><ul><li><strong>Ticket ID:</strong> {{ticket_id}}</li><li><strong>Subject</strong>: {{subject}}</li><li><strong>Last Modified on:</strong> {{update_date}}</li></ul><p>To view and respond to the latest reply, please log into your account and navigate to the ticket section.</p><p>If you have any further questions or need assistance, feel free to reach out to our support team.</p><p>Thank you for your patience and continued support.</p><p>Best regards,<br>{{website_name}}</p>', 'abc', 'en', 1, 'Ticket Submitted at {{website_name}}. Ticket ID: {{ticket_id}}. Email:{{email}}. Any issues? Contact {{website_name}}.', 'Ticket Submitted at {{website_name}}. Ticket ID: {{ticket_id}}', 0, 0, 0, 'Vendor Subject', '', 'Vendor Push', 1, 0, 0, 'Vendor Message', 'Support Ticket Reply Sent to User at  {{website_name}}', '<p>Hi Admin,</p><p>A support ticket has been received or updated at {{website_name}}.</p><h3>Ticket Details:</h3><ul><li><strong>Ticket ID:</strong> {{ticket_id}}</li><li><strong>Subject</strong>: {{subject}}</li><li><strong>Submitted by:</strong> {{first_name}} {{last_name}}</li><li><strong>Last Modified on:</strong> {{update_date}}</li></ul><p>Please review the ticket details and take the necessary action through the admin panel.</p><p>Thank you for your attention.</p>', 'Admin Push Notification', 1, 0, 1, 'Admin Message', 0, '2023-08-30 16:41:50', '2024-12-20 14:58:30'),
(43, 'Item Delivered', 1, 'user#vendor#admin', 'Item \"{{item_name}}\" Delivered Successfully', '<p>Dear <strong>{{first_name}} {{last_name}}</strong>,</p><p>We are pleased to inform you that item has been successfully delivered to you. Thank you for your trust and patience.</p><p><strong>Delivery Details:</strong></p><ul><li><strong>Item Name:</strong> {{item_name}}</li><li><strong>Booking ID:</strong> {{bookingid}}</li><li><strong>Delivery Date:</strong> {{current_date}}</li></ul><p>If you have any questions or concerns about your order, or if there’s anything else we can assist you with, please don’t hesitate to get in touch.</p><p>Thank you for choosing {{website_name}}.</p><p>Best regards,<br>The {{website_name}} Team</p>', 'abc', 'en', 1, 'Good news! Your item \"{{item_name}}\" has been delivered from {{website_name}}.', 'Good news! Your item \"{{item_name}}\" has been delivered from {{website_name}}.', 0, 0, 1, 'Item \"{{item_name}}\" Delivered Successfully', '<p>Dear <strong>{{vendor_name}}</strong> ,</p><p>We are pleased to inform you that the item <strong>\"{{item_name}}\"</strong> for your customer has been successfully delivered. Thank you for ensuring a smooth delivery process and your continued partnership.</p><p><strong>Delivery Details:</strong></p><ul><li><strong>Customer Name:</strong> {{first_name}} {{last_name}}</li><li><strong>Item Name:</strong> {{item_name}}</li><li><strong>Booking ID:</strong> {{bookingid}}</li><li><strong>Delivery Date:</strong> {{current_date}}</li></ul><p>If you have any questions or need further assistance, feel free to reach out to our support team.</p><p>Thank you for your hard work and for choosing to partner with {{website_name}}.</p><p>Best regards,<br>The {{website_name}} Team</p>', 'Good news! Your item \"{{item_name}}\" has been delivered to customer.', 1, 0, 0, 'Good news! Your item \"{{item_name}}\" has been received by customer.', 'Item Delivery Confirmation', '<p>Dear <strong>Admin,</strong></p><p>I hope this email finds you well. We are pleased to inform you that an item delivery has been successfully completed for one of our users at <strong>{{website_name}}</strong>.</p><p><strong>Customer Details:</strong><br>Name: {{first_name}} {{last_name}}<br>Email: {{user_email}}<br>Phone: {{user_phone_country}}{{user_phone}}</p><p><strong>Delivery Details:</strong><br>Item: {{item_name}}<br>Delivery Date: {{current_date}}</p><p><strong>Vendor Details:</strong><br>Vendor Name: {{vendor_name}}</p><p>Vendor Name: {{vendor_email}}<br>Vendor Contact: {{phone_country}}{{vendor_phone}}</p><p>Thank you for your attention to this matter.</p><p>Best regards,<br><strong>{{website_name}} Team</strong></p>', '', 1, 0, 0, '', 0, '2023-09-01 11:50:21', '2024-12-20 14:58:17'),
(44, 'Item Received', 1, 'user#vendor#admin', 'Item \"{{item_name}}\" Received Successfully', '<p>Dear <strong>{{first_name}} {{last_name}}</strong>,</p><p>We are pleased to inform you that item has been successfully received. Thank you for your trust and patience.</p><p><strong>Delivery Details:</strong></p><ul><li><strong>Item Name:</strong> {{item_name}}</li><li><strong>Booking ID:</strong> {{bookingid}}</li><li><strong>Received Date:</strong> {{current_date}}</li></ul><p>If you have any questions or concerns about your order, or if there’s anything else we can assist you with, please don’t hesitate to get in touch.</p><p>Thank you for choosing {{website_name}}.</p><p>Best regards,<br>The {{website_name}} Team</p>', 'abc', 'en', 1, 'Good news! item \"{{item_name}}\" has been received at customer end.', 'Good news! item \"{{item_name}}\" has been received at customer end.', 0, 0, 1, 'Item \"{{item_name}}\" Delivered Successfully', '<p>Dear <strong>{{vendor_name}},</strong></p><p>We are pleased to inform you that the item <strong>\"{{item_name}}\"</strong> for your customer has been successfully received.</p><p><strong>Delivery Details:</strong></p><ul><li><strong>Customer Name:</strong> {{first_name}} {{last_name}}</li><li><strong>Item Name:</strong> {{item_name}}</li><li><strong>Booking ID:</strong> {{bookingid}}</li><li><strong>Received Date:</strong> {{current_date}}</li></ul><p>If you have any questions or need further assistance, feel free to reach out to our support team.</p><p>Thank you for your hard work and for choosing to partner with {{website_name}}.</p><p>Best regards,<br>The {{website_name}} Team</p>', 'Good news! Your item \"{{item_name}}\" has been received by customer.', 1, 0, 0, 'Good news! Your item \"{{item_name}}\" has been received by customer.', 'Item Delivery Confirmation', '<p>Dear <strong>Admin,</strong></p><p>I hope this email finds you well. We are pleased to inform you that an item received successfully by one of our users at <strong>{{website_name}}</strong>.</p><p><strong>Customer Details:</strong><br>Name: {{first_name}} {{last_name}}<br>Email: {{user_email}}<br>Phone: {{user_phone_country}}{{user_phone}}</p><p><strong>Delivery Details:</strong><br>Item: {{item_name}}<br>Received Date: {{current_date}}</p><p><strong>Vendor Details:</strong><br>Vendor Name: {{vendor_name}} </p><p>Vendor Email : {{vendor_email}}<br>Vendor Contact: {{phone_country}}{{vendor_phone}}</p><p>Thank you for your attention to this matter.</p><p>Best regards,<br><strong>{{website_name}} Team</strong></p>', '', 1, 0, 0, '', 0, '2023-09-01 11:50:21', '2024-12-20 14:58:06'),
(45, 'Item Returned', 1, 'user#vendor#admin', 'Item \"{{item_name}}\" Returned Successfully', '<p>Dear <strong>{{first_name}} {{last_name}},</strong></p><p>We are pleased to inform you that the item <strong>\"{{item_name}}\"</strong> for your vendor has been successfully returned.</p><p><strong>Delivery Details:</strong></p><ul><li><strong>Vendor Name:</strong> {{vendor_name}}</li><li><strong>Item Name:</strong> {{item_name}}</li><li><strong>Booking ID:</strong> {{bookingid}}</li><li><strong>Returned Date:</strong> {{current_date}}</li></ul><p>If you have any questions or need further assistance, feel free to reach out to our support team.</p><p>Thank you for your hard work and for choosing to partner with {{website_name}}.</p><p>Best regards,<br>The {{website_name}} Team</p>', 'abc', 'en', 1, 'Good news! item \"{{item_name}}\" has been returned to vendor.', 'Good news! item \"{{item_name}}\" has been returned to vendor.', 0, 0, 1, 'Item  \"{{item_name}}\"  Returned Successfully', '<p>Dear <strong>{{vendor_name}},</strong></p><p>We are pleased to inform you that your item has been successfully returned by customer . Thank you for your trust and patience.</p><p><strong>Delivery Details:</strong></p><ul><li><strong>Item Name:</strong> {{item_name}}</li><li><strong>Customer Name:</strong> {{first_name}} {{last_name}}</li><li><strong>Booking ID:</strong> {{bookingid}}</li><li><strong>Returned Date:</strong> {{current_date}}</li></ul><p>If you have any questions or concerns about your order, or if there’s anything else we can assist you with, please don’t hesitate to get in touch.</p><p>Thank you for choosing {{website_name}}.</p><p>Best regards,<br>The {{website_name}} Team</p>', 'Good news! Your item \"{{item_name}}\" has been returned by customer.', 1, 0, 0, 'Good news! Your item \"{{item_name}}\" has been returned by customer.', 'Item Return Confirmation', '<p>Dear <strong>Admin,</strong></p><p>I hope this email finds you well. We are pleased to inform you that an item returned successfully by one of our users at <strong>{{website_name}}</strong>.</p><p><strong>Customer Details:</strong><br>Name: {{first_name}} {{last_name}}<br>Email: {{user_email}}<br>Phone: {{user_phone_country}}{{user_phone}}</p><p><strong>Delivery Details:</strong><br>Item: {{item_name}}<br>Returned Date: {{current_date}}</p><p><strong>Vendor Details:</strong><br>Vendor Name: {{vendor_name}}</p><p>Vendor Email: {{vendor_email}}<br>Vendor Contact: {{phone_country}}{{vendor_phone}}                                                                                                                                 </p><p>Thank you for your attention to this matter.</p><p>Best regards,<br><strong>{{website_name}} Team</strong></p>', '', 1, 0, 0, '', 0, '2023-09-01 11:50:21', '2024-12-20 14:57:58');

-- --------------------------------------------------------

--
-- Table structure for table `email_type`
--

CREATE TABLE `email_type` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `email_type`
--

INSERT INTO `email_type` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'User Registration Template', '2024-01-21 19:24:30', '2024-01-21 19:24:30'),
(2, 'Signup OTP Template', '2024-01-21 19:24:30', '2024-01-21 19:24:30'),
(3, 'Forgot Password OTP Template', '2024-01-21 19:24:30', '2024-01-21 19:24:30'),
(4, 'Payout Request Template', '2024-01-21 19:24:30', '2024-01-21 19:24:30'),
(5, 'Booking Cancellation by Guest Template', '2024-01-21 19:24:30', '2024-01-21 19:24:30'),
(6, 'Payment Sent Template', '2024-01-21 19:24:30', '2024-01-21 19:24:30'),
(7, 'Wallet Transaction Template', '2024-01-21 19:24:30', '2024-01-21 19:24:30'),
(8, 'Message Template', '2024-01-21 19:24:30', '2024-01-21 19:24:30'),
(9, 'Booking Confirmed by Vendor Template', '2024-01-21 19:24:30', '2024-01-21 19:24:30'),
(10, 'Booking Template', '2024-01-21 19:24:30', '2024-01-21 19:24:30'),
(11, 'Booking Decline by Vendor Template', '2024-01-21 19:24:30', '2024-01-21 19:24:30'),
(12, 'Review by Vendor Template', '2024-01-21 19:24:30', '2024-01-21 19:24:30'),
(13, 'Review by User Template', '2024-01-21 19:24:30', '2024-01-21 19:24:30'),
(14, 'User Host Request', '2024-07-20 11:48:51', '2024-07-20 11:48:51'),
(15, 'Approved Host Request', '2024-07-20 11:48:51', '2024-07-20 11:48:51'),
(16, 'Email Change OTP', '2024-07-31 15:31:36', '2024-07-31 15:31:36'),
(17, 'Resend OTP', '2024-07-31 15:31:36', '2024-07-31 15:31:36'),
(18, 'Change Mobile OTP', '2024-07-31 15:31:36', '2024-07-31 15:31:36'),
(19, 'Item Publish', '2024-07-31 15:31:36', '2024-07-31 15:31:36'),
(20, 'Item Unpublish', '2024-07-31 15:31:36', '2024-07-31 15:31:36'),
(21, 'Ticket Reply By User', '2024-07-31 15:31:36', '2024-07-31 15:31:36'),
(22, 'Ticket Reply By Admin', '2024-07-31 15:31:36', '2024-07-31 15:31:36'),
(23, 'Item Delivered', '2024-11-28 17:54:10', '2024-11-28 17:54:10'),
(24, 'Item Received', '2024-11-28 17:54:10', '2024-11-28 17:54:10'),
(25, 'Item Returned', '2024-11-28 17:56:35', '2024-11-28 17:56:35');

-- --------------------------------------------------------

--
-- Table structure for table `general_settings`
--

CREATE TABLE `general_settings` (
  `id` bigint UNSIGNED NOT NULL,
  `meta_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `meta_key`, `meta_value`, `module`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'general_name', 'Rideon', 1, '2023-07-27 13:59:49', '2025-08-09 15:50:34', NULL),
(2, 'general_email', 'info@sizhitsolutions.com', 1, '2023-07-27 13:59:49', '2025-09-18 11:56:50', NULL),
(3, 'general_phone', '8750044724', 1, '2023-07-27 13:59:49', '2025-09-18 11:56:50', NULL),
(4, 'general_default_currency', 'USD', 1, '2023-07-27 13:59:49', '2025-08-22 10:53:02', NULL),
(5, 'general_default_language', 'en', 1, '2023-07-27 13:59:49', '2024-04-25 21:29:04', NULL),
(6, 'general_logo', 'logo/608330.714930.png', 1, '2023-07-27 13:59:49', '2025-09-04 08:08:44', NULL),
(7, 'general_favicon', 'logo/744152.appIcons.png', 1, '2023-07-27 13:59:49', '2025-08-20 08:28:32', NULL),
(14, 'personalization_money_format', 'after', 1, '2023-07-27 16:07:41', '2023-07-27 16:23:10', NULL),
(15, 'messagewizard_phone_no', '9625847856', 1, '2023-07-27 16:57:59', '2023-07-28 16:54:18', NULL),
(16, 'messagewizard_twilio_sid', 'ytuyti', 1, '2023-07-27 16:57:59', '2023-08-02 18:41:24', NULL),
(17, 'messagewizard_twilio_token', 'yturtu', 1, '2023-07-27 16:57:59', '2023-08-02 18:41:24', NULL),
(18, 'messagewizard_defaults', 'ytutyu', 1, '2023-07-27 16:57:59', '2023-08-02 19:16:02', NULL),
(19, 'messagewizard_status', '1', 1, '2023-07-27 16:59:12', '2023-08-02 19:20:06', NULL),
(20, 'emailwizard_driver', 'smtp', 1, '2023-07-27 17:41:21', '2023-07-27 17:41:21', NULL),
(21, 'emailwizard_emai_host', 'admin@gmail.com', 1, '2023-07-27 17:41:21', '2023-07-27 17:41:21', NULL),
(22, 'emailwizard_port', '507', 1, '2023-07-27 17:41:21', '2023-07-27 17:41:21', NULL),
(23, 'emailwizard_from_address', 'testuser@gmail.com', 1, '2023-07-27 17:41:21', '2023-07-27 17:41:21', NULL),
(25, 'emailwizard_encryption', 'tls', 1, '2023-07-27 17:41:21', '2023-07-27 17:41:21', NULL),
(26, 'emailwizard_username', 'rwer', 1, '2023-07-27 17:41:21', '2023-08-02 18:41:24', NULL),
(27, 'emailwizard_password', 'ewrwer', 1, '2023-07-27 17:41:21', '2023-08-02 18:41:24', NULL),
(33, 'api_google_client_id', 'ewtret', 1, '2023-07-27 19:18:32', '2023-08-02 18:41:24', NULL),
(34, 'api_google_client_secret', 'wetretret', 1, '2023-07-27 19:18:32', '2023-08-02 18:41:24', NULL),
(35, 'api_google_map_key', 'test', 1, '2023-07-27 19:18:32', '2025-09-18 11:48:19', NULL),
(36, 'socialmedia_facebook', '', 1, '2023-07-28 12:17:53', '2023-08-04 14:26:50', NULL),
(37, 'socialmedia_google_plus', '#', 1, '2023-07-28 12:19:42', '2023-08-04 14:26:50', NULL),
(43, 'socialnetwork_facebook_login', '1', 1, '2023-07-28 12:44:12', '2024-05-07 19:30:15', NULL),
(44, 'socialnetwork_google_login', '1', 1, '2023-07-28 12:45:56', '2024-05-24 10:07:53', NULL),
(45, 'paypal_status', 'Active', 1, '2023-07-28 14:28:27', '2025-08-09 15:39:20', NULL),
(46, 'paypal_username', 'agds', 1, '2023-07-28 14:28:27', '2023-08-02 18:41:24', NULL),
(47, 'paypal_password', 'desd', 1, '2023-07-28 14:28:27', '2023-08-02 18:41:24', NULL),
(48, 'paypal_signature', 'etret', 1, '2023-07-28 14:28:27', '2023-08-02 18:41:24', NULL),
(49, 'paypal_mode', 'were', 1, '2023-07-28 14:28:27', '2023-08-02 18:41:24', NULL),
(50, 'stripe_status', 'Active', 1, '2023-07-28 14:44:23', '2024-11-13 15:31:22', NULL),
(51, 'stripe_secret_key', 'rtyrtfgg', 1, '2023-07-28 14:44:23', '2023-08-02 18:41:24', NULL),
(52, 'stripe_publishable_key', 'sddkjl', 1, '2023-07-28 14:44:23', '2023-08-02 18:41:24', NULL),
(56, 'messagewizard_key', 'test', 1, '2023-08-28 13:56:59', '2025-01-28 08:30:47', NULL),
(57, 'messagewizard_secret', 'test', 1, '2023-08-28 13:56:59', '2025-01-28 08:30:47', NULL),
(58, 'emailwizard_key', 'postmaster@sandbox70f6bbf8761741ee89c40d0bd18dcb4a.mailgun.org', 1, '2023-08-28 14:04:43', '2024-05-07 19:15:15', NULL),
(59, 'emailwizard_secret', 'd7c365ca9fca566718058fc5631ce26f-451410ff-4556eb25', 1, '2023-08-28 14:04:43', '2024-05-07 19:15:15', NULL),
(64, 'options', 'test', 1, '2023-09-02 16:16:11', '2024-03-16 17:15:08', NULL),
(81, 'general_description', 'Rideon', 1, '2023-12-08 19:22:11', '2025-08-20 07:58:37', NULL),
(82, 'general_loginBackgroud', 'logo/826379.screen3.jpg', 1, '2023-12-08 20:34:32', '2023-12-08 20:42:34', NULL),
(114, 'msg91_key', 'msg91key 132422', 1, '2024-03-16 12:49:27', '2024-03-16 14:40:36', NULL),
(115, 'msg91_secret', 'msg91key hidden1', 1, '2024-03-16 12:49:27', '2024-03-16 13:04:10', NULL),
(116, 'twillio_key', 'test', 1, '2024-03-16 13:03:55', '2025-09-18 11:48:19', NULL),
(117, 'twillio_secret', 'test', 1, '2024-03-16 13:03:55', '2025-09-18 11:48:19', NULL),
(118, 'nexmo_key', 'nexmo key5', 1, '2024-03-16 13:12:06', '2024-03-16 14:40:48', NULL),
(126, 'test_paypal_client_id', 'test', 1, '2024-03-16 16:46:20', '2025-09-18 11:48:19', NULL),
(127, 'test_paypal_secret_key', 'test', 1, '2024-03-16 16:46:20', '2025-09-18 11:48:19', NULL),
(128, 'live_paypal_client_id', 'test', 1, '2024-03-16 16:48:24', '2025-01-28 08:30:47', NULL),
(129, 'live_paypal_secret_key', 'test', 1, '2024-03-16 16:48:24', '2025-01-28 08:30:47', NULL),
(131, 'paypal_options', 'test', 1, '2024-03-16 17:19:42', '2025-08-09 08:53:35', NULL),
(132, 'stripe_options', 'test', 1, '2024-03-16 17:39:09', '2024-07-24 09:50:01', NULL),
(133, 'test_stripe_public_key', 'test', 1, '2024-03-16 17:39:09', '2025-09-18 11:48:19', NULL),
(134, 'test_stripe_secret_key', 'test', 1, '2024-03-16 17:39:09', '2025-09-18 11:48:19', NULL),
(135, 'live_stripe_public_key', 'test', 1, '2024-03-16 17:39:19', '2025-01-28 08:30:47', NULL),
(136, 'live_stripe_secret_key', 'test', 1, '2024-03-16 17:39:19', '2025-01-28 08:30:47', NULL),
(137, 'razorpay_options', 'test', 1, '2024-03-16 17:49:37', '2025-01-08 13:38:07', NULL),
(138, 'test_razorpay_key_id', 'test', 1, '2024-03-16 17:49:37', '2025-09-18 11:48:19', NULL),
(139, 'test_razorpay_secret_key', 'test', 1, '2024-03-16 17:49:37', '2025-09-18 11:48:19', NULL),
(140, 'live_razorpay_key_id', 'test', 1, '2024-03-16 17:49:47', '2025-01-28 08:30:47', NULL),
(141, 'live_razorpay_secret_key', 'test', 1, '2024-03-16 17:49:47', '2025-01-28 08:30:47', NULL),
(153, 'general_captcha', 'no', 1, '2024-04-26 18:44:22', '2025-07-15 10:42:01', NULL),
(154, 'site_key', 'test', 1, '2024-04-26 19:05:53', '2025-09-18 11:48:19', NULL),
(155, 'private_key', 'test', 1, '2024-04-26 19:05:53', '2025-09-18 11:48:19', NULL),
(156, 'socialnetwork_apple_login', '1', 1, '2024-05-07 19:31:11', '2024-05-07 19:51:03', NULL),
(157, 'twillio_number', 'test', 1, '2024-05-24 09:59:34', '2025-09-18 11:48:19', NULL),
(158, 'pushnotification_key', 'AAAArMZjlK0:APA91bHBFYGyQbU40zONnMHgznc4TEnu324hkfDlorWRsoy1nL84kpTAtMis2NiL5bOyzwW22xL-UrvmfkvpAFGXNhZWBBgpwW4QrK_ep0VIgimiLhAwLVHk2J522lEyW-o673G2i775', 1, '2024-05-27 15:33:58', '2024-05-28 11:59:22', NULL),
(159, 'nonage_status', 'Active', 1, '2024-05-28 09:03:05', '2024-07-19 09:54:06', NULL),
(160, 'twillio_status', 'Inactive', 1, '2024-05-28 09:35:36', '2024-07-19 09:54:06', NULL),
(161, 'host', 'test', 1, '2024-05-31 15:32:35', '2025-09-18 11:48:19', NULL),
(162, 'port', '111', 1, '2024-05-31 15:32:35', '2025-09-18 11:48:19', NULL),
(163, 'username', 'test', 1, '2024-05-31 15:32:35', '2025-09-18 11:48:19', NULL),
(164, 'password', 'test', 1, '2024-05-31 15:32:35', '2025-09-18 11:48:19', NULL),
(165, 'encryption', 'test', 1, '2024-05-31 15:32:35', '2025-09-18 11:48:19', NULL),
(166, 'from_email', 'test', 1, '2024-05-31 15:32:35', '2025-09-18 11:48:19', NULL),
(168, 'onesignal_app_id', 'test', 1, '2024-07-18 07:22:57', '2025-09-18 11:48:19', NULL),
(169, 'onesignal_rest_api_key', 'test', 1, '2024-07-18 07:22:57', '2025-09-18 11:48:19', NULL),
(170, 'push_notification_status', 'onesignal', 1, NULL, '2025-07-29 10:39:44', NULL),
(172, 'sinch_service_plan_id', 'test', 1, '2024-07-19 07:00:46', '2025-01-28 08:30:47', NULL),
(173, 'sinch_api_token', 'test', 1, '2024-07-19 07:00:46', '2025-01-28 08:30:47', NULL),
(174, 'sinch_sender_number', 'test', 1, '2024-07-19 07:00:46', '2025-01-28 08:30:47', NULL),
(175, 'sinch_status', 'Inactive', 1, NULL, NULL, NULL),
(176, 'sms_provider_name', 'nonage', 1, NULL, '2025-08-09 17:21:37', NULL),
(177, 'messagewizard_sender_number', 'test', 1, '2024-07-19 10:26:55', '2025-01-28 08:30:47', NULL),
(178, 'onlinepayment', 'Inactive', 1, '2024-07-24 10:04:04', '2025-09-18 11:48:19', NULL),
(179, 'msg91_auth_key', 'test', 1, '2024-07-26 07:52:22', '2025-01-28 08:30:47', NULL),
(180, 'msg91_template_id', 'test', 1, '2024-07-26 07:52:22', '2025-01-28 08:30:47', NULL),
(181, 'currency_auth_key', 'test', 1, '2024-07-30 10:40:06', '2025-01-28 08:30:47', NULL),
(182, 'auto_fill_otp', '1', 1, '2024-07-30 11:21:52', '2025-08-09 17:31:28', NULL),
(183, 'total_number_of_bookings_per_day', '20', 1, '2024-08-02 12:07:41', '2024-09-11 14:49:47', NULL),
(184, 'multicurrency_status', '0', 1, '2024-10-28 10:12:21', '2024-12-12 11:29:33', NULL),
(185, 'razorpay_status', 'Inactive', 1, '2024-11-13 16:56:47', '2025-07-28 07:39:18', NULL),
(186, 'general_default_phone_country', '+91', 1, '2024-12-05 14:59:29', '2024-12-17 18:45:03', NULL),
(187, 'general_default_country_code', 'IN', 1, '2024-12-05 14:59:29', '2024-12-17 18:45:03', NULL),
(195, 'onesignal_app_id_driver', 'b27d2973-b38a-45d7-b4ef-89e069525e57', 1, '2025-07-29 10:24:26', '2025-07-29 10:24:58', NULL),
(196, 'onesignal_rest_api_key_driver', 'os_v2_app_nnqev6oaozdy7gqo6m6bf7rznl6rk3qcs73eblvko4bil7fdf5graw3hcl34zjzgbgp2f2uovs4yxdzvu4y5atvotqisnmxk5appjmy', 1, '2025-07-29 10:24:26', '2025-09-01 13:46:01', NULL),
(197, 'firebase_update_interval', '5', 1, '2025-08-08 08:06:59', '2025-08-08 11:04:49', NULL),
(198, 'location_accuracy_threshold', '10', 1, '2025-08-08 08:06:59', '2025-08-08 11:04:49', NULL),
(199, 'background_location_interval', '10', 1, '2025-08-08 08:06:59', '2025-08-08 11:04:49', NULL),
(200, 'driver_search_interval', '60', 1, '2025-08-08 08:06:59', '2025-08-21 08:02:30', NULL),
(201, 'use_google_after_pickup', '0', 1, '2025-08-08 08:06:59', '2025-08-08 09:46:27', NULL),
(202, 'use_google_before_pickup', '0', 1, '2025-08-08 08:06:59', '2025-08-08 09:46:27', NULL),
(203, 'minimum_hits_time', '10', 1, '2025-08-08 08:06:59', '2025-08-08 09:46:27', NULL),
(204, 'use_google_source_destination', '0', 1, '2025-08-08 08:06:59', '2025-08-25 11:32:57', NULL),
(205, 'cash_status', 'Active', 1, '2025-08-09 08:39:17', '2025-08-09 15:05:18', NULL),
(206, 'personalization_row_per_page', '25', 1, '2025-08-09 17:33:39', '2025-08-09 17:33:39', NULL),
(207, 'personalization_date_separator', '-', 1, '2025-08-09 17:33:39', '2025-08-09 17:33:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `item_city_fare`
--

CREATE TABLE `item_city_fare` (
  `id` bigint UNSIGNED NOT NULL,
  `item_type_id` bigint UNSIGNED NOT NULL,
  `min_fare` decimal(10,2) DEFAULT NULL,
  `max_fare` decimal(10,2) DEFAULT NULL,
  `recommended_fare` decimal(10,2) NOT NULL,
  `admin_commission` decimal(5,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `language_status` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `short_name`, `language_status`, `created_at`, `updated_at`) VALUES
(1, 'English', 'en', 1, '2023-07-28 18:26:08', '2023-07-28 19:10:40'),
(3, 'French', 'fr', 1, '2023-07-29 12:33:08', '2023-07-29 12:39:58');

-- --------------------------------------------------------

--
-- Table structure for table `make_type_relation`
--

CREATE TABLE `make_type_relation` (
  `id` int NOT NULL,
  `make_id` bigint UNSIGNED NOT NULL,
  `type_id` bigint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  `uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collection_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversions_disk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint UNSIGNED NOT NULL,
  `manipulations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `custom_properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `generated_conversions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `responsive_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `order_column` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(2, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(3, '2024_09_12_000000_create_rental_items_table', 1),
(4, '2024_09_12_000001_create_rental_item_features_table', 1),
(5, '2024_09_12_000002_create_rental_item_types_table', 1),
(6, '2024_09_12_000003_create_currency_table', 1),
(7, '2024_09_12_000004_create_rental_item_vehicle_table', 1),
(8, '2024_09_12_000005_create_rental_item_wishlists_table', 1),
(9, '2024_09_12_000006_create_rental_item_dates_table', 1),
(10, '2024_09_12_000007_create_rental_item_subcategory_table', 1),
(11, '2024_09_12_000008_create_rental_item_meta_table', 1),
(12, '2024_09_12_000009_create_rental_item_category_table', 1),
(13, '2024_09_12_000010_create_add_coupons_table', 1),
(14, '2024_09_12_000020_create_app_user_otps_table', 1),
(15, '2024_09_12_000021_create_availabilities_table', 1),
(16, '2024_09_12_000022_create_booking_cancellation_reasons_table', 1),
(17, '2024_09_12_000023_create_contact_us_table', 1),
(18, '2024_09_12_000024_create_module_table', 1),
(19, '2024_09_12_000025_create_permissions_table', 1),
(20, '2024_09_12_000026_create_roles_table', 1),
(21, '2024_09_12_000028_create_sliders_table', 1),
(22, '2024_09_12_000029_create_static_pages_table', 1),
(23, '2024_09_12_000040_create_testimonials_table', 1),
(24, '2024_09_12_000041_create_app_user_meta_table', 1),
(25, '2024_09_12_000042_create_general_settings_table', 1),
(26, '2024_09_12_000043_create_all_packages_table', 1),
(27, '2024_09_12_000045_create_category_type_relation_table', 1),
(28, '2024_09_12_000047_create_payouts_table', 1),
(29, '2024_09_12_000048_create_booking_cancellation_policies_table', 1),
(30, '2024_09_12_000049_create_reviews_table', 1),
(31, '2024_09_12_000050_create_support_tickets_table', 1),
(32, '2024_09_12_000060_create_app_users_table', 1),
(33, '2024_09_12_000070_create_vehicle_odometer_table', 1),
(34, '2024_09_12_000080_create_users_table', 1),
(35, '2024_09_12_000081_create_transactions_table', 1),
(36, '2024_09_12_000082_create_support_ticket_replies_table', 1),
(37, '2024_09_12_000084_create_rental_item_rules_table', 1),
(38, '2024_09_12_000085_create_languages_table', 1),
(39, '2024_09_12_000086_create_app_users_bank_accounts_table', 1),
(40, '2024_09_12_000087_create_email_type_table', 1),
(41, '2024_09_12_000088_create_email_sms_notification_table', 1),
(42, '2024_09_12_000089_create_email_notification_mappings_table', 1),
(43, '2024_09_12_000090_create_cities_table', 1),
(44, '2024_09_12_000091_create_bookings_table', 1),
(45, '2024_09_12_000092_create_vendor_wallet_table', 1),
(46, '2024_09_12_000092_create_wallets_table', 1),
(47, '2024_09_12_000093_create_media_table', 1),
(48, '2025_09_18_094644_create_add_coupons_table', 0),
(49, '2025_09_18_094644_create_all_packages_table', 0),
(50, '2025_09_18_094644_create_app_user_meta_table', 0),
(51, '2025_09_18_094644_create_app_user_otps_table', 0),
(52, '2025_09_18_094644_create_app_users_table', 0),
(53, '2025_09_18_094644_create_app_users_bank_accounts_table', 0),
(54, '2025_09_18_094644_create_booking_cancellation_policies_table', 0),
(55, '2025_09_18_094644_create_booking_cancellation_reasons_table', 0),
(56, '2025_09_18_094644_create_booking_extensions_table', 0),
(57, '2025_09_18_094644_create_booking_meta_table', 0),
(58, '2025_09_18_094644_create_bookings_table', 0),
(59, '2025_09_18_094644_create_cities_table', 0),
(60, '2025_09_18_094644_create_contact_us_table', 0),
(61, '2025_09_18_094644_create_currency_table', 0),
(62, '2025_09_18_094644_create_email_notification_mappings_table', 0),
(63, '2025_09_18_094644_create_email_sms_notification_table', 0),
(64, '2025_09_18_094644_create_email_type_table', 0),
(65, '2025_09_18_094644_create_general_settings_table', 0),
(66, '2025_09_18_094644_create_item_city_fare_table', 0),
(67, '2025_09_18_094644_create_jobs_table', 0),
(68, '2025_09_18_094644_create_languages_table', 0),
(69, '2025_09_18_094644_create_make_type_relation_table', 0),
(70, '2025_09_18_094644_create_media_table', 0),
(71, '2025_09_18_094644_create_module_table', 0),
(72, '2025_09_18_094644_create_password_resets_table', 0),
(73, '2025_09_18_094644_create_payouts_table', 0),
(74, '2025_09_18_094644_create_permission_role_table', 0),
(75, '2025_09_18_094644_create_permissions_table', 0),
(76, '2025_09_18_094644_create_personal_access_tokens_table', 0),
(77, '2025_09_18_094644_create_rental_item_dates_table', 0),
(78, '2025_09_18_094644_create_rental_item_extension_table', 0),
(79, '2025_09_18_094644_create_rental_item_features_table', 0),
(80, '2025_09_18_094644_create_rental_item_make_table', 0),
(81, '2025_09_18_094644_create_rental_item_meta_table', 0),
(82, '2025_09_18_094644_create_rental_item_rules_table', 0),
(83, '2025_09_18_094644_create_rental_item_types_table', 0),
(84, '2025_09_18_094644_create_rental_item_wishlists_table', 0),
(85, '2025_09_18_094644_create_rental_items_table', 0),
(86, '2025_09_18_094644_create_reviews_table', 0),
(87, '2025_09_18_094644_create_role_user_table', 0),
(88, '2025_09_18_094644_create_roles_table', 0),
(89, '2025_09_18_094644_create_sliders_table', 0),
(90, '2025_09_18_094644_create_static_pages_table', 0),
(91, '2025_09_18_094644_create_support_ticket_replies_table', 0),
(92, '2025_09_18_094644_create_support_tickets_table', 0),
(93, '2025_09_18_094644_create_transactions_table', 0),
(94, '2025_09_18_094644_create_users_table', 0),
(95, '2025_09_18_094644_create_vehicle_odometer_table', 0),
(96, '2025_09_18_094644_create_vendor_wallets_table', 0),
(97, '2025_09_18_094644_create_wallets_table', 0),
(98, '2025_09_18_094647_add_foreign_keys_to_app_user_meta_table', 0),
(99, '2025_09_18_094647_add_foreign_keys_to_app_users_table', 0),
(100, '2025_09_18_094647_add_foreign_keys_to_app_users_bank_accounts_table', 0),
(101, '2025_09_18_094647_add_foreign_keys_to_booking_extensions_table', 0),
(102, '2025_09_18_094647_add_foreign_keys_to_booking_meta_table', 0),
(103, '2025_09_18_094647_add_foreign_keys_to_email_notification_mappings_table', 0),
(104, '2025_09_18_094647_add_foreign_keys_to_item_city_fare_table', 0),
(105, '2025_09_18_094647_add_foreign_keys_to_make_type_relation_table', 0),
(106, '2025_09_18_094647_add_foreign_keys_to_payouts_table', 0),
(107, '2025_09_18_094647_add_foreign_keys_to_permission_role_table', 0),
(108, '2025_09_18_094647_add_foreign_keys_to_rental_item_dates_table', 0),
(109, '2025_09_18_094647_add_foreign_keys_to_rental_item_extension_table', 0),
(110, '2025_09_18_094647_add_foreign_keys_to_rental_item_meta_table', 0),
(111, '2025_09_18_094647_add_foreign_keys_to_rental_item_wishlists_table', 0),
(112, '2025_09_18_094647_add_foreign_keys_to_rental_items_table', 0),
(113, '2025_09_18_094647_add_foreign_keys_to_reviews_table', 0),
(114, '2025_09_18_094647_add_foreign_keys_to_role_user_table', 0),
(115, '2025_09_18_094647_add_foreign_keys_to_transactions_table', 0),
(116, '2025_09_18_094647_add_foreign_keys_to_vendor_wallets_table', 0),
(117, '2025_09_18_094647_add_foreign_keys_to_wallets_table', 0);

-- --------------------------------------------------------

--
-- Table structure for table `module`
--

CREATE TABLE `module` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` tinyint NOT NULL DEFAULT '0',
  `default_module` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `module`
--

INSERT INTO `module` (`id`, `name`, `description`, `status`, `default_module`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 'Taxi', 'Taxi', 1, 1, '2023-10-13 13:36:26', '2025-07-29 08:23:04', NULL),
(3, 'Boat', 'Boat', 0, 0, '2023-10-13 13:43:22', '2024-09-11 14:17:17', '2024-09-11 10:17:17'),
(4, 'Parking', 'Parking', 0, 0, '2023-10-13 13:57:39', '2024-09-11 14:17:20', '2024-09-11 10:17:20'),
(5, 'Bookable', 'Bookable', 0, 0, '2024-01-19 17:08:31', '2024-09-11 14:17:23', '2024-09-11 10:17:23'),
(6, 'Space', 'Space', 0, 0, '2024-02-08 16:28:51', '2024-09-11 14:17:28', '2024-09-11 10:17:28');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('sizhitsolutions@gmail.com', '$2y$10$KCPlqyHkLkEzH7R65wNuGu99DrA0THpePQJMoBsjJy1pZTKAe5IdS', '2025-01-23 16:26:44');

-- --------------------------------------------------------

--
-- Table structure for table `payouts`
--

CREATE TABLE `payouts` (
  `id` bigint UNSIGNED NOT NULL,
  `vendorid` bigint UNSIGNED NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'vendor',
  `payment_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payout_status` enum('Pending','Success','Rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `module` tinyint(1) NOT NULL DEFAULT '2',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `title`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'user_management_access', NULL, NULL, NULL),
(2, 'permission_create', NULL, NULL, NULL),
(3, 'permission_edit', NULL, NULL, NULL),
(4, 'permission_show', NULL, NULL, NULL),
(5, 'permission_delete', NULL, NULL, NULL),
(6, 'permission_access', NULL, NULL, NULL),
(7, 'role_create', NULL, NULL, NULL),
(8, 'role_edit', NULL, NULL, NULL),
(9, 'role_show', NULL, NULL, NULL),
(10, 'role_delete', NULL, NULL, NULL),
(11, 'role_access', NULL, NULL, NULL),
(12, 'user_create', NULL, NULL, NULL),
(13, 'user_edit', NULL, NULL, NULL),
(14, 'user_show', NULL, NULL, NULL),
(15, 'user_delete', NULL, NULL, NULL),
(16, 'user_access', NULL, NULL, NULL),
(17, 'item_setting_access', NULL, NULL, NULL),
(18, 'slider_create', NULL, NULL, NULL),
(19, 'slider_edit', NULL, NULL, NULL),
(20, 'slider_show', NULL, NULL, NULL),
(21, 'slider_delete', NULL, NULL, NULL),
(22, 'slider_access', NULL, '2024-05-21 14:46:33', '2024-05-21 14:46:33'),
(23, 'faq_management_access', NULL, '2024-09-11 14:16:35', '2024-09-11 14:16:35'),
(24, 'faq_category_create', NULL, '2024-09-11 14:16:35', '2024-09-11 14:16:35'),
(25, 'faq_category_edit', NULL, '2024-09-11 14:16:35', '2024-09-11 14:16:35'),
(26, 'faq_category_show', NULL, '2024-09-11 14:16:35', '2024-09-11 14:16:35'),
(27, 'faq_category_delete', NULL, '2024-09-11 14:16:35', '2024-09-11 14:16:35'),
(28, 'faq_category_access', NULL, '2024-09-11 14:16:35', '2024-09-11 14:16:35'),
(29, 'faq_question_create', NULL, '2024-09-11 14:16:35', '2024-09-11 14:16:35'),
(30, 'faq_question_edit', NULL, '2024-09-11 14:16:35', '2024-09-11 14:16:35'),
(31, 'faq_question_show', NULL, '2024-09-11 14:16:35', '2024-09-11 14:16:35'),
(32, 'faq_question_delete', NULL, '2024-09-11 14:16:35', '2024-09-11 14:16:35'),
(33, 'faq_question_access', NULL, '2024-09-11 14:16:35', '2024-09-11 14:16:35'),
(34, 'city_create', NULL, NULL, NULL),
(35, 'city_edit', NULL, NULL, NULL),
(36, 'city_show', NULL, NULL, NULL),
(37, 'city_access', NULL, NULL, NULL),
(38, 'item_types_create', NULL, '2024-09-03 14:28:28', NULL),
(39, 'item_types_edit', NULL, '2024-09-03 14:28:18', NULL),
(40, 'item_types_show', NULL, '2024-09-03 14:28:07', NULL),
(41, 'item_types_access', NULL, '2024-09-03 14:27:43', NULL),
(42, 'space_type_create', NULL, '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(43, 'space_type_edit', NULL, '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(44, 'space_type_show', NULL, '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(45, 'space_type_access', NULL, '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(46, 'bed_type_create', NULL, '2024-09-11 14:17:02', '2024-09-11 14:17:02'),
(47, 'bed_type_edit', NULL, '2024-09-11 14:17:02', '2024-09-11 14:17:02'),
(48, 'bed_type_show', NULL, '2024-09-11 14:17:02', '2024-09-11 14:17:02'),
(49, 'bed_type_access', NULL, '2024-09-11 14:17:02', '2024-09-11 14:17:02'),
(50, 'features_create', NULL, '2024-09-11 14:16:23', NULL),
(51, 'features_edit', NULL, '2024-09-11 14:16:06', NULL),
(52, 'features_show', NULL, '2024-09-11 14:15:56', NULL),
(53, 'features_access', NULL, '2024-09-11 14:15:39', NULL),
(54, 'app_user_create', NULL, NULL, NULL),
(55, 'app_user_edit', NULL, NULL, NULL),
(56, 'app_user_show', NULL, NULL, NULL),
(57, 'app_user_access', NULL, NULL, NULL),
(58, 'front_management_access', NULL, NULL, NULL),
(59, 'item_create', NULL, '2024-09-03 14:27:33', NULL),
(60, 'item_edit', NULL, '2024-09-03 14:27:23', NULL),
(61, 'item_show', NULL, '2024-09-03 14:27:12', NULL),
(62, 'item_delete', NULL, '2024-09-03 14:27:00', NULL),
(63, 'item_access', NULL, '2024-09-03 14:26:49', NULL),
(64, 'item_management_access', NULL, '2024-09-03 14:26:09', NULL),
(65, 'availability_create', NULL, NULL, NULL),
(66, 'availability_edit', NULL, NULL, NULL),
(67, 'availability_show', NULL, NULL, NULL),
(68, 'availability_access', NULL, NULL, NULL),
(69, 'testimonial_create', NULL, NULL, NULL),
(70, 'testimonial_edit', NULL, NULL, NULL),
(71, 'testimonial_show', NULL, NULL, NULL),
(72, 'testimonial_delete', NULL, NULL, NULL),
(73, 'testimonial_access', NULL, NULL, NULL),
(74, 'booking_create', NULL, NULL, NULL),
(75, 'booking_edit', NULL, NULL, NULL),
(76, 'booking_show', NULL, NULL, NULL),
(77, 'booking_access', NULL, NULL, NULL),
(78, 'review_create', NULL, NULL, NULL),
(79, 'review_edit', NULL, NULL, NULL),
(80, 'review_show', NULL, NULL, NULL),
(81, 'review_access', NULL, NULL, NULL),
(82, 'static_page_create', NULL, NULL, NULL),
(83, 'static_page_edit', NULL, NULL, NULL),
(84, 'static_page_show', NULL, NULL, NULL),
(85, 'static_page_delete', NULL, NULL, NULL),
(86, 'static_page_access', NULL, NULL, NULL),
(87, 'package_access', NULL, NULL, NULL),
(88, 'all_package_create', NULL, NULL, NULL),
(89, 'all_package_edit', NULL, NULL, NULL),
(90, 'all_package_show', NULL, NULL, NULL),
(91, 'all_package_access', NULL, NULL, NULL),
(92, 'general_setting_edit', NULL, NULL, NULL),
(93, 'general_setting_access', NULL, NULL, NULL),
(94, 'all_general_setting_access', NULL, NULL, NULL),
(95, 'coupon_access', NULL, NULL, NULL),
(96, 'add_coupon_create', NULL, NULL, NULL),
(97, 'add_coupon_edit', NULL, NULL, NULL),
(98, 'add_coupon_show', NULL, NULL, NULL),
(99, 'add_coupon_delete', NULL, NULL, NULL),
(100, 'add_coupon_access', NULL, NULL, NULL),
(101, 'payout_create', NULL, NULL, NULL),
(102, 'payout_edit', NULL, NULL, NULL),
(103, 'payout_show', NULL, NULL, NULL),
(104, 'payout_access', NULL, NULL, NULL),
(105, 'profile_password_edit', NULL, NULL, NULL),
(106, 'contact_access', '2023-08-09 13:45:44', '2024-05-06 20:58:47', '2024-05-06 20:58:47'),
(107, 'contact_create', '2023-08-09 14:21:40', '2024-05-06 20:58:58', '2024-05-06 20:58:58'),
(108, 'contact_edit', '2023-08-09 14:22:26', '2024-05-06 20:58:58', '2024-05-06 20:58:58'),
(109, 'contact_show', '2023-08-09 14:24:01', '2024-05-06 20:58:58', '2024-05-06 20:58:58'),
(110, 'app_user_detail', '2023-08-23 13:28:45', '2023-08-23 13:28:45', NULL),
(111, 'payout_delete', '2023-08-25 12:06:53', '2023-08-25 12:06:53', NULL),
(112, 'email_access', '2023-08-29 10:59:18', '2023-08-29 10:59:18', NULL),
(113, 'cancellation_access', '2023-09-04 16:53:45', '2023-09-04 16:53:45', NULL),
(114, 'cancellation_policies', '2023-09-04 16:56:52', '2023-09-04 16:56:52', NULL),
(115, 'support_ticket', '2023-09-05 12:16:35', '2023-09-05 12:16:35', NULL),
(116, 'vendor_items', '2023-09-15 14:42:21', '2024-09-03 14:25:58', NULL),
(117, 'ticket_create', '2023-10-09 11:02:54', '2023-10-09 11:02:54', NULL),
(118, 'ticket_edit', '2023-10-12 11:19:19', '2023-10-12 11:20:03', '2023-10-12 11:20:03'),
(119, 'city_delete', '2023-12-11 17:26:59', '2023-12-11 17:26:59', NULL),
(120, 'item_types_delete', '2023-12-11 21:34:38', '2024-09-03 14:25:42', NULL),
(121, 'features_delete', '2023-12-11 21:35:02', '2024-09-11 14:15:27', NULL),
(122, 'boat_make_delete', '2024-02-21 16:56:22', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(123, 'boat_make_show', '2024-02-21 17:05:59', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(124, 'boat_make_edit', '2024-02-21 17:06:08', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(125, 'boat_model_delete', '2024-02-21 17:26:10', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(126, 'boat_model_edit', '2024-02-21 17:26:20', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(127, 'boat_model_show', '2024-02-21 17:26:31', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(128, 'boat_features_show', '2024-02-21 18:36:34', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(129, 'boat_features_edit', '2024-02-21 18:36:41', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(130, 'boat_features_delete', '2024-02-21 18:36:47', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(131, 'boat_type_show', '2024-02-21 18:50:15', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(132, 'boat_type_edit', '2024-02-21 18:50:23', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(133, 'boat_type_delete', '2024-02-21 18:50:29', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(134, 'boat_location_show', '2024-02-21 18:56:10', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(135, 'boat_location_edit', '2024-02-21 18:56:20', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(136, 'boat_location_delete', '2024-02-21 18:56:32', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(137, 'vehicle_features_show', '2024-02-21 19:08:48', '2024-09-23 12:29:52', NULL),
(138, 'vehicle_features_edit', '2024-02-21 19:08:54', '2024-09-23 12:29:40', NULL),
(139, 'vehicle_features_delete', '2024-02-21 19:09:02', '2024-09-23 12:29:30', NULL),
(140, 'vehicle_type_show', '2024-02-21 19:29:24', '2024-02-21 19:29:24', NULL),
(141, 'vehicle_type_edit', '2024-02-21 19:29:31', '2024-02-21 19:29:31', NULL),
(142, 'vehicle_type_delete', '2024-02-21 19:29:39', '2024-02-21 19:29:39', NULL),
(143, 'vehicle_location_delete', '2024-02-22 11:43:50', '2024-02-22 11:43:50', NULL),
(144, 'vehicle_location_edit', '2024-02-22 11:43:58', '2024-02-22 11:43:58', NULL),
(145, 'vehicle_location_show', '2024-02-22 11:44:07', '2024-03-15 16:39:30', NULL),
(146, 'vehicle_makes_show', '2024-02-22 12:10:17', '2024-02-22 12:10:17', NULL),
(147, 'vehicle_makes_edit', '2024-02-22 12:10:23', '2024-02-22 12:10:23', NULL),
(148, 'vehicle_makes_delete', '2024-02-22 12:10:30', '2024-02-22 12:10:30', NULL),
(149, 'vehicle_model_show', '2024-02-22 12:17:21', '2024-02-22 12:17:21', NULL),
(150, 'vehicle_model_edit', '2024-02-22 12:17:28', '2024-02-22 12:17:28', NULL),
(151, 'vehicle_model_delete', '2024-02-22 12:17:35', '2024-02-22 12:17:35', NULL),
(152, 'parking_type_show', '2024-02-22 14:00:45', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(153, 'parking_type_edit', '2024-02-22 14:00:52', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(154, 'parking_type_delete', '2024-02-22 14:01:00', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(155, 'parking_location_show', '2024-02-22 14:20:03', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(156, 'parking_location_edit', '2024-02-22 14:20:16', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(157, 'parking_location_delete', '2024-02-22 14:20:22', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(158, 'parking_features_show', '2024-02-22 14:36:31', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(159, 'parking_features_edit', '2024-02-22 14:36:39', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(160, 'parking_features_delete', '2024-02-22 14:36:49', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(161, 'slider_access', '2024-03-01 18:57:23', '2024-03-01 18:57:23', NULL),
(162, 'vehicle_edit', '2024-03-02 13:04:55', '2024-03-02 13:04:55', NULL),
(163, 'booking_location_delete', '2024-03-05 17:44:33', '2024-03-05 17:44:33', NULL),
(164, 'booking_location_edit', '2024-03-05 17:44:42', '2024-03-05 17:44:42', NULL),
(165, 'booking_location_show', '2024-03-05 17:44:51', '2024-03-05 17:44:51', NULL),
(166, 'space_location_delete', '2024-03-05 17:55:25', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(167, 'space_location_edit', '2024-03-05 17:55:35', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(168, 'space_location_show', '2024-03-05 17:55:44', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(169, 'space_features_delete', '2024-03-06 15:40:30', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(170, 'space_features_edit', '2024-03-06 15:40:37', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(171, 'space_features_show', '2024-03-06 15:40:46', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(172, 'booking_categories_delete', '2024-03-06 15:54:10', '2024-03-06 15:54:10', NULL),
(173, 'booking_categories_edit', '2024-03-06 15:54:20', '2024-03-06 15:54:20', NULL),
(174, 'booking_categories_show', '2024-03-06 15:54:29', '2024-03-06 15:54:29', NULL),
(175, 'booking_subcategories_delete', '2024-03-06 16:11:09', '2024-03-06 16:11:09', NULL),
(176, 'booking_subcategories_edit', '2024-03-06 16:11:19', '2024-03-06 16:11:19', NULL),
(177, 'booking_subcategories_show', '2024-03-06 16:11:24', '2024-03-06 16:11:24', NULL),
(178, 'bookable_type_show', '2024-03-08 17:10:43', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(179, 'bookable_type_edit', '2024-03-08 17:10:51', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(180, 'bookable_type_delete', '2024-03-08 17:10:55', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(181, 'bookable-type\'', '2024-03-08 17:11:04', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(182, 'bookable_attribute_delete', '2024-03-11 16:48:55', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(183, 'bookable_attribute_edit', '2024-03-11 16:49:02', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(184, 'bookable_attribute_show', '2024-03-11 16:49:09', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(185, 'bookable_location_delete', '2024-03-11 17:06:12', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(186, 'bookable_location_edit', '2024-03-11 17:06:18', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(187, 'bookable_location_show', '2024-03-11 17:06:25', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(188, 'bookable_categories_delete', '2024-03-11 17:30:09', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(189, 'bookable_categories_edit', '2024-03-11 17:30:17', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(190, 'bookable_categories_show', '2024-03-11 17:30:26', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(191, 'bookable_subcategories_delete', '2024-03-11 17:43:21', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(192, 'bookable_subcategories_edit', '2024-03-11 17:43:31', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(193, 'bookable_subcategories_show', '2024-03-11 17:43:41', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(194, 'location_show', '2024-03-12 13:47:20', '2024-03-12 13:47:20', NULL),
(195, 'location_edit', '2024-03-12 13:47:27', '2024-03-12 13:47:27', NULL),
(196, 'location_delete', '2024-03-12 13:47:35', '2024-03-12 13:47:35', NULL),
(198, 'item_location_show', '2024-03-15 14:02:19', '2024-09-03 14:25:32', NULL),
(199, 'item_location_edit', '2024-03-15 14:02:30', '2024-09-03 14:25:17', NULL),
(200, 'item_location_delete', '2024-03-15 14:02:40', '2024-09-03 14:25:05', NULL),
(201, 'item_location_access', '2024-03-15 14:02:50', '2024-09-03 14:24:54', NULL),
(202, 'vehicle_location_access', '2024-03-15 16:42:37', '2024-03-15 16:42:37', NULL),
(203, 'boat_location_update', '2024-03-15 16:49:30', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(204, 'boat_location_access', '2024-03-15 16:49:41', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(205, 'boat_location_edit', '2024-03-15 16:49:52', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(206, 'boat_location_delete', '2024-03-15 16:50:01', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(207, 'parking_location_access', '2024-03-15 16:52:12', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(208, 'bookable_location_access', '2024-03-15 16:54:11', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(209, 'space_location_access', '2024-03-15 16:56:04', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(210, 'vehicle_type_access', '2024-03-15 18:08:16', '2024-03-15 18:08:16', NULL),
(211, 'vehicle_type_create', '2024-03-15 18:11:58', '2024-03-15 18:11:58', NULL),
(212, 'boat_type_create', '2024-03-15 18:16:31', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(213, 'boat_type_access', '2024-03-15 18:16:47', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(214, 'parking_type_access', '2024-03-15 18:33:21', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(215, 'parking_type_create', '2024-03-15 18:35:32', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(216, 'bookable_type_access', '2024-03-15 18:39:32', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(217, 'bookable_type_create', '2024-03-15 18:39:42', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(218, 'space_type_delete', '2024-03-15 18:43:41', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(219, 'vehicle_features_access', '2024-03-16 12:57:15', '2024-09-23 12:29:08', NULL),
(220, 'vehicle_features_create', '2024-03-16 12:59:53', '2024-09-23 12:28:59', NULL),
(221, 'boat_features_create', '2024-03-16 13:06:45', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(222, 'boat_features_access', '2024-03-16 13:06:54', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(223, 'parking_features_access', '2024-03-16 13:12:31', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(224, 'parking_features_create', '2024-03-16 13:12:40', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(225, 'bookable_attribute_access', '2024-03-16 13:16:35', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(226, 'bookable_attribute_create', '2024-03-16 13:16:43', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(227, 'space_features_access', '2024-03-16 13:20:21', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(228, 'space_features_create', '2024-03-16 13:20:29', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(229, 'items_setting_access', '2024-03-16 13:57:58', '2024-09-03 14:24:39', NULL),
(230, 'items_setting_edit', '2024-03-16 14:02:48', '2024-09-03 14:24:20', NULL),
(231, 'vehicle_setting_access', '2024-03-16 14:07:59', '2024-03-16 14:07:59', NULL),
(232, 'vehicle_setting_edit', '2024-03-16 14:08:08', '2024-03-16 14:08:08', NULL),
(233, 'space_setting_access', '2024-03-16 14:22:11', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(234, 'space_setting_edit', '2024-03-16 14:22:19', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(235, 'boat_setting_access', '2024-03-16 14:22:45', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(236, 'boat_setting_edit', '2024-03-16 14:22:52', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(237, 'parking_setting_access', '2024-03-16 14:23:06', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(238, 'parking_setting_edit', '2024-03-16 14:23:13', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(239, 'bookable_setting_access', '2024-03-16 14:23:29', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(240, 'bookable_setting_edit', '2024-03-16 14:23:36', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(241, 'space_setting_access', '2024-03-16 14:23:50', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(242, 'space_setting_edit', '2024-03-16 14:24:05', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(243, 'bookable_location_create', '2024-03-16 14:33:02', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(244, 'vehicle_makes_access', '2024-03-16 15:11:29', '2024-03-16 15:11:29', NULL),
(245, 'vehicle_makes_create', '2024-03-16 15:11:38', '2024-03-16 15:11:38', NULL),
(246, 'bookable_categories_access', '2024-03-16 16:08:38', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(247, 'bookable_categories_create', '2024-03-16 16:08:47', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(248, 'vehicle_model_access', '2024-03-16 17:39:01', '2024-03-16 17:39:01', NULL),
(249, 'vehicle_model_create', '2024-03-16 17:39:09', '2024-03-16 17:39:09', NULL),
(250, 'bookable_subcategories_create', '2024-03-16 19:09:02', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(251, 'bookable_subcategories_access', '2024-03-16 19:09:11', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(252, 'transactions_reports_access', '2024-05-06 20:55:10', '2024-05-06 20:55:10', NULL),
(253, 'finance_access', '2024-05-06 21:13:34', '2024-05-06 21:13:34', NULL),
(254, 'bookable_fit_access', '2024-05-18 14:13:26', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(255, 'bookable_fit_edit', '2024-05-18 14:15:12', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(256, 'bookable_fit_show', '2024-05-18 14:15:39', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(257, 'bookable_fit_delete', '2024-05-18 14:16:17', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(258, 'bookable_fit_create', '2024-05-18 14:21:33', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(259, 'bookable_size_access', '2024-05-18 14:50:40', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(260, 'bookable_size_edit', '2024-05-18 14:51:01', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(261, 'bookable_size_create', '2024-05-18 14:51:21', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(262, 'bookable_size_delete', '2024-05-18 14:51:42', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(263, 'bookable_size_show', '2024-05-18 14:52:12', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(264, 'bookable_color_access', '2024-05-18 14:55:36', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(265, 'bookable_color_create', '2024-05-18 14:55:52', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(266, 'bookable_color_show', '2024-05-18 14:56:11', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(267, 'bookable_color_edit', '2024-05-18 14:56:27', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(268, 'bookable_color_delete', '2024-05-18 14:56:44', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(269, 'module_access', '2024-05-18 17:12:43', '2024-05-18 17:12:43', NULL),
(270, 'module_create', '2024-05-18 17:13:07', '2024-05-18 17:13:07', NULL),
(271, 'vehicle_odometer_access', '2024-05-18 17:35:02', '2024-05-18 17:35:02', NULL),
(272, 'vehicle_create', '2024-05-18 17:38:55', '2024-05-18 17:38:55', NULL),
(273, 'language_setting_access', '2024-05-18 17:43:58', '2024-05-18 17:43:58', NULL),
(274, 'vehicle_access', '2024-05-18 17:46:21', '2024-05-18 17:46:21', NULL),
(275, 'vehicle_setting_generalform_access', '2024-05-18 17:49:34', '2024-05-18 17:49:34', NULL),
(276, 'space_module_access', '2024-05-18 17:55:05', '2024-05-18 17:55:42', '2024-05-18 17:55:42'),
(277, 'boats_module_access', '2024-05-18 18:02:50', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(278, 'boats_features_access', '2024-05-18 18:05:40', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(279, 'boats_type_access', '2024-05-18 18:09:28', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(280, 'boats_location_access', '2024-05-18 18:10:03', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(281, 'boat_create', '2024-05-18 18:11:34', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(282, 'boat_access', '2024-05-18 18:12:48', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(283, 'boats_setting_access', '2024-05-18 18:14:06', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(284, 'parking_module_access', '2024-05-18 18:16:32', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(285, 'parking_create', '2024-05-18 18:47:48', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(286, 'parking_access', '2024-05-18 18:50:08', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(287, 'bookable_product_access', '2024-05-18 18:55:25', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(288, 'bookable_fit_access', '2024-05-18 19:00:46', '2024-05-18 19:01:39', '2024-05-18 19:01:39'),
(289, 'bookable_create', '2024-05-18 19:06:56', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(290, 'bookable_access', '2024-05-18 19:08:51', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(291, 'space_module_access', '2024-05-18 19:11:41', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(292, 'space_access', '2024-05-18 19:16:30', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(293, 'space_create', '2024-05-18 19:16:45', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(294, 'contact_access', '2024-05-18 19:32:00', '2024-07-12 08:01:28', '2024-07-12 08:01:28'),
(295, 'item_rule', '2024-05-18 19:45:06', '2024-05-18 19:45:06', NULL),
(296, 'sliders_access', '2024-05-18 19:46:53', '2024-05-18 19:46:53', NULL),
(297, 'message_access', '2024-05-18 19:49:08', '2024-05-18 19:49:08', NULL),
(298, 'reports_access', '2024-05-18 19:52:51', '2024-05-18 19:52:51', NULL),
(299, 'contact_create', '2024-05-20 12:56:04', '2024-07-12 08:01:28', '2024-07-12 08:01:28'),
(300, 'vehicle_delete', '2024-05-31 11:12:29', '2024-05-31 11:12:29', NULL),
(301, 'boat_delete', '2024-05-31 11:12:44', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(302, 'parking_delete', '2024-05-31 11:17:03', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(303, 'bookable_delete', '2024-05-31 11:17:48', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(304, 'space_delete', '2024-05-31 11:18:25', '2024-08-29 12:35:20', '2024-08-29 12:35:20'),
(305, 'booking_delete', '2024-06-01 14:35:55', '2024-06-01 14:35:55', NULL),
(306, 'app_user_delete', '2024-06-04 14:15:24', '2024-06-04 14:15:24', NULL),
(307, 'boat_edit', '2024-06-05 16:11:05', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(308, 'bookable_edit', '2024-06-05 16:12:03', '2024-09-11 14:13:50', '2024-09-11 14:13:50'),
(309, 'parking_edit', '2024-06-05 16:12:29', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(310, 'space_edit', '2024-06-05 16:13:14', '2024-08-29 12:35:09', '2024-08-29 12:35:09'),
(311, 'item_location_create', '2024-06-10 10:49:39', '2024-09-03 14:24:06', NULL),
(312, 'vehicle_location_create', '2024-06-10 16:25:11', '2024-06-10 16:25:11', NULL),
(313, 'boat_location_create', '2024-06-10 16:54:47', '2024-09-11 14:13:29', '2024-09-11 14:13:29'),
(314, 'parking_location_create', '2024-06-10 16:55:22', '2024-09-11 14:14:29', '2024-09-11 14:14:29'),
(315, 'space_location_create', '2024-06-10 16:56:18', '2024-08-29 12:31:40', '2024-08-29 12:31:40'),
(316, 'cancellation_delete', '2024-06-12 16:38:51', '2024-06-12 16:38:51', NULL),
(317, 'message_delete', '2024-06-12 16:39:36', '2024-06-12 16:39:36', NULL),
(318, 'ticket_delete', '2024-06-12 16:40:40', '2024-06-12 16:40:40', NULL),
(319, 'currency_access', '2024-07-30 07:54:33', '2025-06-05 08:50:43', '2025-06-05 08:50:43'),
(320, 'currency_delete', '2024-07-30 07:54:59', '2025-06-05 08:52:16', '2025-06-05 08:52:16'),
(321, 'currency_show', '2024-07-30 07:55:11', '2025-06-05 08:51:40', '2025-06-05 08:51:40'),
(322, 'currency_edit', '2024-07-30 07:55:22', '2025-06-05 08:52:10', '2025-06-05 08:52:10'),
(323, 'currency_create', '2024-07-30 07:55:37', '2025-06-05 08:51:56', '2025-06-05 08:51:56'),
(324, 'add_cancellation_policies', '2024-10-07 15:12:50', '2024-10-07 15:12:50', NULL),
(325, 'email_update', '2024-10-07 16:14:06', '2024-10-07 16:14:06', NULL),
(326, 'app_user_contact_access', '2024-10-10 10:19:04', '2024-10-10 10:19:04', NULL),
(327, 'vehicle_odometer_delete', '2024-10-22 12:41:39', '2024-10-22 12:41:39', NULL),
(328, 'vehicle_odometer_edit', '2024-10-22 14:30:16', '2024-10-22 14:30:16', NULL),
(329, 'item_rule_edit', '2024-10-22 16:29:13', '2024-10-22 16:29:13', NULL),
(330, 'item_rule_delete', '2024-10-22 16:39:53', '2024-10-22 16:39:53', NULL),
(331, 'item_rule_create', '2024-10-23 10:05:42', '2024-10-23 10:05:42', NULL),
(332, 'cancellation_policies_edit', '2024-10-23 12:09:47', '2024-10-23 12:09:47', NULL),
(333, 'cancellation_policies_delete', '2024-10-23 12:12:58', '2024-10-23 12:12:58', NULL),
(334, 'cancellation_create', '2024-10-23 14:18:09', '2024-10-23 14:18:09', NULL),
(335, 'cancellation_reason_delete', '2024-10-23 14:35:33', '2024-10-23 14:35:33', NULL),
(336, 'cancellation_reason_edit', '2024-10-23 15:25:26', '2024-10-23 15:25:26', NULL),
(337, 'title_delete', '2024-10-25 15:06:30', '2024-10-25 15:06:30', NULL),
(338, 'title_edit', '2024-10-25 15:38:13', '2024-10-25 15:38:13', NULL),
(339, 'booking_access', '2024-12-12 11:56:51', '2024-12-12 11:56:51', NULL),
(340, 'trash_booking_access', '2024-12-12 12:02:13', '2024-12-12 12:02:13', NULL),
(341, 'all_package_delete', '2024-12-12 12:25:00', '2024-12-12 12:25:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
  `role_id` bigint UNSIGNED NOT NULL,
  `permission_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permission_role`
--

INSERT INTO `permission_role` (`role_id`, `permission_id`) VALUES
(1, 17),
(1, 18),
(1, 19),
(1, 20),
(1, 34),
(1, 35),
(1, 36),
(1, 37),
(1, 38),
(1, 39),
(1, 40),
(1, 41),
(1, 50),
(1, 51),
(1, 52),
(1, 53),
(1, 54),
(1, 56),
(1, 57),
(1, 58),
(1, 59),
(1, 60),
(1, 61),
(1, 63),
(1, 64),
(1, 65),
(1, 66),
(1, 67),
(1, 68),
(1, 69),
(1, 70),
(1, 71),
(1, 73),
(1, 74),
(1, 75),
(1, 76),
(1, 77),
(1, 78),
(1, 80),
(1, 81),
(1, 82),
(1, 84),
(1, 86),
(1, 87),
(1, 88),
(1, 90),
(1, 91),
(1, 92),
(1, 93),
(1, 94),
(1, 95),
(1, 96),
(1, 97),
(1, 98),
(1, 99),
(1, 100),
(1, 101),
(1, 102),
(1, 103),
(1, 104),
(2, 17),
(2, 18),
(2, 19),
(2, 20),
(2, 21),
(2, 22),
(2, 23),
(2, 24),
(2, 25),
(2, 26),
(2, 27),
(2, 28),
(2, 29),
(2, 30),
(2, 31),
(2, 32),
(2, 33),
(2, 34),
(2, 35),
(2, 36),
(2, 37),
(2, 38),
(2, 39),
(2, 40),
(2, 41),
(2, 42),
(2, 43),
(2, 44),
(2, 45),
(2, 46),
(2, 47),
(2, 48),
(2, 49),
(2, 50),
(2, 51),
(2, 52),
(2, 53),
(2, 54),
(2, 55),
(2, 56),
(2, 57),
(2, 58),
(2, 59),
(2, 60),
(2, 61),
(2, 62),
(2, 63),
(2, 64),
(2, 65),
(2, 66),
(2, 67),
(2, 68),
(2, 69),
(2, 70),
(2, 71),
(2, 72),
(2, 73),
(2, 74),
(2, 75),
(2, 76),
(2, 77),
(2, 78),
(2, 79),
(2, 80),
(2, 81),
(2, 82),
(2, 83),
(2, 84),
(2, 85),
(2, 86),
(2, 87),
(2, 88),
(2, 89),
(2, 90),
(2, 91),
(2, 92),
(2, 93),
(2, 94),
(2, 95),
(2, 96),
(2, 97),
(2, 98),
(2, 99),
(2, 100),
(2, 101),
(2, 102),
(2, 103),
(2, 104),
(2, 105),
(3, 2),
(3, 3),
(3, 4),
(3, 5),
(3, 7),
(3, 8),
(3, 9),
(3, 10),
(3, 12),
(3, 13),
(3, 14),
(3, 15),
(3, 17),
(3, 18),
(3, 19),
(3, 20),
(3, 21),
(3, 34),
(3, 35),
(3, 36),
(3, 37),
(3, 38),
(3, 39),
(3, 40),
(3, 41),
(3, 50),
(3, 51),
(3, 52),
(3, 53),
(3, 54),
(3, 55),
(3, 56),
(3, 57),
(3, 58),
(3, 59),
(3, 60),
(3, 61),
(3, 62),
(3, 63),
(3, 64),
(3, 65),
(3, 66),
(3, 67),
(3, 68),
(3, 69),
(3, 70),
(3, 71),
(3, 72),
(3, 73),
(3, 74),
(3, 75),
(3, 76),
(3, 77),
(3, 78),
(3, 79),
(3, 80),
(3, 81),
(3, 82),
(3, 83),
(3, 84),
(3, 85),
(3, 86),
(3, 87),
(3, 88),
(3, 89),
(3, 90),
(3, 91),
(3, 92),
(3, 93),
(3, 94),
(3, 95),
(3, 96),
(3, 97),
(3, 98),
(3, 99),
(3, 100),
(3, 101),
(3, 102),
(3, 103),
(3, 104),
(3, 105),
(2, 106),
(2, 107),
(2, 108),
(2, 109),
(3, 110),
(2, 110),
(1, 110),
(3, 111),
(2, 111),
(1, 111),
(3, 112),
(2, 112),
(1, 112),
(3, 113),
(2, 113),
(1, 113),
(3, 114),
(2, 114),
(3, 115),
(2, 115),
(1, 115),
(1, 116),
(1, 117),
(1, 119),
(1, 121),
(1, 137),
(1, 140),
(1, 145),
(1, 146),
(1, 149),
(1, 163),
(1, 164),
(1, 165),
(1, 172),
(1, 173),
(1, 174),
(1, 175),
(1, 176),
(1, 177),
(1, 194),
(1, 195),
(1, 198),
(1, 199),
(1, 201),
(1, 202),
(1, 210),
(1, 211),
(1, 219),
(1, 220),
(1, 229),
(1, 230),
(1, 231),
(1, 232),
(1, 244),
(1, 245),
(1, 248),
(1, 249),
(1, 252),
(1, 253),
(1, 270),
(1, 271),
(1, 272),
(1, 274),
(1, 275),
(1, 295),
(1, 297),
(1, 298),
(1, 311),
(1, 312),
(5, 1),
(5, 2),
(5, 3),
(5, 4),
(5, 5),
(5, 6),
(5, 7),
(5, 8),
(5, 9),
(5, 10),
(5, 11),
(5, 12),
(5, 13),
(5, 14),
(5, 15),
(5, 16),
(5, 17),
(5, 18),
(5, 19),
(5, 20),
(5, 21),
(5, 34),
(5, 35),
(5, 36),
(5, 37),
(5, 38),
(5, 39),
(5, 40),
(5, 41),
(5, 50),
(5, 51),
(5, 52),
(5, 53),
(5, 54),
(5, 55),
(5, 56),
(5, 57),
(5, 58),
(5, 59),
(5, 60),
(5, 61),
(5, 62),
(5, 63),
(5, 64),
(5, 65),
(5, 66),
(5, 67),
(5, 68),
(5, 69),
(5, 70),
(5, 71),
(5, 72),
(5, 73),
(5, 74),
(5, 75),
(5, 76),
(5, 77),
(5, 78),
(5, 79),
(5, 80),
(5, 81),
(5, 82),
(5, 83),
(5, 84),
(5, 85),
(5, 86),
(5, 87),
(5, 88),
(5, 89),
(5, 90),
(5, 91),
(5, 92),
(5, 93),
(5, 94),
(5, 95),
(5, 96),
(5, 97),
(5, 98),
(5, 99),
(5, 100),
(5, 101),
(5, 102),
(5, 103),
(5, 104),
(5, 105),
(5, 110),
(5, 111),
(5, 112),
(5, 113),
(5, 114),
(5, 115),
(5, 116),
(5, 117),
(5, 119),
(5, 120),
(5, 121),
(5, 137),
(5, 138),
(5, 139),
(5, 140),
(5, 141),
(5, 142),
(5, 143),
(5, 144),
(5, 145),
(5, 146),
(5, 147),
(5, 148),
(5, 149),
(5, 150),
(5, 151),
(5, 161),
(5, 162),
(5, 163),
(5, 164),
(5, 165),
(5, 172),
(5, 173),
(5, 174),
(5, 175),
(5, 176),
(5, 177),
(5, 194),
(5, 195),
(5, 196),
(5, 198),
(5, 199),
(5, 200),
(5, 201),
(5, 202),
(5, 210),
(5, 211),
(5, 219),
(5, 220),
(5, 229),
(5, 230),
(5, 231),
(5, 232),
(5, 244),
(5, 245),
(5, 248),
(5, 249),
(5, 252),
(5, 253),
(5, 269),
(5, 270),
(5, 271),
(5, 273),
(5, 274),
(5, 275),
(5, 295),
(5, 296),
(5, 297),
(5, 298),
(5, 300),
(5, 305),
(5, 306),
(5, 311),
(5, 312),
(5, 316),
(5, 317),
(5, 318),
(5, 319),
(5, 320),
(5, 321),
(5, 322),
(5, 323),
(5, 272),
(1, 114),
(5, 325),
(5, 326),
(5, 327),
(5, 328),
(5, 329),
(5, 330),
(5, 331),
(1, 331),
(5, 332),
(5, 333),
(5, 334),
(1, 334),
(5, 335),
(5, 336),
(6, 2),
(6, 3),
(6, 4),
(6, 7),
(6, 8),
(6, 9),
(6, 11),
(6, 17),
(6, 18),
(6, 19),
(6, 20),
(6, 34),
(6, 35),
(6, 36),
(6, 37),
(6, 38),
(6, 39),
(6, 40),
(6, 41),
(6, 50),
(6, 51),
(6, 52),
(6, 53),
(6, 54),
(6, 56),
(6, 57),
(6, 58),
(6, 59),
(6, 60),
(6, 61),
(6, 63),
(6, 64),
(6, 65),
(6, 66),
(6, 67),
(6, 68),
(6, 69),
(6, 70),
(6, 71),
(6, 73),
(6, 74),
(6, 75),
(6, 76),
(6, 78),
(6, 79),
(6, 80),
(6, 81),
(6, 82),
(6, 84),
(6, 86),
(6, 87),
(6, 88),
(6, 90),
(6, 91),
(6, 93),
(6, 94),
(6, 95),
(6, 96),
(6, 98),
(6, 100),
(6, 101),
(6, 102),
(6, 103),
(6, 104),
(6, 112),
(6, 113),
(6, 114),
(6, 115),
(6, 116),
(6, 117),
(6, 137),
(6, 140),
(6, 145),
(6, 146),
(6, 149),
(6, 161),
(6, 164),
(6, 165),
(6, 173),
(6, 174),
(6, 176),
(6, 177),
(6, 194),
(6, 195),
(6, 198),
(6, 199),
(6, 201),
(6, 202),
(6, 210),
(6, 211),
(6, 219),
(6, 220),
(6, 229),
(6, 230),
(6, 231),
(6, 232),
(6, 244),
(6, 245),
(6, 248),
(6, 249),
(6, 252),
(6, 253),
(6, 269),
(6, 270),
(6, 271),
(6, 272),
(6, 273),
(6, 274),
(6, 275),
(6, 295),
(6, 297),
(6, 298),
(6, 311),
(6, 312),
(6, 319),
(6, 321),
(6, 323),
(6, 324),
(6, 331),
(5, 337),
(5, 338),
(6, 162),
(6, 77),
(5, 340);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `called_ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `called_ip`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(49, 'App\\Models\\AppUser', 603, 'api-access', '94e0e00ba92ebf30f9d7e7532f77a8b620422dded861c7c3c8bbaa689ebbfa24', '[\"*\"]', '172.68.234.141', '2025-08-26 05:50:21', '2025-09-02 05:34:59', '2025-08-26 05:34:59', '2025-08-26 05:50:21'),
(59, 'App\\Models\\AppUser', 605, 'api-access', 'aec8343666aba171c780ae379cd325efcc634a1db425d7c120b5525f4be3afdf', '[\"*\"]', '172.70.108.192', '2025-08-27 06:45:58', '2025-09-02 08:22:53', '2025-08-26 08:22:53', '2025-08-27 06:45:58'),
(99, 'App\\Models\\AppUser', 602, 'api-access', '64c0dc86a4e18708bc241c1f7ac1a40dcbb506a7189ce5c324b9981dc4d309fa', '[\"*\"]', '104.23.216.9', '2025-09-03 02:00:19', '2025-09-04 19:07:02', '2025-08-28 19:07:02', '2025-09-03 02:00:19'),
(114, 'App\\Models\\AppUser', 607, 'api-access', '2dcb06507b784c39b4d6834ec1fbd29a836c7aebaa5ab2fbd2945fe63a72b0e6', '[\"*\"]', '162.158.23.134', '2025-08-30 09:05:11', '2025-09-06 09:05:10', '2025-08-30 09:05:10', '2025-08-30 09:05:11'),
(120, 'App\\Models\\AppUser', 609, 'api-access', '1af3da64bd3a17656491786f93f10c38f2cbf57f7f35ace722cfc29410bfa23a', '[\"*\"]', '162.158.22.229', '2025-08-30 13:54:46', '2025-09-06 13:54:29', '2025-08-30 13:54:29', '2025-08-30 13:54:46'),
(124, 'App\\Models\\AppUser', 564, 'api-access', '1372f6c3075e7e6714b1fa722ec02d044866dbe34d37d92e5d9bc63c82c98352', '[\"*\"]', '104.23.195.16', '2025-09-01 05:21:36', '2025-09-01 05:51:34', '2025-09-01 05:21:34', '2025-09-01 05:21:36'),
(126, 'App\\Models\\AppUser', 564, 'api-access', 'a67b98b028ea7e32d9a2791f16c85d41f969c4b34f5e2e267dbd1c18ab718539', '[\"*\"]', '162.158.23.125', '2025-09-01 06:21:51', '2025-09-01 06:39:44', '2025-09-01 06:09:44', '2025-09-01 06:21:51'),
(127, 'App\\Models\\AppUser', 564, 'api-access', '3c65b11af5e5ee4875fa3fd1aad3deb766d7a54bc5825149449551220dc2189d', '[\"*\"]', '104.23.239.35', '2025-09-01 07:37:16', '2025-09-01 08:05:55', '2025-09-01 07:35:55', '2025-09-01 07:37:16'),
(129, 'App\\Models\\AppUser', 564, 'api-access', '55f72b702fd005fe41f9c4d76cc496bcf34503832e31a20943e31b0ddd52e207', '[\"*\"]', '172.68.234.72', '2025-09-01 09:19:27', '2025-09-01 09:49:17', '2025-09-01 09:19:17', '2025-09-01 09:19:27'),
(131, 'App\\Models\\AppUser', 564, 'api-access', '881e2128339123c5b7bbfb559f342c0ea0ac93689a03e140c5ca63dad68744d5', '[\"*\"]', '172.70.108.38', '2025-09-01 09:51:31', '2025-09-01 10:21:03', '2025-09-01 09:51:03', '2025-09-01 09:51:31'),
(133, 'App\\Models\\AppUser', 564, 'api-access', '9f58a5619249c62cb30a83dce9718b359ed2fc689b5e6f3a33e8db0dc7dddf63', '[\"*\"]', '172.69.138.236', '2025-09-01 09:57:23', '2025-09-01 10:26:05', '2025-09-01 09:56:05', '2025-09-01 09:57:23'),
(134, 'App\\Models\\AppUser', 564, 'api-access', 'c8690eff70092e309dbff3131e0d46e663637813fa785178ad8835ae0eeb9c91', '[\"*\"]', '162.158.108.14', '2025-09-01 10:01:28', '2025-09-01 10:29:27', '2025-09-01 09:59:27', '2025-09-01 10:01:28'),
(136, 'App\\Models\\AppUser', 613, 'api-access', '8ff0dfec75dcb520daa76c3611402c6109168857512050bbae52dee05c065b78', '[\"*\"]', '172.68.234.132', '2025-09-01 10:39:12', '2025-09-08 10:09:43', '2025-09-01 10:09:43', '2025-09-01 10:39:12'),
(138, 'App\\Models\\AppUser', 564, 'api-access', '42e35f3fb9c1af8e0bd0bba314d5431b7e71605c057bce4e57e2dc989730989e', '[\"*\"]', '172.71.238.222', '2025-09-01 11:00:41', '2025-09-01 11:07:50', '2025-09-01 10:37:50', '2025-09-01 11:00:41'),
(139, 'App\\Models\\AppUser', 564, 'api-access', 'bcc4c8e2d69a67926cfdf8f9d5a453b4263568b3f82b2def78c36738214dc77a', '[\"*\"]', '172.68.147.207', '2025-09-01 10:42:23', '2025-09-01 11:11:56', '2025-09-01 10:41:56', '2025-09-01 10:42:23'),
(141, 'App\\Models\\AppUser', 564, 'api-access', 'cb462806081db1d708cf4fa8d402b6db79cc0d5e94dc6c7fb4f88fc5cdc037ba', '[\"*\"]', '162.158.23.22', '2025-09-01 11:37:14', '2025-09-01 11:50:37', '2025-09-01 11:20:37', '2025-09-01 11:37:14'),
(142, 'App\\Models\\AppUser', 564, 'api-access', '6c184f43646bde85fbb69c278392da9023b09891be47119a85619420a6175b18', '[\"*\"]', '172.69.11.216', '2025-09-01 11:43:51', '2025-09-01 12:11:48', '2025-09-01 11:41:48', '2025-09-01 11:43:51'),
(143, 'App\\Models\\AppUser', 564, 'api-access', '558c20cfacada9fe49654e4427d5eade31e4d518207a772c3ce73dc8b1d7a355', '[\"*\"]', '172.70.108.192', '2025-09-01 12:26:58', '2025-09-01 12:56:04', '2025-09-01 12:26:04', '2025-09-01 12:26:58'),
(144, 'App\\Models\\AppUser', 618, 'api-access', 'a4a8fc5dfa6b68cf9484d56a857a36836733031e6cf726d8aeb05537467c8e98', '[\"*\"]', '172.71.238.52', '2025-09-01 14:46:43', '2025-09-08 12:31:25', '2025-09-01 12:31:25', '2025-09-01 14:46:43'),
(145, 'App\\Models\\AppUser', 564, 'api-access', 'af526213916a322c76865f11409b84dd7df4701e8b0c447979130738564bc913', '[\"*\"]', '172.68.234.22', '2025-09-01 12:50:24', '2025-09-01 13:07:55', '2025-09-01 12:37:55', '2025-09-01 12:50:24'),
(146, 'App\\Models\\AppUser', 564, 'api-access', 'edf896b236ec915b358b2023675519e77045cd0f98b9ebb212b3b4b6b112da34', '[\"*\"]', '172.68.234.206', '2025-09-01 13:00:35', '2025-09-01 13:13:50', '2025-09-01 12:43:50', '2025-09-01 13:00:35'),
(147, 'App\\Models\\AppUser', 564, 'api-access', '0e1afe69ca9a3f342e3fde2c33670cde96ee8fb733b9864e9ebd294ac45e7038', '[\"*\"]', '162.158.22.53', '2025-09-01 13:02:58', '2025-09-01 13:27:34', '2025-09-01 12:57:34', '2025-09-01 13:02:58'),
(149, 'App\\Models\\AppUser', 564, 'api-access', 'aae02c7d41df8b4c4fc0942c117c7b511da8010e7b094373120805cf2fa223a0', '[\"*\"]', '172.70.108.226', '2025-09-01 13:23:39', '2025-09-01 13:52:48', '2025-09-01 13:22:48', '2025-09-01 13:23:39'),
(151, 'App\\Models\\AppUser', 564, 'api-access', '95562f4d1851b1eb8f5b797e0e787621c932921234b39fd10f6d17391068ed39', '[\"*\"]', '162.158.23.22', '2025-09-01 13:28:36', '2025-09-01 13:56:13', '2025-09-01 13:26:13', '2025-09-01 13:28:36'),
(152, 'App\\Models\\AppUser', 564, 'api-access', 'dcfb38d1d46079e1a3f27cc8198eee668456319b191ccea246b3f78e6196c1f1', '[\"*\"]', '172.68.234.23', '2025-09-01 13:47:52', '2025-09-01 14:00:43', '2025-09-01 13:30:43', '2025-09-01 13:47:52'),
(153, 'App\\Models\\AppUser', 564, 'api-access', '0f5f7a1bc6dd4b2c27323b6456c8d2cbec4de871cd1d1fe2162e06e11df27b9b', '[\"*\"]', '172.68.234.132', '2025-09-01 13:47:41', '2025-09-01 14:01:14', '2025-09-01 13:31:14', '2025-09-01 13:47:41'),
(154, 'App\\Models\\AppUser', 564, 'api-access', '4429ae1ef9948d2a727a5461c78893f47fa817791d7d4747834cf4da30349562', '[\"*\"]', '172.71.146.49', '2025-09-01 14:13:37', '2025-09-01 14:37:23', '2025-09-01 14:07:23', '2025-09-01 14:13:37'),
(155, 'App\\Models\\AppUser', 564, 'api-access', 'dc114102854d86013fd872a0660d638f5574ece808c1e1cad2753340b97480d7', '[\"*\"]', '172.71.30.131', '2025-09-01 14:14:27', '2025-09-01 14:44:25', '2025-09-01 14:14:25', '2025-09-01 14:14:27'),
(156, 'App\\Models\\AppUser', 564, 'api-access', '478659a7dd986525b835f4fe6220a21a6edc4bb688b3d8580be844253a346d29', '[\"*\"]', '172.68.22.163', '2025-09-01 14:18:26', '2025-09-01 14:45:06', '2025-09-01 14:15:06', '2025-09-01 14:18:26'),
(157, 'App\\Models\\AppUser', 564, 'api-access', '4433714f64f6ee16378d6be81b8ee69f7eeb5cdb8879a994bc74540353140288', '[\"*\"]', '172.71.146.73', '2025-09-01 14:15:52', '2025-09-01 14:45:42', '2025-09-01 14:15:42', '2025-09-01 14:15:52'),
(159, 'App\\Models\\AppUser', 564, 'api-access', '39ba6371109cd914ed1eeac2658d59191ff4c30fceaf69fb49d4d5296dd9e1ad', '[\"*\"]', '172.70.134.78', '2025-09-01 15:00:37', '2025-09-01 15:30:34', '2025-09-01 15:00:34', '2025-09-01 15:00:37'),
(160, 'App\\Models\\AppUser', 564, 'api-access', '46e1a1a2232c5256b59b0ad8b1125ab21568e3f92d1ccb41bf11f1cf96af5ad7', '[\"*\"]', '104.23.213.139', '2025-09-01 15:13:04', '2025-09-01 15:40:05', '2025-09-01 15:10:05', '2025-09-01 15:13:04'),
(161, 'App\\Models\\AppUser', 564, 'api-access', 'f81a808fb9ac13b5f0524d676b5a4aa4fd2a17a65df40603f29066f53685dd6a', '[\"*\"]', '172.70.134.209', '2025-09-01 15:17:12', '2025-09-01 15:47:09', '2025-09-01 15:17:09', '2025-09-01 15:17:12'),
(162, 'App\\Models\\AppUser', 564, 'api-access', '839c00f40794affc0b1b6f5292874fbdfef3090958e8617b9da1548b0f78ccd1', '[\"*\"]', '172.71.172.96', NULL, '2025-09-01 17:31:22', '2025-09-01 17:01:22', '2025-09-01 17:01:22'),
(163, 'App\\Models\\AppUser', 564, 'api-access', '46cb64e937d2710e4bc746ce13d9dff10025aebc651d14b78fdcc29157faee45', '[\"*\"]', '172.71.250.77', '2025-09-01 17:01:26', '2025-09-01 17:31:25', '2025-09-01 17:01:25', '2025-09-01 17:01:26'),
(164, 'App\\Models\\AppUser', 564, 'api-access', 'a43133037291633b918d1139ab860324b399c9b7072097a006137dc154274d9c', '[\"*\"]', '172.70.34.34', '2025-09-01 19:51:37', '2025-09-01 20:18:55', '2025-09-01 19:48:55', '2025-09-01 19:51:37'),
(165, 'App\\Models\\AppUser', 564, 'api-access', '035e194021cfcdc5137e984b2416e4c7b8a3f476cb8e5b60cdae8b136a882648', '[\"*\"]', '172.71.23.140', '2025-09-02 03:06:37', '2025-09-02 03:34:29', '2025-09-02 03:04:29', '2025-09-02 03:06:37'),
(166, 'App\\Models\\AppUser', 564, 'api-access', 'be67776b197124255560c2f84bf463f93e32156f8fbcea4b12f673913d855bde', '[\"*\"]', '172.70.108.219', '2025-09-02 06:59:44', '2025-09-02 06:59:47', '2025-09-02 06:29:47', '2025-09-02 06:59:44'),
(167, 'App\\Models\\AppUser', 564, 'api-access', '1580d02bb65154ddde9b20fb67072c0448e1131043834d38eaae1d6532194d21', '[\"*\"]', '172.68.234.18', '2025-09-02 06:39:20', '2025-09-02 07:01:39', '2025-09-02 06:31:39', '2025-09-02 06:39:20'),
(168, 'App\\Models\\AppUser', 620, 'api-access', 'fb295d0d780af64e254f7ce263776092759fbcb3a2b70a60319d3beaca3c5698', '[\"*\"]', '172.68.234.121', '2025-09-02 07:30:16', '2025-09-09 06:39:24', '2025-09-02 06:39:24', '2025-09-02 07:30:16'),
(169, 'App\\Models\\AppUser', 525, 'api-access', 'a4db07f4fa4de94bc18cd1a400a79d59b2c903537c27ad67b9275547735bd58f', '[\"*\"]', '162.158.22.14', '2025-09-03 06:11:32', '2025-09-09 06:59:49', '2025-09-02 06:59:49', '2025-09-03 06:11:32'),
(170, 'App\\Models\\AppUser', 564, 'api-access', 'bd92053cee4fe4d290c5ccf1d5649dd2a393b2522125ab468084d1ca8a844085', '[\"*\"]', '104.23.195.39', '2025-09-02 07:20:57', '2025-09-02 07:50:16', '2025-09-02 07:20:16', '2025-09-02 07:20:57'),
(171, 'App\\Models\\AppUser', 564, 'api-access', 'f3f44e634484d9d9ca54b9a84f95854d5bd71b38a6deffd01d318ab520defb94', '[\"*\"]', '104.23.195.73', '2025-09-02 07:24:50', '2025-09-02 07:53:16', '2025-09-02 07:23:16', '2025-09-02 07:24:50'),
(172, 'App\\Models\\AppUser', 564, 'api-access', '7b7b380103dabb564cc6e94d4bd422457155075e5b86c802ac0c2d17fda2e1ac', '[\"*\"]', '172.71.23.132', '2025-09-02 08:54:40', '2025-09-02 09:21:49', '2025-09-02 08:51:49', '2025-09-02 08:54:40'),
(173, 'App\\Models\\AppUser', 564, 'api-access', '603129010c81104fd9503eac3e8637ee6002b9486d78bfecabbd9353b9bbccc0', '[\"*\"]', '172.71.31.110', '2025-09-02 11:00:52', '2025-09-02 11:24:08', '2025-09-02 10:54:08', '2025-09-02 11:00:52'),
(174, 'App\\Models\\AppUser', 564, 'api-access', 'a96c09ba7f359bf3c6e4649d0c72d15c65ef52bc7ec26b65aa970894057b578c', '[\"*\"]', '108.162.237.208', '2025-09-02 11:02:28', '2025-09-02 11:32:25', '2025-09-02 11:02:25', '2025-09-02 11:02:28'),
(175, 'App\\Models\\AppUser', 564, 'api-access', '5a78f1024e130a4bf1b26f06df01e81dc2d221b6983ee5eefd9d589b3518af0d', '[\"*\"]', '172.68.23.124', '2025-09-02 11:14:24', '2025-09-02 11:43:39', '2025-09-02 11:13:39', '2025-09-02 11:14:24'),
(177, 'App\\Models\\AppUser', 564, 'api-access', '126ae398c626e8e50eeb544d6a052017afe8198c20584bbac27a85caf206bff8', '[\"*\"]', '104.23.160.132', '2025-09-02 12:40:26', '2025-09-02 13:05:52', '2025-09-02 12:35:52', '2025-09-02 12:40:26'),
(178, 'App\\Models\\AppUser', 564, 'api-access', '185b8ff6c6c57d91e8ab4a76373d65132580fb20120abf3c1c19d6d691679f88', '[\"*\"]', '172.70.83.109', '2025-09-02 18:51:21', '2025-09-02 19:20:25', '2025-09-02 18:50:25', '2025-09-02 18:51:21'),
(179, 'App\\Models\\AppUser', 564, 'api-access', '61973ae94d22ba6e700329290be1bee44be2f9a53a83a73a969c3916ac363704', '[\"*\"]', '172.70.108.84', '2025-09-03 06:12:22', '2025-09-03 06:41:50', '2025-09-03 06:11:50', '2025-09-03 06:12:22'),
(180, 'App\\Models\\AppUser', 564, 'api-access', 'af659ae8a4d6a98f7e635e4ca77d1add9b35b0af7f23264ffd6f38b19d342c81', '[\"*\"]', '162.158.22.150', '2025-09-03 06:13:01', '2025-09-03 06:42:46', '2025-09-03 06:12:46', '2025-09-03 06:13:01'),
(181, 'App\\Models\\AppUser', 564, 'api-access', '98450bf2ebf3adcc4509c5b8bfca513d2260662e832b0f1e5805de7c48a104f8', '[\"*\"]', '104.23.195.17', '2025-09-03 07:09:12', '2025-09-03 07:39:11', '2025-09-03 07:09:11', '2025-09-03 07:09:12'),
(182, 'App\\Models\\AppUser', 564, 'api-access', 'a9d32fa88d9a5212811d3583279c21c701a5be6d42c3e9ceef1a7c39693bed2f', '[\"*\"]', '104.23.195.72', '2025-09-03 07:14:12', '2025-09-03 07:44:10', '2025-09-03 07:14:10', '2025-09-03 07:14:12'),
(183, 'App\\Models\\AppUser', 564, 'api-access', 'b3be353c86510c12cd80494f8e2185bf26210525d31ac6b7bd2192efa9f5f18f', '[\"*\"]', '162.158.216.9', '2025-09-03 07:17:03', '2025-09-03 07:47:00', '2025-09-03 07:17:00', '2025-09-03 07:17:03'),
(184, 'App\\Models\\AppUser', 564, 'api-access', '7ec15bcf474c97b0430acc2ade10a555398f47309d6361f10b012187f67e8a8e', '[\"*\"]', '172.68.229.97', '2025-09-03 07:21:19', '2025-09-03 07:51:08', '2025-09-03 07:21:08', '2025-09-03 07:21:19'),
(185, 'App\\Models\\AppUser', 564, 'api-access', 'c54e721a6b2ad1e80e64db1fc2c1d3f1c9ff39c2a961d3b492cc2a23d66b737e', '[\"*\"]', '172.69.5.137', '2025-09-03 11:11:11', '2025-09-03 11:38:46', '2025-09-03 11:08:46', '2025-09-03 11:11:11'),
(186, 'App\\Models\\AppUser', 564, 'api-access', 'ab59d818a029d4273177ab8f162818e8f52cb2a5e225a0324962b3799564f27f', '[\"*\"]', '172.68.12.134', '2025-09-03 12:41:39', '2025-09-03 12:47:46', '2025-09-03 12:17:46', '2025-09-03 12:41:39'),
(187, 'App\\Models\\AppUser', 564, 'api-access', '1307110844136ad2cf55194a7b2901d01ffabadb1f1a7f7b6b1e210f40e78edb', '[\"*\"]', '108.162.210.235', '2025-09-03 12:50:08', '2025-09-03 12:51:02', '2025-09-03 12:21:02', '2025-09-03 12:50:08'),
(188, 'App\\Models\\AppUser', 564, 'api-access', '8527caae0a8c58965aebc679d03cedf1687f15e814658d8cf03e507d7494f620', '[\"*\"]', '172.68.164.61', '2025-09-03 12:40:50', '2025-09-03 12:52:31', '2025-09-03 12:22:31', '2025-09-03 12:40:50'),
(189, 'App\\Models\\AppUser', 564, 'api-access', 'ef98de7df4a966218a087632740760d64e1a91eb1ce11745dae638cace733256', '[\"*\"]', '104.23.221.152', '2025-09-03 12:54:08', '2025-09-03 13:22:14', '2025-09-03 12:52:14', '2025-09-03 12:54:08'),
(190, 'App\\Models\\AppUser', 564, 'api-access', '73e291b3a5a2695763744a144a6f556ee766d3338f98f084ea67430db5b7b2e2', '[\"*\"]', '172.71.15.156', '2025-09-03 13:37:14', '2025-09-03 14:06:29', '2025-09-03 13:36:29', '2025-09-03 13:37:14'),
(191, 'App\\Models\\AppUser', 564, 'api-access', 'bf0eb7aaf87efa2084f6447cede2fc94e880f63f5b2db8f7627643731d3ddfaf', '[\"*\"]', '172.68.213.63', '2025-09-03 13:53:49', '2025-09-03 14:08:25', '2025-09-03 13:38:25', '2025-09-03 13:53:49'),
(193, 'App\\Models\\AppUser', 564, 'api-access', 'b1ccfb784d3649b5999a6942dd4e10a0bc559bae9f6d9d351b9ec9117ebe3bc7', '[\"*\"]', '172.71.195.104', '2025-09-04 02:34:30', '2025-09-04 03:04:23', '2025-09-04 02:34:23', '2025-09-04 02:34:30'),
(194, 'App\\Models\\AppUser', 564, 'api-access', '10d46d15b66da8086e9f6786a43176e36b80f8cceeee4b421b4e0448d80d47fe', '[\"*\"]', '172.70.108.212', '2025-09-04 04:59:38', '2025-09-04 05:28:39', '2025-09-04 04:58:39', '2025-09-04 04:59:38'),
(195, 'App\\Models\\AppUser', 564, 'api-access', '489d825dcef299b475b9235de17359dbf7f7017fca0c116e21a9f8e4841cbd5d', '[\"*\"]', '172.70.108.195', '2025-09-04 05:05:02', '2025-09-04 05:31:27', '2025-09-04 05:01:27', '2025-09-04 05:05:02'),
(196, 'App\\Models\\AppUser', 564, 'api-access', '4f64aee34b75004807fd36901e7c733031b243af8ad0e0ab5b1a11de7d8cdd2c', '[\"*\"]', '172.69.5.131', '2025-09-04 05:30:33', '2025-09-04 06:00:31', '2025-09-04 05:30:31', '2025-09-04 05:30:33'),
(197, 'App\\Models\\AppUser', 629, 'api-access', '7300178a63c1ec74d28828540d00956d4759ee058596b65081dfaee1a9b6dc1a', '[\"*\"]', '172.68.234.182', '2025-09-04 06:09:06', '2025-09-11 06:09:03', '2025-09-04 06:09:03', '2025-09-04 06:09:06'),
(198, 'App\\Models\\AppUser', 564, 'api-access', '06de16287d975fe5ffb8483ac47f3457c2666adb190229a626f80a478630cae0', '[\"*\"]', '172.70.108.240', '2025-09-04 08:12:06', '2025-09-04 08:40:59', '2025-09-04 08:10:59', '2025-09-04 08:12:06'),
(200, 'App\\Models\\AppUser', 564, 'api-access', 'b5231fdadb8a9430ce6e08fc5f125bd1972162eff054f8b72d99c6b5011abf81', '[\"*\"]', '172.68.234.241', '2025-09-04 08:26:04', '2025-09-04 08:49:07', '2025-09-04 08:19:07', '2025-09-04 08:26:04'),
(201, 'App\\Models\\AppUser', 564, 'api-access', '542448ac89e824905d2731d58d9759842d9f9b3051dc3444b22f3e3dd15e5a3c', '[\"*\"]', '104.23.162.132', '2025-09-04 08:26:54', '2025-09-04 08:49:39', '2025-09-04 08:19:39', '2025-09-04 08:26:54'),
(202, 'App\\Models\\AppUser', 564, 'api-access', 'aea65adf7c07f2de7c4389362c4614e2006cf9c96b1b02f7042c4debaf718800', '[\"*\"]', '172.69.134.209', '2025-09-04 08:24:29', '2025-09-04 08:53:31', '2025-09-04 08:23:31', '2025-09-04 08:24:29'),
(204, 'App\\Models\\AppUser', 564, 'api-access', '3099984e084ce8386f69e5c1dfbb3302bda18deb8a910dea6e2bf01180554ab7', '[\"*\"]', '172.68.234.80', '2025-09-04 08:29:13', '2025-09-04 08:57:08', '2025-09-04 08:27:08', '2025-09-04 08:29:13'),
(206, 'App\\Models\\AppUser', 564, 'api-access', '389d72af57b5b203f0eae00da0fc619e511199c801b8b4a874b846cf225e1c64', '[\"*\"]', '162.158.22.184', '2025-09-04 08:33:09', '2025-09-04 09:01:13', '2025-09-04 08:31:13', '2025-09-04 08:33:09'),
(207, 'App\\Models\\AppUser', 628, 'api-access', '95f75eb82de82fc33bb9869dd84234598cac6eea0c2ffda16c2fb4f2bc3e20f7', '[\"*\"]', '172.68.234.240', '2025-09-04 09:30:22', '2025-09-11 08:34:56', '2025-09-04 08:34:56', '2025-09-04 09:30:22'),
(208, 'App\\Models\\AppUser', 631, 'api-access', '3dcefc270b1323e4b1ec67ac1ae80b72b1c767addb0ff7e665c1ecfab4a10400', '[\"*\"]', '172.68.234.133', '2025-09-04 13:55:01', '2025-09-11 09:30:53', '2025-09-04 09:30:53', '2025-09-04 13:55:01'),
(209, 'App\\Models\\AppUser', 564, 'api-access', '1655a782e5582a68c64bd65e5b9291a3cfd627c784031e033052ab0a0d6b07ad', '[\"*\"]', '172.71.164.56', '2025-09-04 11:46:20', '2025-09-04 12:07:21', '2025-09-04 11:37:21', '2025-09-04 11:46:20'),
(210, 'App\\Models\\AppUser', 564, 'api-access', '14cab62f0b064f6fc7ba31b16a33e0385f96fb17141539037c3780078e18c837', '[\"*\"]', '172.71.164.106', '2025-09-04 11:41:13', '2025-09-04 12:08:34', '2025-09-04 11:38:34', '2025-09-04 11:41:13'),
(211, 'App\\Models\\AppUser', 632, 'api-access', 'b6f2b53621d0e80335ba87edd93b6cf1a45fb38373185b7f0ef614d60203c9ff', '[\"*\"]', '172.71.164.52', '2025-09-04 11:45:31', '2025-09-11 11:43:01', '2025-09-04 11:43:01', '2025-09-04 11:45:31'),
(212, 'App\\Models\\AppUser', 564, 'api-access', 'bbba4ba86706a1ea85c32f73ac1dd7e221c895506d4b83b161d79353ec490fdd', '[\"*\"]', '172.68.234.81', '2025-09-04 12:44:00', '2025-09-04 12:44:23', '2025-09-04 12:14:23', '2025-09-04 12:44:00'),
(213, 'App\\Models\\AppUser', 564, 'api-access', 'f99f3cd7a70be8647faa7cccecd201d1bfdc0829b57e30cae8046e4ff05ddb57', '[\"*\"]', '172.68.234.72', '2025-09-04 12:25:48', '2025-09-04 12:45:38', '2025-09-04 12:15:38', '2025-09-04 12:25:48'),
(214, 'App\\Models\\AppUser', 564, 'api-access', 'cb6888e2d8904aee1233967e5958cf9f8f61b84a644ab941a7aa6e482775752e', '[\"*\"]', '172.68.234.22', NULL, '2025-09-04 12:57:43', '2025-09-04 12:27:43', '2025-09-04 12:27:43'),
(215, 'App\\Models\\AppUser', 564, 'api-access', '55b7a9b425904edec63ceafc68dab8408317ba1135c5c8a5c28371ad9034ea1e', '[\"*\"]', '162.158.23.73', '2025-09-04 12:43:58', '2025-09-04 12:58:59', '2025-09-04 12:28:59', '2025-09-04 12:43:58'),
(218, 'App\\Models\\AppUser', 564, 'api-access', 'd6cb3ec9763e00698ae9bc7bd4743aa95ab7a2da465efcc407225fb55df5c54d', '[\"*\"]', '162.158.23.125', '2025-09-04 13:18:08', '2025-09-04 13:45:04', '2025-09-04 13:15:04', '2025-09-04 13:18:08'),
(219, 'App\\Models\\AppUser', 564, 'api-access', '6ea263343e73ad562b09ed7872e18100ba64a90da75a4717717c276a83376039', '[\"*\"]', '162.158.22.52', '2025-09-04 13:55:34', '2025-09-04 14:25:24', '2025-09-04 13:55:24', '2025-09-04 13:55:34'),
(220, 'App\\Models\\AppUser', 564, 'api-access', '189e74614c029e86356fc9ca164f222b012b41a9f597c49777d53285640978fc', '[\"*\"]', '172.69.138.88', '2025-09-04 14:25:49', '2025-09-04 14:51:13', '2025-09-04 14:21:13', '2025-09-04 14:25:49'),
(221, 'App\\Models\\AppUser', 564, 'api-access', 'ec8b5932011525ed4325e13324b8709ad052c3769ce709b562434d473d785bdf', '[\"*\"]', '172.70.83.62', '2025-09-04 14:31:59', '2025-09-04 14:58:24', '2025-09-04 14:28:24', '2025-09-04 14:31:59'),
(222, 'App\\Models\\AppUser', 564, 'api-access', 'a827741a5ac6e4a52d702c82d65ab96a2ae524be13dffe53d23fb51d220bb130', '[\"*\"]', '172.71.11.116', '2025-09-04 14:29:47', '2025-09-04 14:59:09', '2025-09-04 14:29:09', '2025-09-04 14:29:47'),
(223, 'App\\Models\\AppUser', 564, 'api-access', 'a12b34878a6556c217c5346eff78eac8a4c1315bbba87aba1a11f66d9d667aa2', '[\"*\"]', '172.68.18.109', '2025-09-04 14:32:40', '2025-09-04 15:02:32', '2025-09-04 14:32:32', '2025-09-04 14:32:40'),
(224, 'App\\Models\\AppUser', 564, 'api-access', '16528f36bc33dfff3b217b396374dce9b33b1baf2a5bdd19aa5e90c7be4f4031', '[\"*\"]', '172.68.12.198', '2025-09-04 14:39:21', '2025-09-04 15:05:42', '2025-09-04 14:35:42', '2025-09-04 14:39:21'),
(225, 'App\\Models\\AppUser', 564, 'api-access', '1068bfd8259dac97efbae4163cee649e874d5b3aa901dbc30bd84a5e99133565', '[\"*\"]', '172.69.11.102', '2025-09-04 14:40:45', '2025-09-04 15:07:33', '2025-09-04 14:37:33', '2025-09-04 14:40:45'),
(226, 'App\\Models\\AppUser', 564, 'api-access', '1d163953801271358f1789a3752dfe1096f33265ef2bc3da0ba0830e6696bace', '[\"*\"]', '172.71.144.133', '2025-09-04 14:46:08', '2025-09-04 15:16:00', '2025-09-04 14:46:00', '2025-09-04 14:46:08'),
(227, 'App\\Models\\AppUser', 635, 'api-access', 'a0a16fe8ed622d750ed62dc2a056d4663512a9fb7fe3b0fc56a7e4973ca61afc', '[\"*\"]', '108.162.212.171', '2025-09-04 14:58:11', '2025-09-11 14:57:38', '2025-09-04 14:57:38', '2025-09-04 14:58:11'),
(228, 'App\\Models\\AppUser', 564, 'api-access', '7c9df4e883536cff06a307bbdb1670258af425b88516d90b1811d74ffab0aa89', '[\"*\"]', '188.114.111.44', '2025-09-04 16:00:02', '2025-09-04 16:25:50', '2025-09-04 15:55:50', '2025-09-04 16:00:02'),
(229, 'App\\Models\\AppUser', 564, 'api-access', 'c57ad475222fa1063a582353703f2d66c2a5de838bf357e7c07b89a3f8707445', '[\"*\"]', '172.71.15.156', '2025-09-04 16:33:58', '2025-09-04 16:58:39', '2025-09-04 16:28:39', '2025-09-04 16:33:58'),
(230, 'App\\Models\\AppUser', 564, 'api-access', '3dcf9a7ca2c5e86df4c303df2ed8e5538bb0bcd5360741a72d87187dcc851423', '[\"*\"]', '172.68.213.63', '2025-09-04 16:33:07', '2025-09-04 16:59:42', '2025-09-04 16:29:42', '2025-09-04 16:33:07'),
(231, 'App\\Models\\AppUser', 564, 'api-access', 'c669eeef30eba275cc1578ebec40f7a5a32675e0f50eaf58255adff03e47650d', '[\"*\"]', '172.71.15.156', '2025-09-04 16:38:41', '2025-09-04 17:05:21', '2025-09-04 16:35:21', '2025-09-04 16:38:41'),
(232, 'App\\Models\\AppUser', 564, 'api-access', '4fe065883b1b29b2ca75fc903470a256c42c6679ea94791562a1eb379d64bb03', '[\"*\"]', '172.68.213.62', '2025-09-04 16:39:36', '2025-09-04 17:08:12', '2025-09-04 16:38:12', '2025-09-04 16:39:36'),
(233, 'App\\Models\\AppUser', 564, 'api-access', 'c19b34c6be5ade793b86a85415072875fd363aeefb23caa1a4fd3cc4a2e2e757', '[\"*\"]', '172.69.9.44', '2025-09-04 20:25:50', '2025-09-04 20:54:41', '2025-09-04 20:24:41', '2025-09-04 20:25:50'),
(234, 'App\\Models\\AppUser', 564, 'api-access', '92923f61f1d028c960127711e3867334d8a08bcc3eccb92ab356cda3d0d83a27', '[\"*\"]', '172.70.216.116', '2025-09-04 20:48:30', '2025-09-04 21:11:48', '2025-09-04 20:41:48', '2025-09-04 20:48:30'),
(235, 'App\\Models\\AppUser', 564, 'api-access', '9492a523d98e0d1bbbf7b7a9f7b4d46b54a3a4a40ad1d41aaf8929ad67ea2411', '[\"*\"]', '172.69.9.45', '2025-09-04 20:49:57', '2025-09-04 21:19:53', '2025-09-04 20:49:53', '2025-09-04 20:49:57'),
(236, 'App\\Models\\AppUser', 637, 'api-access', '6c75d7b5eadc840acc40b49e25a13e03938567a60933015ccacd2607c0571b65', '[\"*\"]', '172.68.26.206', '2025-09-04 23:04:21', '2025-09-11 23:04:19', '2025-09-04 23:04:19', '2025-09-04 23:04:21'),
(237, 'App\\Models\\AppUser', 564, 'api-access', '9972625def07b04696087ffcfb85b19d51f66ec628a2134e5e997988bfc50841', '[\"*\"]', '172.68.234.242', '2025-09-05 06:32:24', '2025-09-05 07:02:15', '2025-09-05 06:32:15', '2025-09-05 06:32:24'),
(238, 'App\\Models\\AppUser', 564, 'api-access', 'ba3ede75131339cbc1fb3abbef842ed73935fae557ed8a46db3276b51f80d415', '[\"*\"]', '162.158.22.14', '2025-09-05 07:11:13', '2025-09-05 07:38:01', '2025-09-05 07:08:01', '2025-09-05 07:11:13'),
(239, 'App\\Models\\AppUser', 604, 'api-access', '41f98d1230876b88c2fd63d3345dafe890dfe31f35199d846e86a64cdf8dcf7d', '[\"*\"]', '172.70.108.62', '2025-09-08 13:12:06', '2025-09-12 07:11:25', '2025-09-05 07:11:25', '2025-09-08 13:12:06'),
(240, 'App\\Models\\AppUser', 564, 'api-access', 'a791b6de944674537cf8e241cbe848db591d009d1ed1b94dd619b8fdbe5f0657', '[\"*\"]', '162.158.42.156', '2025-09-05 10:57:25', '2025-09-05 11:25:56', '2025-09-05 10:55:56', '2025-09-05 10:57:25'),
(241, 'App\\Models\\AppUser', 564, 'api-access', '2060a7e28943fde6dae6b3c88516128dfbca7ff4f85f49b092cb31ccadbf6dbd', '[\"*\"]', '172.69.23.174', '2025-09-05 10:56:52', '2025-09-05 11:26:51', '2025-09-05 10:56:51', '2025-09-05 10:56:52'),
(243, 'App\\Models\\AppUser', 564, 'api-access', '1bcdf945907a374d7d5a661e54c41dda4a9752efdd3e94dfd9807a5f6a090f57', '[\"*\"]', '172.69.22.156', '2025-09-05 11:03:54', '2025-09-05 11:31:49', '2025-09-05 11:01:49', '2025-09-05 11:03:54'),
(244, 'App\\Models\\AppUser', 564, 'api-access', 'c26b4ad2c5c573948b46fa643aff863ae95a832e3cc4e5594d863edc9fb0bff5', '[\"*\"]', '172.68.23.29', '2025-09-05 11:05:50', '2025-09-05 11:32:23', '2025-09-05 11:02:23', '2025-09-05 11:05:50'),
(245, 'App\\Models\\AppUser', 564, 'api-access', '25d2a1ca35c7add526a856f12a7bc755f3b0c8a105ecfe06ee1b7f49abd26a99', '[\"*\"]', '104.23.245.159', '2025-09-05 11:03:42', '2025-09-05 11:32:35', '2025-09-05 11:02:35', '2025-09-05 11:03:42'),
(247, 'App\\Models\\AppUser', 564, 'api-access', 'e3c70f7b1521dce91dd393ecc0abfb320aba6eeb001e61582b53c0357910ad5c', '[\"*\"]', '172.71.22.197', '2025-09-05 11:15:02', '2025-09-05 11:38:34', '2025-09-05 11:08:34', '2025-09-05 11:15:02'),
(248, 'App\\Models\\AppUser', 564, 'api-access', '825c56517024ef7630eb6582fc63433235e5ea266a7ea5df16a6ece9d531ff42', '[\"*\"]', '162.158.42.90', '2025-09-05 11:17:21', '2025-09-05 11:40:48', '2025-09-05 11:10:48', '2025-09-05 11:17:21'),
(249, 'App\\Models\\AppUser', 564, 'api-access', '0aaa9584457d3691036b536216e8e405537b4f052a51f1a2852d980c8c93f730', '[\"*\"]', '104.23.187.32', '2025-09-05 20:02:28', '2025-09-05 20:29:17', '2025-09-05 19:59:17', '2025-09-05 20:02:28'),
(250, 'App\\Models\\AppUser', 564, 'api-access', 'e0a7d47d3bb7a71f3e5c0e9c2046d86cd7840b3e664bb38d655dd02564fb6f6b', '[\"*\"]', '162.158.216.32', '2025-09-05 20:03:06', '2025-09-05 20:32:54', '2025-09-05 20:02:54', '2025-09-05 20:03:06'),
(252, 'App\\Models\\AppUser', 564, 'api-access', '95bad9e473f1b93564ae9f97cfdce70ddb411f85dd28b0570da92ee398e26066', '[\"*\"]', '172.69.74.233', '2025-09-06 02:22:53', '2025-09-06 02:52:51', '2025-09-06 02:22:51', '2025-09-06 02:22:53'),
(253, 'App\\Models\\AppUser', 564, 'api-access', 'ffeb7d8d099bf8a42433c5b12f858c2fb64a3d9018420306c57cf270210ef5e0', '[\"*\"]', '172.68.105.143', '2025-09-06 09:13:54', '2025-09-06 09:39:44', '2025-09-06 09:09:44', '2025-09-06 09:13:54'),
(255, 'App\\Models\\AppUser', 564, 'api-access', '78b97fcb04e00a1a6e7a50462496eff7f36f87ff2a60c0400859a1e8355caa05', '[\"*\"]', '162.158.88.123', '2025-09-06 09:46:14', '2025-09-06 10:15:32', '2025-09-06 09:45:32', '2025-09-06 09:46:14'),
(257, 'App\\Models\\AppUser', 564, 'api-access', '080f648eeabb81ca483ff25a89b2c0ea715beb96a81fb4f2832d83ad81aaa85b', '[\"*\"]', '162.158.108.136', '2025-09-06 09:47:49', '2025-09-06 10:17:42', '2025-09-06 09:47:42', '2025-09-06 09:47:49'),
(258, 'App\\Models\\AppUser', 564, 'api-access', '9e9ffcb6c99afaf6b89a8ab16fe808792b7d336b4af746e889234b2486f91432', '[\"*\"]', '172.68.164.107', '2025-09-06 09:49:04', '2025-09-06 10:18:57', '2025-09-06 09:48:57', '2025-09-06 09:49:04'),
(260, 'App\\Models\\AppUser', 640, 'api-access', 'ba8be2bedd9295770086b7e1c7d7c8d930756afb9f69364c4ff8da91fa1d3a96', '[\"*\"]', '172.68.105.142', '2025-09-06 10:26:53', '2025-09-13 10:26:20', '2025-09-06 10:26:20', '2025-09-06 10:26:53'),
(261, 'App\\Models\\AppUser', 564, 'api-access', 'c1de946e35b8c9ce2294ddc406feb2a5621532f2703e55637562404587ff562a', '[\"*\"]', '104.23.160.133', '2025-09-06 11:37:13', '2025-09-06 12:02:30', '2025-09-06 11:32:30', '2025-09-06 11:37:13'),
(262, 'App\\Models\\AppUser', 564, 'api-access', 'fe6f0aeb1e99280bce397c032b7f5f530a5b733d27eda5f64d56692406e06de8', '[\"*\"]', '162.158.170.53', '2025-09-06 12:17:27', '2025-09-06 12:43:02', '2025-09-06 12:13:02', '2025-09-06 12:17:27'),
(263, 'App\\Models\\AppUser', 564, 'api-access', 'b61fed06d1bbf56242c84d422816c00e1dd22822e68953727f5f1547871a0732', '[\"*\"]', '172.71.82.3', '2025-09-06 12:27:47', '2025-09-06 12:51:22', '2025-09-06 12:21:22', '2025-09-06 12:27:47'),
(264, 'App\\Models\\AppUser', 564, 'api-access', 'bc02afc7097947da892b9f1d95dc113512b3a4286913c007cf192eb34daeee19', '[\"*\"]', '172.71.17.145', '2025-09-06 13:08:04', '2025-09-06 13:34:09', '2025-09-06 13:04:09', '2025-09-06 13:08:04'),
(265, 'App\\Models\\AppUser', 564, 'api-access', '2edbea14462d7c52933228de615308466780cc1412b0a4e47f8d60544243d48a', '[\"*\"]', '162.158.116.106', '2025-09-06 13:49:22', '2025-09-06 14:14:41', '2025-09-06 13:44:41', '2025-09-06 13:49:22'),
(266, 'App\\Models\\AppUser', 564, 'api-access', 'fd88c76ab0a8634667eaea7f8269cfe83c8830382360d185dca0db6a6306eb75', '[\"*\"]', '104.23.205.136', '2025-09-06 14:39:31', '2025-09-06 14:45:13', '2025-09-06 14:15:13', '2025-09-06 14:39:31'),
(267, 'App\\Models\\AppUser', 564, 'api-access', '5e894127e5ed46fd3f270cab3bdbfad1f62018adb3a98287e0b1eced98d9777b', '[\"*\"]', '172.71.134.55', '2025-09-06 14:29:56', '2025-09-06 14:46:44', '2025-09-06 14:16:44', '2025-09-06 14:29:56'),
(268, 'App\\Models\\AppUser', 564, 'api-access', '826f5fb1195a76960323afc66a7f1d908fa91637bc75732d359adf5cd0d32cf8', '[\"*\"]', '172.71.232.147', '2025-09-06 14:23:05', '2025-09-06 14:49:28', '2025-09-06 14:19:28', '2025-09-06 14:23:05'),
(269, 'App\\Models\\AppUser', 564, 'api-access', '3e6211f17d41b6bd759663695185340437f0379652886e143c6f320776d66720', '[\"*\"]', '104.23.205.137', '2025-09-06 14:39:34', '2025-09-06 14:59:08', '2025-09-06 14:29:08', '2025-09-06 14:39:34'),
(270, 'App\\Models\\AppUser', 564, 'api-access', 'ca3b32ff99c54721e0551a8a7a76827dabc67b01edcf975e0c678aa8f0a50624', '[\"*\"]', '104.23.205.137', '2025-09-06 14:37:11', '2025-09-06 15:01:08', '2025-09-06 14:31:08', '2025-09-06 14:37:11'),
(271, 'App\\Models\\AppUser', 564, 'api-access', 'f2c0d9817616a9119912c0e7219deef03e0f257251f6dbf4ffea63bdf2790986', '[\"*\"]', '104.23.205.137', '2025-09-06 14:53:25', '2025-09-06 15:11:47', '2025-09-06 14:41:47', '2025-09-06 14:53:25'),
(274, 'App\\Models\\AppUser', 564, 'api-access', '2e8fa92f5ef3968e4616d71ec85f5253e4f20199b93cee1c0c7fa3a5d8b30c22', '[\"*\"]', '172.71.15.156', '2025-09-06 16:51:43', '2025-09-06 17:21:42', '2025-09-06 16:51:42', '2025-09-06 16:51:43'),
(275, 'App\\Models\\AppUser', 564, 'api-access', 'c5850f4e0c1e4a3cd9d7755ded71cf4940d04bfb70ed973d39b2de629562f7ed', '[\"*\"]', '104.23.205.136', '2025-09-06 18:26:45', '2025-09-06 18:37:22', '2025-09-06 18:07:22', '2025-09-06 18:26:45'),
(276, 'App\\Models\\AppUser', 564, 'api-access', 'f220c770ffe614cd70717a181084edfb51768782c6547e381ca8de81aa055085', '[\"*\"]', '104.23.205.137', '2025-09-06 18:19:16', '2025-09-06 18:42:17', '2025-09-06 18:12:17', '2025-09-06 18:19:16'),
(277, 'App\\Models\\AppUser', 564, 'api-access', 'f4c4735bd8233e4dd895bca79939bf2f82085d985a829c41b9011ac7513ec271', '[\"*\"]', '172.69.222.78', '2025-09-06 18:37:24', '2025-09-06 18:59:13', '2025-09-06 18:29:13', '2025-09-06 18:37:24'),
(279, 'App\\Models\\AppUser', 642, 'api-access', '553dcc1798c49214d953e075222cc4eccfe7fbe6168f97f9851dd6a65d8ba794', '[\"*\"]', '172.70.142.58', '2025-09-06 20:28:40', '2025-09-13 20:22:32', '2025-09-06 20:22:32', '2025-09-06 20:28:40'),
(280, 'App\\Models\\AppUser', 641, 'api-access', 'ffe85bcfb31ed449fccf762358038efa368d7e239a98a2642b949ed5ab8f63b1', '[\"*\"]', '162.158.106.78', '2025-09-06 20:26:20', '2025-09-13 20:24:21', '2025-09-06 20:24:21', '2025-09-06 20:26:20'),
(281, 'App\\Models\\AppUser', 646, 'api-access', 'bdd506f12d6894e5b088bcf0d6d2074768eb3b3e29e2da88f65e03a92bb33a8a', '[\"*\"]', '172.71.184.112', '2025-09-06 23:16:24', '2025-09-13 23:09:33', '2025-09-06 23:09:33', '2025-09-06 23:16:24'),
(282, 'App\\Models\\AppUser', 648, 'api-access', 'f3a374cb9897e8cfa3f7f3da949d1e12cad97c37adb0526bfce03d062bbafd1d', '[\"*\"]', '172.71.184.112', '2025-09-06 23:18:09', '2025-09-13 23:10:09', '2025-09-06 23:10:09', '2025-09-06 23:18:09'),
(284, 'App\\Models\\AppUser', 610, 'api-access', 'a5691726134b84ca0f1427bc6f776c57125fc060bc2e87d2d408a91a852f4653', '[\"*\"]', '172.71.148.45', '2025-09-13 03:13:57', '2025-09-14 13:18:59', '2025-09-07 13:18:59', '2025-09-13 03:13:57'),
(286, 'App\\Models\\AppUser', 564, 'api-access', 'b088153b2c3c705d2e722e7e86fad073f408d974cb0c667bf3c8689f541d64b2', '[\"*\"]', '162.158.193.50', '2025-09-08 07:39:38', '2025-09-08 08:06:19', '2025-09-08 07:36:19', '2025-09-08 07:39:38'),
(288, 'App\\Models\\AppUser', 601, 'api-access', 'dd837efe26e6fb048189dba2997bca4c6be72029801a34416866aa9f35e27567', '[\"*\"]', '172.71.82.2', '2025-09-08 08:26:41', '2025-09-15 08:26:39', '2025-09-08 08:26:39', '2025-09-08 08:26:41'),
(289, 'App\\Models\\AppUser', 564, 'api-access', '36fd8e6160f011c9bc31e9718a4ee78bcc7327f9d2755a710ae51942dd7dd112', '[\"*\"]', '172.69.9.44', '2025-09-08 12:14:37', '2025-09-08 12:44:15', '2025-09-08 12:14:15', '2025-09-08 12:14:37'),
(290, 'App\\Models\\AppUser', 583, 'api-access', '32a791a1fdfbe6c34381ab3288a3a0a75b7ccb8720a58b63816c3c6c1b6b4796', '[\"*\"]', '172.71.82.2', '2025-09-08 13:54:00', '2025-09-15 12:14:45', '2025-09-08 12:14:45', '2025-09-08 13:54:00'),
(291, 'App\\Models\\AppUser', 564, 'api-access', 'f6e9248e749b650abc4dd1148d447ead71969deea2386bf5f71e696cb0532a1c', '[\"*\"]', '172.69.9.45', '2025-09-08 13:21:14', '2025-09-08 13:24:55', '2025-09-08 12:54:55', '2025-09-08 13:21:14'),
(292, 'App\\Models\\AppUser', 564, 'api-access', '8987bc78d4e14da3f34cf52eec31d9bf15c5301cb55f960507a875a330867633', '[\"*\"]', '141.101.69.72', '2025-09-08 13:09:46', '2025-09-08 13:35:45', '2025-09-08 13:05:45', '2025-09-08 13:09:46'),
(293, 'App\\Models\\AppUser', 564, 'api-access', 'bcfee1c8493244d3b66bf91219e8165db6d733099f7446468be49255c5a561dc', '[\"*\"]', '172.70.188.43', '2025-09-08 13:27:58', '2025-09-08 13:52:32', '2025-09-08 13:22:32', '2025-09-08 13:27:58'),
(294, 'App\\Models\\AppUser', 564, 'api-access', 'b704bd0993a9645872259fe48007f48253acf39ff2629f02fb2fe6184887636c', '[\"*\"]', '162.158.88.122', '2025-09-08 13:30:59', '2025-09-08 14:00:19', '2025-09-08 13:30:19', '2025-09-08 13:30:59'),
(295, 'App\\Models\\AppUser', 564, 'api-access', 'b4ebe887c1605edd792fb24337cca8428ca8b8fca9dd0b0dbef5b89301691670', '[\"*\"]', '162.158.108.137', '2025-09-08 13:59:42', '2025-09-08 14:02:23', '2025-09-08 13:32:23', '2025-09-08 13:59:42'),
(296, 'App\\Models\\AppUser', 564, 'api-access', 'c6ea05f3efea5fa6c1e067036951d1bca7884cb3808984530d19b636eb02961d', '[\"*\"]', '162.158.189.92', '2025-09-08 14:25:32', '2025-09-08 14:26:58', '2025-09-08 13:56:58', '2025-09-08 14:25:32'),
(298, 'App\\Models\\AppUser', 564, 'api-access', '2df43ae9b0375d5308db092674f018c779e259b1b4bf29120fe2dcae04e1cdc2', '[\"*\"]', '162.158.129.215', '2025-09-08 14:39:06', '2025-09-08 14:39:22', '2025-09-08 14:09:22', '2025-09-08 14:39:06'),
(299, 'App\\Models\\AppUser', 564, 'api-access', '0f5a11867449706a5b6b18347b1a602c26ca19c169f2ffee85126576d5fe2e33', '[\"*\"]', '104.23.195.97', '2025-09-08 14:29:50', '2025-09-08 14:59:48', '2025-09-08 14:29:48', '2025-09-08 14:29:50'),
(303, 'App\\Models\\AppUser', 564, 'api-access', 'f099783a42a5d2035e40cebfc788576be00e2096a52f2e28f12f34f714d7c428', '[\"*\"]', '172.71.178.74', '2025-09-08 14:42:22', '2025-09-08 15:11:17', '2025-09-08 14:41:17', '2025-09-08 14:42:22'),
(304, 'App\\Models\\AppUser', 654, 'api-access', '4a4e6094abdb0f44aa3cff72e4eeeb5b5fcc00cd31e4225ea31099a5e6bd41ec', '[\"*\"]', '172.71.82.2', '2025-09-08 14:44:01', '2025-09-15 14:43:59', '2025-09-08 14:43:59', '2025-09-08 14:44:01'),
(305, 'App\\Models\\AppUser', 564, 'api-access', 'fd08271593d1b7129c03cf290eb6a85003e9d3f2848e3235d1cc644cb0c3c0a7', '[\"*\"]', '172.71.241.124', '2025-09-08 14:50:05', '2025-09-08 15:15:18', '2025-09-08 14:45:18', '2025-09-08 14:50:05'),
(306, 'App\\Models\\AppUser', 656, 'api-access', '16d576e51448f5628752d635ea77e9397436bea53a27ec163d507a4b9f02d734', '[\"*\"]', '172.71.178.74', '2025-09-08 15:04:01', '2025-09-15 14:53:50', '2025-09-08 14:53:50', '2025-09-08 15:04:01'),
(307, 'App\\Models\\AppUser', 564, 'api-access', '8428daf3cbc58432cd817686481222696e939d83cea2e895f0eee05c39a2a2b0', '[\"*\"]', '172.71.26.21', '2025-09-08 15:03:54', '2025-09-08 15:23:52', '2025-09-08 14:53:52', '2025-09-08 15:03:54'),
(308, 'App\\Models\\AppUser', 615, 'api-access', '6923a9edd3d6c8a95a62a1c9f6d64ee7d06d8a609a35e6cf87a9dedc79863e2f', '[\"*\"]', '172.69.138.29', '2025-09-09 02:03:38', '2025-09-16 02:03:36', '2025-09-09 02:03:36', '2025-09-09 02:03:38'),
(309, 'App\\Models\\AppUser', 564, 'api-access', 'bcd0445e16aa31cbd5bdabc57e9a1c024550251b00369bca12163371ebefc49d', '[\"*\"]', '162.158.88.122', '2025-09-09 06:10:08', '2025-09-09 06:35:06', '2025-09-09 06:05:06', '2025-09-09 06:10:08'),
(310, 'App\\Models\\AppUser', 564, 'api-access', 'f5e47ed20fe9ba0b0ea53948f2d8cf7f45a403e967e5ba694ee465b9e75c41ec', '[\"*\"]', '172.68.164.107', '2025-09-09 06:06:43', '2025-09-09 06:36:10', '2025-09-09 06:06:10', '2025-09-09 06:06:43'),
(311, 'App\\Models\\AppUser', 564, 'api-access', '096961f0068b89bf0e85eac3e1d6b7c9f99b495767f04126f13a0d80fc55e632', '[\"*\"]', '172.71.82.3', '2025-09-09 06:58:23', '2025-09-09 07:06:07', '2025-09-09 06:36:07', '2025-09-09 06:58:23'),
(312, 'App\\Models\\AppUser', 564, 'api-access', 'e8299002f26d0c0b5750b87fd98d2a518de0da84c920e9349d7bdc9051428aba', '[\"*\"]', '172.69.22.241', '2025-09-09 06:41:27', '2025-09-09 07:11:26', '2025-09-09 06:41:26', '2025-09-09 06:41:27'),
(313, 'App\\Models\\AppUser', 564, 'api-access', 'c53d97d7b6672290454b66abf1bc1d1b9fb2bf11dd1a8c0d67e81a5fd9af1921', '[\"*\"]', '162.158.108.137', '2025-09-09 06:48:32', '2025-09-09 07:17:50', '2025-09-09 06:47:50', '2025-09-09 06:48:32'),
(316, 'App\\Models\\AppUser', 564, 'api-access', 'a75373338122b9926640ed66d4b5c75d791fcf410dee1bfa669a7678603669a8', '[\"*\"]', '172.71.152.72', '2025-09-09 07:03:22', '2025-09-09 07:32:22', '2025-09-09 07:02:22', '2025-09-09 07:03:22'),
(317, 'App\\Models\\AppUser', 564, 'api-access', '70f5ace3cedc92062b092f04212be0d0add20fc5de142f0ece508f5c3b8ca4a7', '[\"*\"]', '172.71.124.21', '2025-09-09 07:18:42', '2025-09-09 07:48:35', '2025-09-09 07:18:35', '2025-09-09 07:18:42'),
(319, 'App\\Models\\AppUser', 564, 'api-access', '6a0ff3b10a8dad758f68f9e7efd135028a37cccc0d2efc88e364f91d60faae66', '[\"*\"]', '172.68.164.107', '2025-09-09 07:26:31', '2025-09-09 07:56:06', '2025-09-09 07:26:06', '2025-09-09 07:26:31'),
(320, 'App\\Models\\AppUser', 564, 'api-access', 'c6d33e5e64e3a808692d0e8988b453587db78ac47377b4a7a38b65dd2b609031', '[\"*\"]', '162.158.88.122', '2025-09-09 07:29:56', '2025-09-09 07:59:55', '2025-09-09 07:29:55', '2025-09-09 07:29:56'),
(323, 'App\\Models\\AppUser', 564, 'api-access', '15ff9b9326471f03cdb11a9846b2fcc3f144e310e678dd2430ab1a903b432159', '[\"*\"]', '172.71.124.20', '2025-09-09 07:33:44', '2025-09-09 08:03:38', '2025-09-09 07:33:38', '2025-09-09 07:33:44'),
(324, 'App\\Models\\AppUser', 599, 'api-access', '35d0c64251bf66856e205e8a3758aacf665ccd5ef37a998c3de231035fdb7832', '[\"*\"]', '172.71.82.2', '2025-09-09 07:35:03', '2025-09-16 07:34:14', '2025-09-09 07:34:14', '2025-09-09 07:35:03'),
(325, 'App\\Models\\AppUser', 655, 'api-access', 'ce13d8b17b2da0a7bb653816c07e94387078834b6078267672c91ebf0160c019', '[\"*\"]', '172.70.188.42', '2025-09-09 11:31:40', '2025-09-16 07:35:20', '2025-09-09 07:35:20', '2025-09-09 11:31:40'),
(326, 'App\\Models\\AppUser', 564, 'api-access', 'fa02e5cca004fc91f9efc294dfc255817c98dfd52b8b3714bb1c3322ff82ef63', '[\"*\"]', '162.158.23.89', '2025-09-09 09:56:42', '2025-09-09 10:14:02', '2025-09-09 09:44:02', '2025-09-09 09:56:42'),
(327, 'App\\Models\\AppUser', 564, 'api-access', '53b7a375cc457c2f51269ae95bf26f315984849281aceef164337dcf97a1e891', '[\"*\"]', '172.68.102.133', '2025-09-09 09:52:55', '2025-09-09 10:20:01', '2025-09-09 09:50:01', '2025-09-09 09:52:55'),
(328, 'App\\Models\\AppUser', 658, 'api-access', '41a19ffc4062f7997ba437850f83efcf34dbbde760cd577ed880566d15d2f3be', '[\"*\"]', '162.158.23.90', '2025-09-12 12:19:18', '2025-09-16 09:56:02', '2025-09-09 09:56:02', '2025-09-12 12:19:18'),
(329, 'App\\Models\\AppUser', 564, 'api-access', '77e862b5359e15e977800a0be5f3ca119f2d31b392a09e5dec4f4415337520ae', '[\"*\"]', '162.158.108.136', '2025-09-09 10:16:50', '2025-09-09 10:43:08', '2025-09-09 10:13:08', '2025-09-09 10:16:50'),
(330, 'App\\Models\\AppUser', 564, 'api-access', '79bdb2951af5692fac3897b996eae12c84aab13ba43431ce2eeefea838b0c542', '[\"*\"]', '172.70.188.43', '2025-09-09 10:14:29', '2025-09-09 10:43:38', '2025-09-09 10:13:38', '2025-09-09 10:14:29'),
(332, 'App\\Models\\AppUser', 564, 'api-access', '41aee9fd18aa8d2f9e78b100e118414ef28784d5386f43d8bb74f58450d4369b', '[\"*\"]', '172.70.108.161', '2025-09-09 10:21:34', '2025-09-09 10:50:07', '2025-09-09 10:20:07', '2025-09-09 10:21:34'),
(334, 'App\\Models\\AppUser', 564, 'api-access', 'f7ffbdc70348d570d80cb184dc4a6258e269495c1716c2f0210b5a4973798e11', '[\"*\"]', '172.71.82.3', '2025-09-09 11:49:10', '2025-09-09 12:12:40', '2025-09-09 11:42:40', '2025-09-09 11:49:10'),
(335, 'App\\Models\\AppUser', 564, 'api-access', '8e76d81e6236274b1a033ea6b360c79c6dea19230d2d4d14f861ffa3f6941a65', '[\"*\"]', '104.23.175.139', '2025-09-09 11:50:13', '2025-09-09 12:19:34', '2025-09-09 11:49:34', '2025-09-09 11:50:13'),
(336, 'App\\Models\\AppUser', 564, 'api-access', '935f2adbd0c9df60a1a441149aaba2c9f1376ade98fa7df1d0ff1a0c7e736691', '[\"*\"]', '172.71.152.72', '2025-09-09 12:23:05', '2025-09-09 12:31:57', '2025-09-09 12:01:57', '2025-09-09 12:23:05'),
(337, 'App\\Models\\AppUser', 564, 'api-access', '5292bd2524b9f4d76351cebdfc85cf882bee202924b06e48181b286ae6d4b1bf', '[\"*\"]', '172.68.164.106', '2025-09-09 13:26:12', '2025-09-09 13:55:08', '2025-09-09 13:25:08', '2025-09-09 13:26:12'),
(338, 'App\\Models\\AppUser', 564, 'api-access', 'd3a84cefe4df09a44127534656e2f1da2aa1a02353fc9990704d9c1dac365f88', '[\"*\"]', '198.41.227.55', '2025-09-09 13:28:09', '2025-09-09 13:58:07', '2025-09-09 13:28:07', '2025-09-09 13:28:09'),
(339, 'App\\Models\\AppUser', 564, 'api-access', 'c279e21049b77aa2f56c81545f72e01f78c54ace71fbf0980ed9ef8103f4f1a2', '[\"*\"]', '172.71.124.21', '2025-09-09 13:30:49', '2025-09-09 13:59:05', '2025-09-09 13:29:05', '2025-09-09 13:30:49'),
(340, 'App\\Models\\AppUser', 564, 'api-access', 'a6a0e4fb5ba8eaa7d1a9dbed9507ff8a3ff7e6af62666754a2320a352df69423', '[\"*\"]', '172.69.95.87', '2025-09-09 14:01:46', '2025-09-09 14:31:16', '2025-09-09 14:01:16', '2025-09-09 14:01:46'),
(341, 'App\\Models\\AppUser', 564, 'api-access', '39d41c9b8cfb56ae48b3ec31a001f63cb0b07d5e8a13786f62a77bdcd9144ec1', '[\"*\"]', '108.162.227.99', '2025-09-09 16:29:52', '2025-09-09 16:43:16', '2025-09-09 16:13:16', '2025-09-09 16:29:52'),
(342, 'App\\Models\\AppUser', 564, 'api-access', '6602b4c15927a233dbbb79b184f65124e7dfeac3e9988135e954247288749446', '[\"*\"]', '104.23.225.73', '2025-09-09 19:23:29', '2025-09-09 19:48:46', '2025-09-09 19:18:46', '2025-09-09 19:23:29'),
(343, 'App\\Models\\AppUser', 652, 'api-access', '6804dba196f1ecd5003e60ff33a7e380c02c46c639ff66ff0c9e3c16dc02c841', '[\"*\"]', '172.69.9.45', '2025-09-14 17:38:07', '2025-09-16 19:18:57', '2025-09-09 19:18:57', '2025-09-14 17:38:07'),
(344, 'App\\Models\\AppUser', 564, 'api-access', 'd8e86d1b395dd5c70f6767b290875c2efd2b6f90e81be09ad915b60f6809f135', '[\"*\"]', '162.158.23.89', '2025-09-10 10:51:01', '2025-09-10 11:20:43', '2025-09-10 10:50:43', '2025-09-10 10:51:01'),
(347, 'App\\Models\\AppUser', 616, 'api-access', 'b12ec21d5a44cb64969ce8190cb32bf2f18623f305622c09bd1199a3f467b8b1', '[\"*\"]', '162.158.23.89', '2025-09-10 12:47:21', '2025-09-17 12:43:50', '2025-09-10 12:43:50', '2025-09-10 12:47:21'),
(348, 'App\\Models\\AppUser', 564, 'api-access', 'ecc669c1da0facd2185e3d00e3c03e743e5d1df256459c6bafafe0c01257899d', '[\"*\"]', '162.158.189.119', '2025-09-10 12:47:11', '2025-09-10 13:15:34', '2025-09-10 12:45:34', '2025-09-10 12:47:11'),
(350, 'App\\Models\\AppUser', 659, 'api-access', 'c28c7c94e86e39b3ecafa7e0cfcb663b2bea69d7cf5a037fe12cbd494f00b841', '[\"*\"]', '162.158.88.122', '2025-09-16 12:49:45', '2025-09-17 13:15:45', '2025-09-10 13:15:45', '2025-09-16 12:49:45'),
(351, 'App\\Models\\AppUser', 564, 'api-access', '47589b07a6d0dd2e4eb38133cefd8053bbab17cda1abd5bae15a965a41c06c98', '[\"*\"]', '172.68.234.73', '2025-09-10 13:18:16', '2025-09-10 13:48:11', '2025-09-10 13:18:11', '2025-09-10 13:18:16'),
(352, 'App\\Models\\AppUser', 564, 'api-access', '4c792e8c825a7858f9ca8d2a5f76283fc95b6c4f4520a3a16d35b0cc861a42f2', '[\"*\"]', '162.158.23.89', '2025-09-10 13:18:44', '2025-09-10 13:48:22', '2025-09-10 13:18:22', '2025-09-10 13:18:44'),
(353, 'App\\Models\\AppUser', 626, 'api-access', '0806d28f2fa4a033ede6f85d65ff57620a5c1e481328034ee3303e48f0f81deb', '[\"*\"]', '172.68.234.72', '2025-09-15 06:29:20', '2025-09-17 13:19:59', '2025-09-10 13:19:59', '2025-09-15 06:29:20'),
(354, 'App\\Models\\AppUser', 564, 'api-access', '832dc08a499f130dce4fc49887b8739d218c2bba1cc699b49caa216beabfee64', '[\"*\"]', '172.68.245.193', '2025-09-10 15:16:35', '2025-09-10 15:41:44', '2025-09-10 15:11:44', '2025-09-10 15:16:35'),
(355, 'App\\Models\\AppUser', 564, 'api-access', '7c09184615b6768b0f5ff947e1e1381d1ed41b4f27a23be8acb6130671d44ea5', '[\"*\"]', '108.162.245.17', '2025-09-10 15:17:12', '2025-09-10 15:42:40', '2025-09-10 15:12:40', '2025-09-10 15:17:12'),
(356, 'App\\Models\\AppUser', 653, 'api-access', 'c0f6796fef7b139493e86768fcab26fd608a0f97bdbad784826accc200c3de13', '[\"*\"]', '172.71.126.125', '2025-09-16 13:34:37', '2025-09-17 18:35:57', '2025-09-10 18:35:57', '2025-09-16 13:34:37'),
(357, 'App\\Models\\AppUser', 564, 'api-access', '362e47a733bdc29b9cb1b7914a6ed214d4adf71386380f83816f8b96925985a9', '[\"*\"]', '172.69.166.114', '2025-09-11 07:25:58', '2025-09-11 07:55:06', '2025-09-11 07:25:06', '2025-09-11 07:25:58'),
(358, 'App\\Models\\AppUser', 564, 'api-access', '84b685a7da6c5765614b119ce45198440bdff880848a449fcdc0a45ad655784d', '[\"*\"]', '172.69.176.149', '2025-09-11 09:44:14', '2025-09-11 10:13:38', '2025-09-11 09:43:38', '2025-09-11 09:44:14'),
(359, 'App\\Models\\AppUser', 564, 'api-access', '11cca2645a6c10c40c86ba5ca389c7a5e6492d37ebff3836a2bec3bb68befb1c', '[\"*\"]', '172.70.208.72', '2025-09-11 14:58:27', '2025-09-11 15:27:26', '2025-09-11 14:57:26', '2025-09-11 14:58:27'),
(360, 'App\\Models\\AppUser', 564, 'api-access', 'a4a9d05c87ef937334accd545abfc0b82391735c2020b5d4474f90928a2d5c21', '[\"*\"]', '172.69.34.114', '2025-09-12 02:30:49', '2025-09-12 03:00:47', '2025-09-12 02:30:47', '2025-09-12 02:30:49'),
(361, 'App\\Models\\AppUser', 564, 'api-access', 'f58a8959b325127ee52e130e074fff37e93cf8282ba08f80426369b28ea275bc', '[\"*\"]', '172.71.203.105', '2025-09-13 05:08:43', '2025-09-13 05:35:28', '2025-09-13 05:05:28', '2025-09-13 05:08:43'),
(362, 'App\\Models\\AppUser', 564, 'api-access', '637c8b920577338cf06bd3100c30e89d2812217f5bd576f759173733df89d185', '[\"*\"]', '108.162.227.100', '2025-09-13 05:34:18', '2025-09-13 06:03:19', '2025-09-13 05:33:19', '2025-09-13 05:34:18'),
(363, 'App\\Models\\AppUser', 564, 'api-access', '7480dda0927c6839ab21ac9b3d80326bfd200f68e6ad1be1b9132843e1b17481', '[\"*\"]', '104.23.205.137', '2025-09-13 21:09:33', '2025-09-13 21:39:30', '2025-09-13 21:09:30', '2025-09-13 21:09:33'),
(364, 'App\\Models\\AppUser', 564, 'api-access', '62ab4c1dd6da11cfebc30d429eaeb802d8a063e6a3763e133781dc3d0a0162c0', '[\"*\"]', '172.68.234.72', '2025-09-14 03:48:59', '2025-09-14 04:18:40', '2025-09-14 03:48:40', '2025-09-14 03:48:59'),
(365, 'App\\Models\\AppUser', 564, 'api-access', '65a0d8f11d673e87e61e76462f068ed9b72d8193c4f496593039b18453ec33ac', '[\"*\"]', '104.23.195.97', '2025-09-14 13:36:20', '2025-09-14 14:06:19', '2025-09-14 13:36:19', '2025-09-14 13:36:20'),
(366, 'App\\Models\\AppUser', 564, 'api-access', '387a453bca6f61c6d2216980e7c57fc654ad24e82b7d2e0dc186fedf772f3d1f', '[\"*\"]', '172.69.135.64', '2025-09-15 05:35:18', '2025-09-15 06:05:15', '2025-09-15 05:35:15', '2025-09-15 05:35:18'),
(367, 'App\\Models\\AppUser', 564, 'api-access', '45adb94aac35410a8e01f96d1d06cde7ed4da3a9b245a1872e94f9672230855f', '[\"*\"]', '162.158.86.26', '2025-09-15 11:55:58', '2025-09-15 12:25:29', '2025-09-15 11:55:29', '2025-09-15 11:55:58'),
(368, 'App\\Models\\AppUser', 564, 'api-access', '986c15d7a6d4bbf3dd77076aee22811b714f89c7bcdc7e0580d7f89a838b50d9', '[\"*\"]', '162.158.90.54', '2025-09-15 16:11:06', '2025-09-15 16:41:03', '2025-09-15 16:11:03', '2025-09-15 16:11:06'),
(369, 'App\\Models\\AppUser', 564, 'api-access', 'dfafb2d51ae180734352c5f1e5a7ffab3458c0f51ea68d3a29b8d165d05ec7e7', '[\"*\"]', '104.23.175.139', '2025-09-16 06:29:51', '2025-09-16 06:43:31', '2025-09-16 06:13:31', '2025-09-16 06:29:51'),
(370, 'App\\Models\\AppUser', 564, 'api-access', '284db6e3e0052a79d0c8a595ebdd1170e3f10fefecf067f385d68db6810c2ece', '[\"*\"]', '172.70.188.43', '2025-09-16 06:15:08', '2025-09-16 06:44:31', '2025-09-16 06:14:31', '2025-09-16 06:15:08'),
(371, 'App\\Models\\AppUser', 647, 'api-access', '141078c00e20f25e8ecdf467d85faff1e2ad7dc9ca7b6484bea1d3715e72a960', '[\"*\"]', '104.23.170.122', '2025-09-16 17:10:47', '2025-09-23 06:32:19', '2025-09-16 06:32:19', '2025-09-16 17:10:47');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `called_ip`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(372, 'App\\Models\\AppUser', 670, 'api-access', 'fe3af0f2c5fec0913dd2316ed666b33f72af66c905ca87fa6f64cbfe516df425', '[\"*\"]', '172.69.87.239', '2025-09-16 06:43:34', '2025-09-23 06:43:32', '2025-09-16 06:43:32', '2025-09-16 06:43:34'),
(373, 'App\\Models\\AppUser', 564, 'api-access', 'b32224c128b43880e75f27d32cb12a506b637dc80e3372c206fde961ff87a24e', '[\"*\"]', '104.23.219.100', '2025-09-16 08:41:36', '2025-09-16 09:08:34', '2025-09-16 08:38:34', '2025-09-16 08:41:36'),
(375, 'App\\Models\\AppUser', 650, 'api-access', 'c68ded9ec0ef94a9edd9a8cf6204f13567d3ba97313e11a719563fc6e61aa677', '[\"*\"]', '104.23.205.137', '2025-09-16 17:10:46', '2025-09-23 17:07:16', '2025-09-16 17:07:16', '2025-09-16 17:10:46'),
(376, 'App\\Models\\AppUser', 564, 'api-access', 'f986a496e446bdf1709b3cabb836c63580162a6a37a2de8d5ffc79149bc370b5', '[\"*\"]', '162.158.216.33', '2025-09-17 06:09:49', '2025-09-17 06:38:35', '2025-09-17 06:08:35', '2025-09-17 06:09:49'),
(377, 'App\\Models\\AppUser', 671, 'api-access', 'aa5aabee9f9b9d2c03a973ff0a046427a7f4aa5a34eb53d11330c397097eab3b', '[\"*\"]', '172.71.241.124', '2025-09-17 07:04:57', '2025-09-24 07:04:55', '2025-09-17 07:04:55', '2025-09-17 07:04:57'),
(378, 'App\\Models\\AppUser', 564, 'api-access', 'ff877977aa2c9537fc054d578e3d61f6234d36dce2252b41512ac6b674cc4904', '[\"*\"]', '162.158.210.96', '2025-09-17 11:13:00', '2025-09-17 11:28:41', '2025-09-17 10:58:41', '2025-09-17 11:13:00'),
(379, 'App\\Models\\AppUser', 564, 'api-access', '64140b9be9f40b26e7f62aa1c87e043bca8f6a99014f922ec059cc308e290acb', '[\"*\"]', '162.158.210.96', '2025-09-17 11:13:16', '2025-09-17 11:35:58', '2025-09-17 11:05:58', '2025-09-17 11:13:16'),
(380, 'App\\Models\\AppUser', 564, 'api-access', 'be0620422fad60851b26777815659cb1da919a82324eb535a55c466fe7156896', '[\"*\"]', '172.70.108.160', '2025-09-17 13:01:16', '2025-09-17 13:11:13', '2025-09-17 12:41:13', '2025-09-17 13:01:16'),
(381, 'App\\Models\\AppUser', 564, 'api-access', '60321367f1a1d4a8056f0a44a0dd724f60cc34ae46aed09d7994c87e3b808447', '[\"*\"]', '172.71.203.104', '2025-09-17 12:55:33', '2025-09-17 13:25:31', '2025-09-17 12:55:31', '2025-09-17 12:55:33'),
(382, 'App\\Models\\AppUser', 564, 'api-access', '931fae5e9df6339c38fc850a8b3880d828cc6419199d25c571b0621353a857bc', '[\"*\"]', '162.158.210.97', '2025-09-17 13:36:10', '2025-09-17 13:58:08', '2025-09-17 13:28:08', '2025-09-17 13:36:10'),
(383, 'App\\Models\\AppUser', 672, 'api-access', '3924da130e80d64b43854396f99a3770567043c2f8b92b7b5d2bcbe0eee41a5f', '[\"*\"]', '162.158.210.97', '2025-09-17 13:41:11', '2025-09-24 13:31:27', '2025-09-17 13:31:27', '2025-09-17 13:41:11'),
(384, 'App\\Models\\AppUser', 673, 'api-access', 'c6b773fb92ca59b576619f2177b453194b71f29a21d2b1caa8c6a93808b26739', '[\"*\"]', '162.158.210.97', '2025-09-17 13:39:19', '2025-09-24 13:31:46', '2025-09-17 13:31:46', '2025-09-17 13:39:19'),
(385, 'App\\Models\\AppUser', 564, 'api-access', 'c211ee23700fb48b49fd8c6b20d52dfad3bd9b263ce1e224ecc97b05c7c6973d', '[\"*\"]', '172.70.242.101', '2025-09-18 09:49:10', '2025-09-18 10:11:47', '2025-09-18 09:41:47', '2025-09-18 09:49:10'),
(386, 'App\\Models\\AppUser', 564, 'api-access', 'ccd7948dfe7f7cbd7378a66f668a82d4c8996e2998017e726f94f71dac585830', '[\"*\"]', '172.70.108.160', '2025-09-18 09:49:03', '2025-09-18 10:12:07', '2025-09-18 09:42:07', '2025-09-18 09:49:03'),
(388, 'App\\Models\\AppUser', 663, 'api-access', '261a821e50f51002b9c9bd99003acd0b20ba562017cbfd54ab565b9fff03ce49', '[\"*\"]', '172.68.234.73', '2025-09-18 11:05:46', '2025-09-25 09:52:03', '2025-09-18 09:52:03', '2025-09-18 11:05:46'),
(389, 'App\\Models\\AppUser', 645, 'api-access', '25d1f37e6915c29d68a881c7785f00d4ed1a862f8d0a88ec27a453b99ced0b75', '[\"*\"]', '172.69.211.193', '2025-09-18 10:03:42', '2025-09-25 10:01:06', '2025-09-18 10:01:06', '2025-09-18 10:03:42'),
(390, 'App\\Models\\AppUser', 633, 'api-access', 'baac813eee800cb2e4ab0a91ed81926dd73ffcead741ab46317a6247932f0429', '[\"*\"]', '162.158.170.53', '2025-09-18 11:01:01', '2025-09-25 10:40:31', '2025-09-18 10:40:31', '2025-09-18 11:01:01');

-- --------------------------------------------------------

--
-- Table structure for table `rental_items`
--

CREATE TABLE `rental_items` (
  `id` bigint UNSIGNED NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_rating` double(15,2) DEFAULT '0.00',
  `average_speed_kmph` decimal(15,2) NOT NULL DEFAULT '40.00',
  `longitude` double DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `userid_id` bigint UNSIGNED DEFAULT NULL,
  `item_type_id` bigint UNSIGNED DEFAULT NULL,
  `place_id` bigint UNSIGNED DEFAULT NULL,
  `make` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `registration_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_type` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module` int DEFAULT '2',
  `is_featured` tinyint DEFAULT '0',
  `is_verified` tinyint(1) DEFAULT '0',
  `status` tinyint(1) DEFAULT '0',
  `views_count` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rental_item_dates`
--

CREATE TABLE `rental_item_dates` (
  `id` int UNSIGNED NOT NULL,
  `item_id` bigint UNSIGNED NOT NULL,
  `status` enum('Available','Not available') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Available',
  `booking_id` bigint UNSIGNED NOT NULL DEFAULT '0',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `min_stay` tinyint NOT NULL DEFAULT '0',
  `min_day` int NOT NULL DEFAULT '0',
  `range_index` int NOT NULL DEFAULT '0',
  `date` date DEFAULT NULL,
  `time_slot` time DEFAULT NULL,
  `type` enum('calendar','normal','slot') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'normal',
  `module` tinyint NOT NULL DEFAULT '1',
  `additional_hour` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rental_item_extension`
--

CREATE TABLE `rental_item_extension` (
  `id` bigint NOT NULL,
  `item_id` bigint UNSIGNED NOT NULL,
  `year` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vehicle_registration_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `odometer` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transmission` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rental_item_features`
--

CREATE TABLE `rental_item_features` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` tinyint DEFAULT '2',
  `type` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rental_item_make`
--

CREATE TABLE `rental_item_make` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` int NOT NULL DEFAULT '1',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rental_item_meta`
--

CREATE TABLE `rental_item_meta` (
  `id` bigint UNSIGNED NOT NULL,
  `item_id` bigint UNSIGNED NOT NULL,
  `meta_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rental_item_rules`
--

CREATE TABLE `rental_item_rules` (
  `id` int NOT NULL,
  `rule_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module` int NOT NULL DEFAULT '1',
  `status` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rental_item_types`
--

CREATE TABLE `rental_item_types` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` tinyint(1) DEFAULT '2',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rental_item_wishlists`
--

CREATE TABLE `rental_item_wishlists` (
  `id` int NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `item_id` int NOT NULL,
  `module` int DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` bigint UNSIGNED NOT NULL,
  `bookingid` bigint UNSIGNED NOT NULL,
  `item_id` bigint UNSIGNED DEFAULT '0',
  `item_name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `guestid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guest_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hostid` int DEFAULT NULL,
  `host_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guest_rating` int NOT NULL DEFAULT '0',
  `guest_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `host_rating` int DEFAULT '0',
  `host_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `module` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `title`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Admin', NULL, '2023-09-18 18:04:28', NULL),
(2, 'User', NULL, NULL, NULL),
(3, 'manager', '2023-07-05 22:50:57', '2023-07-05 22:50:57', NULL),
(5, 'supper admin', '2024-07-15 06:42:53', '2024-07-15 06:42:53', NULL),
(6, 'demo', '2024-10-25 12:21:56', '2024-10-25 12:21:56', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role_user`
--

CREATE TABLE `role_user` (
  `user_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_user`
--

INSERT INTO `role_user` (`user_id`, `role_id`) VALUES
(14, 1),
(14, 5);

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` bigint UNSIGNED NOT NULL,
  `heading` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subheading` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `static_pages`
--

CREATE TABLE `static_pages` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module` tinyint DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `static_pages`
--

INSERT INTO `static_pages` (`id`, `name`, `content`, `status`, `module`, `created_at`, `updated_at`) VALUES
(2, 'About us', '<h3>🚖 Ride Booking Made Easy with RideOn Taxi</h3><p>The <strong>RideOn Taxi</strong> app offers a seamless and smart ride booking experience designed for daily commuters, travelers, and anyone looking for fast and reliable transport. With just a few taps, you can book a ride from your current location to any destination — whether it’s a quick city trip or a long-distance journey.</p><h4>🔑 Key Features:</h4><p>✅ <strong>Instant Ride Booking</strong> – Set your pickup and drop-off points and get connected to a nearby driver in seconds.<br>✅ <strong>Live Driver Tracking</strong> – Watch your driver approach in real-time on the map.<br>✅ <strong>Multiple Vehicle Choices</strong> – Choose from different vehicle types based on your needs and comfort.<br>✅ <strong>Transparent Fare Estimates</strong> – Know your trip cost before you confirm — no hidden fees.<br>✅ <strong>Verified Drivers</strong> – All drivers are background-checked and trained for safety and professionalism.<br>✅ <strong>Trip History &nbsp;</strong> – View past rides directly from your account.<br>✅ <strong>24/7 Support</strong> – Facing any issue or need help with your trip? We’re always here.</p><h4>📞 Contact Us:</h4><p>📱 <strong>Phone Support</strong>: +91 97166 46098<br>📧 <strong>Email</strong>: info@sizhitsolutions.com</p><p>Whether you’re heading to work, the airport, or anywhere else — <strong>RideOn Taxi gets you there safely, affordably, and on time.</strong> 🚕</p>', '1', 1, '2023-08-08 13:25:14', '2025-08-26 11:37:48'),
(4, 'Get help', '<h2>🛠️ <strong>Support – We\'re Here to Help</strong></h2><p>Whether you\'re booking a ride with the <strong>RideOn Taxi App</strong> or driving with the <strong>RideOn Driver App</strong>, our team is here to make your experience smooth, safe, and stress-free. 🚖</p><h2>📞 <strong>Contact Us</strong></h2><h3>📧 Email Support</h3><p>✉️ <strong>info@sizhitsolutions.com</strong><br>Need help or facing an issue? Email us anytime! Our team responds within <strong>24 hours</strong> to all support requests.</p><h3>📱 Phone Support</h3><p>📞 <strong>+91 97166 46098</strong><br>Prefer to talk? Call us during business hours for <strong>immediate support</strong> from a real human (not a robot 🤖).</p><h2>❓ <strong>Frequently Asked Questions (FAQs)</strong></h2><h3>👤 1. How do I update my profile?</h3><p><strong>Riders:</strong><br>Go to <strong>Profile</strong> in the menu → Edit your name, phone number, or profile photo → Tap <strong>Save</strong> ✅</p><p><strong>Drivers:</strong><br>Go to <strong>Profile</strong> in the side menu → Update personal and vehicle details → Save changes.</p><h3>🐞 2. How do I report a bug or technical issue?</h3><p>If something isn’t working right, email us at <strong>info@sizhitsolutions.com</strong> with:</p><p>📝 A short description of the issue</p><p>⚠️ Any error messages</p><p>📸 Screenshots or screen recordings (if possible)</p><p>We’ll jump on it quickly!</p><h3>❌ 3. How do I cancel a ride or booking?</h3><p><strong>Riders:</strong><br>Go to <strong>Bookings</strong> → Select the ride → Tap <strong>Cancel Ride</strong> → Confirm (cancellation fee may apply).</p><p><strong>Drivers:</strong><br>Open the ride in the RideOn Driver app → Tap <strong>Cancel Ride</strong> (valid reason required to avoid penalties).</p><h3>💬 4. How do I give feedback or suggestions?</h3><p>We ❤️ feedback! Help us improve:<br>📨 Email your suggestions to <strong>info@sizhitsolutions.com</strong><br>We read every message — yes, <i>every single one</i>!</p><h2>💙 <strong>Thank You for Choosing RideOn!</strong></h2><p>We’re committed to making your ride experience:<br>✅ <strong>Safe</strong><br>✅ <strong>Affordable</strong><br>✅ <strong>Reliable</strong></p><p>If you need help, remember — we’re just a tap or call away. 🚗💨</p>', '1', 1, '2023-08-08 13:26:04', '2025-08-26 11:41:26'),
(5, 'Give us Feedback', '<p><strong>Give Us Feedback</strong></p><p>At <strong>Unibooker Vehicle</strong>, we are committed to continuously improving our app and delivering the best possible experience for our users. Your feedback is invaluable to us and helps us enhance our services to better meet your needs.</p><p><strong>How to Provide Feedback:</strong></p><p><strong>Feedback Form</strong>: Please fill out our online feedback form to share your thoughts, suggestions, or experiences. You can access the form directly within the app by navigating to the \"Feedback\" section under the settings menu. Your responses will be reviewed by our team, and we will use them to make informed improvements to the app.</p><p><strong>Email Us</strong>: If you prefer, you can email your feedback directly to us at info@sizhitsolutions.com. Please include a detailed description of your feedback, any issues you encountered, and suggestions for improvement. We appreciate any insights you can provide.</p><p><strong>Phone Feedback</strong>: For immediate feedback or to discuss your experience directly, you can call us at +91 9540223464. Our team is available during business hours to listen to your feedback and address any concerns you may have.</p><p><strong>Why Your Feedback Matters:</strong></p><p><strong>Enhancing User Experience</strong>: Your feedback helps us identify areas where we can improve the app\'s functionality and user interface, ensuring a smoother and more enjoyable experience.</p><p><strong>Addressing Issues</strong>: Reporting any issues or bugs allows us to address them promptly, improving the overall reliability and performance of the app.</p><p><strong>Feature Requests</strong>: Let us know if there are features you would like to see in future updates. Your suggestions guide us in developing new features that meet your needs.</p><p><strong>We Value Your Input!</strong></p><p>Thank you for taking the time to provide feedback on <strong>Unibooker Vehicle</strong>. We are dedicated to making continuous improvements and appreciate your contribution to making our app better for everyone. Your satisfaction is our priority, and we look forward to hearing from you.</p>', '1', 1, '2023-08-08 13:26:39', '2024-09-06 11:26:06'),
(6, 'Cancellation policy', '<p>Cancellation policy</p>', '1', 1, '2023-08-08 13:27:22', '2024-05-20 14:06:05'),
(11, 'Terms and Conditions', '<h2>🚖 RideOn App – Terms of Service</h2><h3>1. Acceptance of Terms</h3><p>1.1 By downloading, accessing, or using the RideOn App, you agree to these Terms of Service.<br>1.2 If you do not agree with any part of these terms, please stop using the app immediately.</p><h3>2. Account Registration</h3><p>2.1 To use RideOn services, you must create an account with accurate and up-to-date information.<br>2.2 You are responsible for maintaining the confidentiality of your login credentials.<br>2.3 Any unauthorized use of your account must be reported to RideOn Support immediately.</p><h3>3. Ride Booking Services</h3><p>3.1 The RideOn App connects riders with verified drivers for transportation services.<br>3.2 All rides depend on driver availability and system confirmation.<br>3.3 Riders must provide correct pickup and drop-off details.<br>3.4 Riders agree to follow respectful and lawful behavior during the trip.</p><h3>4. Driver Guidelines</h3><p>4.1 Drivers must remain active on the app to receive ride requests.<br>4.2 A negative wallet balance may result in temporary account suspension until cleared.<br>4.3 Drivers are required to obey all traffic and safety rules and ensure a safe journey for passengers.</p><h3>5. Fees and Subscriptions</h3><p>5.1 RideOn is free to download and use for riders.<br>5.2 Drivers may be subject to future service fees or subscription plans for premium features.<br>5.3 Fare charges for rides will be shown clearly before booking.</p><h3>6. Reviews &amp; Ratings</h3><p>6.1 After every completed ride, riders and drivers may rate and review each other.<br>6.2 RideOn reserves the right to remove reviews that contain abusive, false, or harmful content.</p><h3>7. Limitation of Liability</h3><p>7.1 RideOn is a technology platform and does not own or operate vehicles.<br>7.2 We are not responsible for disputes, delays, accidents, damages, or losses during rides.<br>7.3 Users and drivers are solely responsible for their interactions.</p><h3>8. Privacy &amp; Data Protection</h3><p>8.1 Your personal information is collected and protected as per our Privacy Policy.<br>8.2 By using RideOn, you consent to the collection and use of data as outlined in the Privacy Policy.</p><h3>9. Modifications to Terms</h3><p>9.1 RideOn may update or revise these Terms of Service at any time.<br>9.2 Continued use of the app after updates will mean you accept the new terms.</p><h3>10. Account Suspension &amp; Termination</h3><p>10.1 RideOn reserves the right to suspend, limit, or terminate any account that violates these terms.<br>10.2 Misuse of the platform, fraud, or harmful behavior may result in permanent account removal.</p><p>⚠️ <strong>Note:</strong> These Terms of Service apply to all users of the RideOn App, including riders and drivers.</p>', '1', 1, '2024-08-02 08:04:08', '2025-08-26 11:47:20');

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` int NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `thread_id` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thread_status` int NOT NULL DEFAULT '1',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` tinyint(1) NOT NULL DEFAULT '2',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_ticket_replies`
--

CREATE TABLE `support_ticket_replies` (
  `id` int NOT NULL,
  `thread_id` int NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `is_admin_reply` tinyint(1) NOT NULL DEFAULT '0',
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reply_status` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint UNSIGNED NOT NULL,
  `booking_id` bigint UNSIGNED NOT NULL,
  `gateway_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `currency_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `response_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` datetime DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(14, 'admin', 'info@sizhitsolutions.com', NULL, '$2y$10$BGR/IJM0/F2mO4TMJkWp2OwnW4jCAdVJdD1nu7JM3KlqJ7jD9qABC', 'R0WIJCY2u6h6TG8ImlRkf3Rb0YdaAKwya3HP6Gg6GK7w2LHpDkilwK0qlslI', '2024-09-18 18:31:00', '2025-09-03 09:17:29', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_odometer`
--

CREATE TABLE `vehicle_odometer` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL,
  `module` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vendor_wallets`
--

CREATE TABLE `vendor_wallets` (
  `id` bigint UNSIGNED NOT NULL,
  `vendor_id` bigint UNSIGNED NOT NULL,
  `booking_id` bigint UNSIGNED DEFAULT '0',
  `payout_id` bigint UNSIGNED DEFAULT '0',
  `amount` decimal(15,2) NOT NULL,
  `type` enum('credit','debit','refund') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` int NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `type` enum('credit','debit') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `add_coupons`
--
ALTER TABLE `add_coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `all_packages`
--
ALTER TABLE `all_packages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `app_users`
--
ALTER TABLE `app_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_users_email_unique` (`email`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`,`phone_country`),
  ADD KEY `package_fk_8713947` (`package_id`),
  ADD KEY `firestore_id` (`firestore_id`);

--
-- Indexes for table `app_users_bank_accounts`
--
ALTER TABLE `app_users_bank_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_bank_account_user` (`user_id`);

--
-- Indexes for table `app_user_meta`
--
ALTER TABLE `app_user_meta`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id_2` (`user_id`,`meta_key`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indexes for table `app_user_otps`
--
ALTER TABLE `app_user_otps`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `host_id` (`host_id`),
  ADD KEY `userid` (`userid`),
  ADD KEY `itemid` (`itemid`),
  ADD KEY `token` (`token`),
  ADD KEY `check_in` (`ride_date`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `booking_cancellation_policies`
--
ALTER TABLE `booking_cancellation_policies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `booking_cancellation_reasons`
--
ALTER TABLE `booking_cancellation_reasons`
  ADD PRIMARY KEY (`order_cancellation_id`);

--
-- Indexes for table `booking_extensions`
--
ALTER TABLE `booking_extensions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `booking_meta`
--
ALTER TABLE `booking_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_booking_meta_booking_id` (`booking_id`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_us`
--
ALTER TABLE `contact_us`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `email_notification_mappings`
--
ALTER TABLE `email_notification_mappings`
  ADD PRIMARY KEY (`email_type_id`,`email_sms_notification_id`,`module`),
  ADD UNIQUE KEY `email_type_id` (`email_type_id`,`email_sms_notification_id`,`module`),
  ADD KEY `email_sms_notification_id` (`email_sms_notification_id`);

--
-- Indexes for table `email_sms_notification`
--
ALTER TABLE `email_sms_notification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `email_type`
--
ALTER TABLE `email_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `general_settings`
--
ALTER TABLE `general_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `meta_key` (`meta_key`),
  ADD KEY `meta_key_2` (`meta_key`);

--
-- Indexes for table `item_city_fare`
--
ALTER TABLE `item_city_fare`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_type_id` (`item_type_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `make_type_relation`
--
ALTER TABLE `make_type_relation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_make_type_make_id` (`make_id`),
  ADD KEY `fk_make_type_type_id` (`type_id`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `media_uuid_unique` (`uuid`),
  ADD KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  ADD KEY `media_order_column_index` (`order_column`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `module`
--
ALTER TABLE `module`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payouts`
--
ALTER TABLE `payouts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_payouts_vendorid` (`vendorid`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD KEY `role_id_fk_8655789` (`role_id`),
  ADD KEY `permission_id_fk_8655789` (`permission_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `rental_items`
--
ALTER TABLE `rental_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid_fk_8656820` (`userid_id`),
  ADD KEY `property_type_fk_8657403` (`item_type_id`),
  ADD KEY `place_fk_8657368` (`place_id`),
  ADD KEY `property_type_id` (`item_type_id`),
  ADD KEY `token` (`token`);

--
-- Indexes for table `rental_item_dates`
--
ALTER TABLE `rental_item_dates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `property_id` (`item_id`,`date`);

--
-- Indexes for table `rental_item_extension`
--
ALTER TABLE `rental_item_extension`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `item_id` (`item_id`),
  ADD UNIQUE KEY `item_id_3` (`item_id`),
  ADD KEY `item_id_2` (`item_id`);

--
-- Indexes for table `rental_item_features`
--
ALTER TABLE `rental_item_features`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rental_item_make`
--
ALTER TABLE `rental_item_make`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rental_item_meta`
--
ALTER TABLE `rental_item_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rental_item_id` (`item_id`);

--
-- Indexes for table `rental_item_rules`
--
ALTER TABLE `rental_item_rules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rental_item_types`
--
ALTER TABLE `rental_item_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rental_item_wishlists`
--
ALTER TABLE `rental_item_wishlists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_property_id` (`item_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_reviews_bookingid` (`bookingid`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_user`
--
ALTER TABLE `role_user`
  ADD KEY `user_id_fk_8655798` (`user_id`),
  ADD KEY `role_id_fk_8655798` (`role_id`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `static_pages`
--
ALTER TABLE `static_pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_ticket_replies`
--
ALTER TABLE `support_ticket_replies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_transactions_booking_id` (`booking_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `vehicle_odometer`
--
ALTER TABLE `vehicle_odometer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vendor_wallets`
--
ALTER TABLE `vendor_wallets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_vendor_wallets_vendor_id` (`vendor_id`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_wallets_user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `add_coupons`
--
ALTER TABLE `add_coupons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `all_packages`
--
ALTER TABLE `all_packages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `app_users`
--
ALTER TABLE `app_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_users_bank_accounts`
--
ALTER TABLE `app_users_bank_accounts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_user_meta`
--
ALTER TABLE `app_user_meta`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_user_otps`
--
ALTER TABLE `app_user_otps`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `booking_cancellation_policies`
--
ALTER TABLE `booking_cancellation_policies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `booking_cancellation_reasons`
--
ALTER TABLE `booking_cancellation_reasons`
  MODIFY `order_cancellation_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `booking_extensions`
--
ALTER TABLE `booking_extensions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1198;

--
-- AUTO_INCREMENT for table `booking_meta`
--
ALTER TABLE `booking_meta`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `contact_us`
--
ALTER TABLE `contact_us`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `currency`
--
ALTER TABLE `currency`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=164;

--
-- AUTO_INCREMENT for table `email_sms_notification`
--
ALTER TABLE `email_sms_notification`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `email_type`
--
ALTER TABLE `email_type`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `general_settings`
--
ALTER TABLE `general_settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=208;

--
-- AUTO_INCREMENT for table `item_city_fare`
--
ALTER TABLE `item_city_fare`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42972;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `make_type_relation`
--
ALTER TABLE `make_type_relation`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT for table `module`
--
ALTER TABLE `module`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `payouts`
--
ALTER TABLE `payouts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=342;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=391;

--
-- AUTO_INCREMENT for table `rental_items`
--
ALTER TABLE `rental_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rental_item_dates`
--
ALTER TABLE `rental_item_dates`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rental_item_extension`
--
ALTER TABLE `rental_item_extension`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=517;

--
-- AUTO_INCREMENT for table `rental_item_features`
--
ALTER TABLE `rental_item_features`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `rental_item_make`
--
ALTER TABLE `rental_item_make`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `rental_item_meta`
--
ALTER TABLE `rental_item_meta`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rental_item_rules`
--
ALTER TABLE `rental_item_rules`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `rental_item_types`
--
ALTER TABLE `rental_item_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `rental_item_wishlists`
--
ALTER TABLE `rental_item_wishlists`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `static_pages`
--
ALTER TABLE `static_pages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_ticket_replies`
--
ALTER TABLE `support_ticket_replies`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `vehicle_odometer`
--
ALTER TABLE `vehicle_odometer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `vendor_wallets`
--
ALTER TABLE `vendor_wallets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `app_users`
--
ALTER TABLE `app_users`
  ADD CONSTRAINT `package_fk_8713947` FOREIGN KEY (`package_id`) REFERENCES `all_packages` (`id`);

--
-- Constraints for table `app_users_bank_accounts`
--
ALTER TABLE `app_users_bank_accounts`
  ADD CONSTRAINT `fk_bank_account_user` FOREIGN KEY (`user_id`) REFERENCES `app_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `app_user_meta`
--
ALTER TABLE `app_user_meta`
  ADD CONSTRAINT `fk_meta_user` FOREIGN KEY (`user_id`) REFERENCES `app_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `booking_extensions`
--
ALTER TABLE `booking_extensions`
  ADD CONSTRAINT `fk_booking_extensions_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `booking_meta`
--
ALTER TABLE `booking_meta`
  ADD CONSTRAINT `fk_booking_meta_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `email_notification_mappings`
--
ALTER TABLE `email_notification_mappings`
  ADD CONSTRAINT `fk_email_sms_notification` FOREIGN KEY (`email_sms_notification_id`) REFERENCES `email_sms_notification` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_email_type` FOREIGN KEY (`email_type_id`) REFERENCES `email_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `item_city_fare`
--
ALTER TABLE `item_city_fare`
  ADD CONSTRAINT `item_city_fare_ibfk_1` FOREIGN KEY (`item_type_id`) REFERENCES `rental_item_types` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `make_type_relation`
--
ALTER TABLE `make_type_relation`
  ADD CONSTRAINT `fk_make_type_make_id` FOREIGN KEY (`make_id`) REFERENCES `rental_item_make` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_make_type_type_id` FOREIGN KEY (`type_id`) REFERENCES `rental_item_types` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payouts`
--
ALTER TABLE `payouts`
  ADD CONSTRAINT `fk_payouts_vendorid` FOREIGN KEY (`vendorid`) REFERENCES `app_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_id_fk_8655789` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_id_fk_8655789` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `rental_items`
--
ALTER TABLE `rental_items`
  ADD CONSTRAINT `fk_rental_items_userid_id` FOREIGN KEY (`userid_id`) REFERENCES `app_users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `rental_item_dates`
--
ALTER TABLE `rental_item_dates`
  ADD CONSTRAINT `fk_rental_item_dates_item_id` FOREIGN KEY (`item_id`) REFERENCES `rental_items` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `rental_item_extension`
--
ALTER TABLE `rental_item_extension`
  ADD CONSTRAINT `fk_rental_item_extension_item_id` FOREIGN KEY (`item_id`) REFERENCES `rental_items` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `rental_item_meta`
--
ALTER TABLE `rental_item_meta`
  ADD CONSTRAINT `fk_rental_item_meta_item_id` FOREIGN KEY (`item_id`) REFERENCES `rental_items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `rental_item_meta_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `rental_items` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `rental_item_wishlists`
--
ALTER TABLE `rental_item_wishlists`
  ADD CONSTRAINT `fk_rental_item_wishlists_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_reviews_bookingid` FOREIGN KEY (`bookingid`) REFERENCES `bookings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_id_fk_8655798` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_id_fk_8655798` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `fk_transactions_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vendor_wallets`
--
ALTER TABLE `vendor_wallets`
  ADD CONSTRAINT `fk_vendor_wallets_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `app_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wallets`
--
ALTER TABLE `wallets`
  ADD CONSTRAINT `fk_wallets_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
