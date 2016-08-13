using System.Windows.Controls;

namespace AllerConnectManager.Views
{
    /// <summary>
    /// Interaction logic for AllergenSelectionView.xaml
    /// </summary>
    public partial class AllergenSelectionView : UserControl
    {
        public AllergenSelectionView()
        {
            InitializeComponent();
        }

        public override void OnApplyTemplate()
        {
            this.DataContext = App.DataTemplateVWDataContext;

            base.OnApplyTemplate();
        }
    }
}
