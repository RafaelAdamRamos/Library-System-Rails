# Library System (Ruby on Rails)

> 🚧 **Project in development**  
> This project is in **active development**. Some features may be incomplete, subject to changes, or not yet available.  
> It is not recommended for production use in its current state.

## Description

This is a **library system under development**, whose goal is to allow centralized management of books, users, and loans.

The system was designed so that managers can manage the collection and loans, while users can browse available books and request loans in a simple way.

## Features

### Manager
- Book registration and management
- User management
- Approval and confirmation of returns
- Application of fines in case of delay
- Receiving alerts about loan deadlines

### User
- Viewing the list of available books
- Searching and filtering books by category
- Requesting a loan
- Indicating book return in the system
- Receiving alerts about the end of the loan period

## Loan Flow
1. The user requests a book loan.
2. The system controls the loan period.
3. Close to the due date, alerts are sent to the user and the manager.
4. The user informs the return through the system.
5. The manager confirms the return.
6. In case of delay or conflict, a fine is automatically applied after the final deadline.

## Project Status
- Initial system structure under development
- Basic registration features under implementation
- Loan system in evolution
- Notification system planned

## Planned Features
- Authentication and permission control system
- Automatic loan due date notifications
- Late fee system
- Loan history per user
- Improvements in system organization and validations

## Technologies Used
- Ruby on Rails
- Relational database
- HTML / ERB

## Requirements
- Ruby **3.4.7**

## How to run the project
1. Clone the repository:
```bash
   git clone https://github.com/RafaelAdamRamos/Library-System-Rails.git
````
2. Access the project directory:
```
cd Library-System-Rails
```

3. Install dependencies:
```
bundle install
```

4. Set up the database:
```
rails db:create db:migrate
````

5. Start the server:
```
rails server
```

6. Access in the browser:

http://localhost:3000

## Notes
- Project developed for study and learning purposes
- Structure, features, and technical decisions may change throughout development
