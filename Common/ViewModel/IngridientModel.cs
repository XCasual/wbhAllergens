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

namespace AllerConnectCommon.ViewModel
{
    public class IngridientModel : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged(PropertyChangedEventArgs e)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, e);
        }

        private IngridientSelectionModel vmIngridients;
        private AllergenSelectionModel vmAllergens;

        public IngridientSelectionModel IngridientVMModel
        {
            get { return vmIngridients; }
        }

        public AllergenSelectionModel AllergenVMModel
        {
            get { return vmAllergens; }
        }

        public DBObservableCollection<Ingridient> IngriedientItems
        {
            get { return vmIngridients.IngriedientItems; }
            //If dataItems replaced by new collection, WPF must be told
            set { vmIngridients.IngriedientItems = value; OnPropertyChanged(new PropertyChangedEventArgs("IngridientItems")); }
        }

        public Ingridient SelectedIngriedient
        {
            get { return vmIngridients.SelectedIngriedient; }
            set { vmIngridients.SelectedIngriedient = value; OnPropertyChanged(new PropertyChangedEventArgs("SelectedIngriedient")); }
        }

        public IngridientModel()
        {
            vmIngridients = new IngridientSelectionModel();
            vmAllergens = new AllergenSelectionModel();

            searchIngridientCommand = new SearchTreeCommand((IEnumerable<LocalizedItem>)vmIngridients.IngriedientItems.ToArray(), this);
            searchAllergenCommand = new SearchTreeCommand((IEnumerable<LocalizedItem>)vmAllergens.DataItems.ToArray(), this);

            // App.UIController.Messenger.Register("CompositeChanged", (Action<TreeViewItemViewModel>)(param => UpdateComposite(param)));
        }

        ICommand searchIngridientCommand;
        ICommand searchAllergenCommand;

        IEnumerator<LocalizedItem> matchingEnumerator;
        string searchText = String.Empty;

        /// <summary>
        /// Returns the command used to execute a search in the family tree.
        /// </summary>
        public ICommand SearchIngridientCommand
        {
            get { return searchIngridientCommand; }
        }

        /// <summary>
        /// Returns the command used to execute a search in the family tree.
        /// </summary>
        public ICommand SearchAllergenCommand
        {
            get { return searchAllergenCommand; }
        }

        private class SearchTreeCommand : ICommand
        {
            readonly IEnumerable<LocalizedItem> itemsCollection;
            readonly IngridientModel owner;

            public SearchTreeCommand(IEnumerable<LocalizedItem> itemsRef, IngridientModel ownerRef)
            {
                itemsCollection = itemsRef;
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

            var element = matchingEnumerator.Current;

            if (element == null)
                return;

            element.IsSelected = true;
        }

        void VerifyMatchingPeopleEnumerator()
        {
            var matches = this.FindMatches(searchText, vmAllergens.DataItems.ToList<LocalizedItem>());
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

        IEnumerable<LocalizedItem> FindMatches(string searchText, List<LocalizedItem> item)
        {
            var matchedElements = new List<LocalizedItem>();

            foreach (var child in item)
            {
                if ((child.LocalName != null && child.LocalName.Contains(searchText)) ||
                    (child.OrdinaryName != null && child.OrdinaryName.Contains(searchText)))
                {
                    matchedElements.Add(child);
                }
            }
            return matchedElements;
        }
    }
}
