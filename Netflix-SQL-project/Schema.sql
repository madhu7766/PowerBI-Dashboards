create database n2;
use n2;
-- Netflix Database - 4 Essential Tables for Complete Analysis

-- 1. USERS Table - User information aur subscription details
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    country VARCHAR(50),
    subscription_type ENUM('Basic', 'Standard', 'Premium') NOT NULL,
    subscription_start DATE NOT NULL,
    subscription_end DATE,
    monthly_fee DECIMAL(6,2),
    status ENUM('Pending', 'Active', 'Inactive', 'Cancelled') DEFAULT 'Pending',
    join_date DATE DEFAULT (CURRENT_DATE)
);

-- 2. CONTENT Table - Sare movies aur shows ki details
CREATE TABLE content (
    content_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    type ENUM('Movie', 'TV Show', 'Documentary') NOT NULL,
    genre VARCHAR(100) NOT NULL,
    release_year INT,
    imdb_rating DECIMAL(3,1),
    language VARCHAR(50) DEFAULT 'English',
    country VARCHAR(50),
    director VARCHAR(255),
    duration_minutes INT, -- Movie ke liye total time, TV show ke liye avg episode time
    total_seasons INT DEFAULT 1, -- Movies ke liye 1, TV shows ke liye actual seasons
    content_rating ENUM('U', 'UA', 'A', 'TV-MA', 'PG-13') NOT NULL,
    netflix_original BOOLEAN DEFAULT FALSE,
    date_added DATE NOT NULL
);

-- 3. VIEWING_DATA Table - User ne kya dekha, kab dekha, kitna dekha
CREATE TABLE viewing_data (
    view_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    content_id INT NOT NULL,
    watch_date DATE NOT NULL,
    watch_time TIME NOT NULL, -- Kis time dekha
    duration_watched INT NOT NULL, -- Kitne minutes dekha
    device ENUM('TV', 'Mobile', 'Laptop', 'Tablet') NOT NULL,
    completion_rate DECIMAL(5,2), -- Percentage kitna complete dekha (0-100)
    rating_given DECIMAL(2,1), -- User ne rating di (1-5)
    season_number INT DEFAULT 1,
    episode_number INT DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (content_id) REFERENCES content(content_id)
);

-- 4. USER_PREFERENCES Table - User ki choices aur behavior
CREATE TABLE user_preferences (
    pref_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    content_id INT NOT NULL,
    action_type ENUM('Like', 'Dislike', 'Watchlist', 'Downloaded', 'Shared') NOT NULL,
    action_date DATE NOT NULL,
    watch_later BOOLEAN DEFAULT FALSE,
    recommended_to_others BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (content_id) REFERENCES content(content_id)
);

-- Sample Data for Analysis

-- Users data
INSERT INTO users (name, email, age, gender, country, subscription_type, subscription_start, subscription_end, monthly_fee, status) VALUES
('Sakshi Patel', 'sakshi@gmail.com', 31, 'Female', 'India', 'Basic', '2023-05-12', '2024-05-12', 199.00, 'Active'),
('David Johnson', 'david@gmail.com', 42, 'Male', 'UK', 'Premium', '2023-03-08', '2024-03-08', 12.99, 'Active'),
('Anna Mueller', 'anna@gmail.com', 26, 'Female', 'Germany', 'Standard', '2023-06-15', '2024-06-15', 9.99, 'Active'),
('Carlos Lopez', 'carlos@gmail.com', 38, 'Male', 'Mexico', 'Basic', '2023-02-20', '2023-08-20', 6.99, 'Cancelled'),
('Lisa Chen', 'lisa@gmail.com', 27, 'Female', 'Singapore', 'Premium', '2023-04-18', '2024-04-18', 13.98, 'Active'),
('Ravi Kumar', 'ravi@gmail.com', 33, 'Male', 'India', 'Standard', '2023-01-30', '2024-01-30', 499.00, 'Active'),
('Sophie Brown', 'sophie@gmail.com', 25, 'Female', 'Australia', 'Premium', '2023-05-25', '2024-05-25', 16.99, 'Active'),
('Yuki Tanaka', 'yuki@gmail.com', 29, 'Other', 'Japan', 'Standard', '2023-03-15', '2024-03-15', 1490.00, 'Active'),
('Omar Hassan', 'omar@gmail.com', 34, 'Male', 'Egypt', 'Basic', '2023-06-10', '2024-06-10', 4.99, 'Active'),
('Emma Wilson', 'emma@gmail.com', 23, 'Female', 'Canada', 'Standard', '2023-04-22', '2024-04-22', 14.99, 'Active');


