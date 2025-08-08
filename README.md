# 🎬 Netflix Movies & TV Shows Data Analysis (PostgreSQL)

![Netflix Banner](https://upload.wikimedia.org/wikipedia/commons/6/69/Netflix_logo.svg)

## 📌 Overview
This project analyzes Netflix's movies and TV shows dataset using **PostgreSQL** to answer real-world business questions.  
From finding the **most common ratings** to identifying **top content-producing countries**, the queries showcase powerful SQL concepts like **window functions, string operations, and date filtering**.

---

## 🎯 Objectives
- Understand content distribution between Movies and TV Shows.
- Identify the most common ratings for each type of content.
- Analyze content trends by year, country, and genre.
- Discover special insights like longest movies, multi-season shows, and keyword-based categorization.

---

## 📂 Dataset
- **Source:** [Netflix Dataset on Kaggle](https://www.kaggle.com/shivamb/netflix-shows)  
- **Format:** CSV  
- **Size:** ~8,800 records  
- **Schema:**
```sql
CREATE TABLE netflix (
    show_id       VARCHAR(6) PRIMARY KEY,
    type          VARCHAR(10),
    title         VARCHAR(255),
    director      VARCHAR(255),
    casts         VARCHAR(1000),
    country       VARCHAR(150),
    date_added    VARCHAR(150),
    release_year  INT,
    rating        VARCHAR(10),
    duration      VARCHAR(20),
    listed_in     VARCHAR(150),
    description   VARCHAR(250)
);
