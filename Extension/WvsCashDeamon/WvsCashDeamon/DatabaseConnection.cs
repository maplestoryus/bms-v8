using System.Data.SqlClient;
namespace WvsCashDeamon
{
    class DatabaseConnection
    {
        private static string USERNAME = "centersrv";
        private static string PASSWORD = "donggus2gud";
        private static string SERVER = "";
        public static string CONNECTION_STR = "Server=@SERVER;Database=GlobalAccount;User Id=@ID;Password=@PASS;Encrypt=False;";

        private static SqlConnection INSTANCE = null;

        public static void setServer(string serverString) {
            SERVER = serverString;
        }

        public static SqlConnection getConnection() {
            if(INSTANCE != null){
                return INSTANCE;
            }
            string conString = CONNECTION_STR
                            .Replace("@ID", USERNAME)
                            .Replace("@SERVER", SERVER)
                            .Replace("@PASS", PASSWORD);
            INSTANCE = new SqlConnection(conString);
            INSTANCE.Open();
            return INSTANCE;
        }
    }
}