-- Content data
INSERT INTO content (title, type, genre, release_year, imdb_rating, language, country, director, duration_minutes, total_seasons, content_rating, netflix_original, date_added) VALUES
('The Crown', 'TV Show', 'Drama', 2016, 8.7, 'English', 'UK', 'Peter Morgan', 60, 6, 'TV-MA', TRUE, '2016-11-04'),
('Dark', 'TV Show', 'Sci-Fi', 2017, 8.8, 'German', 'Germany', 'Baran bo Odar', 52, 3, 'TV-MA', TRUE, '2017-12-01'),
('Narcos', 'TV Show', 'Crime', 2015, 8.8, 'Spanish', 'Colombia', 'Chris Brancato', 49, 3, 'TV-MA', TRUE, '2015-08-28'),
('Bird Box', 'Movie', 'Thriller', 2018, 6.6, 'English', 'USA', 'Susanne Bier', 124, 1, 'A', TRUE, '2018-12-21'),
('Extraction', 'Movie', 'Action', 2020, 6.7, 'English', 'USA', 'Sam Hargrave', 116, 1, 'A', TRUE, '2020-04-24'),
('Scam 1992', 'TV Show', 'Drama', 2020, 9.3, 'Hindi', 'India', 'Hansal Mehta', 58, 1, 'A', FALSE, '2020-10-09'),
('Squid Game', 'TV Show', 'Thriller', 2021, 8.0, 'Korean', 'South Korea', 'Hwang Dong-hyuk', 54, 1, 'TV-MA', TRUE, '2021-09-17'),
('The Witcher', 'TV Show', 'Fantasy', 2019, 8.2, 'English', 'USA', 'Lauren Schmidt Hissrich', 55, 3, 'TV-MA', TRUE, '2019-12-20'),
('6 Underground', 'Movie', 'Action', 2019, 6.1, 'English', 'USA', 'Michael Bay', 128, 1, 'A', TRUE, '2019-12-13'),
('Arjun Reddy', 'Movie', 'Romance', 2017, 8.1, 'Telugu', 'India', 'Sandeep Reddy Vanga', 182, 1, 'A', FALSE, '2018-06-15'),
('Elite', 'TV Show', 'Drama', 2018, 7.5, 'Spanish', 'Spain', 'Carlos Montero', 50, 6, 'TV-MA', TRUE, '2018-10-05'),
('Our Planet', 'Documentary', 'Nature', 2019, 9.3, 'English', 'UK', 'Alastair Fothergill', 50, 1, 'U', TRUE, '2019-04-05'),
('13 Reasons Why', 'TV Show', 'Drama', 2017, 7.5, 'English', 'USA', 'Brian Yorkey', 57, 4, 'TV-MA', TRUE, '2017-03-31'),
('Marriage Story', 'Movie', 'Drama', 2019, 7.9, 'English', 'USA', 'Noah Baumbach', 137, 1, 'A', TRUE, '2019-12-06');
-- Viewing data
INSERT INTO viewing_data (user_id, content_id, watch_date, watch_time, duration_watched, device, completion_rate, rating_given, season_number, episode_number) VALUES
(6, 7, '2023-06-22', '21:45:00', 60, 'Mobile', 100.0, 4.7, 1, 1),
(7, 8, '2023-06-23', '20:15:00', 52, 'TV', 100.0, 4.9, 1, 1),
(8, 9, '2023-06-24', '19:00:00', 49, 'Laptop', 100.0, 4.6, 1, 1),
(9, 10, '2023-06-25', '22:00:00', 80, 'Mobile', 64.5, 3.2, 1, 1),
(10, 11, '2023-06-26', '20:45:00', 116, 'TV', 100.0, 4.3, 1, 1),
(11, 12, '2023-06-27', '21:15:00', 58, 'TV', 100.0, 4.8, 1, 1),
(12, 13, '2023-06-28', '19:30:00', 54, 'Laptop', 100.0, 4.1, 1, 1),
(13, 14, '2023-06-29', '20:00:00', 55, 'Mobile', 100.0, 4.4, 1, 1),
(14, 15, '2023-06-30', '21:00:00', 90, 'Tablet', 70.3, 3.7, 1, 1),
(15, 16, '2023-07-01', '22:30:00', 182, 'TV', 100.0, 4.9, 1, 1),
(1, 7, '2023-07-02', '20:30:00', 60, 'TV', 100.0, 4.6, 1, 2),
(2, 8, '2023-07-03', '21:45:00', 52, 'Mobile', 100.0, 4.7, 1, 2),
(3, 9, '2023-07-04', '19:15:00', 49, 'TV', 100.0, 4.8, 1, 3),
(4, 17, '2023-07-05', '20:00:00', 50, 'Laptop', 100.0, 4.5, 1, 1),
(5, 18, '2023-07-06', '21:30:00', 50, 'TV', 100.0, 4.9, 1, 1),
(6, 19, '2023-07-07', '22:00:00', 40, 'Mobile', 70.2, 4.2, 1, 1),
(7, 20, '2023-07-08', '20:45:00', 137, 'TV', 100.0, 4.6, 1, 1),
(8, 1, '2023-07-09', '19:00:00', 50, 'Tablet', 100.0, 4.8, 2, 1),
(9, 2, '2023-07-10', '21:15:00', 55, 'Laptop', 100.0, 4.3, 2, 1),
(10, 3, '2023-07-11', '20:30:00', 45, 'TV', 100.0, 4.7, 2, 1),
(11, 13, '2023-07-12', '22:00:00', 54, 'Mobile', 100.0, 4.4, 1, 2),
(12, 14, '2023-07-13', '19:45:00', 55, 'TV', 100.0, 4.5, 2, 1),
(13, 6, '2023-07-14', '21:00:00', 161, 'Laptop', 100.0, 4.9, 1, 1),
(14, 11, '2023-07-15', '20:15:00', 116, 'TV', 100.0, 4.2, 1, 1);

