require 'csv'
require 'sqlite3'

module GreenTechSegments
  class CsvToSqlite3
    def initialize(cvs_file)
      @cvs_file = cvs_file
    end

    def convert(db_file_path)
      csv_data = CSV.read(@cvs_file, headers: true)

      columns = csv_data.headers
      db = SQLite3::Database.new(db_file_path)
      table_name = 'timings'

      create_table_sql = "CREATE TABLE IF NOT EXISTS #{table_name} (#{columns.map { |c| "#{c} TEXT" }.join(', ')});"
      db.execute(create_table_sql)

      insert_sql = "INSERT INTO #{table_name} (#{columns.join(', ')}) VALUES (#{columns.map { '?' }.join(', ')});"
      insert_statement = db.prepare(insert_sql)

      csv_data.each do |row|
        insert_statement.execute(row.fields)
      end

      insert_statement.close
      db.close

      db_file_path
    end
  end
end