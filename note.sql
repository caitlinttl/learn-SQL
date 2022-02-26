SQL

--------------------------------------------------------------------------------
 SQL (Structured Query Language)

 DDL (Data Definition Language) 定義 (增刪修"表格")
 DML (Data Manipulation Language) 操作(增刪修"數據")
 DQL (Data Quary Language) 查詢

--------------------------------------------------------------------------------
SQL tryit editor
https://www.w3schools.com/sql/trysql.asp?filename=trysql_asc

--------------------------------------------------------------------------------
comment:
--comment--
/* comment */

--------------------------------------------------------------------------------
關係模型 (Relational model)
- 由若干個二維表組成
- table與table之間的邏輯關係: 一對多, 多對一, 一對一

二維表:
Record   紀錄, 橫向, 邏輯意義
Colume  字段, 縱向, 數據類型一致

數據類型:
int, float, str, date...null(是否允許為空)

--------------------------------------------------------------------------------
主鍵 (Primary key)
- 同一張table中, 將一個record與其它record區分開來的特定字串(唯一值)稱為主鍵
- 不以任何業務相關的值當作主見鍵
1. 自增整數類型
2. 全局唯一GUID類型

聯合主鍵
- 使用兩個或多個colume作為主鍵
- 允許某colume重複, 但組合必須唯一

--------------------------------------------------------------------------------
外鍵 (Foreign key)
- 通過"另一張table的主鍵", 聯合兩張table的cloume, 稱之為外鍵
- 外鍵必須是其他table的主鍵
- 輔助一個table指向另一個table的colume
1. 一對多
2. 多對多(由兩個一對多的關係來實現, 創建一個中間table)
3. 一對一 (獨立分出來, 可加快查詢速度)

--------------------------------------------------------------------------------
數據類型	          描述
VARCHAR(n)      可變長度的字符/字符串，最大長度為n  (CHARACTER VARYING(n)	)
BINARY(n)	        固定長度為n的二進制串
BOOLEAN	         存儲TRUE或FALSE值
INTEGER(p)	      整數值（沒有小數點），精度為p
INTEGER	            整數值（沒有小數點），精度為10
DECIMAL(p, s)	精確數值，精度為p，小數點後位數為s。例如：DICIMAL(5,2)小數點前有3位數，小數點後有2位數
FLOAT(p)	         近似數值，尾數精度為p
FLOAT	               近似數值，尾數精度為16
DATE	                存儲年、月、日的值
TIMESTAMP	    存儲年、月、日、小時、分、秒的值

--------------------------------------------------------------------------------
創建表格 
CREATE TABLE

CREATE TABLE table_name (
    column1 datatype1,
    column2 datatype2,
    column3 datatype3,
   ....
);

e.g.
CREATE TABLE Students (
    StudentID int, 
    Name varchar(255),
    City varchar(255),
    PRIMARY KEY(StudentID)
);

--------------------------------------------------------------------------------
修改表格 
ALTER TABLE 
(ADD, DROP, MODIFY)
- ADD
- DROP COLUMN
- MODIFY COLUMN

ALTER TABLE table_name 
ADD column_name datatype;
e.g.
ALTER TABLE Students
ADD age int;                                                     增加cloume
DROP COLUMN Age;                                     刪除colume
MODIFY COLUMN Name varchar(200);   修改cloume

刪除表格
DROP TABLE
e.g.
DROP TABLE Students;

--------------------------------------------------------------------------------
操作Record (增加, 刪除, 修改, 替換)
(INSERT INTO, UPDATE, DELETE FROM, REPLACE INTO)
- INSERT INTO ... VALUES
- UPDATE ... SET ... WHERE
- DELETE FROM ... WHERE
- REPLACE INTO ... VALUES

增加
INSERT INTO 
INSERT INTO table_name(column1, column2, column3, ...) VALUES (value1, value2, value3, ...);
INSERT INTO table_name VALUES (value1, value2, value3, ...);
e.g.
INSERT INTO Students(StudentID, Name, City) VALUES (1, 'Enoch', 'Los Angeles');

修改
UPDATE 
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition; (如果不使用WHERE子句, 那麼所有record都會被更新。)
e.g.
UPDATE Students
SET Name = 'Daniel' 
WHERE StudentID = 1;

e.g 
update Students set CourseID=3 where StudentID=6

刪除
DELETE FROM
DELETE FROM table WHERE condition;
e.g.
DELETE FROM Students WHERE City = 'Los Angeles';

替換 (插入一條新紀錄, 但是如果此記錄已經存在, 就先刪除原記錄, 再插入新紀錄)
REPLACE INTO
e.g.
REPLACE INTO Students(StudentID, name, city) VALUES (1, 'Enoch', 'New York City');

--------------------------------------------------------------------------------
約束 Constraints
如果存在違反約束的數據行為, 行為會被約束終止

