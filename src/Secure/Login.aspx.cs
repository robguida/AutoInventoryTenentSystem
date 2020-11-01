using NomadEcommerce.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NomadEcommerce.Secure
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void Authenticate(object sender, EventArgs e)
        {
            try
            {
                TenentUserModel tu = TenentUserModel.LoadModel(
                        this.EmailText.Text,
                        this.PasswordText.Text
                        ).Authenticate();

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