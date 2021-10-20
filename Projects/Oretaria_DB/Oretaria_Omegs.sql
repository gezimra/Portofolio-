create database Oretaria
use Oretaria


create table Furnizuesi(
	ID_Furnizuesi int not null primary key,
	Emri VARCHAR (30) not null,
	Qyteti VARCHAR (20), 
	Rruga VARCHAR (50),
	Nr_postar int,
	ZipKodi int,
)



create table Telefoni_F(
	ID_Furnizuesi int not null,
	Numri int,
	primary key(ID_Furnizuesi, Numri),
	foreign key(ID_Furnizuesi) references Furnizuesi(ID_Furnizuesi)
)

Create table Produkti(
	Barkodi varchar (50) not null primary key,
	Cmimi_Blerjes money not null,
	Cmimi_Shitjes money not null,
	Gjinia char(1),
	Sasia int,
	Prodhuesi varchar(30), 
	Materiali varchar(20),
	Check (Gjinia IN ('M','F','N'))
)

create table Furnizon(
	ID_Furnizuesi int not null references Furnizuesi(ID_Furnizuesi),
	Barkodi varchar(50) not null references Produkti(Barkodi),
	primary key(ID_Furnizuesi, Barkodi)
)

create table Bizhuteri(
	Barkodi varchar(50) not null references Produkti(Barkodi),
	primary key(Barkodi),
	Lloji char (15)
)

create table Syze(
	Barkodi varchar(50) not null references Produkti(Barkodi),
	primary key(Barkodi),
	Perdorimi varchar (15),
	Ngjyra varchar(20)
)

create table Ore(
	Barkodi varchar(50) not null references Produkti(Barkodi),
	primary key(Barkodi),
	Puna varchar (15),
	Ngjyra varchar(20)
)

create table Pjese_servisi(
	Barkodi varchar(50) not null references Produkti(Barkodi),
	primary key(Barkodi),
	Emri varchar (15),
	Kategoria varchar (15),
	Pershkrimi varchar(255)
)

create table Klienti(
	ID_Klienti int identity (1000,1) primary key,
	Emri varchar (15),
	Mbiemri varchar (15),
	Leternjoftimi int,
	mosha int, 
	pike int
)

create table Telefoni_K(
	ID_Klienti int not null,
	Numri int,
	primary key(ID_Klienti, Numri),
	foreign key(ID_Klienti) references Klienti(ID_Klienti)
)

create table Adresa_K(
	ID_Klienti int not null, 
	ID_Adresa int unique, 
	Qyteti varchar (15),
	Rruga varchar (30),
	Nr_postar int,
	ZIP_Kodi int,
	primary key(ID_Klienti,ID_Adresa),
	foreign key(ID_Klienti) references Klienti(ID_Klienti)
)

create table Fatura(
	ID_Fatura int identity (1,1) primary key, 
	Pershkrimi varchar (255), 
	Menyra_Pageses varchar (10),
	Totali money, 
	Data_shtypjes date,
	Klienti int not null, 
	Foreign key (Klienti) references Klienti(ID_Klienti)
)

create table Punetori(
	ID_Punetori int identity(1000,1) primary key,
	Emri varchar (15),
	Mbiemri varchar (15),
	Paga money default 400
)

create table Adresa_P(
	ID_Punetori int not null, 
	ID_Adresa int unique, 
	Qyteti varchar (15),
	Rruga varchar (30),
	Nr_postar int,
	ZIP_Kodi int,
	primary key(ID_Punetori,ID_Adresa),
	foreign key(ID_Punetori) references Punetori(ID_Punetori)
)
create table Telefoni_P(
	ID_Punetori int not null,
	Numri int,
	primary key(ID_Punetori, Numri),
	foreign key(ID_Punetori) references Punetori(ID_Punetori)
)
create table Departamenti(
	ID_Departamenti int unique, 
	Departamenti varchar (20),
	ID_Punetori int references Punetori(ID_Punetori)
)
create table Pun_Dep(
	ID_Punetori int,
	ID_Departamenti int, 
	primary key (ID_Punetori, ID_Departamenti),
	foreign key (ID_Punetori) references Punetori(ID_Punetori),
	foreign key (ID_Departamenti) references Departamenti(ID_Departamenti)
)

create table Blerja(
	ID_Blerja int not null, 
	Blerje_online bit not null,
	ID_Fatura int, 
	Punetori int, 
	Departamenti int,
	primary key(ID_Blerja),
	foreign key (ID_Fatura) references Fatura(ID_Fatura),
	foreign key (Punetori, Departamenti) references Pun_Dep(ID_Punetori, ID_Departamenti)
)

create table Shet (
	ID_Blerja int, 
	Barkodi varchar(50),
	cope int, 
	primary key(ID_Blerja, Barkodi),
	foreign key (ID_Blerja) references Blerja(ID_Blerja),
	foreign key (Barkodi) references Produkti(Barkodi)
)

create Table Transporti(
	ID_Transporti int, 
	Statusi varchar (20),
	Punetori int, 
	Departamenti int, 
	Fatura int,
	primary key (ID_Transporti),
	foreign key (Fatura) references Fatura(ID_Fatura),
	foreign key (Punetori, Departamenti) references Pun_Dep(ID_Punetori,ID_Departamenti)
)

