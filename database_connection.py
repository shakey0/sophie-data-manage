import os, psycopg
from psycopg.rows import dict_row

class DatabaseConnection:

    def connect(self, provided_connection):
        try:
            self.connection = psycopg.connect(provided_connection, row_factory=dict_row)
        except psycopg.OperationalError:
            raise Exception(f"Couldn't connect to the database {self._database_name()}! " \
                            f"Did you create it using `createdb {self._database_name()}`?")

    def seed(self, sql_filename):
        self._check_connection()
        if not os.path.exists(sql_filename):
            raise Exception(f"File {sql_filename} does not exist")
        with self.connection.cursor() as cursor:
            cursor.execute(open(sql_filename, "r").read())
            self.connection.commit()

    def execute(self, query, params=[]):
        self._check_connection()
        with self.connection.cursor() as cursor:
            cursor.execute(query, params)
            if cursor.description is not None:
                result = cursor.fetchall()
            else:
                result = None
            self.connection.commit()
            return result

    def executemany(self, query, params_list):
        self._check_connection()
        with self.connection.cursor() as cursor:
            cursor.executemany(query, params_list)
            self.connection.commit()

    CONNECTION_MESSAGE = '' \
        'DatabaseConnection.exec_params: Cannot run a SQL query as ' \
        'the connection to the database was never opened. Did you ' \
        'make sure to call first the method DatabaseConnection.connect` ' \
        'in your app.py file (or in your tests)?'

    def _check_connection(self):
        if self.connection is None:
            raise Exception(self.CONNECTION_MESSAGE)
