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

        public enum CompositeViewStates
        {
            None,
            TreeCategoryView,
            TreeProductView,
            TreePartproductView,
            TreeIngridientView
        }

        private static ViewStates currentViewState;

        public static ViewStates CurrentViewState
        {
            get { return currentViewState; }
            set { currentViewState = value; }
        }

        private static CompositeViewStates currentCompositeViewState;

        public static CompositeViewStates CurrentCompositeViewState
        {
            get { return currentCompositeViewState; }
            set { currentCompositeViewState = value; }
        }

        public static AllerConnectCommon.Services.UIControllerService UIController;

        private static Dictionary<ViewStates, INotifyPropertyChanged> dataTemplateVMDataContext;
        private static Dictionary<CompositeViewStates, INotifyPropertyChanged> dataTemplateVMCompositeDataContext;


        public static INotifyPropertyChanged DataTemplateVWDataContext
        {
            get { return dataTemplateVMDataContext[CurrentViewState]; }
        }

        public static INotifyPropertyChanged DataTemplateVMCompositeDataContext
        {
            get { return dataTemplateVMCompositeDataContext[CurrentCompositeViewState]; }
        }

        protected override void OnStartup(StartupEventArgs e)
        {
            UIController = AllerConnectCommon.Services.UIControllerService.Instance;

            CurrentViewState = ViewStates.WelcomeView;
            dataTemplateVMDataContext = new Dictionary<ViewStates, INotifyPropertyChanged>();
            dataTemplateVMCompositeDataContext = new Dictionary<CompositeViewStates, INotifyPropertyChanged>();

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

            var productCompositeModel = new ProductCompositionModel();
            dataTemplateVMCompositeDataContext.Add(CompositeViewStates.None, productCompositeModel);
            dataTemplateVMCompositeDataContext.Add(CompositeViewStates.TreeCategoryView, productCompositeModel);
            dataTemplateVMCompositeDataContext.Add(CompositeViewStates.TreeProductView, productCompositeModel);
            dataTemplateVMCompositeDataContext.Add(CompositeViewStates.TreePartproductView, productCompositeModel);
            dataTemplateVMCompositeDataContext.Add(CompositeViewStates.TreeIngridientView, productCompositeModel);

        }
    }
}
