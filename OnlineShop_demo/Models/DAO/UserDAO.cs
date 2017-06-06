using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.EF;
using PagedList;

namespace Models.DAO
{
    public class UserDAO
    {
        OnlineShopDbContext db = null;
        public UserDAO()
        {
            db = new OnlineShopDbContext();
        }
        public long Insert(User entity)
        {
            db.Users.Add(entity);
            db.SaveChanges();
            return entity.ID;
        }

        public bool Update(User entity)
        {
            try
            {
                var user = db.Users.Find(entity.ID);
                user.Name = entity.Name;
                user.Address = entity.Address;
                if (string.IsNullOrEmpty(entity.Password))
                {
                    user.Password = entity.Password;
                }
                user.Phone = entity.Phone;
                user.Email = entity.Email;
                user.Status = entity.Status;
                user.ModifiedBy = entity.ModifiedBy;
                user.ModifiedDate = DateTime.Now;
                db.SaveChanges();
                return true;
            }
            catch(Exception e)
            {
                return false;

            }
            
        }

        public User GetByID(int ID)
        {
            return db.Users.Find(ID);
        }

        public User ViewDetail(int id)
        {
            return db.Users.Find(id);
        }

        public IEnumerable<User> ListAll(string searchString, int page, int pageSize)
        {
            IQueryable<User> model = db.Users;
            if (!string.IsNullOrEmpty(searchString))
            {
                model = model.Where(x => x.Username.Contains(searchString) || x.Name.Contains(searchString));
            }
            return model.OrderByDescending(x => x.CreateDate).ToPagedList(page, pageSize);
        }

        public User GetByUsername(string username)
        {
            return db.Users.SingleOrDefault(x => x.Username == username);
        }
        public int Login(string username, string password)
        {
            var result = db.Users.SingleOrDefault(x => x.Username == username);
            if(result == null)
            {
                return 0;
            }
            else
            {
                if (result.Status == false)
                    return -1;
                else
                {
                    if (result.Password == password)
                    
                        return 1;
                    
                    else
                        return -2;

                }
            }
        }

        public bool Delete(int id)
        {
            try
            {
                var user = db.Users.Find(id);
                db.Users.Remove(user);
                db.SaveChanges();
                return true;
            }
            catch(Exception e)
            {
                return false;
            }
           
        }
    }
}
