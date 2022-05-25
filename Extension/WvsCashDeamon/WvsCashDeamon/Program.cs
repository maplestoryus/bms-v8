using System;
using System.Collections.Generic;

using System.Net;
using System.Net.Sockets;

namespace WvsCashDeamon
{
    class Program
    {
        public static List<Session> ConnectedShops = new List<Session>();
        private static Random random = new Random();

        static void Main(string[] args)
        {

            Console.Title = "WvsCashDeamon";
            if (args.Length > 0 && args[0] != "") {
                Console.WriteLine("Found parameter server: " + args[0]);
                DatabaseConnection.setServer(args[0]);
            }
            DatabaseConnection.getConnection();
            TcpListener listener = new TcpListener(IPAddress.Any, 36091);
            listener.Start();
            listener.BeginAcceptSocket(AcceptSocket, listener);

            Console.WriteLine("WvsCashDeamon started");
            while (true)
            {
                Console.ReadLine();
            }
        }

        static void AcceptSocket(IAsyncResult iar)
        {
            var listener = ((TcpListener)iar.AsyncState);
            try
            {
                new Session(listener.EndAcceptSocket(iar));
            }
            catch { }

            listener.BeginAcceptSocket(AcceptSocket, listener);
        }

        public static void UpdateConnectionCount()
        {
            Console.Title = string.Format("WvsCashDeamon - Connections: {0}", ConnectedShops.Count);
        }

        public static void OnBillPack(BillPack bp, Session session)
        {
            BillPack response = new BillPack();
            response.ReqKey = bp.ReqKey;
            response.ReqType = bp.ReqType;
            switch (bp.ReqType)
            {
                case 0x0A:
                    {
                        if (bp.UserID == null && bp.CharacterID == null && bp.UserNo == 1)
                        {
                            session.SendHB();
                            return;
                        }

                        Console.WriteLine("Got cash request for {0} (Char {1})", bp.UserID, bp.CharacterID);

                        CashRepository rep = new CashRepository();
                        Cash cash = rep.getCashFromAccount(bp.UserID);
                        response.GMReal = cash.NexonCash;
                        response.GMBonus = 0;

                        session.SendBillPack(response);

                        break;
                    }
                case 0x14:
                    {
                        Console.WriteLine("Got buy request for {0} (Char {1})", bp.UserID, bp.CharacterID);
                        response.RetCode = 0;
                        response.PurchaseNo = random.Next();
                        
                        CashRepository rep = new CashRepository();
                        bool ret = rep.buyCashItem(bp.UserID, bp.ItemUnitPrice * bp.ItemCnt);
                        if (!ret)
                        {
                            response.PurchaseNo = -1;
                            response.RetCode = -1;
                            Console.WriteLine("Did not not accepted XD (Purchase NR {0})", response.PurchaseNo);
                        }
                        else {
                            Console.WriteLine("Accepted XD (Purchase NR {0})", response.PurchaseNo);
                        }

                       

                        session.SendBillPack(response);
                        break;
                    }
                case 0x1E:
                    {
                        Console.WriteLine("Got 'Item buy has been handled' response for {0} (Char {1})", bp.UserID, bp.CharacterID);
                        response.RetCode = 0;
                        session.SendBillPack(response);
                        break;
                    }
                case 0x28:
                    {
                        Console.WriteLine("Got 'Item buy has failed' request for {0} (Char {1})", bp.UserID, bp.CharacterID);
                        response.RetCode = 0;
                        session.SendBillPack(response);
                        break;
                    }
                default:
                    {
                        Console.WriteLine("Got unknown BillPack request.");
                        Console.WriteLine("Type: {0:X2}, server: {1}", bp.ReqType, session);

                        break;
                    }
            }
        }
    }
}
