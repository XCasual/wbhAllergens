using AllerConnectCommon.Foundation;
using AllerConnectCommon.Model;
using AllerConnectCommon.ViewModel;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace AllerConnectManager.ViewModel
{
    public class ProductCompositionModel : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged(PropertyChangedEventArgs e)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, e);
        }

        private IngridientSelectionModel vmIngridients;
        private ProductSelectionModel vmProducts;

        public IngridientSelectionModel IngridientSelectionVMModel
        {
            get { return vmIngridients; }
        }

        public ProductSelectionModel ProductSelectionVMModel
        {
            get { return vmProducts; }
        }

        public Product SelectedProduct
        {
            get { return vmProducts.SelectedProduct; }
            set { vmProducts.SelectedProduct = value; OnPropertyChanged(new PropertyChangedEventArgs("SelectedProduct")); }
        }

        private Category selectedCategory;

        public Category SelectedCategory
        {
            get { return selectedCategory; }
            set { selectedCategory = value; OnPropertyChanged(new PropertyChangedEventArgs("SelectedCategory")); }
        }


        public ProductCompositionModel()
        {
            treeRoot = new TreeRootViewModel();
            verwaltungTree = new ReadOnlyCollection<TreeRootViewModel>(new TreeRootViewModel[] { treeRoot });
            searchCommand = new SearchTreeCommand(treeRoot, this);

            vmIngridients = new IngridientSelectionModel();
            vmProducts = new ProductSelectionModel();

            App.CurrentCompositeViewState = CurrentAppCompositeViewState = App.ProductCompositeViewStates.None;
            App.UIController.Messenger.Register("CompositeChanged", (Action<TreeViewItemViewModel>)(param => UpdateComposite(param)));
            App.UIController.Messenger.Register("ProductCompositeSelected", (Action<Product>)(param => SetProduct(param)));
            App.UIController.Messenger.Register("CategoryCompositeSelected", (Action<Category>)(param => SetCategory(param)));
            App.UIController.Messenger.Register("IngridientCompositeSelected", (Action<Ingridient>)(param => SetIngridient(param)));
        }

        private void SetIngridient(Ingridient param)
        {
            vmIngridients.SelectedItem = param;
        }

        private void SetCategory(Category param)
        {
            SelectedCategory = param;
        }

        private void SetProduct(Product param)
        {
            SelectedProduct = param;
        }

        private void UpdateComposite(TreeViewItemViewModel itemModel)
        {
            CurrentAppCompositeViewState = itemModel.ElementComposit;
            App.CurrentCompositeViewState = itemModel.ElementComposit;
        }

        private App.ProductCompositeViewStates currentAppCompositeViewState;

        public App.ProductCompositeViewStates CurrentAppCompositeViewState
        {
            get { return currentAppCompositeViewState; }
            set { currentAppCompositeViewState = value; OnPropertyChanged(new PropertyChangedEventArgs("CurrentAppCompositeViewState")); }
        }

        private TreeRootViewModel treeRoot;
        readonly ReadOnlyCollection<TreeRootViewModel> verwaltungTree;

        public ReadOnlyCollection<TreeRootViewModel> VerwaltungTree
        {
            get { return verwaltungTree; }
        }

        readonly ICommand searchCommand;

        IEnumerator<TreeViewItemViewModel> matchingEnumerator;
        string searchText = String.Empty;

        /// <summary>
        /// Returns the command used to execute a search in the family tree.
        /// </summary>
        public ICommand SearchCommand
        {
            get { return searchCommand; }
        }

        private class SearchTreeCommand : ICommand
        {
            readonly TreeViewItemViewModel itemsTree;
            readonly ProductCompositionModel owner;

            public SearchTreeCommand(TreeViewItemViewModel itemsTreeRef, ProductCompositionModel ownerRef)
            {
                itemsTree = itemsTreeRef;
                owner = ownerRef;
            }

            public bool CanExecute(object parameter)
            {
                return true;
            }

            event EventHandler ICommand.CanExecuteChanged
            {
                // I intentionally left these empty because
                // this command never raises the event, and
                // not using the WeakEvent pattern here can
                // cause memory leaks.  WeakEvent pattern is
                // not simple to implement, so why bother.
                add { }
                remove { }
            }

            public void Execute(object parameter)
            {
                owner.PerformSearch();
            }
        }

        /// <summary>
        /// Gets/sets a fragment of the name to search for.
        /// </summary>
        public string SearchText
        {
            get { return searchText; }
            set
            {
                if (value == searchText)
                    return;

                searchText = value;

                matchingEnumerator = null;
            }
        }


        void PerformSearch()
        {
            if (matchingEnumerator == null || !matchingEnumerator.MoveNext())
                this.VerifyMatchingPeopleEnumerator();

            var person = matchingEnumerator.Current;

            if (person == null)
                return;

            // Ensure that this person is in view.
            if (person.Parent != null)
                person.Parent.IsExpanded = true;

            person.IsSelected = true;
        }

        void VerifyMatchingPeopleEnumerator()
        {
            var matches = this.FindMatches(searchText, treeRoot);
            matchingEnumerator = matches.GetEnumerator();

            if (!matchingEnumerator.MoveNext())
            {
                MessageBox.Show(
                    "No matching names were found.",
                    "Try Again",
                    MessageBoxButton.OK,
                    MessageBoxImage.Information
                    );
            }
        }

        IEnumerable<TreeViewItemViewModel> FindMatches(string searchText, TreeViewItemViewModel item)
        {
            if (item.ElementContainsText(searchText))
                yield return item;

            foreach (var child in item.Children)
                foreach (var match in this.FindMatches(searchText, child))
                    yield return match;
        }
    }
}
