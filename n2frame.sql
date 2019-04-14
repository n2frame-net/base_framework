-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 25 Nov 2018 pada 17.38
-- Versi server: 10.1.37-MariaDB
-- Versi PHP: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `n2frame`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`nframene`@`localhost` PROCEDURE `sp_sys_file` (IN `WTRMRK` VARCHAR(255), IN `CTRL` VARCHAR(255), IN `WTD` VARCHAR(255), IN `SP` VARCHAR(255), IN `SESSIDUSER` VARCHAR(255), IN `SESSIDGROUP` VARCHAR(255), IN `CAD1` VARCHAR(255), IN `CAD2` VARCHAR(255), IN `CAD3` VARCHAR(255), IN `CAD4` VARCHAR(255), IN `P1` VARCHAR(255), IN `P2` VARCHAR(255), IN `P3` VARCHAR(255), IN `P4` VARCHAR(255), IN `P5` VARCHAR(255), IN `P6` VARCHAR(255), IN `P7` VARCHAR(255), IN `P8` VARCHAR(255), IN `P9` VARCHAR(255), IN `P10` VARCHAR(255))  BEGIN
IF (WTD = 's801cda9c0408e05b4c359ae69ad22758_1') THEN
	SELECT id_file, nameview, namecontroller, `namesp`, nameencrypt, `description`, isactivated , isbofo
	FROM sys_file
	WHERE id_file != 1
	AND id_file > 7
	ORDER BY isbofo desc, nameview
	;
ELSEIF (WTD = 'i801cda9c0408e05b4c359ae69ad22758_1') THEN
	INSERT INTO sys_file (nameview, namecontroller, `namesp`, `nameencrypt`, description, isactivated, createdby,isbofo)
	VALUES (P2,P3,P4,CONCAT(MD5(P2),'!',TO_BASE64(P4)),P5,P6,SESSIDUSER,P7)
	;
	SELECT id_file, nameview, namecontroller, `namesp`, nameencrypt, `description`, isactivated , isbofo
	FROM sys_file
	WHERE id_file != 1
	AND id_file > 7
	ORDER BY isbofo desc, nameview
	;
ELSEIF (WTD = 'u801cda9c0408e05b4c359ae69ad22758_1') THEN
	UPDATE sys_file SET
	nameview = P2
	, namecontroller = P3
	, `namesp` = P4
	, `nameencrypt` = CONCAT(md5(P2),'!',to_base64(P4))
	, description = P5
	, isactivated = P6
    , isbofo = P7
	, updatedby = SESSIDUSER
	, updateddate = NOW()
	WHERE id_file = P1
	;
	SELECT id_file, nameview, namecontroller, `namesp`, nameencrypt, `description`, isactivated , isbofo
	FROM sys_file
	WHERE id_file != 1
	AND id_file > 7
	ORDER BY isbofo desc, nameview
	;
ELSEIF (WTD = 'd801cda9c0408e05b4c359ae69ad22758_1') THEN
	DELETE FROM sys_file
	WHERE id_file = P1
	;
	SELECT id_file, nameview, namecontroller, `namesp`, nameencrypt, `description`, isactivated, isbofo
	FROM sys_file
	WHERE id_file != 1
	AND id_file > 7
	ORDER BY isbofo desc, nameview
	;
END IF;
END$$

CREATE DEFINER=`nframene`@`localhost` PROCEDURE `sp_sys_group` (IN `WTRMRK` VARCHAR(255), `CTRL` VARCHAR(255), `WTD` VARCHAR(255), `SP` VARCHAR(255), `SESSIDUSER` VARCHAR(255), IN `SESSIDGROUP` VARCHAR(255), `CAD1` VARCHAR(255), `CAD2` VARCHAR(255), `CAD3` VARCHAR(255), `CAD4` VARCHAR(255), IN `P1` VARCHAR(255), IN `P2` VARCHAR(255), IN `P3` VARCHAR(255), IN `P4` VARCHAR(255), IN `P5` VARCHAR(255), IN `P6` VARCHAR(255), IN `P7` VARCHAR(255), IN `P8` VARCHAR(255), IN `P9` VARCHAR(255), IN `P10` VARCHAR(255))  BEGIN

DECLARE cs VARCHAR(8000);
DECLARE queries VARCHAR(8000);
DECLARE COUNTS INT DEFAULT 0;
DECLARE i INT DEFAULT 0;

IF (WTD = 's801cda9c0408e05b4c359ae69ad22758_1') THEN
	SELECT id_group, namegroup, description
	FROM sys_group
	WHERE id_group != 1
	;
ELSEIF (WTD = 'i801cda9c0408e05b4c359ae69ad22758_1') THEN
	INSERT INTO sys_group (namegroup, description, createdby)
	VALUES (P2,P3,SESSIDUSER)
	;
	SELECT id_group, namegroup, description
	FROM sys_group
	WHERE id_group != 1
	;
ELSEIF (WTD = 'u801cda9c0408e05b4c359ae69ad22758_1') THEN
	UPDATE sys_group SET
	namegroup = P2
	, description = P3
	, updatedby = SESSIDUSER
	, updateddate = NOW()
	WHERE id_group = P1
	;
	SELECT id_group, namegroup, description
	FROM sys_group
	WHERE id_group != 1
	;
