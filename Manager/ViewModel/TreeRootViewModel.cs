using AllerConnectCommon.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace AllerConnectManager.ViewModel
{
    /// <summary>
    /// This is the view-model of the UI.  It provides a data source
    /// for the TreeView (the FirstGeneration property), a bindable
    /// SearchText property, and the SearchCommand to perform a search.
    /// </summary>
    public class TreeRootViewModel : TreeViewItemViewModel
    {
        public TreeRootViewModel()
            : base(null, false)
        {
            foreach (Category categoryElement in App.UIController.IngridientsDB.GetCategories(App.UIController.CurrentLanguageID))
                base.Children.Add(new TreeCategoryViewModel(categoryElement, this));
            base.IsExpanded = true;
        }

        public override string ElementName
        {
            get
            {
                return "Produkte"; ;
            }
        }

        public override void Reload()
        {
            this.Children.Clear();
            foreach (Category categoryElement in App.UIController.IngridientsDB.GetCategories(App.UIController.CurrentLanguageID))
                base.Children.Add(new TreeCategoryViewModel(categoryElement, this));
            base.Reload();
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
                    App.UIController.Messenger.NotifyColleagues("CategoryCompositeSelected", new Category());
                }
            }
        }
    }
}
