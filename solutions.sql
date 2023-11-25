1.1.6
create table book (book_id int primary key auto_increment, title varchar(50), author varchar(30), price decimal(8,2), 
amount int);

1.1.7
insert into book (book_id, title, author, price, amount) values (1, "Мастер и Маргарита", "Булгаков М.А.",
                                                                670.99, 3)
                                                                
1.1.8
insert into book (book_id, title, author, price, amount) values (2, "Белая гвардия", "Булгаков М.А.",
                                                                540.50, 5);
insert into book (book_id, title, author, price, amount) values (3, "Идиот", "Достоевский Ф.М.",
                                                                460.00, 10);
insert into book (book_id, title, author, price, amount) values (4, "Братья Карамазовы", "Достоевский Ф.М.",
                                                                799.01, 2);
                                                                
1.2.2
select * from book

1.2.3
select author, title, price from book

1.2.4
select title as Название, author as Автор from book

1.2.5
select title, amount, 1.65*amount as pack from book

1.2.6
select title, author, amount, round(price*0.7, 2) as new_price from book

1.2.7
select 
  author, 
  title,
  round(if(author="Булгаков М.А.", price*1.1, if(author="Есенин С.А.", price*1.05, price)), 2) as new_price
from book

1.2.8
select author, title, price from book
where amount<10

1.2.9
select title, author, price, amount from book
where price < 500 and price*amount >= 5000 or price > 600 and price*amount >= 5000

1.2.10
select title, author from book
where  price between 540.50 and 800 and amount in (2,3,5,7)

1.2.11
select title, author from book where title like "_% _%" and author like "% С.%" 

1.2.12
select author, title from book
where amount between 2 and 14
order by author desc, title

1.2.13
select * from book where author like '%Дос%'

1.3.2
select distinct amount from book

1.3.3
select 
  author as Автор, 
  count(title) as "Различных_книг", 
  sum(amount) as "Количество_экземпляров"
from book
group by author

1.3.4
select author, min(price) as Минимальная_цена, max(price) as Максимальная_цена, avg(price) as Средняя_цена
from book
group by author

1.3.5
select 
  author, 
  sum(price*amount) as Стоимость, 
  round(sum(price*amount)*0.18/1.18, 2) as НДС, 
  round(sum(price*amount)/1.18, 2) as Стоимость_без_НДС
from book
group by author

1.3.6
select min(price) as Минимальная_цена, max(price) as Максимальная_цена, round(avg(price), 2) as Средняя_цена
from book

1.3.7
select round(avg(price), 2) as Средняя_цена, round(sum(amount*price), 2) as Стоимость
from book
where amount between 5 and 14

1.3.8
select author, sum(price*amount) as Стоимость
from book
where title not in ("Идиот", "Белая гвардия")
group by author
having sum(price*amount) > 5000
order by Стоимость desc

1.4.2
select author, title, price
from book
where price<=(select avg(price) from book)
order by price desc

1.4.3
select author, title, price
from book
where price - (select min(price) from book) <= 150
order by price asc

1.4.4
select author, title, amount
from book
where amount in (select amount from book group by amount having count(amount)=1)

1.4.5
select author, title, price 
from book
where price < ANY (
    select MIN(price)
    from book 
    group by author
)

1.4.6
select title, author, amount, (select max(amount) from book) - amount as Заказ
from book
having Заказ > 0

1.5.2
create table supply(supply_id INT PRIMARY KEY AUTO_INCREMENT, title VARCHAR(50), author VARCHAR(30), price DECIMAL(8, 2), amount INT)

1.5.3
insert into supply(supply_id, title, author, price, amount) values (1, 'Лирика', 'Пастернак Б.Л.', 518.99, 2);
insert into supply(supply_id, title, author, price, amount) values (2, 'Черный человек', 'Есенин С.А.', 570.20, 6);
insert into supply(supply_id, title, author, price, amount) values (3, 'Белая гвардия', 'Булгаков М.А.', 540.50, 7);
insert into supply(supply_id, title, author, price, amount) values (4, 'Идиот', 'Достоевский Ф.М.', 360.80, 3);

1.5.4
insert into book (title, author, price, amount)
select title, author, price, amount
from supply
where author not in ('Булгаков М.А.', 'Достоевский Ф.М.')

1.5.5
insert into book (title, author, price, amount)
select title, author, price, amount
from supply
where author not in (select distinct author from book)