ELSEIF (WTD = 'd801cda9c0408e05b4c359ae69ad22758_1') THEN
	DELETE FROM sys_group
	WHERE id_group = P1
	;
	SELECT id_group, namegroup, description
	FROM sys_group
	WHERE id_group != 1
	;
	
ELSEIF (WTD = 's801cda9c0408e05b4c359ae69ad22758_2') THEN
	SELECT IFNULL(sgm.id_group, 1) id_group  , a.id_menu, b.namemenu AS menu
	, a.namemenu AS submenu, IFNULL(sgm.isactivated, 0) activegroupmenu, a.isactivated AS activemenu
    , a.level, b.id_menu AS id_menuparent
	FROM
	(
		SELECT sm.id_menu, sm.namemenu, sm.id_parentedto, sm.isactivated, sm.ordering
		FROM sys_menu sm
		LEFT JOIN sys_file sf
		ON sm.id_file = sf.id_file
		WHERE sm.id_menu != 1
		AND sm.level = 1
		ORDER BY sm.id_parentedto ASC, sm.level ASC
	) b
	, (
		SELECT sm.id_menu, sm.id_parentedto, sm.id_file, sm.namemenu, sm.level, sm.description
		, sf.nameview, sf.namecontroller, sf.namesp, sf.nameencrypt, sm.isactivated, sm.ordering
		FROM sys_menu sm
		LEFT JOIN sys_file sf
		ON sm.id_file = sf.id_file
		WHERE sm.id_menu != 1
		ORDER BY sm.id_parentedto ASC, sm.level ASC
	) a
	LEFT JOIN sys_groupmenu sgm
		ON sgm.id_menu = a.id_menu
		AND sgm.id_group = P1
		AND sgm.isactivated = 1
		AND a.isactivated = 1
	WHERE b.id_parentedto = a.id_parentedto
	AND (a.isactivated = 1 AND b.isactivated = 1)
	and a.id_menu > 6
	ORDER BY b.ordering, COALESCE(b.id_parentedto, a.id_parentedto), a.level, b.id_parentedto, a.ordering
	;

ELSEIF (WTD = 'u801cda9c0408e05b4c359ae69ad22758_2') THEN
	SET COUNTS = 0;
	SET @queries = CONCAT("\r\n\tUPDATE \r\n\t\t`sys_groupmenu` \r\n\tset \r\n\t\t`isactivated` = 2 \r\n\twhere\r\n\t\t`id_group` = " , P1 , "\r\n\t\tAND `isactivated` = 1\r\n\t;");
	PREPARE stmt FROM @queries;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
	SET cs = P2;
	WHILE LENGTH(cs) > 0 DO
		SET i = LOCATE(',', cs);
		IF (i = 0) THEN
			SET i = LENGTH(cs) + 1;
		END IF;
		SET @queries = CONCAT("\r\n\t\t\tUPDATE \r\n\t\t\t\t`sys_groupmenu` \r\n\t\t\tset \r\n\t\t\t\tisactivated = 1 , updatedby = ", SESSIDUSER ," \r\n\t\t\t\t, updateddate = NOW() ");
		SET @queries = CONCAT (@queries , " \r\n\t\t\tWHERE \t`id_group` = " , P1 , "\r\n\t\t\t\tAND `id_menu` = " , SUBSTRING(cs, 1, i - 1) , "\r\n\t\t\t\tAND `isactivated` = 2 \r\n\t\t\t;");
		PREPARE stmt FROM @queries;
		EXECUTE stmt;
		SET COUNTS = ROW_COUNT();
		DEALLOCATE PREPARE stmt;
		IF COUNTS = 0 THEN
			SET @queries = CONCAT("\r\n\t\t\tINSERT INTO sys_groupmenu (`id_group` , `id_menu` \r\n\t\t\t\t, `createdby`\r\n\t\t\t) \r\n\t\t\tvalues \r\n\t\t\t(" , P1 , " , " , SUBSTRING(cs, 1, i - 1) , " \r\n\t\t\t\t, ", SESSIDUSER ,"\r\n\t\t\t)\r\n\t\t\t");
			PREPARE stmt FROM @queries;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
		END IF;
		SET cs = SUBSTRING(cs, i + 1, LENGTH(cs));
	END WHILE;
	SET @queries = CONCAT("\r\n\tDELETE FROM\r\n\t\t`sys_groupmenu`\r\n\twhere\r\n\t\t`id_group` = " , P1 , " \r\n\t\tAND `isactivated` = 2\r\n\t;");
	PREPARE stmt FROM @queries;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
	SELECT id_group, namegroup, description
	FROM sys_group
	WHERE id_group != 1
	;	
	
END IF;
END$$

