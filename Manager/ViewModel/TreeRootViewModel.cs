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

        public override App.CompositeViewStates ElementComposit
        {
            get
            {
                return App.CompositeViewStates.TreeCategoryView;
            }
        }
    }
}
