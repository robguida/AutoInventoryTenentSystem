using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace NomadEcommerce.Model
{
    public class TenentUserModel : AbstractModel
    {
        public int TenentUserId { get; set; }

        public int TenentId { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string Email { get; set; }

        public string Password { get; set; }

        public string AuthKey { get; set; }

        private DateTime authKeyExpire { get; set; }
        public DateTime AuthKeyExpire { get { return this.authKeyExpire; } }

        protected override void SetTable()
        {
            this.TableName = "TenentUser";
        }

        public static TenentUserModel LoadModel(string Email, string Password, string FirstName = null, string LastName = null)
        {
            TenentUserModel output = new TenentUserModel
            {
                Email = Email,
                Password = Password,
                FirstName = FirstName,
                LastName = LastName
            };
            return output;
        }

        public static TenentUserModel LoadModel(DataRow dr)
        {
            TenentUserModel output = new TenentUserModel
            {
                Email = dr.Field<string>("Email"),
                Password = dr.Field<string>("Password"),
                FirstName = dr.Field<string>("FirstName"),
                LastName = dr.Field<string>("LastName")
            };
            if (dr.Table.Columns.Contains("TenentId"))
            {
                output.TenentId = dr.Field<int>("TenentId");
            }
            if (dr.Table.Columns.Contains("AuthKey"))
            {
                output.AuthKey = dr.Field<string>("AuthKey");
            }
            if (dr.Table.Columns.Contains("AuthKeyExpire"))
            {
                output.authKeyExpire = dr.Field<DateTime>("AuthKeyExpire");
            }
            return output;
        }

        public TenentUserModel Authenticate()
        {
            if (this.Email.Equals(""))
            {
                throw new Exception("Email is required to login");
            }
            if (this.Password.Equals(""))
            {
                throw new Exception("Password is required to login");
            }
            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter("@TenentId", SessionModel.Current().TenentId),
                new SqlParameter("@Email", this.Email),
                new SqlParameter("@Password", this.Password)
            };
            object result = this.Db.Execute("spTenentUser_Authenticate", parameters, Lib.DBService.RequestType.DataRow);
            if (null != result)
            {
                DataRow dr = (DataRow)result;
                if (dr.Table.Columns.Contains("error"))
                {
                    throw new Exception(dr.Field<string>("error"));
                }
                else
                {
                    this.Load(dr);
                }
            }
            return this;
        }

        public TenentUserModel Create()
        {
            if (this.Email.Equals(""))
            {
                throw new Exception("Email is required to create a User");
            }
            if (this.Password.Equals(""))
            {
                throw new Exception("Password is required to create a User");
            }
            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter("@Email", this.Email),
                new SqlParameter("@Password", this.Password),
                new SqlParameter("@FirstName", this.FirstName),
                new SqlParameter("@LastName", this.LastName)
            };
            int result = this.Create(parameters);
            if (0 < result)
            {
                this.TenentId = SessionModel.Current().TenentId;
                this.TenentUserId = result;
            }
            return this;
        }

        public void Load(DataRow dr)
        {
            this.TenentId = dr.Field<int>("TenentId");
            this.TenentUserId = dr.Field<int>("TenentUserId");
            this.Email = dr.Field<string>("Email");
            this.FirstName = dr.Field<string>("FirstName");
            this.LastName = dr.Field<string>("LastName");

            if (dr.Table.Columns.Contains("TenentId"))
            {
                this.TenentId = dr.Field<int>("TenentId");
            }
        }
    }
}