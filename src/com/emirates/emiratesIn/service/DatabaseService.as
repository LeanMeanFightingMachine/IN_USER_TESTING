package com.emirates.emiratesIn.service
{
	import com.emirates.emiratesIn.display.ui.debug.Debug;
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
			var databaseFile : File = File.documentsDirectory.resolvePath(Config.DATABASE_NAME + ".db");

			// open database,If the file doesn't exist yet, it will be created
			_connection.openAsync(databaseFile);
		}
		
		public function insertUser():void
		{
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = _connection;
			var sql : String = "INSERT INTO users(created) VALUES (" + new Date().getTime() + ")";
			statement.text = sql;
			statement.addEventListener(SQLEvent.RESULT, insertUserResult);
			statement.addEventListener(SQLErrorEvent.ERROR, insertErrorHandler);
			statement.execute();
			
			Debug.log("insertUser");
		}
		
		public function insertTest(type:String, level:int, adjust:int, hold:int, position:int, feedback:Boolean, target:int, startTime:int):void
		{
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = _connection;
			var sql : String = "INSERT INTO tests(created,user,type,level,adjust,hold,position,feedback,target,startTime) VALUES (" + new Date().getTime() + ", " + "(SELECT MAX(id) FROM users)" + ", '" + type + "', " + level + ", " + adjust + ", " + hold + ", " + position + ", " + feedback + ",  " + target + ", " + startTime + ")";
			statement.text = sql;
			statement.addEventListener(SQLEvent.RESULT, insertTestResult);
			statement.addEventListener(SQLErrorEvent.ERROR, insertErrorHandler);
			statement.execute();
		}

		private function createTables():void
		{
			createUsersTable();
		}
		
		private function createUsersTable():void
		{
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = _connection;
			var sql : String = "CREATE TABLE IF NOT EXISTS users ( id INTEGER PRIMARY KEY AUTOINCREMENT, created INTEGER NOT NULL )";
			statement.text = sql;
			statement.addEventListener(SQLEvent.RESULT, createUsersTableResult);
			statement.addEventListener(SQLErrorEvent.ERROR, createErrorHandler);
			statement.execute();
		}
		
		private function createTestsTable():void
		{
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = _connection;
			var sql : String = "CREATE TABLE IF NOT EXISTS tests ( id INTEGER PRIMARY KEY AUTOINCREMENT, created INTEGER NOT NULL, user INTEGER, type TEXT, level INTEGER, adjust INTEGER, hold INTEGER, position INTEGER, feedback BOOLEAN, target INTEGER, startTime INTEGER )";
			statement.text = sql;
			statement.addEventListener(SQLEvent.RESULT, createResultTableResult);
			statement.addEventListener(SQLErrorEvent.ERROR, createErrorHandler);
			statement.execute();
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
		
		private function createUsersTableResult(event : SQLEvent) : void
		{
			createTestsTable();
		}
		
		private function createResultTableResult(event : SQLEvent) : void
		{
		}
		
		private function insertErrorHandler(event : SQLErrorEvent) : void
		{
			Debug.log("insertErrorHandler : " + event.error.name + " : " + event.error.message + " : " + event.error.details);
		}

		private function insertUserResult(event : SQLEvent) : void
		{
			Debug.log("insertUserResult");
		}
		
		private function insertTestResult(event : SQLEvent) : void
		{
			Debug.log("insertTestResult");
		}
	}
}