約束類型:
NOT NULL: 字段不能存儲空值。
UNIQUE:  保證字段的每行都是唯一的值。
PRIMARY KEY: 主鍵，NOT NULL和UNIQUE的結合，確保某列（或多列）有唯一標識，用於找到特定記錄。
FOREIGN KEY：保證表中的數據匹配到（指向）另一個表中的主鍵。
CHECK: 保證字段的值符合指定條件。
DEFAULT: 規定沒賦值時的默認值。

時機:
- CREATE TABLE
- ALTER TABLE

CREATE TABLE table_name (
    column1 data_type1(size) constraint1,
    column2 data_type2(size) constraint2,
    column3 data_type3(size) constraint3,
    ...
);

e.g. CREATE TABLE
CREATE TABLE Employees (
  EmployeeID int Primary Key,
  Name varchar(255) NOT NULL,
  Apartment varchar(255) DEFAULT 'A',
  Age int CHECK (Age > 18)
);

e.g. ALTER TABLE
ALTER TABLE Students 
MODIFY Age int NOT NULL;

e.g. 外鍵約束
ALTER TABLE Students
ADD CONSTRAINT fk_class_id
FOREIGN KEY (classID)
REFERENCES Classes(id);
將Students中的"classID"字段設置為外鍵, 讓這個外鍵指向"Classes"表的"id"主鍵, fk_class_id是這個約束的名字

e.g. 刪除外鍵約束
ALTER TABLE Students
DROP FOREIGN KEY fk_class_id;

--------------------------------------------------------------------------------
查詢
SELECT ... FROM ... WHERE (NOT) ... AND/OR  ...
=, >, >=, <, <=, <>, LIKE

SELECT * FROM table_name;
e.g. 
SELECT * FROM Students;

SELECT * FROM table_name WHERE condition;
e.g.
SELECT * FROM Students WHERE Age > 20;
SELECT * FROM Students WHERE Gender = 'M' AND Age > 20;
SELECT * FROM Students WHERE Gender = 'F' OR Age < 20;
SELECT * FROM Students WHERE NOT Gender = 'F';
SELECT * FROM Students WHERE Gender <> 'F';
SELECT * FROM Students WHERE (Age < 20 OR Age > 22) AND Gender = 'M';

SELECT * FROM Students WHERE City LIKE 'Sh%';
(以"Sh"開頭的)

--------------------------------------------------------------------------------
投影查詢
- 只希望返回某些特定colume的數據，而不是所有colume的數據
SELECT column1, column2, … FROM table_name; 
- 只想要不同的數據
SELECT DISTINCT column1, column2, ... FROM table_name;

e.g.
SELECT StudentID, Name FROM Students WHERE Age > 20;

e.g.
SELECT DISTINCT City FROM Students;

--------------------------------------------------------------------------------
排序
ORDER BY ... ASC|DESC
查詢的結果預設是根據主鍵排序的, 使用order by定義的colume排序.
如果有WHERE子句，那麼ORDER BY需要放在WHERE後面
SELECT col1, col2, ... 
FROM table_name
ORDER BY col1, col2, ... ASC|DESC;

e.g.
SELECT * FROM Students ORDER BY Age;
SELECT * FROM Students ORDER BY Age DESC;
SELECT * FROM Students ORDER BY Age ASC, Gender;

e.g.
SELECT * FROM Students 
WHERE City = 'Shanghai'
ORDER BY Age;

e.g.
選取年紀大於20，並且來自上海的學生，將結果按照年紀從小到大的順序排好，最後結果只需要StudentID字段。
SELECT StudentID FROM Students where Age>20 and City='Shanghai' order by Age asc;


--------------------------------------------------------------------------------
進階查詢

1. 聚合查詢
    - 聚合函數 COUNT(*), SUM, AVG, MAX, MIN
    - 分組 GROUP BY
2. 多表查詢
3. 連接查詢(JOIN)
    - RIGHT JOIN, LEFT JOIN
    - FULL JOIN

**聚合查詢
e.g.
SELECT COUNT(*) FROM Students WHERE Age>20;
SELECT AVG(Age) FROM Students;

設置別名
SELECT column AS alias FROM tables
e.g.
SELECT COUNT(*) AS StudentsNum FROM Students; 

分組聚合 GROUP BY
- 將具有共性colume的record整合起來。
比如我們想要根據城市City對學生進行分組，並需要查詢每個城市有多少學生，
e.g.
SELECT City, COUNT(*) FROM Students GROUP BY City;
先將學生根據City分組，然後再根據性別分組
SELECT City, Gender, COUNT(*) FROM Students GROUP BY City, Gender;

如果我們將Name也放入查詢結果，就不合適了，
因為來自相同城市的學生可能有很多位，名字就各不相同了，所以以下語句是不合法的。
SELECT City, COUNT(*), Name FROM Students GROUP BY City;


**多表查詢
SELECT * FROM table1, table2;
e.g.
SELECT * FROM Students, Courses;
結果record的數量為table1*table2, colume的數量為table1+table2
WHERE, ORDER BY, GROUP BY 都適用於多表查詢。

