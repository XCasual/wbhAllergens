using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AllerConnectManager.ViewModel
{
    public enum ViewStates
    {
        WelcomeView,
        AllergenSelectionView,
        AllergenView,
        ProductSelectionView,
        ProductView,
        InformationView
    }

    public class MainWindowModel : INotifyPropertyChanged
    {
        private ViewStates currentViewState;

        public ViewStates CurrentViewState
        {
            get { return currentViewState; }
            set { currentViewState = value; OnPropertyChanged(new PropertyChangedEventArgs("CurrentViewState")); }
        }


        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged(PropertyChangedEventArgs e)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, e);
        }

        public MainWindowModel()
        {
            currentViewState = ViewStates.WelcomeView;

            VMAllergenDisplayModel = new AllerConnectCommon.ViewModel.AllergenDisplayModel();
            VMAllergenSelectionModel = new AllerConnectCommon.ViewModel.AllergenSelectionModel();

            App.UIController.Messenger.Register("Navigate2AllergenView", (Action)(() => SetViewState(ViewStates.AllergenView)));
            App.UIController.Messenger.Register("Navigate2AllergenSelectionView", (Action)(() => SetViewState(ViewStates.AllergenSelectionView)));
            App.UIController.Messenger.Register("Navigate2InformationView", (Action)(() => SetViewState(ViewStates.InformationView)));
            App.UIController.Messenger.Register("Navigate2ProductSelectionView", (Action)(() => SetViewState(ViewStates.ProductSelectionView)));
            App.UIController.Messenger.Register("Navigate2ProductView", (Action)(() => SetViewState(ViewStates.ProductView)));
            App.UIController.Messenger.Register("Navigate2WelcomeScreenView", (Action)(() => SetViewState(ViewStates.WelcomeView)));
        }

        private void SetViewState(ViewStates vs)
        {
            CurrentViewState = vs;
        }

        public AllerConnectCommon.ViewModel.AllergenDisplayModel VMAllergenDisplayModel { get; private set; }
        public AllerConnectCommon.ViewModel.AllergenSelectionModel VMAllergenSelectionModel { get; private set; }

    }
}
