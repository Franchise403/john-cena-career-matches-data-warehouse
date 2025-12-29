John Cena Wrestling Match Analytics

Overview
This project provides a structured analytics dataset covering John Cena’s professional wrestling career.  
The data was collected from raw match records from cagematch.net, cleaned, and transformed into analytics-ready CSV files, then modeled into a relational star schema using SQL Server.

The goal of this project is to provide a reusable dataset and data model for business intelligence, analytics practice, and portfolio demonstration.

What's Included
- Cleaned CSV datasets ready for analytics use
- SQL Server script to create a relational star schema (fact and dimension tables)
- Data dictionary describing all tables and fields
- Database model diagram created in SQL Server (SSMS)

Dataset Contents
The dataset includes:
- Match-level results and outcomes
- Championship and title history
- Venue and location information

The CSV files are designed to work together as part of a relational data model.

Data Modeling
The data warehouse follows a star schema design:
- One fact table capturing match-level events
- Multiple dimension tables for descriptive attributes
- Primary and foreign keys enforced for relational integrity

A screenshot of the finalized schema is included in the `/docs` folder.

Tools Used
- SQL Server
- Excel
- Power BI (in progress)

How to Use
1. Download the CSV files from the `/data` folder
2. Execute the SQL script in `/sql` to create the star schema in SQL Server
3. Load the CSV data into the corresponding tables
4. (Optional) Connect a BI tool such as Power BI for reporting and visualization

License
This project is released under the MIT License and is free to use for educational and analytical purposes.
