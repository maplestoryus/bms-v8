using System;

using System.Net;
using System.Net.Sockets;

namespace WvsCashDeamon
{
    class Session
    {
        private Socket _socket;

        byte[] _buffer = new byte[BillPack.SIZE];
        int _offset = 0;

        public Session(Socket socket)
        {
            _socket = socket;

            Program.ConnectedShops.Add(this);
            Console.WriteLine("Got connection: {0}", this);
            Program.UpdateConnectionCount();

            BeginReceive();
        }

        public override string ToString()
        {
            IPEndPoint endpoint = _socket.RemoteEndPoint as IPEndPoint;
            return string.Format("ShopServer @ {0}:{1}", endpoint.Address, endpoint.Port);
        }

        private void BeginReceive()
        {
            _socket.BeginReceive(_buffer, _offset, BillPack.SIZE - _offset, SocketFlags.None, EndReceive, null);
        }

        private void EndReceive(IAsyncResult iar)
        {
            int receivedLength;
            try
            {
                 receivedLength = _socket.EndReceive(iar);
                 if (receivedLength == 0) throw new Exception();
            }
            catch
            {
                OnDisconnect();
                return;
            }
            _offset += receivedLength;

            if (receivedLength == BillPack.SIZE)
            {
                _offset = 0;

                BillPack bp = new BillPack();
                bp.Decode(_buffer);
                Program.OnBillPack(bp, this);
            }


            BeginReceive();
        }

        private void OnDisconnect()
        {
            Console.WriteLine("Lost connection: {0}", this);
            Program.ConnectedShops.Remove(this);
            Program.UpdateConnectionCount();

            _socket = null;
        }

        public void SendBillPack(BillPack bp)
        {
            try
            {
                _socket.Send(bp.Encode());
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                OnDisconnect();
            }
        }

        public void SendHB()
        {
            BillPack bp = new BillPack();
            bp.ReqKey = 0;
            SendBillPack(bp);
        }
    }
}
