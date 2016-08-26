using AllerConnectCommon.Foundation;
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
        private bool isSelected = true;

        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged(PropertyChangedEventArgs e)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, e);
        }

        private RelayCommand navigate2AllergenSelectionViewCmd;
        public ICommand Navigate2AllergenSelectionViewCmd
        {
            get { return navigate2AllergenSelectionViewCmd ?? (navigate2AllergenSelectionViewCmd = new RelayCommand(() => Navigate2AllergenSelectionView(), () => isSelected)); }
        }

        private void Navigate2AllergenSelectionView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            App.UIController.Messenger.NotifyColleagues("Navigate2AllergenSelectionView");
        } //NavigateToAllergenView        

        private RelayCommand navigate2AllergenViewCmd;
        public ICommand Navigate2AllergenViewCmd
        {
            get { return navigate2AllergenViewCmd ?? (navigate2AllergenViewCmd = new RelayCommand(() => Navigate2AllergenView(), () => isSelected)); }
        }

        private void Navigate2AllergenView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            App.UIController.Messenger.NotifyColleagues("Navigate2AllergenView");
        } //NavigateToAllergenView        

        private RelayCommand navigate2InformationViewCmd;
        public ICommand Navigate2InformationViewCmd
        {
            get { return navigate2InformationViewCmd ?? (navigate2InformationViewCmd = new RelayCommand(() => Navigate2InformationView(), () => isSelected)); }
        }

        private void Navigate2InformationView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            App.UIController.Messenger.NotifyColleagues("Navigate2InformationView");
        } //NavigateToAllergenView              

        private RelayCommand navigate2ProductSelectionViewCmd;
        public ICommand Navigate2ProductSelectionViewCmd
        {
            get { return navigate2ProductSelectionViewCmd ?? (navigate2ProductSelectionViewCmd = new RelayCommand(() => Navigate2ProductSelectionView(), () => isSelected)); }
        }

        private void Navigate2ProductSelectionView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            App.UIController.Messenger.NotifyColleagues("Navigate2ProductSelectionView");
        } //NavigateToAllergenView        

        private RelayCommand navigate2ProductViewCmd;
        public ICommand Navigate2ProductViewCmd
        {
            get { return navigate2ProductViewCmd ?? (navigate2ProductViewCmd = new RelayCommand(() => Navigate2ProductView(), () => isSelected)); }
        }

        private void Navigate2ProductView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            App.UIController.Messenger.NotifyColleagues("Navigate2ProductView");
        } //NavigateToAllergenView        

        private RelayCommand navigate2WelcomeScreenViewCmd;
        public ICommand Navigate2WelcomeScreenViewCmd
        {
            get { return navigate2WelcomeScreenViewCmd ?? (navigate2WelcomeScreenViewCmd = new RelayCommand(() => Navigate2WelcomeScreenView(), () => isSelected)); }
        }

        private void Navigate2WelcomeScreenView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            App.UIController.Messenger.NotifyColleagues("Navigate2WelcomeScreenView");
        } //NavigateToAllergenView

        public ProductCompositionModel()
        {
            treeRoot = new TreeRootViewModel();
            verwaltungTree = new ReadOnlyCollection<TreeRootViewModel>(new TreeRootViewModel[] { treeRoot });
            searchCommand = new SearchTreeCommand(treeRoot, this);

            App.CurrentCompositeViewState = CurrentAppCompositeViewState = App.ProductCompositeViewStates.None;
            App.UIController.Messenger.Register("CompositeChanged", (Action<TreeViewItemViewModel>)(param => UpdateComposite(param)));
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
