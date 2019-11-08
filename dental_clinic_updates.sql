#1 Change the address of the doctor named Jane Sweettooth, to a different city and street of your choice.
select employee.city, employee.street from employee where employee.name = 'Patterson';

UPDATE employee e
set city = 'Plock', street = 'Grabowa'
where name = 'Patterson';

#------------------------------------------------------
#2 . Change the salary of all doctors that had more than 100 appointments in 2019. The new salaries should correspond to an increase in
# 5% from the old values
select e.vat, e.name, e.salary from employee e where e.vat = '100006';
select distinct e.vat, e.name, e.salary from employee e, appointment a
WHERE e.vat = a.VAT_doctor and (select count(a.date_timestamp) from appointment a where e.VAT = a.VAT_doctor) > 4;

UPDATE doctor d, employee e
set e.salary = 1.05 * e.salary
where e.vat = d.vat and (select count(a.date_timestamp) from appointment a where d.VAT = a.VAT_doctor) > 4;

#------------------------------------------------------
#NOT_WORKING
#3 Delete the doctor named Jane Sweettooth from the database, removing also all the appointments and all the consultations (including
# the associated procedures, diagnosis and prescriptions) in which she
# was involved.
INSERT INTO 'employee' (`VAT`, `name`, `birth_date`, `street`, `city`, `zip`, `IBAN`, `salary`) VALUE
('100000', 'Patterson', '1969-12-31', 'P.O. Box 586, 4948 Lobortis. Rd.', 'Puntarenas', '36-367', 'SU002111042141706401', '2041.111');
SELECT * from  appointment a, employee e
where e.VAT = a.VAT_doctor and e.name = 'Patterson';

COMMIT;
delete from employee e where e.name = 'Patterson';
ROLLBACK ;
#------------------------------------------------------
# NOT TESTED
#4 Find the diagnosis code corresponding to gingivitis. Create also a new
# diagnosis code corresponding to periodontitis. Change the diagnosis
# from gingivitis to periodontitis for all clients where, for the same
# consultation/diagnosis, a dental charting procedure shows a value
# above 4 in terms of the average gap between the teeth and the gums.
INSERT INTO `diagnostic_code` (`ID`, `description`) VALUES
('7', 'gingivitis'),
('8', 'periodontitis');

UPDATE consultation_diagnostic
set ID = '8'
where (select avg(pch.measure) from procedure_charting pch natural join consultation natural join
    procedure_in_consultation natural join consultation_diagnostic where consultation_diagnostic.ID = '7')> 4;

