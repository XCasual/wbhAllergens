using AllerConnectCommon.Foundation;
using System;
using System.ComponentModel;
using System.Windows.Input;

namespace AllerConnectCommon.ViewModel
{
    public class IngridientSelectionModel : INotifyPropertyChanged
    {

        public IngridientSelectionModel()
        {
            ingriedientItems = new Model.DBObservableCollection<Ingridient>();
            IngriedientItems = Services.UIControllerService.Instance.IngridientsDB.GetIngridients(-1);
            listBoxCommand = new Foundation.RelayCommand(() => SelectionHasChanged());
            Services.UIControllerService.Instance.Messenger.Register("IngridientCleared", (Action)(() => SelectedIngriedient = null));
            Services.UIControllerService.Instance.Messenger.Register("GetIngriedients", (Action)(() => GetIngriedients()));
            Services.UIControllerService.Instance.Messenger.Register("UpdateIngridient", (Action<Ingridient>)(param => UpdateIngridient(param)));
            Services.UIControllerService.Instance.Messenger.Register("AddIngridient", (Action<Ingridient>)(param => AddIngridient(param)));
        }


        private void GetIngriedients()
        {
            IngriedientItems = Services.UIControllerService.Instance.IngridientsDB.GetIngridients(-1);
            if (Services.UIControllerService.Instance.IngridientsDB.hasError)
                Services.UIControllerService.Instance.Messenger.NotifyColleagues("SetStatus", Services.UIControllerService.Instance.IngridientsDB.errorMessage);
        }


        private void AddIngridient(Ingridient ingridient)
        {
            ingriedientItems.Add(ingridient);
        }


        private void UpdateIngridient(Ingridient ingriedient)
        {
            int index = ingriedientItems.IndexOf(ingriedient);
            ingriedientItems.ReplaceItem(index, ingriedient);
            SelectedIngriedient = ingriedient;
        }

        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged(PropertyChangedEventArgs e)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, e);
        }

        private Model.DBObservableCollection<Ingridient> ingriedientItems;
        public Model.DBObservableCollection<Ingridient> IngriedientItems
        {
            get { return ingriedientItems; }
            //If dataItems replaced by new collection, WPF must be told
            set { ingriedientItems = value; OnPropertyChanged(new PropertyChangedEventArgs("IngridientItems")); }
        }

        private Ingridient selectedIngriedient;
        public Ingridient SelectedIngriedient
        {
            get { return selectedIngriedient; }
            set { selectedIngriedient = value; OnPropertyChanged(new PropertyChangedEventArgs("SelectedIngriedient")); }
        }

        private Foundation.RelayCommand listBoxCommand;
        public ICommand ListBoxCommand
        {
            get { return listBoxCommand; }
        }

        private void SelectionHasChanged()
        {
            var messenger = Services.UIControllerService.Instance.Messenger;
            messenger.NotifyColleagues("IngriedientSelectionChanged", selectedIngriedient);
        }

        private Foundation.RelayCommand deleteCommand;
        public ICommand DeleteCommand
        {
            get { return deleteCommand ?? (deleteCommand = new Foundation.RelayCommand(() => DeleteIngriedient(), () => true)); }
        }

        private void DeleteIngriedient()
        {

            /*if (!Services.UIControllerService.Instance.IngridientsDB.DeleteAllergen(selectedAllergen.ID))
            {
                System.Diagnostics.Debug.Assert(Services.UIControllerService.Instance.IngridientsDB.errorMessage == null);
                return;
            }*/
            ingriedientItems.Remove(selectedIngriedient);
            Services.UIControllerService.Instance.Messenger.NotifyColleagues("DeleteIngriedient");
        } //DeleteAllergen

    }//class AllergenSelectionModel
}
