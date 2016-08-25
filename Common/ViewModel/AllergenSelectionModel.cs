using AllerConnectCommon.Foundation;
using System;
using System.ComponentModel;
using System.Windows.Input;

namespace AllerConnectCommon.ViewModel
{
    public class AllergenSelectionModel : INotifyPropertyChanged
    {

        public AllergenSelectionModel()
        {
            dataItems = new Model.DBObservableCollection<Allergen>();
            DataItems = Services.UIControllerService.Instance.IngridientsDB.GetAllergens(Services.UIControllerService.Instance.CurrentLanguageID);
            listBoxCommand = new Foundation.RelayCommand(() => SelectionHasChanged());
            Services.UIControllerService.Instance.Messenger.Register("AllergenCleared", (Action)(() => SelectedAllergen = null));
            Services.UIControllerService.Instance.Messenger.Register("GetAllergens", (Action)(() => GetAllergens()));
            Services.UIControllerService.Instance.Messenger.Register("UpdateAllergen", (Action<Allergen>)(param => UpdateAllergen(param)));
            Services.UIControllerService.Instance.Messenger.Register("AddAllergen", (Action<Allergen>)(param => AddAllergen(param)));
        }


        private void GetAllergens()
        {
            DataItems = Services.UIControllerService.Instance.IngridientsDB.GetAllergens(Services.UIControllerService.Instance.CurrentLanguageID);
            if (Services.UIControllerService.Instance.IngridientsDB.hasError)
                Services.UIControllerService.Instance.Messenger.NotifyColleagues("SetStatus", Services.UIControllerService.Instance.IngridientsDB.errorMessage);
        }


        private void AddAllergen(Allergen al)
        {
            dataItems.Add(al);
        }


        private void UpdateAllergen(Allergen al)
        {
            int index = dataItems.IndexOf(selectedAllergen);
            dataItems.ReplaceItem(index, al);
            SelectedAllergen = al;
        }

        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged(PropertyChangedEventArgs e)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, e);
        }

        private Model.DBObservableCollection<Allergen> dataItems;
        public Model.DBObservableCollection<Allergen> DataItems
        {
            get { return dataItems; }
            //If dataItems replaced by new collection, WPF must be told
            set { dataItems = value; OnPropertyChanged(new PropertyChangedEventArgs("DataItems")); }
        }

        private Allergen selectedAllergen;
        public Allergen SelectedAllergen
        {
            get { return selectedAllergen; }
            set { selectedAllergen = value; OnPropertyChanged(new PropertyChangedEventArgs("SelectedAllergen")); }
        }

        private Foundation.RelayCommand listBoxCommand;
        public ICommand ListBoxCommand
        {
            get { return listBoxCommand; }
        }

        private void SelectionHasChanged()
        {
            var messenger = Services.UIControllerService.Instance.Messenger;
            messenger.NotifyColleagues("AllergenSelectionChanged", selectedAllergen);
        }

        private RelayCommand navigate2AllergenViewCmd;
        public ICommand Navigate2AllergenViewCmd
        {
            get { return navigate2AllergenViewCmd ?? (navigate2AllergenViewCmd = new RelayCommand(() => Navigate2AllergenView(), () => true)); }
        }

        private void Navigate2AllergenView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            Services.UIControllerService.Instance.Messenger.NotifyColleagues("Navigate2AllergenView");
        } //NavigateToAllergenView   

        private RelayCommand addAndnavigate2AllergenViewCmd;
        public ICommand AddAndnavigate2AllergenViewCmd
        {
            get { return addAndnavigate2AllergenViewCmd ?? (addAndnavigate2AllergenViewCmd = new RelayCommand(() => AddAndnavigate2AllergenView(), () => true)); }
        }

        private void AddAndnavigate2AllergenView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            Services.UIControllerService.Instance.Messenger.NotifyColleagues("AllergenViewCreateTemp");
            Services.UIControllerService.Instance.Messenger.NotifyColleagues("Navigate2AllergenView");
        } //NavigateToAllergenView 

        private Foundation.RelayCommand deleteCommand;
        public ICommand DeleteCommand
        {
            get { return deleteCommand ?? (deleteCommand = new Foundation.RelayCommand(() => DeleteAllergen(), () => true)); }
        }

        private void DeleteAllergen()
        {

            if (!Services.UIControllerService.Instance.IngridientsDB.DeleteAllergen(selectedAllergen.ID))
            {
                System.Diagnostics.Debug.Assert(Services.UIControllerService.Instance.IngridientsDB.errorMessage == null);
                return;
            }
            dataItems.Remove(selectedAllergen);
            Services.UIControllerService.Instance.Messenger.NotifyColleagues("DeleteAllergen");
        } //DeleteAllergen

    }//class AllergenSelectionModel
}
