This repository contains the setup to Ingest following files into Postgres database.

**🔧 Tech Stack**

- Git
- Postgres
- PgAdmin or Dbeaver

**Prerequisites**
1. Python 3.8+
2. pip
3. PostgreSQL

Steps:
1. [Clone the repository](https://github.com/rajesh-veera/hinge-health-exercise)
   ```bash
   git clone git@github.com:rajesh-veera/hinge-health-exercise
   ```

2. Install Postgres
   For Mac: Follow this **[tutorial](https://daily-dev-tips.com/posts/installing-postgresql-on-a-mac-with-homebrew/)**
   ```bash
    pg_restore -U <computer-username> -d postgres data.dump
    ```
   
3. Install Dependencies
    Pandas
    ```bash
    pip install pandas
    ```
    SQL Alchemy
   ```bash
    pip install SQL Alchemy
    ```

5. Database connection --> update in load_data.py
   ```python
    DB_HOST = "localhost"
    DB_NAME = "database_name"
    DB_USER = "user_name"
    DB_PASSWORD = "password"
    DB_PORT = 5432  #change port if installed in another port
   ```

6. Source files --> update in load_data.py
   Place source files in the same directory as the script
   - us_softball_league.txt
   - unity_golf_club.csv
   - companies.csv
   
 