1.5.6
update book set price = 0.9*price
where amount between 5 and 10

1.5.7
update book set buy = if(buy > amount, amount, buy),
                price = if(buy = 0, price * 0.9, price);

1.5.8
update book, supply set book.amount=supply.amount+book.amount, book.price=(book.price+supply.price)/2
where book.title=supply.title

1.5.9
delete from supply 
where author in (
  select author
  from book
  group by author
  having sum(amount) > 10
)

1.5.10
create table ordering as
select author, title, (select avg(amount) from book) as amount
from book
where amount<(select avg(amount) from book);

1.6.2
select name, city, per_diem, date_first, date_last
from trip
where name like '%а %.'
order by date_last desc

1.6.3
select distinct name from trip
where city='Москва'
order by name

1.6.4
select city, count(*) as Количество
from trip
group by city
order by city

1.6.5
select city, count(*) as Количество
from trip
group by city
order by Количество desc
limit 2

1.6.6
select name, city, datediff(date_last, date_first)+1 as Длительность
from trip
where city not in ('Москва', "Санкт-Петербург")
order by Длительность desc, city desc

1.6.7
select name, city, date_first, date_last
from trip
where DATEDIFF(date_last, date_first) = (
    select MIN(DATEDIFF(date_last, date_first))
    from trip
)

1.6.8
select name, city, date_first, date_last
from trip
where month(date_last)=month(date_first)
order by city, name

1.6.9
select MONTHNAME(date_first) as Месяц, count(*) as Количество
from trip
group by Месяц
order by Количество desc, Месяц

1.6.10
select name, city, date_first, per_diem*(datediff(date_last, date_first)+1) as Сумма
from trip
where month(date_first) in (2, 3)
order by name, Сумма desc

1.6.11
select name, sum((datediff(date_last, date_first)+1)*per_diem) as Сумма
from trip
group by name
having count(*) > 3
order by 2 desc

1.7.2
create table fine(fine_id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(30), number_plate VARCHAR(6),
                 violation VARCHAR(50), sum_fine DECIMAL(8,2), date_violation DATE, date_payment DATE)
                 
1.7.3
insert into fine(fine_id, name, number_plate, violation, sum_fine, date_violation, date_payment) 
           values(6, "Баранов П.Е.", 'Р523ВТ', 'Превышение скорости(от 40 до 60)', Null, '2020-02-14', Null);
insert into fine(fine_id, name, number_plate, violation, sum_fine, date_violation, date_payment) 
           values(7, "Абрамова К.А.", 'О111АВ', 'Проезд на запрещающий сигнал', Null, '2020-02-23', Null);
insert into fine(fine_id, name, number_plate, violation, sum_fine, date_violation, date_payment) 
           values(8, "Яковлев Г.Р.", 'Т330ТТ', 'Проезд на запрещающий сигнал', Null, '2020-03-03', Null);

1.7.4
Update fine as f, traffic_violation as tv
set f.sum_fine=tv.sum_fine
where f.violation=tv.violation and f.sum_fine is null

1.7.5
select name, number_plate, violation
from fine
group by name, number_plate, violation
having count(*) > 1
order by name

1.7.6
update fine, (select name, number_plate, violation
from fine
group by name, number_plate, violation
having count(*) > 1
order by name) as new_fine
set fine.sum_fine=fine.sum_fine*2
where date_payment is null and 
           new_fine.name=fine.name and 
           new_fine.number_plate=fine.number_plate and 
           new_fine.violation=fine.violation

1.7.7
update fine, payment
set fine.date_payment=payment.date_payment,
fine.sum_fine=if(datediff(payment.date_payment, fine.date_violation) <= 20, fine.sum_fine/2, fine.sum_fine)
where fine.name=payment.name and 
fine.number_plate=payment.number_plate and 
fine.violation=payment.violation and  
fine.date_payment is null

1.7.8
create table back_payment as (select name, number_plate, violation, sum_fine, date_violation from fine
where date_payment is null) 

1.7.9
delete from fine
where date_violation < '2020-02-01'

2.1.6
create table author (author_id INT PRIMARY KEY AUTO_INCREMENT, name_author VARCHAR(50))

2.1.7
insert into author(author_id, name_author)
values
(1, 'Булгаков М.А.'),
(2, 'Достоевский Ф.М.'),
(3, 'Есенин С.А.'),
(4, 'Пастернак Б.Л.')

