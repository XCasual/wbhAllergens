using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
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

namespace AllerConnectManager
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void WindowLoaded(object sender, RoutedEventArgs e)
        {
            App.UIController.CurrentLanguageID = Properties.Settings.Default.CurrentLanguageID;
            App.UIController.CurrentLocalID = Properties.Settings.Default.CurrentLocalId;
            SetUICulture(Properties.Settings.Default.AppLanguage);
            App.IntiliazieViewModels();
        }

        private void LanguageSwitchTrigger(object sender, MouseButtonEventArgs e)
        {
            var enCulture = new System.Globalization.CultureInfo("en");
            var deCulture = new System.Globalization.CultureInfo("de");

            var imgButton = sender as Image;
            if (imgButton != null)
            {
                SetUICulture(imgButton.Name);
            }
        }

        private void SetUICulture(string cultureName)
        {
            var appCulture = new System.Globalization.CultureInfo(cultureName);
            Thread.CurrentThread.CurrentUICulture = appCulture;
            WPFLocalizeExtension.Engine.LocalizeDictionary.Instance.Culture = appCulture;

            var dbCultureID = App.UIController.IngridientsDB.GetLanguageID(cultureName);
            Properties.Settings.Default.CurrentLanguageID = dbCultureID;
            App.UIController.CurrentLanguageID = dbCultureID;
            Properties.Settings.Default.Save();

            App.UIController.Messenger.NotifyColleagues("GetAllergens");
            App.UIController.Messenger.NotifyColleagues("GetProducts");
            App.UIController.Messenger.NotifyColleagues("GetIngriedients");
        }
    }
}
