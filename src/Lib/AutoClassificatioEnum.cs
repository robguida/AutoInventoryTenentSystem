using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.InteropServices;
using System.Web;

namespace NomadEcommerce.Lib
{
    public static class AutoClassificatioEnum
    {
        public const string Compact = "Compact";
        public const string Economy = "Economy";
        public const string Midsize = "Midsize";
        public const string Standard = "Standard";
        public const string Fullsize = "Fullsize";
        public const string Luxury = "Luxury";
        public const string Minivan = "Minivan";
        public const string Van = "Van";
        public const string Truck = "Truck";

        public static DataTable GetList()
        {
            DataTable output = new DataTable("Classifications");
            output.Columns.Add("display", Type.GetType("System.String"));
            output.Columns.Add("value", Type.GetType("System.String"));
            List<string> classifications = AutoClassificatioEnum.GetList(true);
            foreach (string classification in classifications)
            {
                DataRow dr = output.NewRow();
                dr["display"] = classification;
                dr["value"] = classification;
                output.Rows.Add(dr);
            }
            return output;
        }

        public static List<string> GetList(bool list)
        {
            return new List<string>
            {
                AutoClassificatioEnum.Compact,
                AutoClassificatioEnum.Economy,
                AutoClassificatioEnum.Midsize,
                AutoClassificatioEnum.Standard,
                AutoClassificatioEnum.Fullsize,
                AutoClassificatioEnum.Luxury,
                AutoClassificatioEnum.Minivan,
                AutoClassificatioEnum.Van,
                AutoClassificatioEnum.Truck
            };
        }

        public static bool Exists(string classification)
        {
            return AutoClassificatioEnum.GetList(true).Contains(classification, StringComparer.OrdinalIgnoreCase);
        }
    }
}