2.1.8
CREATE TABLE book (
      book_id INT PRIMARY KEY AUTO_INCREMENT, 
      title VARCHAR(50), 
      author_id INT NOT NULL, 
      genre_id INT,
      price DECIMAL(8,2), 
      amount INT, 
      FOREIGN KEY (author_id)  REFERENCES author (author_id),
      FOREIGN KEY (genre_id)  REFERENCES genre (genre_id)
)

2.1.9
CREATE TABLE book (
      book_id INT PRIMARY KEY AUTO_INCREMENT, 
      title VARCHAR(50), 
      author_id INT, 
    genre_id INT,
      price DECIMAL(8,2), 
      amount INT, 
      FOREIGN KEY (author_id)  REFERENCES author (author_id) ON DELETE CASCADE,
      FOREIGN KEY (genre_id)  REFERENCES genre (genre_id) ON DELETE set null
)

2.1.11
insert into book (book_id, title, author_id, genre_id, price, amount)
values 
    (6, "Стихотворения и поэмы", 3, 2, 650.00, 15),
    (7, "Черный человек", 3, 2, 570.20, 6),
    (8, "Лирика", 4, 2, 518.99, 2)
    
2.2.2
select title, name_genre, price
from book
inner join genre
on genre.genre_id=book.genre_id
where amount > 8
order by price desc

2.2.3
select name_genre from genre
left join book
on book.genre_id=genre.genre_id
where amount is null

2.2.4
select name_city, name_author, date_add('2020-01-01', interval FLOOR(RAND()*365) day) as Дата
from author
cross join city
order by 1, 3 desc

2.2.5
select name_genre, title, name_author 
from book
inner join author
on book.author_id=author.author_id
inner join genre
on book.genre_id=genre.genre_id
where name_genre='Роман'
order by title

2.2.6
select name_author, sum(amount) as Количество
from author
left join book on author.author_id=book.author_id
group by name_author
having sum(amount) < 10 or Количество is null
order by Количество

2.2.7
select name_author from book
inner join author
on author.author_id=book.author_id
group by name_author
having count(distinct genre_id) = 1

2.2.8
select title, name_author, genre_name.name_genre, price, amount
from book
inner join author on author.author_id=book.author_id
inner join (select genre.genre_id, genre.name_genre from (SELECT genre_id, SUM(amount) AS sum_amount
FROM book
GROUP BY genre_id
HAVING sum_amount >= MAX(sum_amount)) as pop_genre
join genre on genre.genre_id=pop_genre.genre_id) as genre_name
on book.genre_id=genre_name.genre_id
order by title

2.2.9
select
    book.title as Название,
    author as Автор,
    book.amount + supply.amount as Количество
from
    book
    join supply on supply.title = book.title
    and supply.price = book.price

2.2.10
select * from book

2.3.2
update book 
inner join author on book.author_id=author.author_id
inner join supply on book.title=supply.title and supply.author = author.name_author
set book.price=if(book.price <> supply.price, (book.price * book.amount + supply.price * supply.amount)/(book.amount+supply.amount), book.price),
book.amount=book.amount+supply.amount,
supply.amount=0
where book.price <> supply.price;

2.3.3
insert into author(author_id, name_author)
select supply_id as author_id, author from supply
left join author
on supply.author=author.name_author
where author_id is null

2.3.4
insert into book(title, author_id, price, amount)
SELECT title, author_id, price, amount
FROM author INNER JOIN supply
     ON author.name_author = supply.author
WHERE amount <> 0

2.3.5
UPDATE book
SET genre_id = (SELECT genre_id 
                FROM genre 
                WHERE name_genre = 'Поэзия')
WHERE genre_id is null and book_id=10;

UPDATE book
SET genre_id = (SELECT genre_id 
                FROM genre 
                WHERE name_genre = 'Приключения')
WHERE genre_id is null and book_id=11;

2.3.6
delete from author
where author_id in (select author_id from book
                    group by author_id
                    having sum(amount) < 20)
                    
2.3.7
delete from genre
where genre_id in (select genre_id from book
                    group by genre_id
                   having count(genre_id)<3)
                   
2.4.5
select buy.buy_id, book.title, book.price, buy_book.amount from client
inner join buy on client.client_id=buy.client_id
inner join buy_book on buy.buy_id=buy_book.buy_id
inner join book on book.book_id=buy_book.book_id
where client.client_id=1
order by buy_id, title

