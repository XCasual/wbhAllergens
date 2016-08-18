using AllerConnectCommon.ViewModel;

namespace AllerConnectManager.ViewModel
{
    public class TreeIngridientsRootViewModel : TreeViewItemViewModel
    {
        readonly Product product;

        public TreeIngridientsRootViewModel(Product productElement, TreeProductViewModel parent)
            : base(parent, true)
        {
            product = productElement;
        }

        public override string ElementName
        {
            get { return "Rohstoffe"; }
        }

        internal int ID
        {
            get { return product.ID; }
        }

        protected override void LoadChildren()
        {
            var parentModel = base.Parent as TreeProductViewModel;
            foreach (Ingridient ingridientElement in App.UIController.IngridientsDB.GetIngridients(parentModel.ID))
                    base.Children.Add(new TreeIngridientsViewModel(ingridientElement, parentModel));
        }

        public override App.CompositeViewStates ElementComposit
        {
            get
            {
                return App.CompositeViewStates.TreeIngridientView;
            }
        }
    }
}