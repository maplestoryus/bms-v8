using System;
using System.Text;

using System.IO;

namespace WvsCashDeamon
{
    class BillPack
    {
        public const int SIZE = 517;
        

        public short ReqLen { get; set; }
        public short ReqType { get; set; }
        public int ReqKey { get; set; }
        public int UserNo { get; set; }
        public string UserID { get; set; }
        public string CharacterID { get; set; }
        public short PresentFlag { get; set; }
        public string RCharacterID { get; set; }
        public int GMReal { get; set; }
        public int GMBonus { get; set; }
        public int ReqChargeAmt { get; set; }
        public int ChargedAmt { get; set; }
        public long PurchaseNo { get; set; }
        public int CommodityID { get; set; }
        public int ItemID { get; set; }
        public short ItemCnt { get; set; }
        public int ItemUnitPrice { get; set; }
        public string ItemName { get; set; }
        public int RetCode { get; set; }
        public string RetMsg { get; set; }

        private byte[] GetStringAsBytes(string what, int length)
        {
            string text = what ?? "";
            byte[] textAsBytes = Encoding.ASCII.GetBytes(text);
            Array.Resize<byte>(ref textAsBytes, length);
            textAsBytes[length - 1] = 0; // Zero-terminate, to be sure
            return textAsBytes;
        }

        public byte[] Encode()
        {
            using (var stream = new MemoryStream(SIZE))
            using (var writer = new BinaryWriter(stream))
            {
                writer.Write(ReqLen);
                writer.Write(ReqType);
                writer.Write(ReqKey);
                writer.Write(UserNo);
                writer.Write(GetStringAsBytes(UserID, 51));
                writer.Write(GetStringAsBytes(CharacterID, 51));
                writer.Write(PresentFlag);
                writer.Write(GetStringAsBytes(RCharacterID, 51));
                writer.Write(GMReal);
                writer.Write(GMBonus);
                writer.Write(ReqChargeAmt);
                writer.Write(ChargedAmt);
                writer.Write(PurchaseNo);
                writer.Write(CommodityID);
                writer.Write(ItemID);
                writer.Write(ItemCnt);
                writer.Write(ItemUnitPrice);
                writer.Write(GetStringAsBytes(ItemName, 51));
                writer.Write(RetCode);
                writer.Write(GetStringAsBytes(RetMsg, 257));

                return stream.ToArray();
            }

        }

        public string GetStringFromBytes(byte[] bytes)
        {
            string ret = "";
            foreach (var b in bytes) 
                if (b == 0) break;
                else ret += (char)b;

            return ret.Length == 0 ? null : ret;
        }

        public void Decode(byte[] bytes)
        {
            using (var stream = new MemoryStream(bytes))
            using (var reader = new BinaryReader(stream))
            {
                ReqLen = reader.ReadInt16();
                ReqType = reader.ReadInt16();
                ReqKey = reader.ReadInt32();
                UserNo = reader.ReadInt32();
                UserID = GetStringFromBytes(reader.ReadBytes(51));
                CharacterID = GetStringFromBytes(reader.ReadBytes(51));
                PresentFlag = reader.ReadInt16();
                RCharacterID = GetStringFromBytes(reader.ReadBytes(51));
                GMReal = reader.ReadInt32();
                GMBonus = reader.ReadInt32();
                ReqChargeAmt = reader.ReadInt32();
                ChargedAmt = reader.ReadInt32();
                PurchaseNo = reader.ReadInt64();
                CommodityID = reader.ReadInt32();
                ItemID = reader.ReadInt32();
                ItemCnt = reader.ReadInt16();
                ItemUnitPrice = reader.ReadInt32();
                ItemName = GetStringFromBytes(reader.ReadBytes(51));
                RetCode = reader.ReadInt32();
                RetMsg = GetStringFromBytes(reader.ReadBytes(257));
            }
        }
    }
}
