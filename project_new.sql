#1.	Create DataBase BANK and Write SQL query to create above schema with constraints
#A.	Retail Banking Case Study
#The retail banking business model maintains records of Branch, Employees, Customers and Accounts as follows
#1.	Create DataBase BANK and Write SQL query to create above schema with constraints
create database bank;
use bank;
create table branch(
Branch_no int not null,
Branch_name char(50) not null
 );
create table employee(
Emp_no int,
Branch_no int unique, 
Fname char(10),
mname char(10),
lname char(10),
Dept  char(10),
Desig char(10),
Mngr_no int not null);

create table customer(
Cust_id int not null,
Fname char(10),
Mname char(10),
Lname char(10),
Occup varchar(10),
DoB  date);
create table accounts(
Acc_no int not null,
Branch_id int unique, 
Cust_no int,
curr_bal int,
OpnDT date,
Type char(10),
astatus char(10));

# 2.	Inserting Records into created tables Branch
insert into branch values(1,'delhi');
insert into branch values(2,'mumbai');
insert into customer values(1,'Ramesh','Chandra','Sharma','Service','1976-12-06');
insert into customer values(2,'Avinash','Sunder','Minha','Business','1974-10-16');
insert into accounts values(1,1,1,10000,'2012-12-15','Saving','Active');
insert into accounts values(2,2,2,5000,'2012-06-12','Saving','Active');
insert into employee values(1,1,'Mark','steve','Lara','Account','Accountant',2);
insert into employee values(2,2,'Bella','James','Ronald','Loan','Manager',1);
#3.	Select unique occupation from customer table
select * from customer;
select occup 
from customer;
#4.	Sort accounts according to current balance 
select  * from accounts;
select max(curr_bal) 
from accounts;

#5.	Find the Date of Birth of customer name ‘Ramesh’
select dob from customer where fname like 'ramesh';
#6.	Add column city to branch table
alter  table branch add city varchar(10);
#7.	Update the mname and lname of employee ‘Bella’ and set to ‘Karan’, ‘Singh’ 
UPDATE employee
SET mname='karan', 
lname = 'singh'
WHERE  fname='bella';
#8.	Select accounts opened between '2012-07-01' AND '2013-01-01'
select * from accounts;
SELECT *
FROM accounts
WHERE opndt between '2012-07-01' AND '2013-01-01';
#9.	List the names of customers having ‘a’ as the second letter in their names 
select fname 
from customer where fname like '_A%';
#10.	Find the lowest balance from customer and account table
select min(curr_bal) 
from accounts ;
#11.	Give the count of customer for each occupation
select count(occup)
from customer;
#12.	Write a query to find the name (first_name, last_name) of the employees who are managers.
select fname,lname
from employee where desig like 'manager';
#13.	List name of all employees whose name ends with a
SELECT *
FROM employee
WHERE fname LIKE '%a';
#14.	Select the details of the employee who work either for department ‘loan’ or ‘credit’
select * 
from employee where dept like 'loan' or 'credit';
#15.	Write a query to display the customer number, customer firstname, account number for the customer’s
# who are born after 15th of any month.
select a.cust_no,c.fname,a.acc_no,c.cust_id
from accounts a,customer c 
where a.cust_no=c.cust_id 
and day(.dob)>15;
#16.	Write a query to display the customer’s number, customer’s firstname, branch id and balance amount for people using JOIN.

select c.cust_id,c.fname,b.branch_no,a.curr_bal as balance_amount
from customer c ,branch b ,accounts a;
#17.	Create a virtual table to store the customers who are having the accounts in the same city as they live

select * from account;
select * from customer;

# creating new attribute city in customer table, which shows his city of residence.
select * from customer;
alter table customer add column city varchar(15);

# Now adding some values in branch_mstr and customer table

select * from customer;
select * from branch;

update branch set city='Delhi' where branch_no=1;
update branch set city='Mumbai' where branch_no=2;

update customer set city='Mumbai' where cust_id=1;
update customer set city='Mumbai' where cust_id=2;

select * from customer;
select * from account;
alter table customer rename column city to city_of_residence;

create view cust as
(select c.*,b.branch_name as branch_city 
from customer as c 
join branch as b 
on b.branch_name = c.city_of_residence);
select *from cust;



