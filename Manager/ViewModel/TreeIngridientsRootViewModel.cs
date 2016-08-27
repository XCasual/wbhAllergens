using AllerConnectCommon.ViewModel;

namespace AllerConnectManager.ViewModel
{
    public class TreeIngridientsRootViewModel : TreeViewItemViewModel
    {
        readonly Product product;
        private bool isConservant;

        public TreeIngridientsRootViewModel(Product productElement, TreeProductViewModel parent, bool conservants)
            : base(parent, true)
        {
            product = productElement;
            isConservant = conservants;
        }

        public override string ElementName
        {
            get { return isConservant ? "Zusatzstoffe" : "Rohstoffe"; }
        }

        internal int ID
        {
            get { return product.ID; }
        }

        protected override void LoadChildren()
        {
            var parentModel = base.Parent as TreeProductViewModel;
            foreach (Ingridient ingridientElement in App.UIController.IngridientsDB.GetIngridients(false, parentModel.ID, isConservant))
                    base.Children.Add(new TreeIngridientsViewModel(ingridientElement, parentModel, isConservant));
        }

        public override App.ProductCompositeViewStates ElementComposit
        {
            get
            {
                return isConservant ? App.ProductCompositeViewStates.TreeConservantSelectionView : App.ProductCompositeViewStates.TreeIngridientSelectionView;
            }
        }
    }
}