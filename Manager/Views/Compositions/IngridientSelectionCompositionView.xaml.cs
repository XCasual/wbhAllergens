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

namespace AllerConnectManager.Views.Compositions
{
    /// <summary>
    /// Interaction logic for IngridientSelectionCompositionView.xaml
    /// </summary>
    public partial class IngridientSelectionCompositionView : UserControl
    {
        public IngridientSelectionCompositionView()
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
    }
}
