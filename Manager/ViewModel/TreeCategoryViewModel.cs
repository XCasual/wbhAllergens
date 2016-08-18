using AllerConnectCommon.ViewModel;

namespace AllerConnectManager.ViewModel
{
    public class TreeCategoryViewModel : TreeViewItemViewModel
    {
        readonly Category category;

        public TreeCategoryViewModel(Category categoryElement, TreeRootViewModel parent)
            : base(parent, true)
        {
            category = categoryElement;
        }

        public override string ElementName
        {
            get { return category.OrdinaryName; }
        }

        internal int ID
        {
            get { return category.ID; }
        }

        protected override void LoadChildren()
        {
            foreach (Product productElement in App.UIController.IngridientsDB.GetProducts(App.UIController.CurrentLanguageID, category.ID, App.UIController.CurrentLocalID))
                base.Children.Add(new TreeProductViewModel(productElement, this));
        }

        public override App.CompositeViewStates ElementComposit
        {
            get
            {
                return App.CompositeViewStates.TreeCategoryView;
            }
        }
    }
}