using AllerConnectCommon.ViewModel;

namespace AllerConnectManager.ViewModel
{
    public class TreePartproductViewModel : TreeViewItemViewModel
    {
        readonly Product product;

        public TreePartproductViewModel(Product productElement, TreeProductViewModel parent)
            : base(parent, false)
        {
            product = productElement;
        }

        public override string ElementName
        {
            get { return product.OrdinaryName; }
        }

        internal int ID
        {
            get { return product.ID; }
        }

        protected override void LoadChildren()
        {
            // No Children
            base.LoadChildren();
        }

        public override App.CompositeViewStates ElementComposit
        {
            get
            {
                return App.CompositeViewStates.TreePartproductView;
            }
        }
    }
}