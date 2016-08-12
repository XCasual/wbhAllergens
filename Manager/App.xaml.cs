using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;

namespace AllerConnectManager
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        public static AllerConnectCommon.Services.UIControllerService UIController;

        protected override void OnStartup(StartupEventArgs e)
        {
            UIController = AllerConnectCommon.Services.UIControllerService.Instance;
            base.OnStartup(e);
        }
    }
}