2.4.6
select name_author, title, count(buy_book.book_id) as Количество
from author
    left join book
    on book.author_id=author.author_id
    left join buy_book
    on buy_book.book_id=book.book_id
	where title is not null
group by name_author, title
order by name_author, title

2.4.7
select name_city, count(*) as Количество from buy
inner join client
on client.client_id=buy.client_id
inner join city
on city.city_id=client.city_id
group by name_city

2.4.8
select buy_id, date_step_end from buy_step
where step_id=1 and date_step_end is not null

2.4.9
select buy.buy_id, name_client, sum(buy_book.amount*book.price) as Стоимость from buy
join client on buy.client_id=client.client_id
join buy_book on buy_book.buy_id=buy.buy_id
join book on book.book_id=buy_book.book_id
group by buy.buy_id
order by buy.buy_id

2.4.10
select buy.buy_id, step.name_step from buy
join buy_step on buy_step.buy_id=buy.buy_id
join step on step.step_id=buy_step.step_id
where date_step_beg is not null and date_step_end is null

2.4.11
select buy.buy_id, 
  datediff(buy_step.date_step_end, buy_step.date_step_beg) as Количество_дней, 
  if(city.days_delivery-datediff(buy_step.date_step_end, buy_step.date_step_beg)>=0, 0, datediff(buy_step.date_step_end, buy_step.date_step_beg) - city.days_delivery) as Опоздание  
from city
join client on client.city_id=city.city_id
join buy on buy.client_id=client.client_id
join buy_step on buy_step.buy_id=buy.buy_id
where buy_step.step_id=3 and buy_step.date_step_end is not null
order by buy.buy_id

2.4.12
select name_client from client
join buy on buy.client_id=client.client_id
join buy_book on buy.buy_id=buy_book.buy_id
join book on book.book_id=buy_book.book_id
where book.author_id=2
group by name_client
order by name_client

2.4.13
select name_genre, sum(buy_book.amount) as Количество from buy_book
join book on book.book_id=buy_book.book_id
join genre on genre.genre_id=book.genre_id
group by genre.genre_id, name_genre
limit 1

2.5.2
insert into client(client_id, name_client, city_id, email)
values (5, 'Попов Илья', 1, 'popov@test')

2.5.3
insert into buy(buy_id, buy_description, client_id)
values(5, 'Связаться со мной по вопросу доставки', 5)

2.5.4
insert into buy_book(buy_id, book_id, amount)
values (5, 8, 2);
insert into buy_book(buy_id, book_id, amount)
values (5, 2, 1);

2.5.5
UPDATE book 
     INNER JOIN buy_book
     on book.book_id = buy_book.book_id
           SET book.amount = book.amount-buy_book.amount   
WHERE buy_book.buy_id = 5 ;

2.5.6
create table buy_pay(title varchar(50), name_author varchar(30), price decimal(8,2), amount int, Стоимость decimal(8,2)); 

insert into buy_pay (title, name_author, price, amount, Стоимость) 
select book.title, author.name_author, book.price, buy_book.amount, book.price*buy_book.amount from author 
inner join book on author.author_id = book.author_id 
inner join buy_book on book.book_id = buy_book.book_id 
where buy_book.buy_id = 5 
order by title; 

select title, name_author, price, amount, Стоимость from buy_pay;

2.5.7
create table buy_pay
select buy_id, sum(buy_book.amount) as Количество, sum(price*buy_book.amount) as Итого from buy_book
inner join book on book.book_id=buy_book.book_id
where buy_id=5
group by buy_id

2.5.8
insert into buy_step(buy_id, step_id)
select buy_id, step_id from buy
cross join step
where buy_id=5

2.5.9
update buy_step
set date_step_beg='2020-04-12'
where buy_id=5 and step_id=1

2.5.10
update buy_step
set date_step_end='2020-04-13'
where buy_id=5 and step_id=1;

update buy_step
set date_step_beg='2020-04-13'
where buy_id=5 and step_id=2;

3.1.2
select name_student, date_attempt, result from student
join attempt on attempt.student_id=student.student_id
join subject on subject.subject_id=attempt.subject_id
where name_subject='Основы баз данных'
order by result desc

3.1.3
select name_subject, count(result) as Количество, round(avg(result), 2) as Среднее from subject
left join attempt on subject.subject_id=attempt.subject_id
group by name_subject

