create table users(
id int auto_increment PRIMARY KEY,
username varchar(50) not null,
email varchar(100) not null unique,
password varchar(255) not null
);

create table notes(
	id int auto_increment primary key,
	user_id int not null,
	content text not null,
	created_at TIMESTAMP DEFAULT current_timestamp,
	foreign key (user_id) REFERENCES users(id) on delete cascade
);