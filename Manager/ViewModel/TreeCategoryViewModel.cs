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
            base.IsExpanded = true;
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

        public override App.ProductCompositeViewStates ElementComposit
        {
            get
            {
                return App.ProductCompositeViewStates.TreeCategoryView;
            }
        }

        private bool isSelected;

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
                    App.UIController.Messenger.NotifyColleagues("CategoryCompositeSelected", category);
                }
            }
        }
    }
}