using SUT.PrintEngine.Utils;
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

namespace AllerConnectInfo.Views
{
    /// <summary>
    /// Interaction logic for InformationView.xaml
    /// </summary>
    public partial class ProductInformationView : UserControl
    {
        public ProductInformationView()
        {
            InitializeComponent();
        }

        public override void OnApplyTemplate()
        {
            this.DataContext = App.DataTemplateVWDataContext;

            base.OnApplyTemplate();
        }

        private void btnPrintClicked(object sender, RoutedEventArgs e)
        {
            var visualSize = new Size(PrintGrid.ActualWidth, PrintGrid.ActualHeight);
            var printControl = PrintControlFactory.Create(visualSize, PrintGrid);
            printControl.ShowPrintPreview();
        }
    }
}
