📝 Notes Management System
A responsive and user-friendly Notes Management Web Application built with HTML, CSS, JavaScript, Flask (Python), and MySQL. This app allows users to create, read, update, and delete (CRUD) personal notes securely with user authentication.

🚀 Features
🔐 User Authentication (Register, Login, Logout)

📝 Create, View, Edit, and Delete Notes

📱 Responsive Design — mobile & desktop friendly

🎨 Clean UI with interactive hover effects & modern layout

💾 MySQL Database integration for persistent storage

📅 Notes display with timestamps

🔐 Secure password handling with bcrypt


🛠️ Tech Stack
Frontend: HTML5, CSS3, JavaScript

Backend: Python (Flask Framework)

Database: MySQL

Libraries: Bcrypt

Deployment: Can be hosted on Render, Vercel, or any WSGI-compatible server


📂 Folder Structure
Notes-Management/
│
├── static/
│   └── css, images, JS files
├── templates/
│   └── HTML templates (dashboard, login, register, etc.)
├── app.py
├── database.py
├── emailo.py
├── requirements.txt
└── README.md



✅ How to Run Locally
1.Clone the repo
git clone https://github.com/your-username/notes-management.git
cd notes-management

2.Install dependencies
pip install -r requirements.txt

3.Set up MySQL DB and update database.py

4.Run the app
python app.py


