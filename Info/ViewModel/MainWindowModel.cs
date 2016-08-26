using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AllerConnectInfo.ViewModel
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

            App.UIController.Messenger.Register("Navigate2ProductInformationView", (Action)(() => SetViewState(App.ViewStates.ProductInformationView)));
            App.UIController.Messenger.Register("Navigate2WelcomeScreenView", (Action)(() => SetViewState(App.ViewStates.WelcomeView)));
        }

        private void SetViewState(App.ViewStates vs)
        {
            App.CurrentViewState = vs;
            CurrentAppViewState = vs;
        }
    }
}