CREATE DEFINER=`nframene`@`localhost` PROCEDURE `sp_sys_login` (IN `WTRMRK` VARCHAR(255), IN `CTRL` VARCHAR(255), IN `WTD` VARCHAR(255), IN `SP` VARCHAR(255), IN `SESSIDUSER` VARCHAR(255), IN `SESSIDGROUP` VARCHAR(255), IN `CAD1` VARCHAR(255), IN `CAD2` VARCHAR(255), IN `CAD3` VARCHAR(255), IN `CAD4` VARCHAR(255), IN `P1` VARCHAR(255), IN `P2` VARCHAR(255), IN `P3` VARCHAR(255), IN `P4` VARCHAR(255), IN `P5` VARCHAR(255), IN `P6` VARCHAR(255), IN `P7` VARCHAR(255), IN `P8` VARCHAR(255), IN `P9` VARCHAR(255), IN `P10` VARCHAR(255))  BEGIN
IF (WTD = 's801cda9c0408e05b4c359ae69ad22758_1') THEN
	SELECT su.id_user, cm.id_member, sg.id_group
	, su.fullname, su.username, su.password, sg.namegroup
	, su.isactivated, su.description, cm.profileimage
	FROM sys_user su, app_member cm, sys_group sg
	WHERE su.id_user != 1
	AND su.id_member = cm.id_member
	AND su.id_group = sg.id_group
	AND su.username = P1
	AND su.password = md5(P2)
    AND isadmin = 1
	;
END IF;
END$$

CREATE DEFINER=`nframene`@`localhost` PROCEDURE `sp_sys_menu` (IN `WTRMRK` VARCHAR(255), IN `CTRL` VARCHAR(255), IN `WTD` VARCHAR(255), IN `SP` VARCHAR(255), IN `SESSIDUSER` VARCHAR(255), IN `SESSIDGROUP` VARCHAR(255), IN `CAD1` VARCHAR(255), IN `CAD2` VARCHAR(255), IN `CAD3` VARCHAR(255), IN `CAD4` VARCHAR(255), IN `P1` VARCHAR(255), IN `P2` VARCHAR(255), IN `P3` VARCHAR(255), IN `P4` VARCHAR(255), IN `P5` VARCHAR(255), IN `P6` VARCHAR(255), IN `P7` VARCHAR(255), IN `P8` VARCHAR(255), IN `P9` VARCHAR(255), IN `P10` VARCHAR(255))  BEGIN
declare MAXID int;
IF (WTD = 's801cda9c0408e05b4c359ae69ad22758_1') THEN
	SELECT b.id_menu AS id_menulv1, b.namemenu AS menulv1, a.id_menu AS id_menulv2, a.namemenu AS menulv2
	, a.id_file, a.level, a.description, a.nameview, a.namecontroller, a.namesp, a.nameencrypt, a.isactivated
	, a.ordering orderinglv2, b.ordering orderinglv1, a.isdashboard
	FROM
	(
		SELECT sm.id_menu, sm.id_parentedto, sm.id_file, sm.namemenu, sm.level, sm.description
		, sf.nameview, sf.namecontroller, sf.namesp, sf.nameencrypt, sm.isactivated, sm.ordering, sm.isdashboard
		FROM sys_menu sm
		LEFT JOIN sys_file sf
		ON sm.id_file = sf.id_file
		WHERE sm.id_menu != 1
	) a
	,
	(
		SELECT sm.id_menu, sm.namemenu, sm.id_parentedto, sm.isactivated, sm.ordering, sm.level, sm.isdashboard
		FROM sys_menu sm
		LEFT JOIN sys_file sf
		ON sm.id_file = sf.id_file
		WHERE sm.id_menu != 1
		AND sm.level = 1
	) b
	WHERE a.id_parentedto = b.id_parentedto
	AND a.id_menu > 6
	ORDER BY b.ordering, COALESCE(b.id_parentedto, a.id_parentedto), a.level, b.id_parentedto, a.ordering
	;
ELSEIF (WTD = 's801cda9c0408e05b4c359ae69ad22758_2') THEN
	SELECT sm.id_menu, sm.namemenu
	FROM sys_menu sm
	WHERE sm.id_menu != 1
	AND sm.level = 1
	and sm.isactivated = 1
	;
ELSEIF (WTD = 's801cda9c0408e05b4c359ae69ad22758_3') THEN
	SELECT sf.id_file, sf.nameview
	FROM sys_file sf
	WHERE sf.id_file != 1
	AND sf.isactivated = 1
    AND sf.isbofo = 'BO'
	;
ELSEIF (WTD = 'i801cda9c0408e05b4c359ae69ad22758_1') THEN
	INSERT INTO sys_menu (`level`, namemenu, id_file, description, id_parentedto, isactivated, ordering, isdashboard, createdby)
	VALUES (P2,P3,P4,P5,P6,P7,P8,P9,SESSIDUSER)
	;
	-- INI UNTUK HEADER MENU
    -- SUPAYA FIELD parentedto nya sama dengan id_menu
	if (P6 = 1) then
		SELECT MAX(id_menu) into MAXID FROM sys_menu;
		UPDATE sys_menu SET
		id_parentedto = MAXID
		WHERE id_menu = MAXID
		;
	end if;
	SELECT b.id_menu AS id_menulv1, b.namemenu AS menulv1, a.id_menu AS id_menulv2, a.namemenu AS menulv2
	, a.id_file, a.level, a.description, a.nameview, a.namecontroller, a.namesp, a.nameencrypt, a.isactivated
	, a.ordering orderinglv2, b.ordering orderinglv1, a.isdashboard
	FROM
	(
		SELECT sm.id_menu, sm.id_parentedto, sm.id_file, sm.namemenu, sm.level, sm.description
		, sf.nameview, sf.namecontroller, sf.namesp, sf.nameencrypt, sm.isactivated, sm.ordering, sm.isdashboard
		FROM sys_menu sm
		LEFT JOIN sys_file sf
		ON sm.id_file = sf.id_file
		WHERE sm.id_menu != 1
	) a
	,
	(
		SELECT sm.id_menu, sm.namemenu, sm.id_parentedto, sm.isactivated, sm.ordering, sm.level, sm.isdashboard
		FROM sys_menu sm
		LEFT JOIN sys_file sf
		ON sm.id_file = sf.id_file
		WHERE sm.id_menu != 1
		AND sm.level = 1
	) b
	WHERE a.id_parentedto = b.id_parentedto
	AND a.id_menu > 6
	ORDER BY b.ordering, COALESCE(b.id_parentedto, a.id_parentedto), a.level, b.id_parentedto, a.ordering
	;
