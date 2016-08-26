using AllerConnectCommon.Foundation;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace AllerConnectInfo.ViewModel
{
    public class WelcomeModel : INotifyPropertyChanged
    {
        private bool isSelected = true;

        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged(PropertyChangedEventArgs e)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, e);
        }

        private RelayCommand navigate2ProductInformationViewCmd;
        public ICommand Navigate2ProductInformationViewCmd
        {
            get { return navigate2ProductInformationViewCmd ?? (navigate2ProductInformationViewCmd = new RelayCommand(() => navigate2ProductInformationView(), () => isSelected)); }
        }

        private void navigate2ProductInformationView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            App.UIController.Messenger.NotifyColleagues("Navigate2ProductInformationView");
        } //NavigateToAllergenView

        private RelayCommand navigate2WelcomeScreenViewCmd;
        public ICommand Navigate2WelcomeScreenViewCmd
        {
            get { return navigate2WelcomeScreenViewCmd ?? (navigate2WelcomeScreenViewCmd = new RelayCommand(() => Navigate2WelcomeScreenView(), () => isSelected)); }
        }

        private void Navigate2WelcomeScreenView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            App.UIController.Messenger.NotifyColleagues("Navigate2WelcomeScreenView");
        } //NavigateToAllergenView
    }
}
