using AllerConnectInfo.ViewModel;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;

namespace AllerConnectInfo
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        public enum ViewStates
        {
            WelcomeView,
            ProductInformationView
        }

        private static ViewStates currentViewState;

        public static ViewStates CurrentViewState
        {
            get { return currentViewState; }
            set { currentViewState = value; }
        }

        public static AllerConnectCommon.Services.UIControllerService UIController;
        private static Dictionary<ViewStates, INotifyPropertyChanged> dataTemplateVMDataContext;


        public static INotifyPropertyChanged DataTemplateVWDataContext
        {
            get { return dataTemplateVMDataContext[CurrentViewState]; }
        }

        protected override void OnStartup(StartupEventArgs e)
        {
            UIController = AllerConnectCommon.Services.UIControllerService.Instance;

            CurrentViewState = ViewStates.WelcomeView;
            dataTemplateVMDataContext = new Dictionary<ViewStates, INotifyPropertyChanged>();
            dataTemplateVMDataContext.Add(ViewStates.WelcomeView, new WelcomeModel());

            base.OnStartup(e);
        }

        public static void IntiliazieViewModels()
        {
            dataTemplateVMDataContext.Add(ViewStates.ProductInformationView, new AllerConnectCommon.ViewModel.ProductInformationModel());
        }
    }
}
