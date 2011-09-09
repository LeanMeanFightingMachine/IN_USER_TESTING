package com.emirates.emiratesIn.service
{
	import flash.errors.SQLError;
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

			// get currently dir
			var databaseFile : File = File.documentsDirectory.resolvePath(Config.DATABASE_NAME + ".db");

			// open database, if the file doesn't exist yet, it will be created
			_connection.openAsync(databaseFile);
			
			try
			{
				_connection.open(databaseFile);
			}
			catch(error:SQLError)
			{
				Debug.log(error.name + " : " + error.message);
			}
			finally
			{
				createTables();
			}
		}
		
		public function getTypeComparisionData():Array
		{
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = _connection;
			var sql : String = "SELECT * FROM tests";
			statement.text = sql;
			
			try
			{
				statement.execute();
				
				var d:Array = statement.getResult().data;
				
				for(var i:int = 0; i < d.length; i++)
				{
					Debug.log(">>> " + d[i]);
					
					for (var j : String in d[i])
					{
						Debug.log(">>>>> " + j);
					}
				}
				
				return d;
			}
			catch(error:SQLError)
			{
				Debug.log(error.name + " : " + error.message);
			}
			
			return null;
		}
		
		public function insertUser():void
		{
			Debug.log("insertUser");
			
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = _connection;
			var sql : String = "INSERT INTO users(created) VALUES (" + new Date().getTime() + ")";
			statement.text = sql;
			
			try
			{
				statement.execute();
			}
			catch(error:SQLError)
			{
				Debug.log(error.name + " : " + error.message);
			}
		}
		
		public function insertTest(type:String, level:int, adjust:int, hold:int, position:int, feedback:Boolean):void
		{
			Debug.log("insertTest");
			
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = _connection;
			var sql : String = "INSERT INTO tests(created,user,type,level,adjust,hold,position,feedback) VALUES (" + new Date().getTime() + ", " + "(SELECT MAX(id) FROM users)" + ", '" + type + "', " + level + ", " + adjust + ", " + hold + ", " + position + ", " + feedback + ")";
			statement.text = sql;
			
			try
			{
				statement.execute();
			}
			catch(error:SQLError)
			{
				Debug.log(error.name + " : " + error.message);
			}
		}
		
		public function updateTest(target:int, startTime:int, completedTime:int):void
		{
			Debug.log(">>> updateTest : " + target + " : " + startTime +  " : " + completedTime);
			
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = _connection;
			var sql : String = "UPDATE tests SET target=" + target + ",startTime=" + startTime + ",completedTime=" + completedTime + " WHERE id=(SELECT MAX(id) FROM tests)";
			statement.text = sql;
			
			try
			{
				statement.execute();
			}
			catch(error:SQLError)
			{
				Debug.log(error.name + " : " + error.message + " : " + error.details);
			}
		}
		
		public function insertData(attention:int, hotspot:Boolean, hit:Boolean, time:int):void
		{
			Debug.log("insertData");
			
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = _connection;
			var sql : String = "INSERT INTO data(created,test,attention,hotspot,hit,time) VALUES (" + new Date().getTime() + ", " + "(SELECT MAX(id) FROM tests)" + ", '" + attention + "', " + hotspot + ", " + hit + ", " + time + ")";
			statement.text = sql;
			
			try
			{
				statement.execute();
			}
			catch(error:SQLError)
			{
				Debug.log(error.name + " : " + error.message + " : " + error.details);
			}
		}
		
		public function insertAnswer(question:int, answer:int):void
		{
			Debug.log("insertAnswer");
			
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = _connection;
			var sql : String = "INSERT INTO answers (created,test,question,answer) VALUES (" + new Date().getTime() + ", " + "(SELECT MAX(id) FROM tests)" + ", '" + question + "', " + answer + ")";
			statement.text = sql;
			
			try
			{
				statement.execute();
			}
			catch(error:SQLError)
			{
				Debug.log(error.name + " : " + error.message + " : " + error.details);
			}
		}

		private function createTables():void
		{
			createUsersTable();
		}
		
		private function createUsersTable():void
		{
			Debug.log("createUsersTable");
			
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = _connection;
			var sql : String = "CREATE TABLE IF NOT EXISTS users ( id INTEGER PRIMARY KEY AUTOINCREMENT, created INTEGER NOT NULL )";
			statement.text = sql;
			
			try
			{
				statement.execute();
			}
			catch(error:SQLError)
			{
				Debug.log(error.name + " : " + error.message);
			}
			finally
			{
				createTestsTable();
			}
		}
		
		private function createTestsTable():void
		{
			Debug.log("createTestsTable");
			
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = _connection;
			var sql : String = "CREATE TABLE IF NOT EXISTS tests ( id INTEGER PRIMARY KEY AUTOINCREMENT, created INTEGER NOT NULL, user INTEGER, type TEXT, level INTEGER, adjust INTEGER, hold INTEGER, position INTEGER, feedback BOOLEAN, target INTEGER, startTime INTEGER, completedTime INTEGER )";
			statement.text = sql;
			
			try
			{
				statement.execute();
			}
			catch(error:SQLError)
			{
				Debug.log(error.name + " : " + error.message);
			}
			finally
			{
				createDataTable();
			}
		}
		
		private function createDataTable():void
		{
			Debug.log("createDataTable");
			
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = _connection;
			var sql : String = "CREATE TABLE IF NOT EXISTS data ( id INTEGER PRIMARY KEY AUTOINCREMENT, created INTEGER NOT NULL, test INTEGER, attention INTEGER, hotspot BOOLEAN, hit BOOLEAN, time INTEGER )";
			statement.text = sql;
			
			try
			{
				statement.execute();
			}
			catch(error:SQLError)
			{
				Debug.log(error.name + " : " + error.message);
			}
			finally
			{
				createAnswersTable();
			}
		}
		
		private function createAnswersTable():void
		{
			Debug.log("createAnswersTable");
			
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = _connection;
			var sql : String = "CREATE TABLE IF NOT EXISTS answers ( id INTEGER PRIMARY KEY AUTOINCREMENT, created INTEGER NOT NULL, test INTEGER, question INTEGER, answer INTEGER )";
			statement.text = sql;
			
			try
			{
				statement.execute();
			}
			catch(error:SQLError)
			{
				Debug.log(error.name + " : " + error.message);
			}
			finally
			{
				
			}
		}
	}
}