#18.	A. Create a transaction table with following details 
create table transaction (
TID MEDIUMINT NOT NULL auto_increment,
cust_id char(10),
branch_id char(10),
amount int,
atype char(10),
dob date,
primary key (TID));

#19.	Write a query to display the details of customer with second highest balance 
select * from customer;
select * from account;

select fname,t.custid,acnumber,atype,astatus,curbal from customer c
join
(select custid,acnumber,atype,astatus,curbal from account order by curbal desc limit 1,1)t
on c.custid=t.custid;


#20.	Take backup of the databse created in this case study
# 1. Backup of database taken using the server option.
# 2. Using data export in server menu.
# 3. A dump folder was created 1st for the database created 'project'.
# 4. A dump file was created after creating a dump folder. 
# 5. The backup of data base can be accessed using any of the 2 options.
# 6. Using data import in server option will help in fetching our backup dumps.







use casestudy;
#1. Display the product details as per the following criteria and sort them in descending order of category:
   #a.  If the category is 2050, increase the price by 2000
   #b.  If the category is 2051, increase the price by 500
   #c.  If the category is 2052, increase the price by 600
	

 select * from product;
select product_id,product_desc,product_class_code,product_quantity_avail,len,width,height,weight,product_price,
case
when product_class_code=2050 then product_price+2000
when product_class_code=2051 then product_price+500
when product_class_code=2052 then product_price+600
else product_price
end as increased_price
from product
order by product_class_code;
#2. List the product description, class description and price of all products which are shipped.
select oh.customer_id,product_id,
concat(customer_fname,' ',customer_lname) Full_Name,
product_price,product_class_desc,oi.order_id,state
from product p
join product_class pc using(product_class_code)
join order_items oi using(product_id)
join order_header oh using(order_id)
join online_customer oc using(customer_id)
join address ad using(address_id)
where ad.state != 'Karnataka' and pc.product_class_desc not in ('Toys','Books')
group by oc.customer_id order by p.product_id;


#3. Show inventory status of products as below as per their available quantity:
#a. For Electronics and Computer categories, if available quantity is < 10, show 'Low stock', 11 < qty < 30, show 'In stock', > 31, show 'Enough stock'
#b. For Stationery and Clothes categories, if qty < 20, show 'Low stock', 21 < qty < 80, show 'In stock', > 81, show 'Enough stock'
#c. Rest of the categories, if qty < 15 – 'Low Stock', 16 < qty < 50 – 'In Stock', > 51 – 'Enough stock'
#For all categories, if available quantity is 0, show 'Out of stock'.

select pc.product_class_desc, p.product_id, p.product_desc, p.product_quantity_avail,
case
when (pc.product_class_desc = 'Electronics or pc.product_class_dsc'='computer') and p.product_quantity_avail <=10 then 'LOWW STOCK'
when (pc.product_class_desc = 'Electronics or pc.product_class_dsc'='computer') and p.product_quantity_avail <=11 and 
      p.product_quantity_avail<=30 then 'IN STOCK'
when (pc.product_class_desc = 'Electronics or pc.product_class_dsc'='computer') and p.product_quantity_avail >=31 then 'ENOUGH STOCK'


when (pc.product_class_desc = 'stationary' or pc.product_class_desc='cloths') and p.product_quantity_avail <=20 then 'LOW STOCK'
when (pc.product_class_desc = 'stationary' or pc.product_class_desc='cloths') and p.product_quantity_avail >=21 and 
      p.product_quantity_avail<=80 then 'IN STOCK'
when (pc.product_class_desc = 'stationary' or pc.product_class_desc='cloths') and p.product_quantity_avail >= 81 then 'Enough Stock'
when p.product_quantity_avail <=15 then 'LOW STOCK'
else 'Enough stock'

End as 'Inventory_status'
from product p
inner join product_class pc on p.product_class_code = pc.PRODUCT_CLASS_CODE;
    
    
    
 #4. List customers from outside Karnataka who haven’t bought any toys or books   
select * from
(select customer_fname,customer_lname,product_id,product_desc,a.product_class_code,product_price,product_class_desc,
o.order_id,order_status,oh.customer_id,oc.address_id,state
from product a 
join product_class b using(product_class_code)
join order_items o using(product_id)
join order_header oh using(order_id)
join online_customer oc using(customer_id)
join address ad using(address_id))t
where product_class_desc not in('Toys','Books') and state not in ('Karnataka') 
group by customer_id;
 select * from online_customer;













