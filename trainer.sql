CREATE TABLE IF NOT EXISTS `django_content_type` (
	`id`	integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`app_label`	varchar(100) NOT NULL,
	`model`	varchar(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS `django_migrations` (
	`id`	integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`app`	varchar(255) NOT NULL,
	`name`	varchar(255) NOT NULL,
	`applied`	datetime NOT NULL
);
CREATE TABLE IF NOT EXISTS `django_session` (
	`session_key`	varchar(40) NOT NULL,
	`session_data`	text NOT NULL,
	`expire_date`	datetime NOT NULL,
	PRIMARY KEY(`session_key`)
);
CREATE TABLE IF NOT EXISTS `auth_group` (
	`id`	integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`name`	varchar(150) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS `trainers_customtrainer` (
	`id`	integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`password`	varchar(128) NOT NULL,
	`last_login`	datetime,
	`is_superuser`	bool NOT NULL,
	`username`	varchar(150) NOT NULL UNIQUE,
	`first_name`	varchar(30) NOT NULL,
	`last_name`	varchar(150) NOT NULL,
	`email`	varchar(254) NOT NULL,
	`is_staff`	bool NOT NULL,
	`is_active`	bool NOT NULL,
	`date_joined`	datetime NOT NULL,
	`specialty`	varchar(50),
	`employee_cell_phone`	varchar(50)
);
CREATE TABLE IF NOT EXISTS `clients_client` (
	`id`	integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`name`	varchar(50) NOT NULL,
	`address`	varchar(50),
	`city`	varchar(50) NOT NULL,
	`state`	varchar(50) NOT NULL,
	`zipcode`	varchar(10) NOT NULL,
	`email`	varchar(100) NOT NULL,
	`acct_number`	varchar(50),
	`date`	datetime NOT NULL,
	`trainer_id`	integer NOT NULL,
	`cell_phone`	varchar(128) NOT NULL,
	FOREIGN KEY(`trainer_id`) REFERENCES `trainers_customtrainer`(`id`) 
);
CREATE TABLE IF NOT EXISTS `clients_exercisecategory` (
	`id`	integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`category`	varchar(26) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS `clients_exercises` (
	`id`	integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`exercise_category_category_id`	integer NOT NULL,
	`name`	varchar(26) NOT NULL UNIQUE,
	FOREIGN KEY(`exercise_category_category_id`) REFERENCES `clients_exercisecategory`(`id`) 
);
CREATE TABLE IF NOT EXISTS `clients_diary` (
	`id`	integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`duration`	integer NOT NULL,
	`duration_units`	varchar(5) NOT NULL,
	`reps`	integer NOT NULL,
	`weight`	integer NOT NULL,
	`weight_units`	varchar(5) NOT NULL,
	`client_id`	integer NOT NULL,
	`exercises_id`	integer NOT NULL,
	`trainer_id`	integer,
	`day`	date NOT NULL,
	FOREIGN KEY(`exercises_id`) REFERENCES `clients_exercises`(`id`) ,
	FOREIGN KEY(`client_id`) REFERENCES `clients_client`(`id`) ,
	FOREIGN KEY(`trainer_id`) REFERENCES `trainers_customtrainer`(`id`) 
);
CREATE TABLE IF NOT EXISTS `clients_comment` (
	`id`	integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`comment`	text NOT NULL,
	`trainer_id`	integer NOT NULL,
	`client_id`	integer NOT NULL,
	`day`	date NOT NULL,
	FOREIGN KEY(`trainer_id`) REFERENCES `trainers_customtrainer`(`id`) ,
	FOREIGN KEY(`client_id`) REFERENCES `clients_client`(`id`) 
);
CREATE TABLE IF NOT EXISTS `django_admin_log` (
	`id`	integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`action_time`	datetime NOT NULL,
	`object_id`	text,
	`object_repr`	varchar(200) NOT NULL,
	`change_message`	text NOT NULL,
	`content_type_id`	integer,
	`user_id`	integer NOT NULL,
	`action_flag`	smallint unsigned NOT NULL CHECK(`action_flag`>=0),
	FOREIGN KEY(`content_type_id`) REFERENCES `django_content_type`(`id`) ,
	FOREIGN KEY(`user_id`) REFERENCES `trainers_customtrainer`(`id`) 
);
CREATE TABLE IF NOT EXISTS `auth_permission` (
	`id`	integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`content_type_id`	integer NOT NULL,
	`codename`	varchar(100) NOT NULL,
	`name`	varchar(255) NOT NULL,
	FOREIGN KEY(`content_type_id`) REFERENCES `django_content_type`(`id`) 
);
CREATE TABLE IF NOT EXISTS `trainers_customtrainer_user_permissions` (
	`id`	integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`customtrainer_id`	integer NOT NULL,
	`permission_id`	integer NOT NULL,
	FOREIGN KEY(`permission_id`) REFERENCES `auth_permission`(`id`) ,
	FOREIGN KEY(`customtrainer_id`) REFERENCES `trainers_customtrainer`(`id`) 
);
CREATE TABLE IF NOT EXISTS `trainers_customtrainer_groups` (
	`id`	integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`customtrainer_id`	integer NOT NULL,
	`group_id`	integer NOT NULL,
	FOREIGN KEY(`group_id`) REFERENCES `auth_group`(`id`) ,
	FOREIGN KEY(`customtrainer_id`) REFERENCES `trainers_customtrainer`(`id`) 
);

CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
	`id`	integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`group_id`	integer NOT NULL,
	`permission_id`	integer NOT NULL,
	FOREIGN KEY(`permission_id`) REFERENCES `auth_permission`(`id`) ,
	FOREIGN KEY(`group_id`) REFERENCES `auth_group`(`id`) 
);
INSERT INTO `clients_client` (`id`,`name`,`address`,`city`,`state`,`zipcode`,`email`,`acct_number`,`date`,`trainer_id`,`cell_phone`) VALUES (1,'John Garza','8738 Quest St','Omaha','NE','68122','jgarza@unomaha.edu','1','2020-02-13 03:19:28.305956',3,'4022154508'),
 (2,'Gary Bennet','3478 North 10th Street','Omaha','NE','68124','garyb@yahoo.com','00000','2020-02-14 02:35:41.511688',1,'4023990956'),
 (3,'Joseph Patil','7559 North 121st Street','Omaha','NE','68167','ipatil@outlook.com','00000','2020-02-16 02:04:26.611497',2,'4027391110'),
 (4,'Katherine McClusky','6782 Miles Street','Ames','IA','50010','katherinemc@gmail.com','00000','2020-02-16 06:41:19.716871',1,'5155543499'),
 (5,'T''Pol','5678','Vulcan St','San Fransico','12345','vulcanrule@startrek.com','00000','2020-02-16 06:42:42.848824',2,'4025555555'),
 (6,'John Garza','8738 Quest St','Omaha','NE','68122','jgarza@unomaha.edu','00000','2020-03-10 04:24:35.855373',1,'+14022154508');
INSERT INTO `clients_diary` (`id`,`duration`,`duration_units`,`reps`,`weight`,`weight_units`,`client_id`,`exercises_id`,`trainer_id`,`day`) VALUES (6,0,'min',10,25,'lbs',1,8,NULL,'2020-02-14'),
 (7,10,'min',10,10,'lbs',1,1,NULL,'2020-02-13'),
 (8,10,'min',9,10,'lbs',1,1,NULL,'2020-02-06'),
 (9,10,'min',10,10,'lbs',1,2,NULL,'2020-02-05'),
 (10,45,'min',0,0,'lbs',1,1,NULL,'2020-02-15'),
 (11,0,'min',25,135,'lbs',1,5,1,'2020-02-16'),
 (12,30,'min',0,0,'lbs',3,1,1,'2020-02-15'),
 (13,10,'min',50,10,'lbs',5,7,2,'2020-02-15'),
 (14,0,'min',25,210,'lbs',3,5,1,'2020-02-16'),
 (15,25,'min',0,0,'lbs',1,3,1,'2020-02-14'),
 (16,30,'min',25,115,'lbs',5,5,3,'2020-01-01'),
 (17,20,'min',20,10,'lbs',4,7,4,'2020-01-01'),
 (18,15,'min',20,10,'lbs',3,8,1,'2020-01-04'),
 (19,10,'min',10,115,'lbs',1,5,3,'2020-01-01'),
 (20,10,'min',0,0,'lbs',4,1,1,'2020-03-08'),
 (21,10,'min',0,0,'lbs',4,1,1,'2020-03-08'),
 (22,10,'min',0,0,'lbs',4,1,1,'2020-03-08'),
 (23,10,'min',0,0,'lbs',4,1,1,'2020-03-08');
INSERT INTO `clients_comment` (`id`,`comment`,`trainer_id`,`client_id`,`day`) VALUES (7,'Gary is a little slugish. We need to work on his endurance.',3,2,'2020-02-15'),
 (8,'This is what happened.',1,3,'2020-02-15'),
 (9,'T''Pol is marvelous. I might take her to nationals.',3,5,'2020-02-16'),
 (10,'Gary is a good worker.',1,2,'2020-02-14'),
 (11,'We did it we finished the app!',1,3,'2020-02-16'),
 (12,'Well we are almost finished. An app is never quite finishe.',1,2,'2020-02-16'),
 (13,'This Comment was made today.',1,2,'2020-03-09'),
 (14,'This Comment was made today.',1,2,'2020-03-09'),
 (15,'This Comment was made today.',1,2,'2020-03-09'),
 (16,'This Comment was made today.',1,2,'2020-03-09');
INSERT INTO `clients_exercises` (`id`,`exercise_category_category_id`,`name`) VALUES (1,1,'running'),
 (2,1,'walking'),
 (3,1,'bicycling'),
 (4,2,'dead lift'),
 (5,2,'bench press'),
 (6,2,'squat'),
 (7,3,'kettle bell swing'),
 (8,3,'one leg shoulder press');
INSERT INTO `clients_exercisecategory` (`id`,`category`) VALUES (1,'cardio'),
 (2,'strength'),
 (3,'balance');
INSERT INTO `django_session` (`session_key`,`session_data`,`expire_date`) VALUES ('tvr2wty7wfqqeu1bd47chzvrg47265qv','ZDQ4YzZjNTI0ZjEzZDBhZGRlNmQ0MDU0ZTllOTViYmJlZmE3NzQ4MTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZjlhOGVhZDFiOWRlZWI2YmU3YTY1NGEwYTA2Mjk0YTUzZDAyNjExIn0=','2020-02-27 03:24:05.451136'),
 ('84e2k4k4eapuzcp4jok044k0l2il58x4','ZDQ4YzZjNTI0ZjEzZDBhZGRlNmQ0MDU0ZTllOTViYmJlZmE3NzQ4MTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZjlhOGVhZDFiOWRlZWI2YmU3YTY1NGEwYTA2Mjk0YTUzZDAyNjExIn0=','2020-03-01 21:14:00.251648');
INSERT INTO `django_admin_log` (`id`,`action_time`,`object_id`,`object_repr`,`change_message`,`content_type_id`,`user_id`,`action_flag`) VALUES (1,'2020-02-13 03:19:28.362982','1','John Garza','[{`added`: {}}]',7,1,1),
 (2,'2020-02-13 03:21:30.539640','1','cardio','[{`added`: {}}]',9,1,1),
 (3,'2020-02-13 03:22:30.143438','2','strength','[{`added`: {}}]',9,1,1),
 (4,'2020-02-13 03:22:36.837248','3','balance','[{`added`: {}}]',9,1,1),
 (5,'2020-02-13 03:24:28.323902','1','running','[{`added`: {}}]',10,1,1),
 (6,'2020-02-13 03:24:43.365772','2','walking','[{`added`: {}}]',10,1,1),
 (7,'2020-02-13 03:25:14.159609','3','bicycling','[{`added`: {}}]',10,1,1),
 (8,'2020-02-13 03:25:28.369954','4','dead lift','[{`added`: {}}]',10,1,1),
 (9,'2020-02-13 03:25:36.918899','5','bench press','[{`added`: {}}]',10,1,1),
 (10,'2020-02-13 03:25:49.147165','6','squat','[{`added`: {}}]',10,1,1),
 (11,'2020-02-13 03:25:59.587420','7','kettle bell swing','[{`added`: {}}]',10,1,1),
 (12,'2020-02-13 03:26:58.239874','8','one leg shoulder press','[{`added`: {}}]',10,1,1),
 (13,'2020-02-13 03:40:45.176342','1','John Garza','[{`added`: {}}]',8,1,1),
 (14,'2020-02-13 03:41:17.602802','2','John Garza','[{`added`: {}}]',8,1,1),
 (15,'2020-02-13 03:41:40.336816','3','John Garza','[{`added`: {}}]',8,1,1),
 (16,'2020-02-13 03:42:22.830136','4','John Garza','[{`added`: {}}]',8,1,1),
 (17,'2020-02-13 03:49:53.157651','4','diary object (4)','[]',8,1,2),
 (18,'2020-02-13 03:50:05.658430','1','diary object (1)','[]',8,1,2),
 (19,'2020-02-13 03:52:58.384439','4','diary object (4)','',8,1,3),
 (20,'2020-02-13 03:52:58.750326','3','diary object (3)','',8,1,3),
 (21,'2020-02-13 03:52:58.950531','2','diary object (2)','',8,1,3),
 (22,'2020-02-13 03:52:59.159230','1','diary object (1)','',8,1,3),
 (23,'2020-02-13 03:53:08.234084','5','diary object (5)','[{`added`: {}}]',8,1,1),
 (24,'2020-02-13 03:53:14.116632','6','diary object (6)','[{`added`: {}}]',8,1,1),
 (25,'2020-02-13 03:56:56.574063','7','John Garza','[{`added`: {}}]',8,1,1),
 (26,'2020-02-13 04:59:45.884580','8','02/06/2020','[{`added`: {}}]',8,1,1),
 (27,'2020-02-13 05:01:11.873052','9','02/04/2020','[{`added`: {}}]',8,1,1),
 (28,'2020-02-14 02:35:41.573666','2','Gary Bennet','[{`added`: {}}]',7,1,1),
 (29,'2020-02-16 02:01:37.626463','2','rockyb','[{`added`: {}}]',6,1,1),
 (30,'2020-02-16 02:02:42.019581','2','rockyb','[{`changed`: {`fields`: [`first_name`, `last_name`, `email`, `user_permissions`]}}]',6,1,2),
 (31,'2020-02-16 02:03:02.368090','3','Creed','[{`added`: {}}]',6,1,1),
 (32,'2020-02-16 02:03:37.111734','3','Creed','[{`changed`: {`fields`: [`first_name`, `last_name`, `email`, `user_permissions`]}}]',6,1,2),
 (33,'2020-02-16 02:03:51.232239','1','John Garza','[{`changed`: {`fields`: [`author`]}}]',7,1,2),
 (34,'2020-02-16 02:04:26.639306','3','Joseph Patil','[{`added`: {}}]',7,1,1),
 (35,'2020-02-16 09:13:31.530568','6','Gary was a little slow but we are getting there.','',11,1,3),
 (36,'2020-02-16 09:13:31.769754','5','John was great.','',11,1,3),
 (37,'2020-02-16 09:13:31.996166','4','John worked hard today.','',11,1,3),
 (38,'2020-02-16 09:13:32.288138','3','John had a good day.','',11,1,3),
 (39,'2020-02-16 09:13:32.536181','2','John had a good day.','',11,1,3),
 (40,'2020-02-16 09:13:32.762429','1','John had a good day.','',11,1,3),
 (41,'2020-02-16 09:14:04.180173','7','Gary is a little slugish. We need to work on his endurance.','[{`added`: {}}]',11,1,1),
 (42,'2020-02-16 09:19:48.405737','9','T''Pol is marvelous. I might take her to nationals.','[{`added`: {}}]',11,1,1),
 (43,'2020-03-10 03:22:01.056446','1','instructor','[{`changed`: {`fields`: [`first_name`, `last_name`]}}]',6,1,2),
 (44,'2020-03-10 03:23:20.049046','1','instructor','[{`changed`: {`fields`: [`user_permissions`]}}]',6,1,2),
 (45,'2020-03-10 03:23:42.292746','18','Joseph Patil','[{`changed`: {`fields`: [`trainer`]}}]',8,1,2),
 (46,'2020-03-10 03:24:17.719630','18','Joseph Patil','[]',8,1,2);
INSERT INTO `trainers_customtrainer_user_permissions` (`id`,`customtrainer_id`,`permission_id`) VALUES (1,2,25),
 (2,2,26),
 (3,2,27),
 (4,2,28),
 (5,2,29),
 (6,2,30),
 (7,2,31),
 (8,2,32),
 (9,2,33),
 (10,2,34),
 (11,2,35),
 (12,2,36),
 (13,2,37),
 (14,2,38),
 (15,2,39),
 (16,2,40),
 (17,2,41),
 (18,2,42),
 (19,2,43),
 (20,2,44),
 (21,2,45),
 (22,2,46),
 (23,2,47),
 (24,2,48),
 (25,3,25),
 (26,3,26),
 (27,3,27),
 (28,3,28),
 (29,3,29),
 (30,3,30),
 (31,3,31),
 (32,3,32),
 (33,3,33),
 (34,3,34),
 (35,3,35),
 (36,3,36),
 (37,3,37),
 (38,3,38),
 (39,3,39),
 (40,3,40),
 (41,3,41),
 (42,3,42),
 (43,3,43),
 (44,3,44),
 (45,3,45),
 (46,3,46),
 (47,3,47),
 (48,3,48),
 (49,1,25),
 (50,1,26),
 (51,1,27),
 (52,1,28),
 (53,1,29),
 (54,1,30),
 (55,1,31),
 (56,1,32),
 (57,1,33),
 (58,1,34),
 (59,1,35),
 (60,1,36),
 (61,1,37),
 (62,1,38),
 (63,1,39),
 (64,1,40),
 (65,1,41),
 (66,1,42),
 (67,1,43),
 (68,1,44),
 (69,1,45),
 (70,1,46),
 (71,1,47),
 (72,1,48);
INSERT INTO `trainers_customtrainer` (`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`,`specialty`,`employee_cell_phone`) VALUES (1,'pbkdf2_sha256$150000$DscEKxzuaykH$UT2wp4xV40PaL6YLZbCpalHiJTQGAf1M6CfHNg+njBk=','2020-03-09 17:12:28',1,'instructor','George','Royce','groyce@unomaha.edu',1,1,'2020-02-13 02:33:55',' ',' '),
 (2,'pbkdf2_sha256$150000$5l8V0beTc8zM$hX5npFz2WodI5md2kf3YI+F/GpZVuDg9znhbrwBjpiU=','2020-02-16 06:41:44.068407',0,'rockyb','Rocky','Balboa','Champ1976@america.com',0,1,'2020-02-16 02:01:37',' ',' '),
 (3,'pbkdf2_sha256$150000$1lXlutdk6OZY$vJbn+01k1PQA7HdGyP08BdoUIkbgIELyAuU+5kY+hSE=','2020-02-16 06:20:36.643276',0,'Creed','Appallo','Creed','ibeatrocky@biggerchamp.com',0,1,'2020-02-16 02:03:02',' ',' '),
 (4,'pbkdf2_sha256$150000$lbtRmcuQ0FJ1$SmrESd8+ZFFRNJl13kFMpskIhuByHPk+SdebhKG30eA=','2020-02-16 06:44:56.123831',0,'angryjoe','Joe','Roberts','jrob@madeupemail.com',0,1,'2020-02-16 06:44:46.873421',' ','4566789');
INSERT INTO `auth_permission` (`id`,`content_type_id`,`codename`,`name`) VALUES (1,1,'add_logentry','Can add log entry'),
 (2,1,'change_logentry','Can change log entry'),
 (3,1,'delete_logentry','Can delete log entry'),
 (4,1,'view_logentry','Can view log entry'),
 (5,2,'add_permission','Can add permission'),
 (6,2,'change_permission','Can change permission'),
 (7,2,'delete_permission','Can delete permission'),
 (8,2,'view_permission','Can view permission'),
 (9,3,'add_group','Can add group'),
 (10,3,'change_group','Can change group'),
 (11,3,'delete_group','Can delete group'),
 (12,3,'view_group','Can view group'),
 (13,4,'add_contenttype','Can add content type'),
 (14,4,'change_contenttype','Can change content type'),
 (15,4,'delete_contenttype','Can delete content type'),
 (16,4,'view_contenttype','Can view content type'),
 (17,5,'add_session','Can add session'),
 (18,5,'change_session','Can change session'),
 (19,5,'delete_session','Can delete session'),
 (20,5,'view_session','Can view session'),
 (21,6,'add_customtrainer','Can add user'),
 (22,6,'change_customtrainer','Can change user'),
 (23,6,'delete_customtrainer','Can delete user'),
 (24,6,'view_customtrainer','Can view user'),
 (25,7,'add_client','Can add client'),
 (26,7,'change_client','Can change client'),
 (27,7,'delete_client','Can delete client'),
 (28,7,'view_client','Can view client'),
 (29,8,'add_diary','Can add diary'),
 (30,8,'change_diary','Can change diary'),
 (31,8,'delete_diary','Can delete diary'),
 (32,8,'view_diary','Can view diary'),
 (33,9,'add_exercise_category','Can add exercise_category'),
 (34,9,'change_exercise_category','Can change exercise_category'),
 (35,9,'delete_exercise_category','Can delete exercise_category'),
 (36,9,'view_exercise_category','Can view exercise_category'),
 (37,10,'add_exercises','Can add exercises'),
 (38,10,'change_exercises','Can change exercises'),
 (39,10,'delete_exercises','Can delete exercises'),
 (40,10,'view_exercises','Can view exercises'),
 (41,9,'add_exercisecategory','Can add exercise category'),
 (42,9,'change_exercisecategory','Can change exercise category'),
 (43,9,'delete_exercisecategory','Can delete exercise category'),
 (44,9,'view_exercisecategory','Can view exercise category'),
 (45,11,'add_comment','Can add comment'),
 (46,11,'change_comment','Can change comment'),
 (47,11,'delete_comment','Can delete comment'),
 (48,11,'view_comment','Can view comment');
INSERT INTO `django_content_type` (`id`,`app_label`,`model`) VALUES (1,'admin','logentry'),
 (2,'auth','permission'),
 (3,'auth','group'),
 (4,'contenttypes','contenttype'),
 (5,'sessions','session'),
 (6,'trainers','customtrainer'),
 (7,'clients','client'),
 (8,'clients','diary'),
 (9,'clients','exercisecategory'),
 (10,'clients','exercises'),
 (11,'clients','comment');
INSERT INTO `django_migrations` (`id`,`app`,`name`,`applied`) VALUES (1,'contenttypes','0001_initial','2020-02-13 02:32:15.761653'),
 (2,'contenttypes','0002_remove_content_type_name','2020-02-13 02:32:16.080855'),
 (3,'auth','0001_initial','2020-02-13 02:32:16.385407'),
 (4,'auth','0002_alter_permission_name_max_length','2020-02-13 02:32:16.620021'),
 (5,'auth','0003_alter_user_email_max_length','2020-02-13 02:32:16.833617'),
 (6,'auth','0004_alter_user_username_opts','2020-02-13 02:32:17.046447'),
 (7,'auth','0005_alter_user_last_login_null','2020-02-13 02:32:17.265387'),
 (8,'auth','0006_require_contenttypes_0002','2020-02-13 02:32:17.565579'),
 (9,'auth','0007_alter_validators_add_error_messages','2020-02-13 02:32:17.797597'),
 (10,'auth','0008_alter_user_username_max_length','2020-02-13 02:32:18.006120'),
 (11,'auth','0009_alter_user_last_name_max_length','2020-02-13 02:32:18.225484'),
 (12,'auth','0010_alter_group_name_max_length','2020-02-13 02:32:18.437274'),
 (13,'auth','0011_update_proxy_permissions','2020-02-13 02:32:18.642069'),
 (14,'trainers','0001_initial','2020-02-13 02:32:18.939260'),
 (15,'admin','0001_initial','2020-02-13 02:32:19.230551'),
 (16,'admin','0002_logentry_remove_auto_add','2020-02-13 02:32:19.455819'),
 (17,'admin','0003_logentry_add_action_flag_choices','2020-02-13 02:32:19.681134'),
 (18,'clients','0001_initial','2020-02-13 02:32:19.916510'),
 (19,'clients','0002_client_author','2020-02-13 02:32:20.188820'),
 (20,'sessions','0001_initial','2020-02-13 02:32:20.401980'),
 (21,'clients','0003_diary_exercise_category_exercises','2020-02-13 03:00:54.874414'),
 (22,'clients','0004_auto_20200212_2101','2020-02-13 03:01:40.813033'),
 (23,'clients','0005_auto_20200212_2117','2020-02-13 03:17:35.022296'),
 (24,'clients','0006_auto_20200212_2123','2020-02-13 03:23:41.116608'),
 (25,'clients','0007_auto_20200212_2156','2020-02-13 03:56:22.045968'),
 (26,'clients','0008_auto_20200212_2203','2020-02-13 04:03:42.417161'),
 (27,'clients','0009_auto_20200212_2209','2020-02-13 04:09:32.957922'),
 (28,'clients','0010_auto_20200212_2250','2020-02-13 04:50:28.640153'),
 (29,'clients','0011_auto_20200212_2251','2020-02-13 04:51:37.875562'),
 (30,'clients','0012_auto_20200213_2056','2020-02-14 02:56:30.209845'),
 (31,'clients','0013_comment','2020-02-16 01:04:59.678985'),
 (32,'clients','0002_auto_20200215_2147','2020-02-16 03:47:24.095150'),
 (33,'clients','0003_auto_20200215_2204','2020-02-16 04:04:30.596252'),
 (34,'clients','0004_auto_20200215_2230','2020-02-16 04:30:35.537091'),
 (35,'clients','0002_auto_20200216_0031','2020-02-16 06:31:53.356852'),
 (36,'clients','0003_auto_20200216_0034','2020-02-16 06:34:51.056048'),
 (37,'clients','0004_auto_20200216_0223','2020-02-16 08:23:56.858642'),
 (38,'clients','0005_auto_20200216_0226','2020-02-16 08:27:05.434515'),
 (39,'clients','0006_comment_day','2020-02-16 08:30:48.584032'),
 (40,'clients','0007_remove_client_notes','2020-02-16 09:22:20.960364'),
 (41,'clients','0008_auto_20200309_1431','2020-03-09 19:31:28.947102'),
 (42,'clients','0009_auto_20200309_1433','2020-03-09 19:33:44.299104'),
 (43,'clients','0010_auto_20200309_2312','2020-03-10 04:12:56.600697'),
 (44,'clients','0011_auto_20200309_2315','2020-03-10 04:15:48.276006'),
 (45,'clients','0012_auto_20200309_2323','2020-03-10 04:23:20.008038');
ALTER TABLE `clients_client` ADD INDEX `trainer_id` (`clients_client_trainer_id_42c717c6`) ;
ALTER TABLE `clients_diary` ADD INDEX `exercises_id` ( `clients_diary_exercises_id_06ae5406`);
ALTER TABLE `clients_diary` ADD INDEX `cleint_id` ( `clients_diary_client_id_8c9e9045`);
ALTER TABLE `clients_comment` ADD INDEX `client_id` (`clients_comment_client_id_6a84f792`);
ALTER TABLE `clients_comment` ADD INDEX `trainer_id` ( `clients_comment_trainer_id_addd1b09` );
ALTER TABLE `clients_exercises` ADD INDEX `exercise_category_category_id` (`clients_exercises_exercise_category_category_id_e45bcc2d`);
ALTER TABLE `django_session` ADD INDEX `expire_date` ( `django_session_expire_date_a5c62663` );
ALTER TABLE `django_admin_log` ADD INDEX `user_id` ( `django_admin_log_user_id_c564eba6` );
ALTER TABLE `django_admin_log` ADD INDEX `content_type_id` ( `django_admin_log_content_type_id_c4bce8eb` );
ALTER TABLE `trainers_customtrainer_user_permisions` ADD INDEX `permission_id` ( `trainers_customtrainer_user_permissions_permission_id_89be2a70`);
ALTER TABLE `trainers_customtrainer_user_permissions` ADD INDEX `customtrainer_id`(`trainers_customtrainer_user_permissions_customtrainer_id_29caef40`);
ALTER TABLE `trainers_customtrainer_user_permissions` ADD INDEX `permission_id`(`trainers_customtrainer_user_permissions_customtrainer_id_29caef40`);
ALTER TABLE `trainers_customtrainer_user_permissions` ADD INDEX `customtrainer_id` (`trainers_customtrainer_user_permissions_customtrainer_id_permission_id_c9323b3c_uniq`);
ALTER TABLE `trainers_customtrainer_groups` ADD INDEX `group_id` (`trainers_customtrainer_groups_group_id_ccbd0df1`);
ALTER TABLE `trainers_customtrainer_groups` ADD INDEX `customtrainer_id` (`trainers_customtrainer_groups_customtrainer_id_91059aa5`);
ALTER TABLE `trainers_customtrainer_groups` ADD INDEX `customtrainer_id` (`trainers_customtrainer_groups_customtrainer_id_group_id_19008314_uniq`);
ALTER TABLE `trainers_customtrainer_groups` ADD INDEX `group_id` (`trainers_customtrainer_groups_customtrainer_id_group_id_19008314_uniq`);
ALTER TABLE `auth_permission` ADD INDEX `content_type_id` (`auth_permission_content_type_id_2f476e4b`);
ALTER TABLE `auth_permission` ADD INDEX `content_type_id` (`auth_permission_content_type_id_codename_01ab375a_uniq`);
ALTER TABLE `auth_permission` ADD INDEX `codename` (`auth_permission_content_type_id_codename_01ab375a_uniq`);
ALTER TABLE `auth_group_permissions` ADD INDEX `permission_id` (`auth_group_permissions_permission_id_84c5c92e`);
ALTER TABLE `auth_group_permissions` ADD INDEX `group_id` (`auth_group_permissions_group_id_b120cbf9`);
ALTER TABLE `auth_group_permissions` ADD INDEX `group_id` ( `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` );
ALTER TABLE `auth_group_permissions` ADD INDEX `permission_id` ( `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` );
ALTER TABLE `django_content_type` ADD INDEX `app_label` (`django_content_type_app_label_model_76bd3d3b_uniq`);
ALTER TABLE `django_content_type` ADD INDEX `model` (`django_content_type_app_label_model_76bd3d3b_uniq`);
COMMIT;