3.1.4
select name_student, result from attempt
join student on student.student_id=attempt.student_id
where result=(select max(result) from attempt)

3.1.5
select name_student, name_subject, datediff(max(date_attempt), min(date_attempt)) as Интервал from attempt
join student on student.student_id=attempt.student_id
join subject on subject.subject_id=attempt.subject_id
group by name_student, name_subject
having count(*)>1
order by Интервал

3.1.6
select name_subject, count(distinct attempt.student_id) as Количество from subject
left join attempt on attempt.subject_id=subject.subject_id
group by subject.subject_id
order by name_subject, Количество desc

3.1.7
select question_id, name_question from question
join subject on subject.subject_id=question.subject_id
where subject.name_subject='Основы баз данных'
order by rand()
limit 3

3.1.8
select name_question, name_answer, if(is_correct, 'Верно', 'Неверно') as Результат from question
join testing on question.question_id=testing.question_id
join answer on answer.answer_id=testing.answer_id
where testing.attempt_id=7

3.1.9
select name_student, name_subject, date_attempt, round(sum(is_correct)/3*100, 2) as Результат from answer
join testing on testing.answer_id=answer.answer_id
join attempt on attempt.attempt_id=testing.attempt_id
join subject on subject.subject_id=attempt.subject_id
join student on student.student_id=attempt.student_id
group by name_student, name_subject, date_attempt
order by name_student, Результат desc

3.1.10
select 
name_subject, 
concat(left(name_question, 30), '...') as Вопрос, 
count(*) as Всего_ответов,
round(sum(is_correct)/count(*)*100, 2) as Успешность 
from subject
join question on question.subject_id=subject.subject_id
join testing on question.question_id=testing.question_id
join answer on answer.answer_id=testing.answer_id
group by question.question_id
order by name_subject, Успешность desc, Вопрос

3.2.2
insert into attempt(student_id, subject_id, date_attempt, result)
values (1, 2, now(), null)

3.2.3
insert into testing(attempt_id, question_id)
select attempt_id, question.question_id from question
join subject on subject.subject_id=question.subject_id
join attempt on attempt.subject_id=question.subject_id
where subject.subject_id=2 and attempt_id=(select max(attempt_id) from attempt)
order by rand()
limit 3

3.2.4
update attempt,
(
    select student.student_id, subject.subject_id, date_attempt, round(sum(is_correct)/3*100) as result from answer
    join testing on testing.answer_id=answer.answer_id
    join attempt on attempt.attempt_id=testing.attempt_id
    join subject on subject.subject_id=attempt.subject_id
    join student on student.student_id=attempt.student_id
    where attempt.attempt_id=8
    group by student.student_id, subject.subject_id, date_attempt
) as tmp
set attempt.result=tmp.result
where attempt_id=8;

3.2.5
delete from attempt
where date_attempt < '2020-05-01'

3.3.2
select name_enrollee from enrollee
join program_enrollee on program_enrollee.enrollee_id=enrollee.enrollee_id
join program on program_enrollee.program_id=program.program_id
where program.name_program="Мехатроника и робототехника"
order by name_enrollee 

3.3.3
select name_program from program
join program_subject on program_subject.program_id=program.program_id
join subject on subject.subject_id=program_subject.subject_id
where name_subject='Информатика'

3.3.4
select 
  name_subject, 
  count(*) as Количество, 
  max(result) as Максимум, 
  min(result) as Минимум, 
  round(avg(result), 1) as Среднее 
from subject
join enrollee_subject on enrollee_subject.subject_id=subject.subject_id
group by name_subject
order by name_subject

3.3.5
select distinct name_program from program
join program_subject on program_subject.program_id=program.program_id
group by name_program
having min(min_ball) >= 40
order by name_program

3.3.6
select name_program, plan from program
where plan=(select max(plan) from program)

3.3.7
select name_enrollee, ifnull(sum(a.add_ball), 0) as Бонус from enrollee e
left join enrollee_achievement ev on e.enrollee_id=ev.enrollee_id
left join achievement a on a.achievement_id=ev.achievement_id
group by name_enrollee

3.3.8
select 
  name_department, 
  p.name_program, plan, 
  count(*) as Количество, round(count(*)/plan, 2) as Конкурс 
