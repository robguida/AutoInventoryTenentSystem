using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.InteropServices;
using System.Web;

namespace NomadEcommerce.Lib
{
    public static class AutoModelNumberEnum
    {
        public const string J300 = "J300";
        public const string J600 = "J600";
        public const string Fury = "Fury";
        public const string Galaxy = "Galaxy";
        public const string Genesis = "Genesis";
        public const string Avalon = "Avalon";
        public const string GrandTour = "GrandTour";
        public const string Laramie = "Laramie";
        public const string X300 = "X300";

        public static DataTable GetList()
        {
            DataTable output = new DataTable("Classifications");
            output.Columns.Add("display", Type.GetType("System.String"));
            output.Columns.Add("value", Type.GetType("System.String"));
            List<string> classifications = AutoModelNumberEnum.GetList(true);
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
                AutoModelNumberEnum.J300,
                AutoModelNumberEnum.J600,
                AutoModelNumberEnum.Fury,
                AutoModelNumberEnum.Galaxy,
                AutoModelNumberEnum.Genesis,
                AutoModelNumberEnum.Avalon,
                AutoModelNumberEnum.GrandTour,
                AutoModelNumberEnum.Laramie,
                AutoModelNumberEnum.X300
            };
        }

        public static bool Exists(string modelNumber)
        {
            return AutoModelNumberEnum.GetList(true).Contains(modelNumber, StringComparer.OrdinalIgnoreCase);
        }
    }
}