ELSEIF (WTD = 'u801cda9c0408e05b4c359ae69ad22758_1') THEN
	IF (P6 = 1) THEN
		UPDATE sys_menu SET
		`level` = P2
		, `namemenu` = P3
		, id_file = P4
		, description = P5
		, isactivated = P7
		, ordering = P8
        , isdashboard = P9
		, updatedby = SESSIDUSER
		, updateddate = NOW()
		WHERE id_menu = P1
		;
	ELSE
		UPDATE sys_menu SET
		`level` = P2
		, `namemenu` = P3
		, id_file = P4
		, description = P5
		, id_parentedto = P6
		, isactivated = P7
		, ordering = P8
        , isdashboard = P9
		, updatedby = SESSIDUSER
		, updateddate = NOW()
		WHERE id_menu = P1
		;
	END IF;
	SELECT b.id_menu AS id_menulv1, b.namemenu AS menulv1, a.id_menu AS id_menulv2, a.namemenu AS menulv2
	, a.id_file, a.level, a.description, a.nameview, a.namecontroller, a.namesp, a.nameencrypt, a.isactivated
	, a.ordering orderinglv2, b.ordering orderinglv1, a.isdashboard
	FROM
	(
		SELECT sm.id_menu, sm.id_parentedto, sm.id_file, sm.namemenu, sm.level, sm.description
		, sf.nameview, sf.namecontroller, sf.namesp, sf.nameencrypt, sm.isactivated, sm.ordering, sm.isdashboard
		FROM sys_menu sm
		LEFT JOIN sys_file sf
		ON sm.id_file = sf.id_file
		WHERE sm.id_menu != 1
	) a
	,
	(
		SELECT sm.id_menu, sm.namemenu, sm.id_parentedto, sm.isactivated, sm.ordering, sm.level, sm.isdashboard
		FROM sys_menu sm
		LEFT JOIN sys_file sf
		ON sm.id_file = sf.id_file
		WHERE sm.id_menu != 1
		AND sm.level = 1
	) b
	WHERE a.id_parentedto = b.id_parentedto
	AND a.id_menu > 6
	ORDER BY b.ordering, COALESCE(b.id_parentedto, a.id_parentedto), a.level, b.id_parentedto, a.ordering
	;
ELSEIF (WTD = 'd801cda9c0408e05b4c359ae69ad22758_1') THEN
	DELETE FROM sys_menu
	WHERE id_menu = P1
	;
    -- JIKA HEADER MENU YANG DI HAPUS MAKA
    -- SELURUH SUB MENU AKAN TERHAPUS
    IF (P2 = 1) THEN
    	DELETE FROM sys_menu
        WHERE id_parentedto = P1
        ;
    END IF;
	SELECT b.id_menu AS id_menulv1, b.namemenu AS menulv1, a.id_menu AS id_menulv2, a.namemenu AS menulv2
	, a.id_file, a.level, a.description, a.nameview, a.namecontroller, a.namesp, a.nameencrypt, a.isactivated
	, a.ordering orderinglv2, b.ordering orderinglv1, a.isdashboard
	FROM
	(
		SELECT sm.id_menu, sm.id_parentedto, sm.id_file, sm.namemenu, sm.level, sm.description
		, sf.nameview, sf.namecontroller, sf.namesp, sf.nameencrypt, sm.isactivated, sm.ordering, sm.isdashboard
		FROM sys_menu sm
		LEFT JOIN sys_file sf
		ON sm.id_file = sf.id_file
		WHERE sm.id_menu != 1
	) a
	,
	(
		SELECT sm.id_menu, sm.namemenu, sm.id_parentedto, sm.isactivated, sm.ordering, sm.level, sm.isdashboard
		FROM sys_menu sm
		LEFT JOIN sys_file sf
		ON sm.id_file = sf.id_file
		WHERE sm.id_menu != 1
		AND sm.level = 1
	) b
	WHERE a.id_parentedto = b.id_parentedto
	AND a.id_menu > 6
	ORDER BY b.ordering, COALESCE(b.id_parentedto, a.id_parentedto), a.level, b.id_parentedto, a.ordering
	;
END IF;
END$$

