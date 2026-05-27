# 📱 Teen Phone Addiction Analysis - Power BI Project

## Overview

A comprehensive Power BI dashboard analyzing teenage phone usage patterns and addiction levels. The project helps identify risk factors and provides actionable insights for parents, educators, and healthcare professionals.

## 📊 Project Highlights

* **Interactive Visualizations:** Track teen phone usage behavior across different time periods and categories.
* **Risk-Level Categorization:** Identify teens at risk based on daily screen time.
* **Parental Control Impact:** Analyze the effect of parental control settings on phone usage.
* **Sleep Pattern Correlation:** Explore the relationship between phone usage and sleep patterns.

## 🔧 Data Modeling & Measures

### DAX Measures Created

**1. Addiction Level**

```DAX
Addiction Level = 
SWITCH(
    TRUE(), 
    teen_phone_addiction_dataset[Daily_Usage_Hours] < 1, 1,   
    teen_phone_addiction_dataset[Daily_Usage_Hours] <= 2, 1,       
    teen_phone_addiction_dataset[Daily_Usage_Hours] <= 3, 2,      
    teen_phone_addiction_dataset[Daily_Usage_Hours] <= 4, 3,       
    teen_phone_addiction_dataset[Daily_Usage_Hours] <= 5, 6, 
    teen_phone_addiction_dataset[Daily_Usage_Hours] <= 6, 7,       
    teen_phone_addiction_dataset[Daily_Usage_Hours] <= 7, 8,
    teen_phone_addiction_dataset[Daily_Usage_Hours] <= 8, 9, 
    10
)
```

**2. Addiction Risk Level**

```DAX
Addiction Risk Level = 
SWITCH(
    TRUE(),
    teen_phone_addiction_dataset[Daily_Usage_Hours] < 2, "Safe",
    teen_phone_addiction_dataset[Daily_Usage_Hours] < 4, "Moderate",
    teen_phone_addiction_dataset[Daily_Usage_Hours] < 6, "Concerning",
    teen_phone_addiction_dataset[Daily_Usage_Hours] >= 6, "Critical",
    "Unknown"
)
```

**3. Average Daily Usage**

```DAX
Avg of Daily usage Hour = 
AVERAGE(teen_phone_addiction_dataset[Daily_Usage_Hours])
```

**4. Average Sleep Hours**

```DAX
Avg of sleep hours = 
AVERAGE(teen_phone_addiction_dataset[Sleep_Hours])
```

**5. Parental Control Status** (Calculated Column)

```DAX
Parental Control Status = 
IF(
    teen_phone_addiction_dataset[Parental_Control] = 1, 
    "YES", 
    "NO"
)
```

## 🛠️ Tools Used

* **Power BI Desktop:** Dashboard development and visualization
* **DAX:** Custom measures and calculated columns
* **Power Query:** Data transformation and cleaning

## 📂 Files Included

* `.pbix` file – Power BI dashboard
* Dataset – Teen phone addiction data
* `README.md` – Project documentation

## 🎯 Use Cases

* **Parental Awareness:** Inform parents about their teen's phone usage patterns.
* **School Counseling Programs:** Support guidance counselors with usage insights.
* **Digital Wellness Initiatives:** Aid organizations promoting healthy tech habits.
* **Healthcare Research:** Study correlations between screen time and sleep or mental health.


