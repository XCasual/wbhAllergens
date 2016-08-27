using AllerConnectCommon.Foundation;
using System;
using System.ComponentModel;
using System.Windows.Input;

namespace AllerConnectCommon.ViewModel
{
    public class ProductSelectionModel : INotifyPropertyChanged
    {

        public ProductSelectionModel()
        {
            dataItems = new Model.DBObservableCollection<Product>();
            DataItems = Services.UIControllerService.Instance.IngridientsDB.GetProducts(Services.UIControllerService.Instance.CurrentLanguageID, Services.UIControllerService.Instance.CurrentLocalID);
            listBoxCommand = new Foundation.RelayCommand(() => SelectionHasChanged());
        }


        private void GetAllergens()
        {
            DataItems = Services.UIControllerService.Instance.IngridientsDB.GetProducts(Services.UIControllerService.Instance.CurrentLanguageID, Services.UIControllerService.Instance.CurrentLocalID);
            if (Services.UIControllerService.Instance.IngridientsDB.hasError)
                Services.UIControllerService.Instance.Messenger.NotifyColleagues("SetStatus", Services.UIControllerService.Instance.IngridientsDB.errorMessage);
        }

        private void AddProduct(Product pr)
        {
            dataItems.Add(pr);
        }


        private void UpdateProduct(Product pr)
        {
            int index = dataItems.IndexOf(selectedProduct);
            dataItems.ReplaceItem(index, pr);
            SelectedProduct = pr;
        }


        private void DeleteProduct()
        {
            dataItems.Remove(selectedProduct);
        }

        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged(PropertyChangedEventArgs e)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, e);
        }

        private Model.DBObservableCollection<Product> dataItems;
        public Model.DBObservableCollection<Product> DataItems
        {
            get { return dataItems; }
            //If dataItems replaced by new collection, WPF must be told
            set { dataItems = value; OnPropertyChanged(new PropertyChangedEventArgs("DataItems")); }
        }

        private Product selectedProduct;
        public Product SelectedProduct
        {
            get { return selectedProduct; }
            set { selectedProduct = value; OnPropertyChanged(new PropertyChangedEventArgs("SelectedProduct")); }
        }

        private void SelectionHasChanged()
        {
            var messenger = Services.UIControllerService.Instance.Messenger;
            messenger.NotifyColleagues("AllergenSelectionChanged", selectedProduct);
        }

        private Foundation.RelayCommand listBoxCommand;
        public ICommand ListBoxCommand
        {
            get { return listBoxCommand; }
        }

    }//class AllergenSelectionModel
}
