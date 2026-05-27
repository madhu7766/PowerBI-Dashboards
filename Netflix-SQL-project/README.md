<img width="2226" height="678" alt="logo" src="https://github.com/user-attachments/assets/e4fb3aa9-47dc-4ffa-91b8-1bdd09536a9b" />



# 🎬 Netflix Database – 15 Business Problems & SQL Solutions

---

### **1️⃣ Count the number of Movies vs TV Shows vs Documentaries**

```sql
SELECT 
    type, 
    COUNT(*) AS total_titles
FROM content
GROUP BY type;
```

---

### **2️⃣ Find the top 3 genres with the most content**

```sql
SELECT 
    genre, 
    COUNT(*) AS total_content
FROM content
GROUP BY genre
ORDER BY total_content DESC
LIMIT 3;
```

---

### **3️⃣ Find the average IMDb rating of Netflix Originals vs Non-Originals**

```sql
SELECT 
    netflix_original,
    ROUND(AVG(imdb_rating), 2) AS avg_rating
FROM content
GROUP BY netflix_original;
```

---

### **4️⃣ List all content released after 2018 with IMDb rating above 8.0**

```sql
SELECT 
    title, type, genre, release_year, imdb_rating
FROM content
WHERE release_year > 2018 
  AND imdb_rating > 8.0
ORDER BY imdb_rating DESC;
```

---

### **5️⃣ Find the longest movie on Netflix**

```sql
SELECT 
    title, duration_minutes
FROM content
WHERE type = 'Movie'
ORDER BY duration_minutes DESC
LIMIT 1;
```

---

### **6️⃣ Count total users by subscription type**

```sql
SELECT 
    subscription_type, 
    COUNT(*) AS total_users
FROM users
GROUP BY subscription_type;
```

---

### **7️⃣ Find the country with the most Premium subscribers**

```sql
SELECT 
    country, 
    COUNT(*) AS premium_users
FROM users
WHERE subscription_type = 'Premium'
GROUP BY country
ORDER BY premium_users DESC
LIMIT 1;
```

---

### **8️⃣ Find users whose subscription expires within the next 60 days**

```sql
SELECT 
    name, email, subscription_end
FROM users
WHERE DATEDIFF(subscription_end, CURDATE()) <= 60
  AND status = 'Active';
```

---

### **9️⃣ Calculate total active revenue by country**

```sql
SELECT 
    country, 
    SUM(monthly_fee) AS total_revenue
FROM users
WHERE status = 'Active'
GROUP BY country
ORDER BY total_revenue DESC;
```

---

### **🔟 Find the average monthly fee per subscription plan**

```sql
SELECT 
    subscription_type, 
    ROUND(AVG(monthly_fee), 2) AS avg_fee
FROM users
GROUP BY subscription_type;
```

---

### **11️⃣ Find top 5 most watched content by total watch duration**

```sql
SELECT 
    c.title, 
    SUM(v.duration_watched) AS total_minutes
FROM viewing_data v
JOIN content c ON v.content_id = c.content_id
GROUP BY c.title
ORDER BY total_minutes DESC
LIMIT 5;
```

---

### **12️⃣ Find which device type is used most by viewers**

```sql
SELECT 
    device, 
    COUNT(*) AS total_views
FROM viewing_data
GROUP BY device
ORDER BY total_views DESC;
```

---

### **13️⃣ Find the average completion rate by device type**

```sql
SELECT 
    device, 
    ROUND(AVG(completion_rate), 2) AS avg_completion
FROM viewing_data
GROUP BY device
ORDER BY avg_completion DESC;
```

---

### **14️⃣ Find which country’s users gave the highest average rating**

```sql
SELECT 
    u.country, 
    ROUND(AVG(v.rating_given), 2) AS avg_rating
FROM viewing_data v
JOIN users u ON v.user_id = u.user_id
GROUP BY u.country
ORDER BY avg_rating DESC
LIMIT 5;
```

---

### **15️⃣ Find the most liked content and total number of likes**

```sql
SELECT 
    c.title, 
    COUNT(*) AS total_likes
FROM user_preferences p
JOIN content c ON p.content_id = c.content_id
WHERE p.action_type = 'Like'
GROUP BY c.title
ORDER BY total_likes DESC
LIMIT 5;
```


Conclusion

This Netflix SQL Analysis project provides valuable insights into user behavior, content performance, and subscription patterns using structured SQL queries.
By exploring 15 real-world business problems, we analyzed:

Content Trends (top genres, IMDb ratings, originals vs non-originals)

User Insights (active subscribers, expiring plans, regional revenues)

Viewing Behavior (most-watched content, preferred devices, completion rate)

Engagement Metrics (likes, ratings, and overall popularity)