改別名
有時候兩張表可能擁有相同名字的字段，我們可以通過使用AS 取別名來區別字段。
比如使用以下語句給StudentID和CourseID改名為StudentId和CourseId:
e.g.
SELECT Students.StudentID AS StudentId, Courses.CourseID AS CourseId FROM Students, Courses;
假設Students和Courses的主鍵字段都叫ID，那麼這個別名就很有幫助。
我們可以使用以下語句使查詢結果更明瞭:
SELECT Students.ID AS StudentId, Courses.ID AS CourseId FROM Students, Courses;

表格取別名
SELECT S.StudentID AS StudentId, C.CourseID AS CourseId FROM Students AS S, Courses AS C;

查詢StudentID和其對應的課程名字
SELECT S.StudentID, C.CourseName FROM Students AS S, Courses AS C WHERE S.CourseID = C.CourseID;


**連接查詢
INNER JOIN ... ON  返回同時存在兩表的數據
LEFT JOIN ... ON     返回左表的數據, 右表若無值補null (LEFT OUTER JOIN)
RIGHT JOIN ... ON  返回右表的數據, 左表若無值補null  (RIGHT OUTER JOIN)
FULL JOIN ... ON    返回兩表的數據, 無值全部補null (FULL OUTER JOIN)

連接查詢是另一種類型的多表查詢，連接查詢會對多個表格進行JOIN運算。
先確定一個主表作為結果集，然後將其他表的記錄有選擇性地“嵌入”到主表結果集上。
1. 確定主表，使用FROM table_name
2. 緊接著確認連接的表，使用INNER JOIN table_name
3. 再確定連接條件，使用ON condition，上面語句的條件就是S.CourseID = C.CourseID
4. 最後還能加上： WHERE、ORDER BY等子句

e.g.
SELECT S.StudentID, C.CourseName 
FROM Students AS S 
INNER JOIN Courses AS C ON S.CourseID = C.CourseID;


找出加入CourseID為1的學生數量和課程名字，要注意的是，我們只尋找那些年紀大於20歲的男學生數量。
e.g.
SELECT COUNT(*) AS StudentsNum, CourseName 
FROM Students LEFT JOIN Courses ON Students.CourseID = Courses.CourseID 
WHERE Courses.CourseID=1 AND Students.Age > 20 AND Students.Gender = 'M'
GROUP BY Students.CourseID;


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Example

CREATE TABLE Students (
    StudentID int PRIMARY KEY,
    Name varchar(255),
    Gender varchar(1),
    Age int,
    City varchar(255)
);
INSERT INTO Students VALUES(1, 'David', 'M', 21, 'Shanghai');
INSERT INTO Students VALUES(2, 'Kevin', 'M', 19, 'Beijing');
INSERT INTO Students VALUES(3, 'Emily', 'F', 22, 'Shanghai');
INSERT INTO Students VALUES(4, 'William', 'M', 20, 'New York City');
INSERT INTO Students VALUES(5, 'Alice', 'F', 19, 'Los Angeles');
INSERT INTO Students VALUES(6, 'Frank', 'F', 22, 'Los Angeles');


CREATE TABLE Courses (
    CourseID int PRIMARY KEY,
    CourseName varchar(255)
);
INSERT INTO Courses VALUES(1, 'CS101');
INSERT INTO Courses VALUES(2, 'CS202');
INSERT INTO Courses VALUES(3, 'EE101');


--------------------------------------------------------------------------------
View 檢視表、視圖 (SQL View)

View 檢視表
- View 是由查詢 (select tables) 得到的結果集組合而成的資料表
- 資料表table 是一種實體結構 (physical structure)
- 檢視表View 是一種虛擬結構 (virtual structure)

特性
1. 加強資料庫的安全性, 將實體資料表結構隱藏
2. 唯讀的
3. 簡化查詢的複雜度
4. 當資料表結構有變更, 只需要更改 View 的設定, 不需更改程式

CREATE VIEW
CREATE OR REPLACE VIEW (CREATE VIEW/ALTER VIEW)
DROP VIEW 

CREATE VIEW view_name [(column_list)] AS
SELECT column_name(s)
FROM table_name
WHERE condition;

e.g.
CREATE VIEW v AS SELECT qty, price, qty*price AS value FROM t;

e.g.
CREATE VIEW view_p_sum (Product, P_SUM) AS
SELECT Product, Price*Quantity FROM p_orders GROUP BY Product;
SELECT * FROM view_p_sum


--------------------------------------------------------------------------------
MySQL安裝

apt-get install mysql-server
export PATH=${PATH}:/usr/local/mysql/bin
設定root密碼

mysql -u root -p
show databases;

創建資料庫
CREATE DATABASE testDB;

使用資料庫
USE testDB;

創建Table
CREATE TABLE Students (
    StudentID int PRIMARY KEY, 
    Name varchar(255),
    City varchar(255)
);

插入Record
INSERT INTO Students VALUES(1, 'David', 'Beijing');

查詢Record
SELECT * FROM Students;


--------------------------------------------------------------------------------
python 操作SQL

pip install mysql-connector-python
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------





