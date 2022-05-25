using System;
using System.Data.SqlClient;


namespace WvsCashDeamon
{
    class CashRepository
    {
        public Cash getCashFromAccount(string accountID) {
            SqlConnection con = DatabaseConnection.getConnection();
            Cash cash = new Cash();
            SqlCommand command = new SqlCommand("Select NexonCash from Account WHERE AccountName = @ID", con);
            command.Parameters.AddWithValue("@ID", accountID);
            using (SqlDataReader reader = command.ExecuteReader()) {
                if (reader.Read())
                {
                    cash.AccountID = accountID;
                    cash.NexonCash = Convert.ToInt32(reader["nexonCash"].GetType() != typeof(DBNull) ? reader["nexonCash"] : 0);
                    return cash;
                }
            }
            return null;
        }

        public bool buyCashItem(string accountID, int value)
        {
            SqlConnection con = DatabaseConnection.getConnection();
            string query = "UPDATE Account SET NexonCash = NexonCash - @CASH WHERE AccountName = @ID";
            Cash cash = getCashFromAccount(accountID);
            if (cash == null || cash.NexonCash < value) {
                return false;
            }
            using (SqlCommand command = new SqlCommand(query, con))
            {
                command.Parameters.AddWithValue("@ID", accountID);
                command.Parameters.AddWithValue("@CASH", value);
                command.ExecuteNonQuery();
            }
            return true;
        }


    }
}
