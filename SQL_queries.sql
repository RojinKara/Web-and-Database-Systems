USE coursework;


-- Query 1: This one shows the URN of students enrolled in the course "BSc Computer Science".
SELECT URN FROM Student WHERE Stu_Course = (SELECT Crs_Code FROM Course WHERE Crs_Title = 'BSc Computer Science');


-- Query 2: This one selects students' full name from the Student table that studies in BSc Computer Science.
SELECT Student.Stu_FName, Student.Stu_LName FROM Student JOIN Course on Course.Crs_Code = Student.Stu_Course WHERE Crs_Title = 'BSc Computer Science';


-- Query 3: This one goes through Student, Society and StuSoc tables to give the number of students in each society.
SELECT Society_Name, COUNT(Student.URN) FROM Student JOIN StuSoc SS on Student.URN = SS.URN JOIN coursework.Societies S on SS.SOCIETY_ID = S.SOCIETY_ID GROUP BY S.SOCIETY_ID;

-- If you want to do some more queries as the extra challenge task you can include them here

-- Extra Query 1: This one shows how many students are assigned to each hobby.
SELECT Hobby_Name, COUNT(Student.URN) FROM Student JOIN StuHob SS on Student.URN = SS.URN JOIN coursework.Hobbies S on SS.HOBBY_ID = S.HOBBY_ID GROUP BY S.HOBBY_ID;

-- Extra Query 2: This one shows the names of the courses run by the Department called "Information Technology".
SELECT Crs_Title FROM Course WHERE Crs_Department = (SELECT DEPARTMENT_ID FROM Department WHERE Department_Name = 'Information Technology');

-- Extra Query 3: This one gives all the details about activities ordered by their dates.
SELECT * FROM Activities ORDER BY Activity_Date


