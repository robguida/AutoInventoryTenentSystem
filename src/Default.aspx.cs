using NomadEcommerce.Model;
using System;
using System.Web.UI;

namespace NomadEcommerce
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //int TenentId = TenentModel.LoadModel("tester", "test.com").Create();
            //TenentIdLabel.Text = TenentId.ToString();
            TenentIdLabel.Text = "TEST";
        }
    }
}