-- User preferences
INSERT INTO user_preferences (user_id, content_id, action_type, action_date, watch_later) VALUES
(6, 7, 'Like', '2023-06-22', FALSE),
(7, 8, 'Watchlist', '2023-06-23', TRUE),
(8, 9, 'Downloaded', '2023-06-24', FALSE),
(9, 10, 'Dislike', '2023-06-25', FALSE),
(10, 11, 'Like', '2023-06-26', FALSE),
(11, 12, 'Shared', '2023-06-27', FALSE),
(12, 13, 'Like', '2023-06-28', FALSE),
(13, 14, 'Watchlist', '2023-06-29', TRUE),
(14, 15, 'Dislike', '2023-06-30', FALSE),
(15, 16, 'Like', '2023-07-01', FALSE),
(1, 7, 'Downloaded', '2023-07-02', FALSE),
(2, 8, 'Like', '2023-07-03', FALSE),
(3, 9, 'Shared', '2023-07-04', FALSE),
(4, 17, 'Watchlist', '2023-07-05', TRUE),
(5, 18, 'Like', '2023-07-06', FALSE),
(6, 19, 'Dislike', '2023-07-07', FALSE),
(7, 20, 'Like', '2023-07-08', FALSE),
(8, 1, 'Watchlist', '2023-07-09', TRUE),
(9, 2, 'Downloaded', '2023-07-10', FALSE),
(10, 3, 'Like', '2023-07-11', FALSE),
(11, 13, 'Shared', '2023-07-12', FALSE),
(12, 14, 'Like', '2023-07-13', FALSE),
(13, 6, 'Watchlist', '2023-07-14', TRUE),
(14, 11, 'Like', '2023-07-15', FALSE),
(1, 13, 'Watchlist', '2023-07-16', TRUE),
(2, 14, 'Downloaded', '2023-07-17', FALSE),
(3, 7, 'Like', '2023-07-18', FALSE),
(4, 8, 'Shared', '2023-07-19', FALSE),
(5, 9, 'Like', '2023-07-20', FALSE);

select * from content;
select * from  user_preferences;
select * from  users;
select * from  viewing_data;





