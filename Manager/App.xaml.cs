using AllerConnectManager.ViewModel;
using System;
using System.Collections.Generic;
using System.ComponentModel;
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
        public enum ViewStates
        {
            WelcomeView,
            AllergenSelectionView,
            AllergenView,
            ProductInformationView,
            ProductSelectionView,
            ProductView,
            InformationView
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

            base.OnStartup(e);
        }

        public static void IntiliazieViewModels()
        {
            dataTemplateVMDataContext.Add(ViewStates.WelcomeView, new WelcomeModel());
            dataTemplateVMDataContext.Add(ViewStates.AllergenView, new AllerConnectCommon.ViewModel.AllergenDisplayModel());
            dataTemplateVMDataContext.Add(ViewStates.ProductInformationView, new AllerConnectCommon.ViewModel.ProductInformationModel());
            dataTemplateVMDataContext.Add(ViewStates.AllergenSelectionView, new AllerConnectCommon.ViewModel.AllergenSelectionModel());
            dataTemplateVMDataContext.Add(ViewStates.ProductView, new AllerConnectCommon.ViewModel.ProductDisplayModel());
            dataTemplateVMDataContext.Add(ViewStates.ProductSelectionView, new AllerConnectCommon.ViewModel.ProductSelectionModel());
            dataTemplateVMDataContext.Add(ViewStates.InformationView, new InformationModel());
        }
    }
}
