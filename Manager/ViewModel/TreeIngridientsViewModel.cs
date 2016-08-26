using AllerConnectCommon.ViewModel;

namespace AllerConnectManager.ViewModel
{
    public class TreeIngridientsViewModel : TreeViewItemViewModel
    {
        readonly Ingridient ingridient;
        private bool isConservant;

        public TreeIngridientsViewModel(Ingridient ingridientElement, TreeProductViewModel parent, bool conservants)
            : base(parent, false)
        {
            ingridient = ingridientElement;
            isConservant = conservants;
        }

        public override string ElementName
        {
            get { return ingridient.OrdinaryName; }
        }

        internal int ID
        {
            get { return ingridient.ID; }
        }

        protected override void LoadChildren()
        {
            // No Children
        }

        public override App.ProductCompositeViewStates ElementComposit
        {
            get
            {
                return App.ProductCompositeViewStates.TreeIngridientView;
            }
        }
    }
}