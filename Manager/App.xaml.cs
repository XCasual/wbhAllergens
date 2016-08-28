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
            IngridientView,
            InformationView
        }

        public enum ProductCompositeViewStates
        {
            None,
            TreeCategoryView,
            TreeProductView,
            TreePartproductSelectionView,
            TreeIngridientSelectionView,
            TreeConservantSelectionView,
            TreeIngridientView
        }

        private static ViewStates currentViewState;

        public static ViewStates CurrentViewState
        {
            get { return currentViewState; }
            set { currentViewState = value; }
        }

        private static ProductCompositeViewStates currentCompositeViewState;

        public static ProductCompositeViewStates CurrentCompositeViewState
        {
            get { return currentCompositeViewState; }
            set { currentCompositeViewState = value; }
        }

        public static AllerConnectCommon.Services.UIControllerService UIController;

        private static Dictionary<ViewStates, INotifyPropertyChanged> dataTemplateVMDataContext;
        private static Dictionary<ProductCompositeViewStates, INotifyPropertyChanged> dataTemplateVMProductCompositeDataContext;


        public static INotifyPropertyChanged DataTemplateVWDataContext
        {
            get { return dataTemplateVMDataContext[CurrentViewState]; }
        }

        public static INotifyPropertyChanged DataTemplateVMProductCompositeDataContext
        {
            get { return dataTemplateVMProductCompositeDataContext[CurrentCompositeViewState]; }
        }

        protected override void OnStartup(StartupEventArgs e)
        {
            UIController = AllerConnectCommon.Services.UIControllerService.Instance;

            CurrentViewState = ViewStates.WelcomeView;
            dataTemplateVMDataContext = new Dictionary<ViewStates, INotifyPropertyChanged>();
            dataTemplateVMProductCompositeDataContext = new Dictionary<ProductCompositeViewStates, INotifyPropertyChanged>();

            base.OnStartup(e);
        }

        public static void IntiliazieViewModels()
        {
            var vmIngridient = new AllerConnectCommon.ViewModel.IngridientModel();
            var vmAllergenDisplay = new AllerConnectCommon.ViewModel.AllergenDisplayModel();
            var vmProductInfo = new AllerConnectCommon.ViewModel.ProductInformationModel();
            var vmProductDisplay = new AllerConnectCommon.ViewModel.ProductDisplayModel();
            var vmProductComposition = new ProductCompositionModel();
            var vmInformation = new InformationModel();
            var vmNavigation = new NavigationBarModel();

            dataTemplateVMDataContext.Add(ViewStates.WelcomeView, vmNavigation);
            dataTemplateVMDataContext.Add(ViewStates.AllergenView, vmAllergenDisplay);
            dataTemplateVMDataContext.Add(ViewStates.ProductInformationView, vmProductInfo);
            dataTemplateVMDataContext.Add(ViewStates.AllergenSelectionView, vmIngridient.AllergenVMModel);
            dataTemplateVMDataContext.Add(ViewStates.ProductSelectionView, vmProductComposition);
            dataTemplateVMDataContext.Add(ViewStates.IngridientView, vmIngridient);
            dataTemplateVMDataContext.Add(ViewStates.InformationView, vmInformation);

            var productCompositeModel = new ProductCompositionModel();
            dataTemplateVMProductCompositeDataContext.Add(ProductCompositeViewStates.None, productCompositeModel);
            dataTemplateVMProductCompositeDataContext.Add(ProductCompositeViewStates.TreeCategoryView, productCompositeModel);
            dataTemplateVMProductCompositeDataContext.Add(ProductCompositeViewStates.TreeProductView, productCompositeModel);
            dataTemplateVMProductCompositeDataContext.Add(ProductCompositeViewStates.TreePartproductSelectionView, productCompositeModel);
            dataTemplateVMProductCompositeDataContext.Add(ProductCompositeViewStates.TreeIngridientView, productCompositeModel);
            dataTemplateVMProductCompositeDataContext.Add(ProductCompositeViewStates.TreeIngridientSelectionView, productCompositeModel);
            dataTemplateVMProductCompositeDataContext.Add(ProductCompositeViewStates.TreeConservantSelectionView, productCompositeModel);
        }
    }
}
