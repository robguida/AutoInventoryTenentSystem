using NomadEcommerce.Controller;
using NomadEcommerce.Lib;
using NomadEcommerce.Model;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NomadEcommerce
{
    public partial class AutoCreate : Page
    {
        AutoController AC;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SessionModel sm = SessionModel.Current();
                if (!sm.IsAuthenticated())
                {
                    sm.ErrorMessage = "You are not authenticated";
                    Response.Redirect("~/Secure/Login.aspx");
                }
                this.SetUpForm();
            }
            else
            {
                this.AC = new AutoController();
            }
        }

        protected void SetUpForm()
        {
            this.ModelNumberDdl.DataSource = AutoModelNumberEnum.GetList();
            this.ModelNumberDdl.DataTextField = "display";
            this.ModelNumberDdl.DataValueField = "value";
            this.ModelNumberDdl.DataBind();
            this.ModelNumberDdl.Items.Insert(0, new ListItem("Select a Model", ""));

            this.ClassificationDdl.DataSource = AutoClassificatioEnum.GetList();
            this.ClassificationDdl.DataTextField = "display";
            this.ClassificationDdl.DataValueField = "value";
            this.ClassificationDdl.DataBind();
            this.ClassificationDdl.Items.Insert(0, new ListItem("Select a Classification", ""));

            this.ColorDdl.DataSource = (new AutoColorController()).List();
            this.ColorDdl.DataTextField = "DisplayName";
            this.ColorDdl.DataValueField = "AutoColorId";
            this.ColorDdl.DataBind();
            this.ColorDdl.Items.Insert(0, new ListItem("Select a Color", "0"));

            this.TrimLevelDdl.DataSource = (new AutoTrimController()).List();
            this.TrimLevelDdl.DataTextField = "DisplayName";
            this.TrimLevelDdl.DataValueField = "AutoTrimId";
            this.TrimLevelDdl.DataBind();
            this.TrimLevelDdl.Items.Insert(0, new ListItem("Select a Trim Level", "0"));
        }

        protected void CreateAuto(object sender, EventArgs e)
        {
            try
            {
                AutoInventoryModel AIM = this.AC.Create(
                    this.ModelNumberDdl.SelectedValue,
                    this.ClassificationDdl.SelectedValue,
                    this.VinText.Text,
                    this.ColorDdl.SelectedValue,
                    this.TrimLevelDdl.SelectedValue,
                    this.DoorsTextBox.Text
                    );
                if (0 < AIM.AutoInventoryId)
                {
                    SessionModel.Current().SuccessMessage = "Automobile saved!";
                    Response.Redirect("~/Default.aspx");
                }
                else
                {
                    throw new Exception("Could not create the automobile");
                }
            }
            catch (Exception Exp)
            {
                this.Master.ErrorMessagePanel.Visible = true;
                this.Master.ErrorMessagePanel.GroupingText = Exp.Message;
            }
        }

        protected void LoadDummyData(object sender, EventArgs e)
        {
            AutoController AC = new AutoController();
            DataTable models = AutoModelNumberEnum.GetList();
            DataTable classes = AutoClassificatioEnum.GetList();
            DataTable colors = (new AutoColorController()).List();
            DataTable trims = (new AutoTrimController()).List();
            Int64 VIN = 12345678901234567;
            foreach (DataRow model in models.Rows)
            {
                string ModelNumber = model.Field<string>("value");
                foreach (DataRow _class in classes.Rows)
                {
                    string ClassName = _class.Field<string>("value");
                    foreach (DataRow color in colors.Rows)
                    {
                        int AutoColorId = color.Field<int>("AutoColorId");
                        foreach (DataRow trim in trims.Rows)
                        {
                            int AutoTrimId = trim.Field<int>("AutoTrimId");
                            for (int Door = 2; Door <= 5; Door++)
                            {
                                AC.Create(ModelNumber, ClassName, VIN.ToString(), AutoColorId, AutoTrimId, Door);
                                VIN++;
                            }
                        }
                    }
                }

            }
        }
    }
}