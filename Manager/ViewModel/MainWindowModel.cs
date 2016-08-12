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
        AllergenView
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
            App.UIController.Messenger.Register("WelcomeView", (Action)(() => SetViewState(ViewStates.WelcomeView)));
            App.UIController.Messenger.Register("NavigateToAllergenView", (Action)(() => SetViewState(ViewStates.AllergenView)));
            App.UIController.Messenger.Register("NavigateToAllergenSelectionView", (Action)(() => SetViewState(ViewStates.AllergenSelectionView)));
        }

        private void SetViewState(ViewStates vs)
        {
            CurrentViewState = vs;
        }
    }
}
