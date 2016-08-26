using AllerConnectCommon.ViewModel;

namespace AllerConnectManager.ViewModel
{
    public class TreeIngridientsConservantsViewModel : TreeViewItemViewModel
    {
        readonly Ingridient ingridient;

        public TreeIngridientsConservantsViewModel(Ingridient ingridientElement, TreeProductViewModel parent)
            : base(parent, false)
        {
            ingridient = ingridientElement;
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