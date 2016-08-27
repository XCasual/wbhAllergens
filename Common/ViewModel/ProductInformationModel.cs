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
            Services.UIControllerService.Instance.Messenger.Register("GetProducts", (Action)(() => SetCompositeProduct()));
            possibleProducts = Services.UIControllerService.Instance.IngridientsDB.GetProducts(Services.UIControllerService.Instance.CurrentLanguageID, Services.UIControllerService.Instance.CurrentLocalID);
        }

        private void SetCompositeProduct()
        {
            if (displayedProduct != null)
            {
                var conservants = Services.UIControllerService.Instance.IngridientsDB.GetIngridients(false, displayedProduct.ID, true);
                DisplayedProduct = Services.UIControllerService.Instance.IngridientsDB.GetProduct(displayedProduct.ID, Services.UIControllerService.Instance.CurrentLanguageID,
                displayedProduct.CategoryID, displayedProduct.LocalID);
                var conservantsClass = from ce in conservants
                                       select ce.ClassName;
                var finalList = conservantsClass.Distinct();
                var sb = new StringBuilder();
                foreach (var item in finalList)
                {
                    if (sb.Length > 0)
                        sb.Append(',');
                    sb.Append(item);
                }
                productConservants = sb.ToString();
                PossibleProducts = Services.UIControllerService.Instance.IngridientsDB.GetProducts(Services.UIControllerService.Instance.CurrentLanguageID, Services.UIControllerService.Instance.CurrentLocalID);
            }
        }

        private void SetCompositeProduct(Product itemModel)
        {
            var productElement = itemModel;
            if (productElement != null)
            {
                UpdateInformationModel(productElement);
                var conservants = Services.UIControllerService.Instance.IngridientsDB.GetIngridients(false, displayedProduct.ID, true);
                var conservantsClass = from ce in conservants
                                       select ce.ClassName;
                var finalList = conservantsClass.Distinct();
                var sb = new StringBuilder();
                foreach (var item in finalList)
                {
                    if (sb.Length > 0)
                        sb.Append(',');
                    sb.Append(item);
                }
                productConservants = sb.ToString();
                PossibleProducts = Services.UIControllerService.Instance.IngridientsDB.GetProducts(Services.UIControllerService.Instance.CurrentLanguageID, Services.UIControllerService.Instance.CurrentLocalID);
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
                OnPropertyChanged(new PropertyChangedEventArgs("PossibleProducts"));
            }
        }

        private string productConservants;

        public string ProductConservants
        {
            get { return productConservants; }
            set
            {
                productConservants = value;
                OnPropertyChanged(new PropertyChangedEventArgs("ProductConservants"));
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
