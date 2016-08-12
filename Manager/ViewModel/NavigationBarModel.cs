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

        private RelayCommand navigate2AllergenViewCommand;
        public ICommand NavigateToAllergenViewCommand
        {
            get { return navigate2AllergenViewCommand ?? (navigate2AllergenViewCommand = new RelayCommand(() => NavigateToAllergenView(), () => isSelected)); }
        }

        private void NavigateToAllergenView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            App.UIController.Messenger.NotifyColleagues("NavigateToAllergenView");
        } //NavigateToAllergenView()

        private RelayCommand navigate2AllergenSelectionViewCommand;
        public ICommand NavigateToAllergenSelectionViewCommand
        {
            get { return navigate2AllergenSelectionViewCommand ?? (navigate2AllergenSelectionViewCommand = new RelayCommand(() => NavigateToAllergenSelectionView(), () => isSelected)); }
        }

        private void NavigateToAllergenSelectionView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            App.UIController.Messenger.NotifyColleagues("NavigateToAllergenSelectionView");
        } //NavigateToAllergenView
    }
}
