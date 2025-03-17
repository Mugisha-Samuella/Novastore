# NovaStore eCommerce Platform

A Java-based eCommerce platform built using Servlets, JSP, and PostgreSQL, following the MVC architecture. This project is designed as a classroom assignment demonstrating core Java web development concepts without using frameworks.

## Features

- 🔐 User Authentication (Login/Register)
- 🌐 Multi-language Support (English, Spanish, French)
- 🛍️ Product Catalog with Categories
- 🛒 Shopping Cart Functionality
- 💳 Checkout Process
- 📱 Responsive Design
- 🔍 Product Search and Filtering
- 👤 User Profile Management

## Technologies Used

- Java 11
- Servlets & JSP
- PostgreSQL Database
- Maven for Dependency Management
- BCrypt for Password Hashing
- JSTL for JSP
- Bootstrap 5 for UI
- Tomcat 9.x Server

## Prerequisites

- JDK 11 or later
- Apache Maven
- Apache Tomcat 9.x
- PostgreSQL 12 or later
- IDE (IntelliJ IDEA recommended)

## Project Structure

```
src/main/
├── java/
│   └── com/novastore/
│       ├── controller/    # Servlet controllers
│       ├── dao/          # Data Access Objects
│       ├── model/        # Entity classes
│       └── util/         # Utility classes
├── resources/
│   ├── database.properties
│   └── i18n/            # Internationalization files
└── webapp/
    ├── css/
    ├── WEB-INF/
    │   ├── views/       # JSP files
    │   └── web.xml
    └── index.jsp
```

## Database Setup

1. Create PostgreSQL database:

```sql
CREATE DATABASE novastore;
```

2. Execute the following SQL scripts:

```sql
-- Users Table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone_number VARCHAR(20)
);

-- Products Table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price NUMERIC(10,2) NOT NULL,
    stock_quantity INTEGER NOT NULL,
    category VARCHAR(50),
    image_url VARCHAR(255)
);
```

## Installation & Setup

1. Clone the repository:

```bash
git clone https://github.com/yourusername/novastore.git
cd novastore
```

2. Configure database connection in `src/main/resources/database.properties`:

```properties
db.url=jdbc:postgresql://localhost:5432/novastore
db.username=your_username
db.password=your_password
db.driver=org.postgresql.Driver
```

3. Build the project:

```bash
mvn clean package
```

4. Deploy to Tomcat:

- Copy the generated WAR file from `target/novastore.war` to Tomcat's webapps directory
- Or configure Tomcat in your IDE and run the project

## Running in IntelliJ IDEA

1. Open the project in IntelliJ IDEA
2. Configure Tomcat Server:

   - Go to Run → Edit Configurations
   - Click + and select "Tomcat Server → Local"
   - Configure your Tomcat installation
   - Under "Deployment" tab, add the artifact: novastore:war exploded
   - Set Application context to: `/novastore`

3. Run the project using the green play button

## Accessing the Application

After deployment, access the application at:

```
http://localhost:8080/novastore
```

## Default Credentials

For testing purposes, you can use:

- Email: admin@novastore.com
- Password: admin123

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Bootstrap for the responsive UI components
- PostgreSQL for the robust database system
- Apache Tomcat for the servlet container
- The Java community for excellent documentation

## Contact

Your Name - your.email@example.com
Project Link: https://github.com/yourusername/novastore
