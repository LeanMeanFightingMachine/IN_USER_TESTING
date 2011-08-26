package com.emirates.emiratesIn.service
{
	import com.emirates.emiratesIn.enum.Config;
	import org.robotlegs.mvcs.Actor;

	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;

	/**
	 * @author Fraser Hobbs
	 */
	public class DatabaseService extends Actor
	{
		private var _connection:SQLConnection;

		public function openDatabaseConnection() : void
		{
			// create new sqlConnection
			_connection = new SQLConnection();
			_connection.addEventListener(SQLEvent.OPEN, connectionOpenHandler);
			_connection.addEventListener(SQLErrorEvent.ERROR, connectionErrorHandler);

			// get currently dir
			var databaseFile : File = File.applicationStorageDirectory.resolvePath(Config.DATABASE_NAME + ".db");

			// open database,If the file doesn't exist yet, it will be created
			_connection.openAsync(databaseFile);
		}

		private function createTables():void
		{
			createUserTable();
		}
		
		private function createUserTable():void
		{
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = _connection;
			var sql : String = "CREATE TABLE IF NOT EXISTS user (" + "    id INTEGER PRIMARY KEY AUTOINCREMENT," + "    created DATE NOT NULL" + ")";
			statement.text = sql;
			statement.addEventListener(SQLEvent.RESULT, createUserTableResult);
			statement.addEventListener(SQLErrorEvent.ERROR, createErrorHandler);
			statement.execute();
		}
		
		private function createResultTable():void
		{
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = _connection;
			var sql : String = "CREATE TABLE IF NOT EXISTS result (" + "    id INTEGER PRIMARY KEY AUTOINCREMENT," + "    created DATE NOT NULL," + "    user INTEGER" + ")";
			statement.text = sql;
			statement.addEventListener(SQLEvent.RESULT, createResultTableResult);
			statement.addEventListener(SQLErrorEvent.ERROR, createErrorHandler);
			statement.execute();
		}
		
		private function insertUser():void
		{
			var sql : String = "Insert into user(id,created) values('" + new Date() + "')";
		}
		
		private function insertResult():void
		{
			var sql : String = "Insert into results(id,created,user) values('" + new Date() + "',(SELECT LAST(id) FROM user))";
		}

		private function createErrorHandler(event : SQLErrorEvent) : void
		{
			trace("Details:", event.error.message);
		}

		private function connectionErrorHandler(event : SQLErrorEvent) : void
		{
			trace("Details:", event.error.message);
		}
		
		private function connectionOpenHandler(event : SQLEvent) : void
		{
			createTables();
		}
		
		private function createUserTableResult(event : SQLEvent) : void
		{
			createResultTable();
		}
		
		private function createResultTableResult(event : SQLEvent) : void
		{
		}
	}
}
