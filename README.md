# Funnel Performance Analysis: Desktop vs Mobile

## Project Overview
This project analyzes **user behavior across a multi-step digital funnel**, comparing **desktop and mobile users** to identify where user drop-off occurs and how conversion efficiency differs by device type.

The objective of this analysis is to move beyond surface-level metrics and provide **actionable, business-relevant insights** into:
- Funnel attrition by stage  
- Step-to-step conversion performance  
- Behavioral differences across device segments  

The project demonstrates an end-to-end analytics workflow using **SQL (BigQuery)** for data modeling and **Tableau** for visualization.

## Dashboard Preview


<img width="656" height="714" alt="image" src="https://github.com/user-attachments/assets/12fe0904-4009-4602-a899-ea6fc55fc2a1" />



## Funnel Structure
The funnel consists of 5 major stages; 
1) Awareness - The user opening the app/site
2) Content View - User engages with content
3) Ad Click - User interacts with an advertisement
4) Checkout - User starts purchase process
5) Purchase - Transaction completed

## Key Insights
- Mobile users have stronger early stage engagment (Stages 1-3)
- Desktop users tend to get from stage 4 to stage 5 more compared to mobile users

## Methodology
Data Modeling
- Raw data was cleaned + standardized
- Users were segmented (desktop & mobile)
- Step-Step converstions were calculated (via safe_divide)
- A long-format table was created to easily transfer to Tableau
This process can be seen in more depth via the SQL folder, which includes all of the relevant code to the project

## Visualization
Two visualizations were created;
1) Funnel- User Drop-Off by Device
   - This displays total people per sequence, grouped via device type
   - This shows changes in volume between sequences
2) Conversion Rate by Funnel Step & Device
   - This shows the percent of people that are retained between sequences
   - This makes it easy to compare the difference in efficiency between device types
  
## Tools Used
- Bigquery (SQL)
- Tableau

## About Me
### Harrison Nordstrom
### Data Analytics | Virgina Tech 2026 | Economics - College of Science | nordstromharrison@gmail.com | www.linkedin.com/in/nordstromharrison
### This project is part of my portfolio that demonstrated my problem solving skills and technical proficiency

This project can be found on my Tableau Account;
https://public.tableau.com/views/FunnelPerformancebyDeviceType/Dashboard1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link



