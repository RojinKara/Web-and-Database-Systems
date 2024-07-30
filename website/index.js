const express = require('express');
const path = require('path');

const mysql = require('mysql2/promise');
const app = express();
const connection = mysql.createConnection({
  host: 'localhost',
  port: '3306',
  user: 'root',
  database: 'coursework'
});

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')))
app.get('/', (req, res) => {
  res.render("home");
})

// view all for student table
app.get('/student', async (req, res) => {
  let [rows, fields] = await (await connection).execute("SELECT * FROM Student;").catch((error) => {
    console.error(error);
  });
  res.render("student", {rows:rows, fields:fields});
});

// view single row of student table
app.get('/viewonestudent/:URN', async (req, res) => {
  let [rows, fields] = await (await connection).execute(`SELECT * FROM Student WHERE URN = ${req.params.URN};`).catch((error) => {
    console.error(error);
  });
  res.render("student", {rows:rows, fields:fields});
});

// adds delete functionality to student table
app.get('/delete/:URN', async (req, res) => {
  let [rows, fields] = await (await connection).execute(`DELETE FROM Student WHERE URN = ${req.params.URN};`).catch((error) => {
    console.error(error);
  });
  res.redirect(`/student`);
});


// adds update functionality to student table
app.get('/update/:URN', async (req, res) => {
  let [rows, fields] = await (await connection).execute(`SELECT * FROM Student WHERE URN = ${req.params.URN};`).catch((error) => {
    console.error(error);
  });
  res.render("update", {rows:rows, fields:fields});
});

// updates student information if the changes are valid
app.post('/update', async (req, res) => {
  if (validate(req.body)) {
    await (await connection).execute(`UPDATE Student SET Stu_FName = '${req.body.Stu_FName}',
                  Stu_LName = '${req.body.Stu_LName}', Stu_DOB = '${req.body.Stu_DOB}',
                  Stu_Phone = '${req.body.Stu_Phone}', Stu_Course = '${req.body.Stu_Course}',
                  Stu_Type = '${req.body.Stu_Type}' WHERE URN = ${req.body.URN};`).catch((error) => {
      console.error(error);
    });
    res.redirect(`/update/${req.body.URN}?s=true`);
  } else {
    res.redirect(`/update/${req.body.URN}?s=false`);
  }
});

const validCourse = [100, 101, 200, 201, 210, 211];
// validation of data for student details
function validate(data) {
  if (!/[A-Z][a-z]*/.test(data.Stu_FName)) return false;
  if (!/[A-Z][a-z]*/.test(data.Stu_LName)) return false;
  if (!/\d{4}-\d{2}-\d{2}/.test(data.Stu_DOB.toString())) return false;
  if (!/\d{11}/.test(data.Stu_Phone)) return false;
  if (!validCourse.includes(parseInt(data.Stu_Course))) return false;
  if (!/\d{3}/.test(data.Stu_Course)) return false;
  if (!/UG|PG/.test(data.Stu_Type)) return false;
  return true
}

// view all for course table
app.get('/course', async (req, res) => {
  let [rows, fields] = await (await connection).execute("SELECT * FROM Course;").catch((error) => {
    console.error(error);
  });
  res.render("course", {rows:rows, fields:fields});
});

// view single row of course table
app.get('/viewonecourse/:ID', async (req, res) => {
  let [rows, fields] = await (await connection).execute(`SELECT * FROM Course WHERE Crs_Code = ${req.params.ID};`).catch((error) => {
    console.error(error);
  });
  res.render("course", {rows:rows, fields:fields});
});

// view all for department table
app.get('/department', async (req, res) => {
  let [rows, fields] = await (await connection).execute("SELECT * FROM Department;").catch((error) => {
    console.error(error);
  });
  res.render("department", {rows:rows, fields:fields});
});

// view single row of department table
app.get('/viewonedepartment/:ID', async (req, res) => {
  let [rows, fields] = await (await connection).execute(`SELECT * FROM Department WHERE DEPARTMENT_ID = ${req.params.ID};`).catch((error) => {
    console.error(error);
  });
  res.render("department", {rows:rows, fields:fields});
});

// view all for hobbies table
app.get('/hobbies', async (req, res) => {
  let [rows, fields] = await (await connection).execute("SELECT * FROM Hobbies;").catch((error) => {
    console.error(error);
  });
  res.render("hobbies", {rows:rows, fields:fields});
});

// view single row of hobbies table
app.get('/viewonehobbies/:ID', async (req, res) => {
  let [rows, fields] = await (await connection).execute(`SELECT * FROM Hobbies WHERE HOBBY_ID = ${req.params.ID};`).catch((error) => {
    console.error(error);
  });
  res.render("hobbies", {rows:rows, fields:fields});
});

// view all for societies table
app.get('/societies', async (req, res) => {
  let [rows, fields] = await (await connection).execute("SELECT * FROM Societies;").catch((error) => {
    console.error(error);
  });
  res.render("societies", {rows:rows, fields:fields});
});

// view single row of societies table
app.get('/viewonesocieties/:ID', async (req, res) => {
  let [rows, fields] = await (await connection).execute(`SELECT * FROM Societies WHERE SOCIETY_ID = ${req.params.ID};`).catch((error) => {
    console.error(error);
  });
  res.render("societies", {rows:rows, fields:fields});
});

// view all for activities table
app.get('/activities', async (req, res) => {
  let [rows, fields] = await (await connection).execute("SELECT * FROM Activities;").catch((error) => {
    console.error(error);
  });
  res.render("activities", {rows:rows, fields:fields});
});

// view single row of activities table
app.get('/viewoneactivities/:ID', async (req, res) => {
  let [rows, fields] = await (await connection).execute(`SELECT * FROM Activities WHERE ACTIVITY_ID = ${req.params.ID};`).catch((error) => {
    console.error(error);
  });
  res.render("activities", {rows:rows, fields:fields});
});

// runs the website on localhost:3000
app.listen(3000, () => {
  console.log(`Application listening on port: ${3000}`)
});