from program_enrollee pe
join program p on pe.program_id=p.program_id
join department d on d.department_id=p.department_id
group by name_department, p.name_program, plan
order by plan, name_program desc

3.3.9
select p.name_program from subject s
join program_subject ps on s.subject_id=ps.subject_id
join program p on p.program_id=ps.program_id
where name_subject in ('Математика', 'Информатика')
group by name_program
having count(*)=2

3.3.10
SELECT p.name_program, e.name_enrollee, SUM(es.result) AS itog
FROM program_subject ps
    INNER JOIN program p USING(program_id)
    INNER JOIN program_enrollee pe USING(program_id)
    INNER JOIN enrollee e USING(enrollee_id)
    INNER JOIN enrollee_subject es ON es.subject_id = ps.subject_id AND
                                  es.enrollee_id = pe.enrollee_id
GROUP BY 1, 2
ORDER BY 1, 3 DESC;

3.3.11
SELECT name_program, name_enrollee
FROM enrollee
     JOIN program_enrollee USING(enrollee_id)
     JOIN program USING(program_id)
     JOIN program_subject USING(program_id)
     JOIN subject USING(subject_id)
     JOIN enrollee_subject USING(subject_id)
WHERE enrollee_subject.enrollee_id = enrollee.enrollee_id and result < min_result
ORDER BY 1, 2

3.4.1
CREATE TABLE applicant
SELECT program_id, enrollee.enrollee_id, SUM(result) AS itog
FROM enrollee
     JOIN program_enrollee USING(enrollee_id)
     JOIN program USING(program_id)
     JOIN program_subject USING(program_id)
     JOIN subject USING(subject_id)
     JOIN enrollee_subject USING(subject_id)
WHERE enrollee_subject.enrollee_id = enrollee.enrollee_id
GROUP BY program_id, enrollee_id
ORDER BY program_id, itog DESC;

3.4.2
DELETE FROM applicant
USING
  applicant
  JOIN (
    SELECT program_enrollee.program_id, program_enrollee.enrollee_id 
    FROM program
    JOIN program_subject  USING(program_id)
    JOIN program_enrollee USING(program_id)
    JOIN enrollee_subject ON 
    enrollee_subject.enrollee_id = program_enrollee.enrollee_id AND
    enrollee_subject.subject_id = program_subject.subject_id
    WHERE result < min_result
 ) AS t
 ON applicant.program_id = t.program_id AND
    applicant.enrollee_id = t.enrollee_id

3.4.3
UPDATE applicant JOIN (
    SELECT enrollee_id, IFNULL(SUM(bonus), 0) AS Бонус FROM enrollee_achievement
    LEFT JOIN achievement USING(achievement_id)
    GROUP BY enrollee_id 
    ) AS t USING(enrollee_id)
SET itog = itog + Бонус;

3.4.4
CREATE TABLE applicant_order
SELECT * FROM applicant
ORDER BY 1, 3 DESC;
DROP TABLE applicant

3.4.5
ALTER TABLE applicant_order ADD
str_id int FIRST

3.4.6
SET @row_num := 1;
SET @num_pr := 0;
UPDATE applicant_order
    SET str_id = IF(program_id = @num_pr, @row_num := @row_num + 1, @row_num := 1 AND @num_pr := @num_pr + 1);

3.4.7
CREATE TABLE student
SELECT name_program, name_enrollee, itog FROM enrollee
	JOIN applicant_order USING (enrollee_id)
	JOIN program USING (program_id)
WHERE str_id<=plan
ORDER BY name_program, itog DESC;

3.5.1
SELECT CONCAT(LEFT(CONCAT(module_id, ' ', module_name), 16), '...') Модуль,
       CONCAT(LEFT(CONCAT(module_id, '.', lesson_position, ' ', lesson_name), 16), '...') Урок,
       CONCAT(module_id, '.', lesson_position, '.', step_position, ' ', step_name) Шаг
  FROM module
       INNER JOIN lesson USING(module_id)
       INNER JOIN step   USING(lesson_id)
 WHERE step_name LIKE '%ложенн% запрос%'
 ORDER BY module_id, lesson_id, step_id;

3.5.2
INSERT INTO step_keyword
SELECT step.step_id, keyword.keyword_id 
FROM 
    keyword
    CROSS JOIN step
WHERE step.step_name REGEXP CONCAT(' ', CONCAT(keyword.keyword_name, '\\b'))
GROUP BY step.step_id, keyword.keyword_id
ORDER BY keyword.keyword_id;

