using Model.EF;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PagedList;
using Common;

namespace Model.DAO
{
    public class UserDAO
    {
        OnlineShopDbContext db = null;
        public UserDAO()
        {
            db = new OnlineShopDbContext();
        }

        public int Login (string Username, string Password, bool isLoginAdmin= false)
        {
            var result = db.Users.SingleOrDefault(x => x.Username == Username);
            if (result == null)
            {
                return -2;
            }
            else
            {
                if(isLoginAdmin == true)
                {
                    if(result.GroupID == CommonConstantCredential.ADMIN_GROUP || result.GroupID == CommonConstantCredential.SALE_GROUP || result.GroupID == CommonConstantCredential.ACCOUNTANT_GROUP)
                    {
                        if (result.Status == 0)
                            return -1;
                        else
                        {
                            if (result.Password == Password)
                            {
                                return 1;
                            }
                            else
                                return -2;

                        }
                    }
                    else
                    {
                        return -3;
                    }
                }
                else
                {
                    if (result.Status == 0)
                        return -1;
                    else
                    {
                        if (result.Password == Password)
                        {
                           
                            return 1;
                        }
                        else
                            return -2;

                    }
                }
                

                
            }
        }

        public int Register(string Name, string Username, string Password, string Email, string PhoneNumber)
        {
            var result = db.Users.FirstOrDefault(x => x.Username == Username);
            if(result == null)
            {
                var user = new User();
                user.Name = Name;
                user.Username = Username;
                user.Password = Password;
                user.Email = Email;
                user.Phone = PhoneNumber;
                user.JoinDate = DateTime.Now;
                user.Status = 1;
                user.Type = 0;
                db.Users.Add(user);
                db.SaveChanges();
                return 1;
            }
            else
            {
                return -1;
            }
        }

        public User GetByUsername(string username)
        {
            return db.Users.SingleOrDefault(x => x.Username == username);
        }

        public User GetByID(int ID)
        {
            return db.Users.Find(ID);
        }

        public IEnumerable<User> ListAllAdmin(string keyword, ref int totalAdmin, int page = 1, int pageSize = 5)
        {
            IQueryable<User> model = db.Users;
            if (!string.IsNullOrEmpty(keyword))
            {
                var list = db.Users.SqlQuery("select * from [User] where Type = 1 and Status !=2 and ( Name like N'%" + keyword + "%' or Username like N'%" + keyword + "%' or Email like N'%" 
                    + keyword + "%' or Address like N'%" + keyword  + "%')").AsQueryable<User>();
                model = list;
            }
            else
            {
                model = model.Where(x => x.Type == 1 && x.Status != 2);
            }


            totalAdmin = model.Count();
            return model.OrderByDescending(x => x.JoinDate).ToPagedList(page, pageSize);


        }

        public IEnumerable<User> ListAllCustomer(string keyword, ref int totalCustomer, int page = 1, int pageSize = 5)
        {
            IQueryable<User> model = db.Users;
            if (!string.IsNullOrEmpty(keyword))
            {
                var list = db.Users.SqlQuery("select * from [User] where Type = 0 and Status !=2 and ( Name like N'%" + keyword + "%' or Username like N'%" + keyword + "%' or Email like N'%"
                    + keyword + "%' or Address like N'%" + keyword + "%')").AsQueryable<User>();
                model = list;
            }
            else
            {
                model = model.Where(x => x.Type == 0 && x.Status != 2);
            }


            totalCustomer = model.Count();
            return model.OrderByDescending(x => x.JoinDate).ToPagedList(page, pageSize);
        }

        public List<User> ListAllUserOrder()
        {
            return db.Users.Where(x => x.Status == 1 && x.Type == 0).ToList();
        }

        public int Insert(User user)
        {
            var username = db.Users.SingleOrDefault(x => x.Username == user.Username);
            if (username != null)
            {
                return -1;
            }
            else
            {
                user.Type = user.Type;
                user.JoinDate = DateTime.Now;
                db.Users.Add(user);
                db.SaveChanges();
                return 1;
            }
        }

        public int Update(User user)
        {
            try
            {
                var userTemp = db.Users.Find(user.ID);
                userTemp.Name = user.Name;
                userTemp.Username = user.Username;
                userTemp.Password = user.Password;
                userTemp.Gender = user.Gender;
                userTemp.Address = user.Address;
                userTemp.Phone = user.Phone;
                userTemp.Email = user.Email;
                userTemp.Status = user.Status;
                userTemp.RecentChange = DateTime.Now;
                userTemp.Avatar = user.Avatar;
                db.SaveChanges();
                return 1;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public int Delete (int ID)
        {
            try
            {
                var user = db.Users.Find(ID);
                user.Status = 2;
                //db.Users.Remove(user);
                db.SaveChanges();
                return 1;
            }
            catch(Exception e)
            {
                return -1;
            }
            
        }

        public int ResetPassword(User user)
        {
            try
            {
                var userTemp = db.Users.Where(x => x.Username == user.Username).FirstOrDefault();
                if (userTemp != null)
                {
                    if (userTemp.Email.Equals(user.Email))
                    {
                        userTemp.Password = user.Password;
                        db.SaveChanges();
                        return 1;
                    }
                    else
                    {
                        return -3;
                    }

                }
                else
                {
                    return -2;
                }

            }
            catch (Exception)
            {
                return -1;
            }
        }

        public List<string> GetListCredential(string username)
        {
            var user = db.Users.Single(x => x.Username == username);
            var data = (from a in db.Credentials
                       join b in db.UserGroups on a.UserGroupID equals b.ID
                       join c in db.Roles on a.RoleID equals c.ID
                       where b.ID == user.GroupID
                       select new
                       {
                           RoleID = a.RoleID,
                           UserGroupID = a.UserGroupID
                       }).AsEnumerable().Select(x => new Credential() {
                           RoleID = x.RoleID,
                           UserGroupID = x.UserGroupID
                       });
            return data.Select(x => x.RoleID).ToList();
        }
    }
}
