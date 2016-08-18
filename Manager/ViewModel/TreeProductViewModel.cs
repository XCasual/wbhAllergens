using AllerConnectCommon.ViewModel;

namespace AllerConnectManager.ViewModel
{
    public class TreeProductViewModel : TreeViewItemViewModel
    {
        readonly Product product;

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

        public override App.CompositeViewStates ElementComposit
        {
            get
            {
                return App.CompositeViewStates.TreeProductView;
            }
        }
    }
}