3.5.3
SELECT 
    concat(module_id,'.',lesson_position,
           IF(step_position < 10, ".0","."),
           step_position," ",step_name) AS Шаг
FROM
   step
   JOIN lesson USING(lesson_id)
   JOIN module USING(module_id)
   JOIN step_keyword USING (step_id)
   JOIN keyword USING(keyword_id)
WHERE keyword_name = 'MAX' OR keyword_name ='AVG'
GROUP BY ШАГ
HAVING COUNT(*) = 2
ORDER BY 1;

3.5.4
SELECT
    rate_group Группа, 
    CASE rate_group
        WHEN 'I'   THEN 'от 0 до 10'
        WHEN 'II'  THEN 'от 11 до 15'
        WHEN 'III' THEN 'от 16 до 27'
        ELSE 'больше 27'
    END Интервал,
    COUNT(*) Количество
FROM
(
    SELECT 
        CASE
            WHEN COUNT(DISTINCT step_id) <= 10 THEN 'I'
            WHEN COUNT(DISTINCT step_id) <= 15 THEN 'II'
            WHEN COUNT(DISTINCT step_id) <= 27 THEN 'III'
            ELSE 'IV'
        END rate_group
    FROM step_student
    WHERE result = 'correct'
    GROUP BY student_id
) query_in
GROUP BY rate_group
ORDER BY 1;

3.5.5
WITH table1 (step_name, correct, count) AS (   
SELECT 
  step_name, 
  SUM( IF (result = 'correct' , 1 , 0)) AS s, 
  COUNT(result) AS c
  FROM step 
  JOIN step_student USING (step_id)
  GROUP BY step_name
    )

SELECT  step_name AS Шаг, ROUND((correct/count)*100) AS Успешность
FROM table1
ORDER BY 2, 1

3.5.6
WITH get_passed (student_name, pssd)
    AS
        (
           SELECT student_name, COUNT(DISTINCT step_id) AS passed
           FROM student JOIN step_student USING(student_id)
           WHERE result = "correct"
           GROUP BY student_id
           ORDER BY passed
         )
SELECT student_name AS Студент, ROUND(100*pssd/(SELECT COUNT(DISTINCT step_id) FROM step_student)) AS Прогресс,
    CASE
        WHEN ROUND(100*pssd/(SELECT COUNT(DISTINCT step_id) FROM step_student)) =  100 THEN "Сертификат с отличием"
        WHEN ROUND(100*pssd/(SELECT COUNT(DISTINCT step_id) FROM step_student)) >= 80 THEN "Сертификат"
        ELSE ""
    END AS Результат
FROM get_passed
ORDER BY Прогресс DESC, Студент

3.5.7
SELECT student_name AS Студент, 
    CONCAT(LEFT(step_name, 20), '...') AS Шаг, 
    result AS Результат, 
    FROM_UNIXTIME(submission_time) AS Дата_отправки,
    SEC_TO_TIME(submission_time - LAG(submission_time, 1, submission_time) OVER (ORDER BY submission_time)) AS Разница
FROM student
    INNER JOIN step_student USING(student_id)
    INNER JOIN step USING(step_id)
WHERE student_name = 'student_61'
ORDER BY Дата_отправки;

3.5.8
SELECT ROW_NUMBER() OVER (ORDER BY Среднее_время) AS Номер,
    Урок, Среднее_время
FROM(
    SELECT 
        Урок, ROUND(AVG(difference), 2) AS Среднее_время
FROM
     (SELECT student_id,
             CONCAT(module_id, '.', lesson_position, ' ', lesson_name) AS Урок,
             SUM((submission_time - attempt_time) / 3600) AS difference
      FROM module INNER JOIN lesson USING (module_id)
                  INNER JOIN step USING (lesson_id)
                  INNER JOIN step_student USING (step_id)
      WHERE submission_time - attempt_time <= 4 * 3600
      GROUP BY 1, 2) AS query_1
GROUP BY 1) AS TA
order by 3;

3.5.9
SELECT  module_id AS Модуль, student_name AS Студент, COUNT(DISTINCT step_id) AS Пройдено_шагов ,
	ROUND(COUNT(DISTINCT step_id) / 
      MAX(COUNT(DISTINCT step_id)) OVER(PARTITION BY module_id) *100, 1) AS Относительный_рейтинг
