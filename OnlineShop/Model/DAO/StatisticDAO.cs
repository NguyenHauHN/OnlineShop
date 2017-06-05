using Model.EF;
using Model.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.DAO
{
    public class StatisticDAO
    {
        OnlineShopDbContext db = null;
        public StatisticDAO()
        {
            db = new OnlineShopDbContext();
        }
        public List<StatisticOrderViewModel> StatisticOrder(string startDate, string endDate)
        {
            var list = new List<StatisticOrderViewModel>();
            DateTime Start = Convert.ToDateTime(startDate);
            DateTime End = Convert.ToDateTime(endDate);
            var listAllDate = this.ListAllDate(Start, End);
            foreach(var item in listAllDate)
            {
                var statistic = new StatisticOrderViewModel();
                string date = item.ToString("yyyy-MM-dd");
                var amountProduct = db.Database.SqlQuery<int>("select Count(Amount) from [OrderProduct] where CAST(CreateDate as DATE) = '" + date + "'").First();
                var amountOrder = db.Database.SqlQuery<int>("select Count(ID) from [Order] where CAST(CreateDate as DATE) = '" + date + "'").First();
                statistic.AmountProduct = (long)amountProduct;
                statistic.AmountOrder = (long)amountOrder;
                statistic.Date = date;
                list.Add(statistic);
            }
            return list;
        }
        public List<DateTime> ListAllDate(DateTime startDate, DateTime endDate)
        {
            var listDate = new List<DateTime>();
            for (DateTime date = startDate; date <= endDate; date = date.AddDays(1))
                listDate.Add(date);
            return listDate;
        }
    }
}
