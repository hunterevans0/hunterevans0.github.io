----------------------------  mod log  -------------------------------

--	created by:					Hunter Evans
--	date created:				02/13/2024
--	last modified by:			Hunter Evans
--	date modified:				03/01/2024
--	version:					v02

--	modification description:
--		v01:
--				v1.01: created a database named 'disk_inventoryHE'
--				v1.02: created tables 9 tables
--				v1.03: created a user named 'diskUserHE'
--				v1.04: added 'diskUserHE' to a role named 'db_datareader'
--		v02:
--					b(
--				v2.01: changed password to match example
--				v2.02: changed table order to match example and removed unnecessary if statements
--				v2.03: drop database, instead of doing nothing if database exists
--				v2.04: refactored primary key and foreign key assignments
--				v2.05: refactored and moved code for creating user
--				v2.06: ensured disk and artist are unique in disk_has_artist table
--					)b
--				v2.07: Added all sample data to tables
--				v2.08: Added a query to select unreturned disks
--				v2.09: Added a "sleeping session killer" so the database can be dropped, even if a sleeping session exists.

----------------------------------------------------------------------





USE master;

-------------------- v2.09 --------------------

-- I was having problems with sleeping sessions. 
-- I asked my dad to help me. He works with SQL Server at his job. He helped me write this code. 
-- I had him explain to me everything done in this section. The main thing I had to learn was how to kill sleeping sessions. 
-- The rest is just how we killed them. I don't know why some sessions I start linger as sleeping sessions. 
-- I think that the fact that I have sleeping sessions is the problem, but this is our convoluted solution:
DECLARE @session_killer TABLE (session_id int) -- creates a table variable
INSERT INTO @session_killer
SELECT session_id FROM sys.dm_exec_sessions WHERE database_id = DB_ID('disk_inventoryHE') -- takes session_id from sys.dm_exec_sessions, and inserts it into the table

DECLARE @current_session int -- creates an int variable
WHILE EXISTS (SELECT 1 from @session_killer) -- @session_killer only exists while there is data in it, so when all sleeping sessions are killed, the while statement breaks
BEGIN
	SET @current_session = (SELECT TOP 1 session_id FROM @session_killer); -- selects first row from colomn session_id
	DECLARE @kill_query NVARCHAR(100); -- creates a string variable that can hold up to 100 characters
	SET @kill_query = 'KILL ' + CAST(@current_session AS NVARCHAR(10)); -- creates a variable with the string literal 'KILL {session_id}'
	BEGIN TRY
	EXEC sp_executesql @kill_query; -- executes the string held in @kill_query as if it was writen here
	END TRY
	BEGIN CATCH -- does nothing if there is a running session, as opposed to a sleeping session. If the session is running, the statement 'USE maser' will kill it because this is the only the query that should be making it run actively
	END CATCH
	DELETE FROM @session_killer WHERE session_id = @current_session -- removes the session_id from @session_killer that was killed
END


-------------------- v2.03 ------------
DROP DATABASE IF EXISTS disk_inventoryHE;
-------------------- v1.01 --------------------
CREATE DATABASE disk_inventoryHE
GO

-------------------- v1.03 --------------------

USE disk_inventoryHE;
GO
-------------------- v2.05 ---------------------
IF SUSER_ID ('diskUserHE') IS NULL
------------ v2.01 ---------------
	CREATE LOGIN diskUserHE 
	WITH PASSWORD = 'Pa$$w0rd',
	DEFAULT_DATABASE = disk_inventoryHE;

------------------- v1.04 --------------------
CREATE USER diskUserHE;
ALTER ROLE db_datareader 
	ADD MEMBER diskUserHE;
GO

------------------- v2.02 -------------------
------------------- v1.02 --------------------
USE disk_inventoryHE
GO
------------------- v2.04 ---------------------

CREATE TABLE artist_type
	(
	artist_type_id					INT				NOT NULL PRIMARY KEY IDENTITY,
	description						varchar(20)		NOT NULL,
	);

CREATE TABLE disk_type
	(
	disk_type_id					INT				NOT NULL PRIMARY KEY IDENTITY,
	description						varchar(20)		NOT NULL,
	);