FROM lesson 
	JOIN step USING (lesson_id)
	JOIN step_student USING (step_id)
	JOIN student USING (student_id)
WHERE result = 'correct'
GROUP BY module_id, student_name
ORDER BY 1, 4 DESC, 2

3.5.10
WITH get_time_lesson(student_name,  lesson, max_submission_time)
AS(
    SELECT student_name,  CONCAT(module_id, '.', lesson_position), MAX(submission_time)
    FROM step_student INNER JOIN step USING (step_id)
                          INNER JOIN lesson USING (lesson_id)
                          INNER JOIN student USING(student_id)
    WHERE  result = 'correct'  
    GROUP BY 1,2
    ORDER BY 1),
get_students(student_name)
AS(
    SELECT student_name 
    FROM get_time_lesson
    GROUP BY student_name
    HAVING COUNT(lesson) = 3)
SELECT student_name as Студент,  
       lesson as Урок, 
       FROM_UNIXTIME(max_submission_time) as Макс_время_отправки, 
       IFNULL(CEIL((max_submission_time - LAG(max_submission_time) OVER (PARTITION BY student_name ORDER BY max_submission_time )) / 86400),'-') as Интервал 
FROM get_time_lesson
WHERE student_name in (SELECT * FROM get_students)
ORDER BY 1,3;

3.5.11
SET @avg_time := (SELECT CEIL(AVG(submission_time - attempt_time))
FROM step_student INNER JOIN student USING(student_id)
WHERE student_name = "student_59" AND (submission_time - attempt_time) < 3600);
WITH get_stat
AS
(
SELECT student_name, CONCAT(module_id, ".", lesson_position, ".", step_position) AS less, step_id, RANK() OVER (PARTITION BY CONCAT(module_id, ".", lesson_position, ".", step_position) ORDER BY submission_time) AS rang, result, 
CASE
    WHEN (submission_time - attempt_time) > 3600 THEN @avg_time
    ELSE (submission_time - attempt_time)
END AS qr
FROM student 
    INNER JOIN step_student USING(student_id)
    INNER JOIN step USING(step_id)
    INNER JOIN lesson USING(lesson_id)
WHERE student_name = "student_59"
)
SELECT student_name AS Студент, less AS Шаг, rang AS Номер_попытки, result AS Результат, SEC_TO_TIME(CEIL(qr)) AS Время_попытки, ROUND((qr / (SUM(qr) OVER (PARTITION BY less ORDER BY less)) * 100), 2) AS Относительное_время
FROM get_stat
ORDER BY step_id, 3;

4.1.1
SELECT beg_range, end_range,
     ROUND(AVG(price), 2) AS Средняя_цена,
     SUM(price * amount) AS Стоимость,
     COUNT(amount) AS Количество
FROM(
    SELECT beg_range, end_range, price, amount
    FROM stat 
    JOIN book ON beg_range<price AND end_range>price
    ) table1    
GROUP BY beg_range, end_range
ORDER BY 1

4.1.2
SELECT *
FROM book
ORDER BY LENGTH(title)

4.1.3
DELETE book, supply 
FROM book, supply
WHERE book.price LIKE '%.99' 
    AND supply.price LIKE '%.99';

4.1.4
SELECT author, title, price, amount,
    IF(price > 600, ROUND(price * 0.2, 2), '-') AS sale_20, 
    IF(price > 600, ROUND(price * 0.8, 2),  '-') AS price_sale
FROM book
ORDER BY author, title

4.1.5
SET @avg_price := (SELECT AVG(price) FROM book);
SELECT author,  
    SUM(price * amount) AS Стоимость 
FROM book
WHERE author in (SELECT author FROM book WHERE price > @avg_price)
GROUP BY author
ORDER BY 2 DESC;

4.1.6
SELECT author AS "Автор", title AS "Название_книги", amount AS "Количество", price AS "Розничная_цена",
    IF (amount >= 10, 15, 0) AS "Скидка",
    round (IF (amount >= 10, price * 0.85, price), 2) AS "Оптовая_цена"    
FROM book
ORDER BY author, title;

4.1.7
SELECT author, 
    COUNT(author) AS Количество_произведений, 
    MIN(price) AS Минимальная_цена, 
    SUM(amount) AS Число_книг 
FROM book
WHERE amount > 1
GROUP BY author
HAVING COUNT(author) > 1
ORDER BY author;
