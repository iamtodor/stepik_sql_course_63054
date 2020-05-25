3.1
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
select name_subject, count(*) as Количество, max(result) as Максимум, min(result) as Минимум, round(avg(result), 1) as Среднее from subject
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
select name_department, p.name_program, plan, count(*) as Количество, round(count(*)/plan, 2) as Конкурс from program_enrollee pe
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