CREATE TABLE genre
	(
	genre_id						INT				NOT NULL PRIMARY KEY IDENTITY,
	description						varchar(20)		NOT NULL,
	);

CREATE TABLE status
	(
	status_id						INT				NOT NULL PRIMARY KEY IDENTITY,
	description						varchar(20)		NOT NULL,
	);

CREATE TABLE borrower
	(
	borrower_id					INT					NOT NULL PRIMARY KEY IDENTITY,
	fname							varchar(20)		NOT NULL,
	lname							varchar(20)		NOT NULL,
	phone_num						varchar(20)		NOT NULL,
	);

CREATE TABLE disk
	(
	disk_id						INT					NOT NULL PRIMARY KEY IDENTITY,
	disk_name						varchar(80)		NOT NULL,
	release_date					date			NOT NULL,
	genre_id						INT				NOT NULL REFERENCES genre(genre_id),
	status_id						INT				NOT NULL REFERENCES status(status_id),
	disk_type_id					INT				NOT NULL REFERENCES disk_type(disk_type_id)
	);

CREATE TABLE artist
	(
	artist_id						INT				NOT NULL PRIMARY KEY IDENTITY,
	fname							varchar(20)		NOT NULL,
	lname							varchar(20)		NOT NULL,
	artist_type_id					INT				NOT NULL REFERENCES artist_type(artist_type_id),
	);

CREATE TABLE disk_has_borrower
	(
	disk_has_borrower_id			INT				NOT NULL PRIMARY KEY IDENTITY,
	borrowed_date					date			NOT NULL,
	due_date						date			NOT NULL,
	returned_date					date			NULL,
	borrower_id						INT				NOT NULL REFERENCES borrower(borrower_id),
	disk_id							INT				NOT NULL REFERENCES disk(disk_id),
	);

CREATE TABLE disk_has_artist
	(
	disk_has_artist_id				INT				NOT NULL PRIMARY KEY IDENTITY,
	disk_id							INT				NOT NULL REFERENCES disk(disk_id),
	artist_id						INT				NOT NULL REFERENCES artist(artist_id)
------------------ v2.06 --------------
	UNIQUE (disk_id, artist_id)
	);
GO

