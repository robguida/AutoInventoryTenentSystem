using NomadEcommerce.Controller;
using NomadEcommerce.Model;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NomadEcommerce
{
    public partial class Default : Page
    {
        private AutoController AC { get; set; }
        private DataTable AutoDataTable { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            SessionModel sm = SessionModel.Current();
            this.AC = new AutoController();
            if (!Page.IsPostBack)
            {
                if (!sm.IsAuthenticated())
                {
                    sm.ErrorMessage = "You are not authenticated";
                    Response.Redirect("~/Secure/Login.aspx");
                }
                this.AutoDataTable = this.AC.List();
                this.BindAutoResults();
                this.AuthTokenHidden.Value = sm.GetAuthToken();
            }
        }

        protected void BindAutoResults()
        {
            if (0 < this.AutoDataTable.Rows.Count)
            {
                this.AutoResultsRepeater.DataSource = this.AutoDataTable;
                this.AutoResultsRepeater.DataBind();
                this.AutoResultsPanel.Visible = true;
                this.AutoNoResultPanel.Visible = false;
            }
            else
            {
                this.AutoResultsPanel.Visible = false;
                this.AutoNoResultPanel.Visible = true;
            }
        }

        protected void LoadAutoResults(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemIndex != -1)
            {
                RepeaterItem MainRepeaterItem = e.Item;
            }
        }

        protected void FilterResults(object sender, EventArgs e)
        {
            this.AutoDataTable = this.AC.List("ModelNumber", this.SearchTextBox.Text);
            this.BindAutoResults();
        }

        protected void ClearResults(object sender, EventArgs e)
        {
            this.SearchTextBox.Text = "";
            this.AutoDataTable = this.AC.List();
            this.BindAutoResults();
        }
    }
}