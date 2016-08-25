using AllerConnectCommon.Foundation;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace AllerConnectManager.ViewModel
{
    public class NavigationBarModel : INotifyPropertyChanged
    {
        private bool isSelected = true;

        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged(PropertyChangedEventArgs e)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, e);
        }

        private RelayCommand navigate2AllergenSelectionViewCmd;
        public ICommand Navigate2AllergenSelectionViewCmd
        {
            get { return navigate2AllergenSelectionViewCmd ?? (navigate2AllergenSelectionViewCmd = new RelayCommand(() => Navigate2AllergenSelectionView(), () => isSelected)); }
        }

        private void Navigate2AllergenSelectionView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            App.UIController.Messenger.NotifyColleagues("Navigate2AllergenSelectionView");
        } //NavigateToAllergenView        

        private RelayCommand navigate2AllergenViewCmd;
        public ICommand Navigate2AllergenViewCmd
        {
            get { return navigate2AllergenViewCmd ?? (navigate2AllergenViewCmd = new RelayCommand(() => Navigate2AllergenView(), () => isSelected)); }
        }

        private void Navigate2AllergenView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            App.UIController.Messenger.NotifyColleagues("Navigate2AllergenView");
        } //NavigateToAllergenView        

        private RelayCommand navigate2InformationViewCmd;
        public ICommand Navigate2InformationViewCmd
        {
            get { return navigate2InformationViewCmd ?? (navigate2InformationViewCmd = new RelayCommand(() => Navigate2InformationView(), () => isSelected)); }
        }

        private void Navigate2InformationView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            App.UIController.Messenger.NotifyColleagues("Navigate2InformationView");
        } //NavigateToAllergenView              

        private RelayCommand navigate2ProductSelectionViewCmd;
        public ICommand Navigate2ProductSelectionViewCmd
        {
            get { return navigate2ProductSelectionViewCmd ?? (navigate2ProductSelectionViewCmd = new RelayCommand(() => Navigate2ProductSelectionView(), () => isSelected)); }
        }

        private void Navigate2ProductSelectionView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            App.UIController.Messenger.NotifyColleagues("Navigate2ProductSelectionView");
        } //NavigateToAllergenView        

        private RelayCommand navigate2ProductViewCmd;
        public ICommand Navigate2ProductViewCmd
        {
            get { return navigate2ProductViewCmd ?? (navigate2ProductViewCmd = new RelayCommand(() => Navigate2ProductView(), () => isSelected)); }
        }

        private void Navigate2ProductView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            App.UIController.Messenger.NotifyColleagues("Navigate2ProductView");
        } //NavigateToAllergenView    

        private RelayCommand navigate2IngridientViewCmd;
        public ICommand Navigate2IngridientViewCmd
        {
            get { return navigate2IngridientViewCmd ?? (navigate2IngridientViewCmd = new RelayCommand(() => Navigate2IngridientView(), () => isSelected)); }
        }

        private void Navigate2IngridientView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            App.UIController.Messenger.NotifyColleagues("Navigate2IngridientView");
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
