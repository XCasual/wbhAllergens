using AllerConnectCommon.Foundation;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace AllerConnectCommon.ViewModel
{
    public class ProductInformationModel : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged(PropertyChangedEventArgs e)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, e);
        }

        public ProductInformationModel()
        {
            Services.UIControllerService.Instance.Messenger.Register("ProductCompositeSelected", (Action<Product>)(param => SetCompositeProduct(param)));
            possibleProducts = Services.UIControllerService.Instance.IngridientsDB.GetProducts(Services.UIControllerService.Instance.CurrentLanguageID, Services.UIControllerService.Instance.CurrentLocalID);
        }

        private void SetCompositeProduct(Product itemModel)
        {
            var productElement = itemModel;
            if (productElement != null)
            {
                UpdateInformationModel(productElement);
            }
        }

        private void UpdateInformationModel(Product productElement)
        {
            displayedProduct = productElement;
            if (displayedProduct != null)
            {
                displayedAllergens = Services.UIControllerService.Instance.IngridientsDB.GetProductAllergenInfo(displayedProduct);
            }
            else
            {
                displayedAllergens.Clear();
            }
        }

        private Product displayedProduct = new Product();
        public Product DisplayedProduct
        {
            get { return displayedProduct; }
            set
            {
                displayedProduct = value;
                UpdateInformationModel(displayedProduct);
                OnPropertyChanged(new PropertyChangedEventArgs("DisplayedProduct"));
                OnPropertyChanged(new PropertyChangedEventArgs("DisplayedAllergens"));

            }
        }

        private ObservableCollection<v_ProductAllergensResult> displayedAllergens = new ObservableCollection<v_ProductAllergensResult>();
        public ObservableCollection<v_ProductAllergensResult> DisplayedAllergens
        {
            get { return displayedAllergens; }
            set
            {
                displayedAllergens = value;
                OnPropertyChanged(new PropertyChangedEventArgs("DisplayedAllergens"));
            }
        }

        private ObservableCollection<Product> possibleProducts = new ObservableCollection<Product>();
        public ObservableCollection<Product> PossibleProducts
        {
            get { return possibleProducts; }
            set
            {
                possibleProducts = value;
                OnPropertyChanged(new PropertyChangedEventArgs("PossibleProducts"));
            }
        }

        private v_ProductAllergensResult selectedAllergen;
        public v_ProductAllergensResult SelectedAllergen
        {
            get { return selectedAllergen; }
            set { selectedAllergen = value; OnPropertyChanged(new PropertyChangedEventArgs("SelectedAllergen")); }
        }
    }
}