CREATE DEFINER=`nframene`@`localhost` PROCEDURE `sp_sys_menubar` (IN `WTRMRK` VARCHAR(255), IN `CTRL` VARCHAR(255), IN `WTD` VARCHAR(255), IN `SP` VARCHAR(255), IN `SESSIDUSER` VARCHAR(255), IN `SESSIDGROUP` VARCHAR(255), IN `CAD1` VARCHAR(255), IN `CAD2` VARCHAR(255), IN `CAD3` VARCHAR(255), IN `CAD4` VARCHAR(255), IN `P1` VARCHAR(255), IN `P2` VARCHAR(255), IN `P3` VARCHAR(255), IN `P4` VARCHAR(255), IN `P5` VARCHAR(255), IN `P6` VARCHAR(255), IN `P7` VARCHAR(255), IN `P8` VARCHAR(255), IN `P9` VARCHAR(255), IN `P10` VARCHAR(255))  BEGIN
IF (WTD = 's801cda9c0408e05b4c359ae69ad22758_menubar') THEN	
	SELECT b.id_menu AS id_menulv1, b.namemenu AS menulv1, a.id_menu AS id_menulv2, a.namemenu AS menulv2
	, a.id_file, a.level, a.description, a.nameview, a.namecontroller, a.namesp, a.nameencrypt, b.isactivated
	, IFNULL(sgm.id_group, 1) id_group, sgm.isactivated AS activegroupmenu, a.isdashboard
	FROM
	(
		SELECT sm.id_menu, sm.namemenu, sm.id_parentedto, sm.isactivated, sm.ordering, sm.isdashboard
		FROM sys_menu sm
		LEFT JOIN sys_file sf
		ON sm.id_file = sf.id_file
		WHERE sm.id_menu != 1
		AND sm.level = 1
		ORDER BY sm.id_parentedto ASC, sm.level ASC
	) b
	, (
		SELECT sm.id_menu, sm.id_parentedto, sm.id_file, sm.namemenu, sm.level, sm.description
		, sf.nameview, sf.namecontroller, sf.namesp, sf.nameencrypt, sm.isactivated, sm.ordering, sm.isdashboard
		FROM sys_menu sm
		LEFT JOIN sys_file sf
		ON sm.id_file = sf.id_file
		WHERE sm.id_menu != 1
		ORDER BY sm.id_parentedto ASC, sm.level ASC
	) a
	LEFT JOIN sys_groupmenu sgm
		ON sgm.id_menu = a.id_menu
		AND sgm.id_group = SESSIDGROUP
		AND sgm.isactivated = 1
		AND a.isactivated = 1
	WHERE b.id_parentedto = a.id_parentedto
	AND (a.isactivated = 1 AND b.isactivated = 1)
	AND sgm.isactivated  IS NOT NULL
	AND (a.namemenu LIKE CONCAT('%',P1,'%') OR P1 = '-9')
	ORDER BY b.ordering, COALESCE(b.id_parentedto, a.id_parentedto), a.level, b.id_parentedto, a.ordering
	;
    
elseIF (WTD = 's801cda9c0408e05b4c359ae69ad22758_routes') THEN	
	SELECT b.id_menu AS id_menulv1, b.namemenu AS menulv1, a.id_menu AS id_menulv2, a.namemenu AS menulv2
	, a.id_file, a.level, a.description, a.nameview, a.namecontroller, a.namesp, a.nameencrypt, b.isactivated
	, IFNULL(sgm.id_group, 1) id_group, sgm.isactivated AS activegroupmenu, a.isdashboard
	FROM
	(
		SELECT sm.id_menu, sm.namemenu, sm.id_parentedto, sm.isactivated, sm.isdashboard
		FROM sys_menu sm
		LEFT JOIN sys_file sf
		ON sm.id_file = sf.id_file
		WHERE sm.id_menu != 1
		AND sm.level = 1
		ORDER BY sm.id_parentedto ASC, sm.level ASC
	) b
	, (
		SELECT sm.id_menu, sm.id_parentedto, sm.id_file, sm.namemenu, sm.level, sm.description
		, sf.nameview, sf.namecontroller, sf.namesp, sf.nameencrypt, sm.isactivated, sm.isdashboard
		FROM sys_menu sm
		LEFT JOIN sys_file sf
		ON sm.id_file = sf.id_file
		WHERE sm.id_menu != 1
		ORDER BY sm.id_parentedto ASC, sm.level ASC
	) a
	LEFT JOIN sys_groupmenu sgm
		ON sgm.id_menu = a.id_menu
		AND sgm.id_group = SESSIDGROUP
		AND sgm.isactivated = 1
		AND a.isactivated = 1
	WHERE b.id_parentedto = a.id_parentedto
	AND (a.isactivated = 1 AND b.isactivated = 1)
	AND sgm.isactivated  IS NOT NULL
	ORDER BY b.id_parentedto ASC, a.level ASC
	;
END IF;
END$$

CREATE DEFINER=`nframene`@`localhost` PROCEDURE `sp_sys_user` (IN `WTRMRK` VARCHAR(255), IN `CTRL` VARCHAR(255), IN `WTD` VARCHAR(255), IN `SP` VARCHAR(255), IN `SESSIDUSER` VARCHAR(255), IN `SESSIDGROUP` VARCHAR(255), IN `CAD1` VARCHAR(255), IN `CAD2` VARCHAR(255), IN `CAD3` VARCHAR(255), IN `CAD4` VARCHAR(255), IN `P1` VARCHAR(255), IN `P2` VARCHAR(255), IN `P3` VARCHAR(255), IN `P4` VARCHAR(255), IN `P5` VARCHAR(255), IN `P6` VARCHAR(255), IN `P7` VARCHAR(255), IN `P8` VARCHAR(255), IN `P9` VARCHAR(255), IN `P10` VARCHAR(255))  BEGIN
IF (WTD = 's801cda9c0408e05b4c359ae69ad22758_1') THEN
	SELECT su.id_user, cm.id_member, sg.id_group
	, su.fullname, su.username, sg.namegroup
	, su.isactivated, su.description, cm.profileimage
	FROM sys_user su, app_member cm, sys_group sg
	WHERE su.id_user != 1
	AND su.id_member = cm.id_member
	AND su.id_group = sg.id_group
	;
