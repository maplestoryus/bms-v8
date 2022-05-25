using System;

namespace WvsCashDeamon
{
    class Cash
    {
        private string accountId;
        private int nexonCash;

        public string AccountID
        {
            get { return accountId; }
            set { accountId = value; }
        }
        public int NexonCash
        {
            get { return nexonCash; }
            set { nexonCash = value; }
        }
    }
}
