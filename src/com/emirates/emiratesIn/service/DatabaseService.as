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
		private var conn : SQLConnection;
		private var sqlStat : SQLStatement;
		
		private var _connection:SQLConnection;

		public function openDatabaseConnection() : void
		{
			// create new sqlConnection
			_connection = new SQLConnection();
			_connection.addEventListener(SQLEvent.OPEN, onDatabaseOpen);
			_connection.addEventListener(SQLErrorEvent.ERROR, errorHandler);

			// get currently dir
			var databaseFile : File = File.applicationStorageDirectory.resolvePath(Config.DATABASE_NAME + ".db");

			// open database,If the file doesn't exist yet, it will be created
			_connection.openAsync(databaseFile);
		}

		// connect and init database/table
		private function onDatabaseOpen(event : SQLEvent) : void
		{
			// init sqlStatement object
			sqlStat = new SQLStatement();
			sqlStat.sqlConnection = conn;
			var sql : String = "CREATE TABLE IF NOT EXISTS user (" + "    id INTEGER PRIMARY KEY AUTOINCREMENT, " + "    name TEXT, " + "    password TEXT" + ")";
			sqlStat.text = sql;
			sqlStat.addEventListener(SQLEvent.RESULT, statResult);
			sqlStat.addEventListener(SQLErrorEvent.ERROR, createError);
			sqlStat.execute();
		}

		private function statResult(event : SQLEvent) : void
		{
			// refresh data
			var sqlresult : SQLResult = sqlStat.getResult();
			if (sqlresult.data == null)
			{
				getResult();
				return;
			}
			
		}

		// get data
		private function getResult() : void
		{
			var sqlquery : String = "SELECT * FROM user";
			excuseUpdate(sqlquery);
		}

		private function createError(event : SQLErrorEvent) : void
		{
			trace("Details:", event.error.message);
		}

		private function errorHandler(event : SQLErrorEvent) : void
		{
			trace("Details:", event.error.message);
		}

		// update
		private function excuseUpdate(sql : String) : void
		{
			sqlStat.text = sql;
			sqlStat.execute();
		}

		// insert
		private function insertemp() : void
		{
			//var sqlupdate : String = "Insert into user(id,name,password) values('" + name.text + "','" + password.text + "')";
			//excuseUpdate(sqlupdate)
		}

		// delete
		private function deleteemp() : void
		{
			//var sqldelete : String = "delete from user where id='" + datafiled.selectedItem.id + "'";
			//excuseUpdate(sqldelete);
		}
	}
}
