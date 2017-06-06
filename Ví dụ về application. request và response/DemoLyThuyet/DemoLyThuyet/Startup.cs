using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(DemoLyThuyet.Startup))]
namespace DemoLyThuyet
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
