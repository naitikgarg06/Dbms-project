REM   Script: Session 17
REM   project dbms 

create table student_n(  
roll_no number(20) primary key , student_name  
varchar2(20)  
);

create table student_ph1(  
roll_no number(20) primary key references student_n(roll_no),   
student_phone1 number(10)  
);

create table student_ph2(  
roll_no number(20) primary key references student_n(roll_no),  
student_phone2 number(10)   
);

create table student_r(  
roll_no number(20) primary key references student_n(roll_no),   
student_room_no number(5)  
);

create table complaint_table(  
complaint_no number(10) primary key,  
roll_no number(20) references student_n(roll_no)  
);

create table complaint_info(  
complaint_no number(10) primary key references complaint_table(complaint_no),  
description varchar2(100),   
complaint_type varchar2(20)  
);

create table mess_table(   
sr_no number(10) primary key,  
roll_no number(20) references student_n(roll_no)  
);

create table mess_info(  
sr_no number(10) primary key references mess_table(sr_no),  
feedback varchar2(100)  
);

create table laundry_table(   
sr_no number(10) primary key,  
roll_no number(20) references student_n(roll_no)  
);

create table laundry_info(  
sr_no number(10) primary key references laundry_table(sr_no),   
given_on date,  
recieved_on date ,  
completed varchar2(1)  
);

CREATE OR REPLACE PROCEDURE insert_data (roll student_n.roll_no%TYPE, name  
student_n.student_name%TYPE, phone1  
student_ph1.student_phone1%TYPE,  
phone2  
student_ph2.student_phone2%TYPE, room  
student_r.student_room_no%TYPE)  
IS  
BEGIN  
INSERT INTO student_n (roll_no, student_name)  
VALUES (roll,name);  
INSERT INTO student_ph1 (roll_no, student_phone1)  
VALUES (roll,phone1);  
INSERT INTO student_ph2 (roll_no, student_phone2)  
VALUES (roll,phone2);  
INSERT INTO student_r(roll_no, student_room_no)  
VALUES (roll,room);  
COMMIT;  
END;  
/

begin  
insert_data(102,'ramu',9863354,47534724,13);  
insert_data(114,'sasmita',7696725530,12345678,20);  
insert_data(104,'Anmol',12345678,8765432455,21);  
insert_data(105,'arushi',987654234,98756637,22);  
insert_data(106,'kashita',7696725530,4374623473,23);  
insert_data(107,'simran',7696725530,12345678,24);  
insert_data(108,'deepak',7696725530,12345678,25);  
insert_data(109,'rahul',7696725530,12345678,26);  
insert_data(110,'chintu',7696725530,12345678,27);  
insert_data(111,'ramu',7696725530,12345678,28);  
insert_data(112,'kapil',7696725530,12345678,29);  
insert_data(113,'titu',7696725530,12345678,30);   
end;
/

select * from student_n;

select * from student_ph1;

select * from student_ph2;

select * from student_r;

create or replace procedure add_complaint( c_no  
complaint_table.complaint_no%type,  
roll complaint_table.roll_no%type,  
disc complaint_info.description%type,  
c_type complaint_info.complaint_type%type  
) 
is  
begin  
insert into complaint_table(complaint_no,roll_no)  
values(c_no,roll);  
insert into complaint_info(complaint_no,description,complaint_type)  
values(c_no,disc,c_type);  
commit;  
end;
/

begin  
add_complaint(122,102,'good service','mess');  
add_complaint(12,102,'avg','laundary');  
add_complaint(113,104,'very good service im very happy','mess');  
add_complaint(114,105,'food was yummy','mess');  
add_complaint(115,106,'good service','laundary');  
end;  

/

select * from complaint_table;

select * from complaint_info;

create or replace procedure  
add_mess( sno mess_table.sr_no%type,  
roll mess_table.roll_no%type,  
feed mess_info.feedback%type  
)  
is  
begin  
insert into mess_table(sr_no,roll_no) values(sno,roll);  
insert into  
mess_info(sr_no,feedback)  
values(sno,feed);   
commit;   
end;
/

declare  
sno mess_table.sr_no%type; begin  
select max(sr_no)into sno from mess_table;  
add_mess(1,102,'v.v.v.good');  
add_mess(2,102,'v.good');  
add_mess(3,108,'very bad');  
add_mess(4,104,'avg');  
add_mess(5,105,'great');  
add_mess(6,106,'it was amazing');  
add_mess(7,107,'not bad');  
add_mess(8,108,'it was okay');  
add_mess(9,109,'great');   
end;
/

select * from mess_table;

select* from mess_info;

create or replace procedure  
add_laundry(sno  
laundry_table.sr_no%type, roll  
laundry_table.roll_no%type, g_date  
laundry_info.given_on%type, r_date  
laundry_info.recieved_on%type,  
comp laundry_info.completed%type  
)  
is  
begin  
insert into laundry_table(sr_no,roll_no) values(sno,roll);  
insert into laundry_info(sr_no,given_on,recieved_on,completed)  
values(sno,g_date,r_date,comp);  
commit;  
end;  
/

declare  
sno laundry_table.sr_no%type; begin  
select max(sr_no) into sno from laundry_table;  
add_laundry(1,109,to_date('2-08-2002','dd-mm-yyyy'),to_date('12-07-2022','dd-mm-yyyy'),'n'); 
add_laundry(2,109,to_date('2-08-2002','dd-mm-yyyy'),to_date('12-07-2022','dd-mm-yyyy'),'y'); 
add_laundry(3,109,to_date('2-08-2002','dd-mm-yyyy'),to_date('12-07-2022','dd-mm-yyyy'),'y'); 
add_laundry(4,109,to_date('2-08-2002','dd-mm-yyyy'),to_date('12-07-2022','dd-mm-yyyy'),'n'); 
add_laundry(5,109,to_date('2-08-2002','dd-mm-yyyy'),to_date('12-07-2022','dd-mm-yyyy'),'n'); 
end;
/

select* from laundry_table;

select* from laundry_info;

create or replace procedure update_laundry( sno  
laundry_table.sr_no%type,  
comp laundry_info.completed%type  
)  
is  
begin  
update laundry_info set completed = comp where sr_no = sno;  
commit;  
end;
/

begin  
update_laundry(1,'y'); end;   

/

select * from laundry_info;

create or replace trigger Insert_at_12  
before insert on student_n for each  
row  
when ((to_char(sysdate,'fmDAY'))=('MONDAY')) declare  
abcd exception; begin raise abcd; exception when abcd  
then dbms_output.put_line('have a good start of the  
week.');  
end; 
/

insert into student_n values(1200,'anmol');

select * from student_n;

select to_char(sysdate,'day') from dual;

CREATE OR REPLACE PROCEDURE RETRIEVE(  
roll student_n.roll_no%TYPE,  
nam OUT student_n.student_name%TYPE  
)  
IS  
BEGIN  
SELECT student_name into nam FROM student_n where roll_no=roll; exception  
when NO_DATA_FOUND then  
dbms_output.put_line('Sorry No data found');  
COMMIT;  
END;
/

select * from student_n;

declare  
b student_n.student_name%TYPE;  
begin  
RETRIEVE(100,b);  
end;
/