------------------ v2.07 ---------------
-- 6 Columns --
INSERT INTO disk_type (description) VALUES ('CD')
INSERT INTO disk_type (description) VALUES ('DVD')
INSERT INTO disk_type (description) VALUES ('Cassette')
INSERT INTO disk_type (description) VALUES ('VHS')
INSERT INTO disk_type (description) VALUES ('Lazer Disk')
INSERT INTO disk_type (description) VALUES ('Blue Ray')
-- 7 Columns --
INSERT INTO genre (description) VALUES ('Country')
INSERT INTO genre (description) VALUES ('Rock')
INSERT INTO genre (description) VALUES ('Classical')
INSERT INTO genre (description) VALUES ('Horror')
INSERT INTO genre (description) VALUES ('Action')
INSERT INTO genre (description) VALUES ('Western')
INSERT INTO genre (description) VALUES ('Comedy')
-- 6 Columns --
INSERT INTO status (description) VALUES ('Damaged')
INSERT INTO status (description) VALUES ('Borrowed')
INSERT INTO status (description) VALUES ('Avalible')
INSERT INTO status (description) VALUES ('Missing')
INSERT INTO status (description) VALUES ('Pending Reshelf')
INSERT INTO status (description) VALUES ('Waitlist')
-- 21 Columns --
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Lazy Forever', '07/09/1991', '6', '1', '2')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Discover Crash', '01/10/2014', '5', '2', '5')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Life-Changing Melody', '05/04/2012', '1', '2', '5')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('State Of Crash', '03/08/2002', '1', '4', '2')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Into Evening', '05/13/2017', '2', '4', '6')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Dr. Crippen', '10/14/2019', '6', '2', '2')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('To Be Twenty', '04/06/1981', '6', '1', '4')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Family Day', '10/13/1994', '1', '3', '6')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Out of Africa', '01/18/1988', '5', '6', '2')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Rodeo Of Here', '05/17/2015', '4', '2', '4')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Inside Horizon', '07/17/1982', '2', '1', '3')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Outsourced', '10/03/2018', '2', '3', '6')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Attack of the Crab Monsters', '04/21/1989', '1', '4', '4')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Words and Pictures', '08/22/1980', '2', '7', '2')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Divide, The', '03/18/1994', '2', '4', '3')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Another Shimmer', '05/21/2021', '1', '7', '6')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Calm DISNEY', '12/15/1993', '4', '2', '5')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Hyperspace Nirvana', '08/24/2005', '5', '3', '4')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Snow Falling on Cedars', '04/09/2008', '1', '1', '6')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('Action Oasis', '12/23/2010', '6', '3', '4')
INSERT INTO disk (disk_name, release_date, disk_type_id, genre_id, status_id) VALUES ('House Of Own Way', '04/01/1981', '1', '6', '3')
-- 22 Columns --
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Fawne', 'Somerbell', '995-835-1607')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Isador', 'Garaway', '415-692-9477')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Orsola', 'Stevings', '142-947-3369')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Denni', 'Binne', '366-995-6450')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Quinn', 'Bucktharp', '552-992-9245')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Allene', 'Pearse', '123-617-6364')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Joya', 'Kittles', '128-438-1789')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Averyl', 'Goodband', '300-196-9044')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Eberto', 'Reedshaw', '739-337-7159')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Cecily', 'Dunstone', '713-326-6165')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Chariot', 'Callinan', '909-963-5829')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Amabel', 'MacColm', '978-780-3185')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Rosabella', 'Gladwell', '332-901-1709')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Pierrette', 'Colt', '279-816-9224')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Hilly', 'Duncanson', '245-264-2925')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Minerva', 'Tidmas', '749-315-9188')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Trixy', 'Yegorov', '555-853-8845')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Fancy', 'Cosson', '749-416-2732')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Laurice', 'Sextie', '790-473-2221')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Erek', 'Pottery', '573-877-4530')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Siward', 'Tokell', '963-725-2561')
INSERT INTO borrower (fname, lname, phone_num) VALUES ('Kaitlynn', 'Stride', '880-189-3176')

------ removes Cecily Dunstone as a borrower -----------
Delete borrower
WHERE lname = 'Dunstone'

-- 21 Columns --
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('10/18/18', '11/17/18', '10/27/18', '15', '12') -- f.2, f.3
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('05/23/17', '06/22/17', '06/13/17', '9', '15') -- f.2, f.3
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('06/26/21', '07/26/21', '07/07/21', '3', '11') -- f.5: disk_id 3 does not have a row
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('10/28/22', '11/27/22', '11/07/22', '9', '2') -- f.7: borrower_id 4 does not have a row
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('10/29/21', '11/28/21', '11/06/21', '3', '15')
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('11/22/21', '12/22/21', '12/10/21', '20', '21') -- f.4
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('09/01/19', '10/01/19', '09/16/19', '5', '5')
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('08/13/17', '09/12/17', NULL, '18', '7')
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('03/18/23', '04/17/23', '04/01/23', '5', '6')
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('03/06/23', '04/05/23', '03/23/23', '2', '1') -- f.6
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('07/21/21', '08/20/21', '08/19/21', '2', '15')
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('01/25/20', '02/24/20', '02/02/20', '15', '16')
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('04/19/17', '05/19/17', '05/06/17', '13', '2')
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('05/08/20', '06/07/20', '05/21/20', '14', '2')
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('09/08/17', '10/08/17', '09/15/17', '9', '20')
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('07/01/17', '07/31/17', '07/22/17', '20', '21') -- f.4
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('05/11/17', '06/10/17', '05/24/17', '19', '14') -- f.8
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('03/07/19', '04/06/19', NULL, '1', '16')
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('05/08/19', '06/07/19', '06/05/19', '16', '1') -- f.6
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('05/28/23', '06/27/23', '06/14/23', '8', '9')
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id) VALUES ('06/29/19', '07/29/19', '07/14/19', '19', '10') -- f.8
GO

------------------- v2.08 ---------------
SELECT borrower_id, disk_id, borrowed_date, returned_date
FROM disk_has_borrower
WHERE returned_date IS NULL
GO