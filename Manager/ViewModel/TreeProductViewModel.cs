using AllerConnectCommon.ViewModel;

namespace AllerConnectManager.ViewModel
{
    public class TreeProductViewModel : TreeViewItemViewModel
    {
        readonly Product product;
        private bool isSelected;

        public TreeProductViewModel(Product productElement, TreeCategoryViewModel parent)
            : base(parent, false)
        {
            product = productElement;
            base.Children.Add(new TreePartproductRootViewModel(product, this));
            base.Children.Add(new TreeIngridientsRootViewModel(product, this));
        }

        public override string ElementName
        {
            get { return product.OrdinaryName; }
        }

        internal int ID
        {
            get { return product.ID; }
        }

        public override App.ProductCompositeViewStates ElementComposit
        {
            get
            {
                return App.ProductCompositeViewStates.TreeProductView;
            }
        }

        public override bool IsSelected
        {
            get { return isSelected; }
            set
            {
                if (value != isSelected)
                {
                    isSelected = value;
                    this.OnPropertyChanged("IsSelected");
                    App.UIController.Messenger.NotifyColleagues("CompositeChanged", this);
                    App.UIController.Messenger.NotifyColleagues("ProductCompositeSelected", product);
                }
            }
        }
    }
}