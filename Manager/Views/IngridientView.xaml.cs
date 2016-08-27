using AllerConnectCommon.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace AllerConnectManager.Views
{
    /// <summary>
    /// Interaction logic for IngridientCompositView.xaml
    /// </summary>
    public partial class IngridientView : UserControl
    {
        public IngridientView()
        {
            InitializeComponent();
        }

        public override void OnApplyTemplate()
        {
            this.DataContext = App.DataTemplateVWDataContext;

            base.OnApplyTemplate();
        }

        public void searchTextBoxKeyDown(object sender, KeyEventArgs e)
        {
            //if (e.Key == Key.Enter)
            //    tree.SearchCommand.Execute(null);
        }

        private void dataGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var currentVM = DataContext as IngridientModel;
            var ingridientElement = currentVM.IngridientVMModel.SelectedItem;
            

            foreach (var allergen in currentVM.AllergenVMModel.DataItems)
            {
                allergen.IsChecked = false;
            }

            if (ingridientElement != null)
            {
                App.UIController.IngridientsDB.GetIngridientAllergenId(ingridientElement);
                foreach (var alergenRef in ingridientElement.AllergenIDs)
                {
                    foreach (var allergen in currentVM.AllergenVMModel.DataItems)
                    {
                        bool isChecked = alergenRef.ID == allergen.ID;
                        if (isChecked)
                        {
                            allergen.IsChecked = isChecked;
                            break;
                        }
                    }
                }
            }
            currentVM.IngridientVMModel.OnPropertyChanged(new System.ComponentModel.PropertyChangedEventArgs("DataItems"));
            currentVM.AllergenVMModel.DataItems.UpdateCollection();
        }
    }
}