ELSEIF (WTD = 's801cda9c0408e05b4c359ae69ad22758_2') THEN
	SELECT cm.id_member, sg.id_group, cm.namemember, sg.namegroup
	FROM app_member cm, sys_group sg
	WHERE id_member != 1
	and cm.id_group = sg.id_group
	AND (cm.namemember LIKE CONCAT('%',P1,'%') OR P1 = '-9')
	-- AND (sg.namegroup LIKE CONCAT('%',P1,'%') OR P1 = '-9')
	;
    -- SELECT GROUP
ELSEIF (WTD = 's801cda9c0408e05b4c359ae69ad22758_3') THEN
	SELECT sg.id_group, sg.namegroup
	FROM sys_group sg
	WHERE sg.id_group != 1
	AND (sg.namegroup LIKE CONCAT('%',P1,'%') OR P1 = '-9')
	;
ELSEIF (WTD = 'i801cda9c0408e05b4c359ae69ad22758_1') THEN
	INSERT INTO sys_user 
	(id_member, fullname, id_group, username, `password`, realpassword
	, description, createdby)
	VALUES (P2,P3,P4,P5,md5(P6),P7
	,P8,SESSIDUSER)
	;
	SELECT su.id_user, cm.id_member, sg.id_group
	, su.fullname, su.username, sg.namegroup
	, su.isactivated, su.description, cm.profileimage
	FROM sys_user su, app_member cm, sys_group sg
	WHERE su.id_user != 1
	AND su.id_member = cm.id_member
	AND su.id_group = sg.id_group
	;
ELSEIF (WTD = 'u801cda9c0408e05b4c359ae69ad22758_1') THEN
	UPDATE sys_user SET
	id_member = P2
	, fullname = P3
	, id_group = P4
	, username = P5
	, `password` = md5(P6)
	, realpassword = P7
	, description = P8
	, updatedby = SESSIDUSER
	, updateddate = now()
	WHERE id_user = P1
	;
	SELECT su.id_user, cm.id_member, sg.id_group
	, su.fullname, su.username, sg.namegroup
	, su.isactivated, su.description, cm.profileimage
	FROM sys_user su, app_member cm, sys_group sg
	WHERE su.id_user != 1
	AND su.id_member = cm.id_member
	AND su.id_group = sg.id_group
	;
ELSEIF (WTD = 'd801cda9c0408e05b4c359ae69ad22758_1') THEN
	DELETE FROM sys_user
	WHERE id_user = P1
	;
	SELECT su.id_user, cm.id_member, sg.id_group
	, su.fullname, su.username, sg.namegroup
	, su.isactivated, su.description, cm.profileimage
	FROM sys_user su, app_member cm, sys_group sg
	WHERE su.id_user != 1
	AND su.id_member = cm.id_member
	AND su.id_group = sg.id_group
	;
END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `app_member`
--