create table Servisi (
	ID_Servis int, 
	Pershkrimi varchar (255),
	Cmimi money,
	Punetori int, 
	Departamenti int, 
	Fatura int,
	primary key (ID_Servis),
	foreign key (Fatura) references Fatura(ID_Fatura),
	foreign key (Punetori, Departamenti) references Pun_Dep(ID_Punetori,ID_Departamenti)
)

create table Serv_Perdore(
	Barkodi varchar(50),
	ID_Servis int, 
	primary key(Barkodi, ID_Servis),
	foreign key(Barkodi) references Produkti(Barkodi),
	foreign key(ID_Servis) references Servisi(ID_Servis)
)


insert into Furnizuesi values ('1', 'KOSIMPORT', 'Zona Indrustriale', 'Fushe Kosove', '23', '12000')
insert into Furnizuesi values ('2', 'Te Ademi', 'Hamdi Ibrahimi', 'Gjilan', '76', '60000')
insert into Furnizuesi values ('3', 'Akoma te Isaku', 'Abedin Fejza', 'Fushe Kosove', '15', '12000')
insert into Furnizuesi values ('4', 'Esati', 'Zona Indrustriale', 'Fushe Kosove', '34', '12000')
insert into Furnizuesi values ('5', 'Deluxe Time', 'Zona Indrustriale', 'Fushe Kosove', '52', '12000')
insert into Furnizuesi values ('6', 'AgroImpex', 'Adem Jashari', 'Ferizaj', '75', '50000')
insert into Furnizuesi values ('7', 'Mountal', 'Afrim  Dedinja', 'Peje', '37', '30000')
insert into Furnizuesi values ('8', 'Toni Impex', 'Adem Jashari', 'Gjilan', '92', '60000')
insert into Furnizuesi values ('9', 'Buqaj', 'M30', 'Lipjan', '152', '14000')
insert into Furnizuesi values ('10', 'Te Fatosi', 'M2', 'Prishtine', '98', '10000')


insert into Telefoni_F (ID_Furnizuesi,Numri) values (1, 044123456)
insert into Telefoni_F (ID_Furnizuesi,Numri) values (1, 044123457)
insert into Telefoni_F (ID_Furnizuesi,Numri) values (2, 044234567)
insert into Telefoni_F (ID_Furnizuesi,Numri) values (3, 044323456)
insert into Telefoni_F (ID_Furnizuesi,Numri) values (3, 044323457)
insert into Telefoni_F (ID_Furnizuesi,Numri) values (4, 044423466)
insert into Telefoni_F (ID_Furnizuesi,Numri) values (4, 044423465)
insert into Telefoni_F (ID_Furnizuesi,Numri) values (5, 044654321)
insert into Telefoni_F (ID_Furnizuesi,Numri) values (6, 044789456)
insert into Telefoni_F (ID_Furnizuesi,Numri) values (6, 049123456)
insert into Telefoni_F (ID_Furnizuesi,Numri) values (7, 044123987)
insert into Telefoni_F (ID_Furnizuesi,Numri) values (8, 043161856)
insert into Telefoni_F (ID_Furnizuesi,Numri) values (8, 044165945)
insert into Telefoni_F (ID_Furnizuesi,Numri) values (9, 048123456)

insert into Produkti values ('102030', 35, 40, 'M', 10, 'Esprit', 'Metal')
insert into Produkti values ('102031', 34, 80, 'F', 12, 'Esprit', 'Metal'),
insert into Produkti values ('103030', 28, 60, 'M', 5, 'Esprit', 'Lekure'),
insert into Produkti values ('103031', 27, 45, 'F', 9, 'Esprit', 'Lekure'),
insert into Produkti values ('202030', 52, 99, 'M', 7, 'Festina', 'Metal'),
insert into Produkti values ('202031', 50, 95, 'F', 10, 'Festina', 'Metal')
insert into Produkti values ('302010', 15, 35, 'M', 10, 'Daniel Klein', 'Metal')
insert into Produkti values ('301010', 20, 45, 'M', 10, 'Matrix', 'Plastike')
insert into Produkti values ('104030', 7, 15, 'M', 20, 'Esprit', 'Metal')
insert into Produkti values ('2030', 2, 5, 'N', 10, 'Renata', null)

insert into Ore (Barkodi,Ngjyra,Puna) values ('102030','Argjend','Bateri')
insert into Ore (Barkodi,Ngjyra,Puna) values ('102031','Argjend','Bateri')
insert into Ore (Barkodi,Ngjyra,Puna) values ('103030','Argjend','Bateri')
insert into Ore (Barkodi,Ngjyra,Puna) values ('103031','Ari','Bateri')
insert into Ore (Barkodi,Ngjyra,Puna) values ('202030','Arigjend','Bateri')
insert into Ore (Barkodi,Ngjyra,Puna) values ('202031','Ari','Bateri')

	Barkodi varchar(50) not null references Produkti(Barkodi),
	primary key(Barkodi),
	Perdorimi varchar (15),
	Ngjyra varchar(20)

insert into Syze (Barkodi,Ngjyra,Perdorimi) values ('302010','Ari','Per diell')
insert into Syze (Barkodi,Ngjyra,Perdorimi) values ('301010','Zeze','Optike')

insert into Bizhuteri (Barkodi,Lloji) values ('104030', 'Byzylyk')

insert into Pjese_servisi (Barkodi, Emri, Kategoria,Pershkrimi) values ('2030', '377', 'Ore', 'Bateri per ore dore')

insert into Punetori (Emri, Mbiemri, Paga) values ('Bedri','Rashiti', )

select * from Punetori

