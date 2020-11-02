using NomadEcommerce.Lib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Configuration;

namespace NomadEcommerce.Model
{
    public class SessionModel
    {
        public const string SESSION_KEY = "NomadEcommerce";

        private TenentUserModel Auth { get; set; }

        private TenentModel Guest { get; set; }

        public int TenentId { get { return this.Guest.TenentId; } }

        public int TenentUserId { get { return this.Auth.TenentUserId; } }

        public bool IsAuthenticated()
        {
            return (null != this.Auth);
        }

        public void SetAuthSession(TenentUserModel TenentUserModel)
        {
            TenentUserModel.Password = "";
            this.Auth = TenentUserModel;
        }

        public void SetGuestSession(string DomainName)
        {
            List<SqlParameter> parameters = new List<SqlParameter>
                {
                    new SqlParameter("@TenentDomain", DomainName)
                };
            object result = DBService.Init.Execute("spTenent_List", parameters, DBService.RequestType.DataRow);
            if (null != result)
            {
                DataRow dr = (DataRow)result;
                this.Guest = TenentModel.LoadModel(dr);
            }
        }

        #region Session Messages
        public string ErrorMessage { get; set; }

        public string SuccessMessage { get; set; }

        public void ClearMessage()
        {
            this.ErrorMessage = null;
            this.SuccessMessage = null;
        }
        #endregion

        #region Instantiation
        private SessionModel(string DomainName = null)
        {
            /* When the domain is passed in from Global.Session_Start, initialize the guest session with the TenentModel. */
            if (null != DomainName)
            {
                this.SetGuestSession(DomainName);
            }
            this.SessionTimeout = 1800; //30 minutes
            this.AdvanceSessionTimeout();
        }

        public static SessionModel Current(string DomainName = null)
        {
            SessionModel output = new SessionModel();
            if (null != HttpContext.Current)
            {
                object storedModel = HttpContext.Current.Session[SESSION_KEY];
                if (null == storedModel)
                {
                    output = new SessionModel(DomainName);
                    HttpContext.Current.Session[SESSION_KEY] = output;
                }
                else
                {
                    output = (SessionModel)storedModel;
                }
            }
            return output;
        }
        #endregion

        #region Session Timeout Functions
        public DateTime SessionExpires { get; set; }

        public int SessionTimeout { get; set; }

        public void AdvanceSessionTimeout()
        {
            DateTime Now = DateTime.Now.AddSeconds(SessionTimeout);
            this.SessionExpires = Now;
        }

        public void DestroyAuthSession()
        {
        }

        public void DestroySession()
        {
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.Abandon();
        }

        public Boolean HasSessionExpired()
        {
            return this.SessionExpires <= DateTime.Now;
        }
        #endregion
    }
}