from database_connection import DatabaseConnection

connection = DatabaseConnection()
connection.connect("postgresql://localhost:5432/sophie-data-local")
connection.seed("seed_database.sql")
