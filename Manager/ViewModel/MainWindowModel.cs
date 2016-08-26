using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AllerConnectManager.ViewModel
{
    public class MainWindowModel : INotifyPropertyChanged
    {
        private App.ViewStates currentAppViewState;

        public App.ViewStates CurrentAppViewState
        {
            get { return currentAppViewState; }
            set { currentAppViewState = value; OnPropertyChanged(new PropertyChangedEventArgs("CurrentAppViewState")); }
        }


        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged(PropertyChangedEventArgs e)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, e);
        }

        public MainWindowModel()
        {
            currentAppViewState = App.CurrentViewState;

            App.UIController.Messenger.Register("Navigate2AllergenView", (Action)(() => SetViewState(App.ViewStates.AllergenView)));
            App.UIController.Messenger.Register("Navigate2AllergenSelectionView", (Action)(() => SetViewState(App.ViewStates.AllergenSelectionView)));
            App.UIController.Messenger.Register("Navigate2InformationView", (Action)(() => SetViewState(App.ViewStates.InformationView)));
            App.UIController.Messenger.Register("Navigate2ProductInformationView", (Action)(() => SetViewState(App.ViewStates.ProductInformationView)));
            App.UIController.Messenger.Register("Navigate2ProductSelectionView", (Action)(() => SetViewState(App.ViewStates.ProductSelectionView)));
            App.UIController.Messenger.Register("Navigate2IngridientView", (Action)(() => SetViewState(App.ViewStates.IngridientView)));
            App.UIController.Messenger.Register("Navigate2ProductView", (Action)(() => SetViewState(App.ViewStates.ProductView)));
            App.UIController.Messenger.Register("Navigate2WelcomeScreenView", (Action)(() => SetViewState(App.ViewStates.WelcomeView)));
        }

        private void SetViewState(App.ViewStates vs)
        {
            App.CurrentViewState = vs;
            CurrentAppViewState = vs;
        }
    }
}