CREATE TABLE `app_member` (
  `id_member` int(100) NOT NULL,
  `id_user` int(11) NOT NULL DEFAULT '0',
  `fullname` varchar(100) DEFAULT NULL,
  `phonenumber` varchar(15) NOT NULL,
  `companyname` text NOT NULL,
  `streetaddress` text NOT NULL,
  `district` text NOT NULL,
  `city` text NOT NULL,
  `state` text NOT NULL,
  `postcode` varchar(8) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `profileimage` varchar(200) DEFAULT NULL,
  `createdby` int(100) DEFAULT NULL COMMENT 'id_user',
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedby` int(100) DEFAULT NULL COMMENT 'id_user',
  `updateddate` timestamp NULL DEFAULT NULL COMMENT 'query update ada di SP',
  `isused` tinyint(1) DEFAULT '1',
  `isactivated` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `app_member`
--

INSERT INTO `app_member` (`id_member`, `id_user`, `fullname`, `phonenumber`, `companyname`, `streetaddress`, `district`, `city`, `state`, `postcode`, `description`, `profileimage`, `createdby`, `createddate`, `updatedby`, `updateddate`, `isused`, `isactivated`) VALUES
(1, 0, 'UNDEFINED', 'UNDEFINED', 'UNDEFINED', 'UNDEFINED', 'UNDEFINED', 'UNDEFINED', 'UNDEFINED', 'UNDEFI', 'UNDEFINED', 'UNDEFINED', 0, '2018-07-27 03:55:15', NULL, NULL, 0, 0),
(2, 0, 'User Test', '08xxxxxxxxxx', 'n2frame', 'USER TEST', 'USER TEST', 'USER TEST', '', 'USER TES', 'USER TEST', '54982309201858.jpg', 4, '2018-09-22 14:30:53', 4, '2018-09-23 05:28:52', 1, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sys_file`
--

CREATE TABLE `sys_file` (
  `id_file` int(10) NOT NULL,
  `nameview` varchar(50) DEFAULT NULL,
  `namecontroller` varchar(50) DEFAULT NULL,
  `namesp` varchar(50) DEFAULT NULL,
  `nameencrypt` varchar(200) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `isbofo` varchar(2) NOT NULL COMMENT 'BO = Back Office, FO = Front Office',
  `createdby` int(100) DEFAULT NULL COMMENT 'id_user',
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedby` int(100) DEFAULT NULL COMMENT 'id_user',
  `updateddate` timestamp NULL DEFAULT NULL COMMENT 'query update ada di SP',
  `isused` tinyint(1) DEFAULT '1',
  `isactivated` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `sys_file`
--

INSERT INTO `sys_file` (`id_file`, `nameview`, `namecontroller`, `namesp`, `nameencrypt`, `description`, `isbofo`, `createdby`, `createddate`, `updatedby`, `updateddate`, `isused`, `isactivated`) VALUES
(1, 'UNDEFINED', 'UNDEFINED', 'UNDEFINED', 'UNDEFINED', 'UNDEFINED', 'UN', NULL, '2018-07-23 11:50:20', NULL, NULL, 1, 1),
(2, 'view_sys_user.html', 'controller_sys_user.nfh.php', 'sp_sys_user', 'b821369047d8bbaafaac94d4b781b238!c3Bfc3lzX3VzZXI=', 'buat olah akun user', 'BO', NULL, '2018-07-23 12:03:33', 3, '2018-07-29 03:14:21', 1, 1),
(3, 'view_sys_file.html', 'controller_sys_file.nfh.php', 'sp_sys_file', '5b364eec44f54d8e5330307a2dfd2508!c3Bfc3lzX2ZpbGU=', 'untuk olah file baru', 'BO', 3, '2018-07-23 13:15:00', 3, '2018-07-23 15:24:53', 1, 1),
(4, 'view_sys_menu.html', 'controller_sys_menu.nfh.php', 'sp_sys_menu', 'f1cf684924a4de649fffddbc1ce51ee6!c3Bfc3lzX21lbnU=', 'untuk config menu', 'BO', 3, '2018-07-23 13:16:31', 3, '2018-07-23 15:24:59', 1, 1),
(5, 'view_sys_menubar.html', 'controller_sys_menubar.nfh.php', 'sp_sys_menubar', '2663da4add7faeda9d690079bd6167ff!c3Bfc3lzX21lbnViYXI=', 'UNTUK NEMAPILKAN MENU PADA SIDEBAR', 'BO', 3, '2018-07-25 06:16:02', NULL, NULL, 1, 1),
(6, 'view_sys_group.html', 'controller_sys_group.nfh.php', 'sp_sys_group', '87ddffe90fed1d8a76913673a20cb9dd!c3Bfc3lzX2dyb3Vw', 'LOGIN SEBAGAI SIAPA', 'BO', 3, '2018-07-27 00:54:29', NULL, NULL, 1, 1),
(7, 'view_dashboard.html', 'controller_dashboard.nfh.php', 'sp_dashboard', 'c2e275d3fb6fc1b8fa54cd1472cb21ac!c3BfZGFzaGJvYXJk', 'dashboard', 'BO', 2, '2018-07-29 10:00:12', 2, '2018-07-29 10:02:39', 1, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sys_group`
--

CREATE TABLE `sys_group` (
  `id_group` int(100) NOT NULL,
  `namegroup` varchar(100) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `createdby` int(100) DEFAULT NULL COMMENT 'id_user',
  `createddate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedby` int(100) DEFAULT NULL COMMENT 'id_user',
  `updateddate` timestamp NULL DEFAULT NULL COMMENT 'query update ada di SP',
  `isused` tinyint(1) DEFAULT '1',
  `isactivated` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `sys_group`
--

INSERT INTO `sys_group` (`id_group`, `namegroup`, `description`, `createdby`, `createddate`, `updatedby`, `updateddate`, `isused`, `isactivated`) VALUES
(1, 'UNDEFINED', 'UNDEFINED', NULL, '2018-07-23 08:52:07', NULL, NULL, 1, 1),
(2, 'PROGRAMMER', 'UNTUK DEV APLIKASI', 3, '2018-10-10 06:14:38', NULL, NULL, 1, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sys_groupmenu`
--

CREATE TABLE `sys_groupmenu` (
  `id_group` int(50) DEFAULT NULL,
  `id_menu` int(50) DEFAULT NULL,
  `createdby` int(100) DEFAULT NULL COMMENT 'id_user',
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedby` int(100) DEFAULT NULL COMMENT 'id_user',
  `updateddate` timestamp NULL DEFAULT NULL COMMENT 'query update ada di SP',
  `isused` tinyint(1) DEFAULT '1',
  `isactivated` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `sys_groupmenu`
--

INSERT INTO `sys_groupmenu` (`id_group`, `id_menu`, `createdby`, `createddate`, `updatedby`, `updateddate`, `isused`, `isactivated`) VALUES
(2, 2, 2, '2018-10-09 09:18:14', NULL, NULL, 1, 1),
(2, 3, 2, '2018-10-09 09:18:14', NULL, NULL, 1, 1),
(2, 4, 2, '2018-10-09 09:18:14', NULL, NULL, 1, 1),
(2, 5, 2, '2018-11-23 16:26:42', NULL, NULL, 1, 1),
(2, 6, 2, '2018-11-23 16:26:42', NULL, NULL, 1, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sys_menu`
--

CREATE TABLE `sys_menu` (
  `id_menu` int(10) NOT NULL,
  `id_parentedto` int(10) DEFAULT NULL COMMENT 'jika level 1 maka, menggunakan ID nya sendiri, jika level 2, maka mengikuti ID level 1 nya',
  `id_file` int(10) DEFAULT '1' COMMENT 'jika 1 maka level 1 join table sys_file',
  `namemenu` varchar(100) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `level` tinyint(1) DEFAULT NULL,
  `ordering` int(3) DEFAULT NULL,
  `isdashboard` tinyint(1) NOT NULL DEFAULT '0',
  `createdby` int(100) DEFAULT NULL COMMENT 'id_user',
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedby` int(100) DEFAULT NULL COMMENT 'id_user',
  `updateddate` timestamp NULL DEFAULT NULL COMMENT 'query update ada di SP',
  `isused` tinyint(1) DEFAULT '1',
  `isactivated` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `sys_menu`
--

INSERT INTO `sys_menu` (`id_menu`, `id_parentedto`, `id_file`, `namemenu`, `description`, `level`, `ordering`, `isdashboard`, `createdby`, `createddate`, `updatedby`, `updateddate`, `isused`, `isactivated`) VALUES
(1, 0, 0, 'UNDEFINED', 'UNDEFINED', 0, 2, 0, 0, '0000-00-00 00:00:00', NULL, NULL, 0, 0),
(2, 2, 1, 'SYSTEM', 'HEADER', 1, 999, 0, 3, '2018-07-25 06:43:04', 2, '2018-11-24 05:45:20', 1, 1),
(3, 2, 3, 'SYS FILE', 'OLAH FILE', 2, 1, 0, 3, '2018-07-25 06:43:33', 3, '2018-08-14 06:46:09', 1, 1),
(4, 2, 4, 'SYS MENU', 'KONFIG MENU', 2, 2, 0, 3, '2018-07-25 16:51:59', 3, '2018-08-13 04:33:44', 1, 1),
(5, 2, 6, 'SYS GROUP', 'OLAH DATA GROUP', 2, 4, 0, 3, '2018-07-27 01:00:37', 2, '2018-11-25 16:04:11', 1, 1),
(6, 2, 2, 'SYS USER', 'OLAH DATA USER', 2, 3, 0, 3, '2018-07-27 01:09:25', 3, '2018-08-13 04:34:26', 1, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sys_user`
--

CREATE TABLE `sys_user` (
  `id_user` int(50) NOT NULL,
  `id_member` int(11) NOT NULL DEFAULT '0' COMMENT 'id_user disini hanya digunakan di BO',
  `id_group` int(10) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `realpassword` varchar(100) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `isforgetpassword` tinyint(1) DEFAULT '0' COMMENT '1 = lupa password, 0 = tidak lupa password',
  `isadmin` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 = register ADMIN (PENJUAL), 0 = register USER (PEMBELI)',
  `createdby` int(100) DEFAULT NULL COMMENT 'id_user',
  `createddate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedby` int(100) DEFAULT NULL COMMENT 'id_user',
  `updateddate` timestamp NULL DEFAULT NULL COMMENT 'query update ada di SP',
  `isused` tinyint(1) DEFAULT '1',
  `isactivated` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `sys_user`
--

INSERT INTO `sys_user` (`id_user`, `id_member`, `id_group`, `email`, `fullname`, `username`, `password`, `realpassword`, `description`, `isforgetpassword`, `isadmin`, `createdby`, `createddate`, `updatedby`, `updateddate`, `isused`, `isactivated`) VALUES
(1, 1, 1, '', 'UNDEFINED', 'UNDEFINED', 'UNDEFINED', '', 'UNDEFINED', 0, 1, 1, '2018-02-25 23:29:47', 1, NULL, 1, 1),
(2, 1, 2, '', 'SYSTEM', 'sys', '36bcbb801f5052739af8220c6ea51434', 'sys', 'sys', 0, 1, 2, '2018-07-29 07:32:48', 2, '2018-10-14 16:04:02', 1, 1);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `app_member`
--
ALTER TABLE `app_member`
  ADD PRIMARY KEY (`id_member`);

--
-- Indeks untuk tabel `sys_file`
--
ALTER TABLE `sys_file`
  ADD PRIMARY KEY (`id_file`);

--
-- Indeks untuk tabel `sys_group`
--
ALTER TABLE `sys_group`
  ADD PRIMARY KEY (`id_group`);

--
-- Indeks untuk tabel `sys_menu`
--
ALTER TABLE `sys_menu`
  ADD PRIMARY KEY (`id_menu`);

--
-- Indeks untuk tabel `sys_user`
--
ALTER TABLE `sys_user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `app_member`
--
ALTER TABLE `app_member`
  MODIFY `id_member` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `sys_file`
--
ALTER TABLE `sys_file`
  MODIFY `id_file` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `sys_group`
--
ALTER TABLE `sys_group`
  MODIFY `id_group` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `sys_menu`
--
ALTER TABLE `sys_menu`
  MODIFY `id_menu` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `sys_user`
--
ALTER TABLE `sys_user`
  MODIFY `id_user` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
