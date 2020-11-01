using NomadEcommerce.Model;
using System;
using System.Web.UI;
using System.Web.WebPages;

namespace NomadEcommerce
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        public void CreateUser(object sender, EventArgs e)
        {
            try
            {
                TenentUserModel tu = TenentUserModel.LoadModel(
                        this.EmailText.Text,
                        this.PasswordText.Text,
                        this.FirstNameText.Text,
                        this.LastNameText.Text
                        ).Create();

                if (0 < tu.TenentUserId)
                {
                    SessionModel.Current().SetAuthSession(tu);
                    Response.Redirect("~/Default.aspx");
                }
            }
            catch (Exception Exp)
            {
                this.Master.ErrorMessagePanel.Visible = true;
                this.Master.ErrorMessagePanel.GroupingText = Exp.Message;
            }
        }
    }
}