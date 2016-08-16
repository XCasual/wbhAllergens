using AllerConnectCommon.Foundation;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace AllerConnectCommon.ViewModel
{
    public class ProductInformationModel : INotifyPropertyChanged
    {
        private bool isSelected = false;

        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged(PropertyChangedEventArgs e)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, e);
        }
        //data checks and status indicators done in another class
        private readonly AllergenDisplayModelStatus stat = new AllergenDisplayModelStatus();
        public AllergenDisplayModelStatus Stat { get { return stat; } }

        private Allergen displayedAllergen = new Allergen();
        public Allergen DisplayedAllergen
        {
            get { return displayedAllergen; }
            set {
                displayedAllergen = value;
                OnPropertyChanged(new PropertyChangedEventArgs("DisplayedAllergen")); }
        }


        private Foundation.RelayCommand getAllergensCommand;
        public ICommand GetAllergensCommand
        {
            get { return getAllergensCommand ?? (getAllergensCommand = new Foundation.RelayCommand(() => GetAllergens())); }
        }

        private void GetAllergens()
        {
            isSelected = false;
            stat.NoError();
            DisplayedAllergen = new Allergen();
            Services.UIControllerService.Instance.Messenger.NotifyColleagues("GetAllergens");
        }


        private Foundation.RelayCommand clearCommand;
        public ICommand ClearCommand
        {
            get { return clearCommand ?? (clearCommand = new Foundation.RelayCommand(() => ClearAllergenDisplay()/*, ()=>isSelected*/)); }
        }

        private void ClearAllergenDisplay()
        {
            isSelected = false;
            stat.NoError();
            DisplayedAllergen = new Allergen();
            Services.UIControllerService.Instance.Messenger.NotifyColleagues("AllergenCleared");
        } //ClearAllergenDisplay()


        private Foundation.RelayCommand updateCommand;
        public ICommand UpdateCommand
        {
            get { return updateCommand ?? (updateCommand = new Foundation.RelayCommand(() => UpdateAllergen(), () => isSelected)); }
        }

        private void UpdateAllergen()
        {
            if (!stat.ChkAllergenForUpdate(DisplayedAllergen)) return;
            if (!Services.UIControllerService.Instance.IngridientsDB.UpdateAllergen(DisplayedAllergen))
            {
                stat.Status = Services.UIControllerService.Instance.IngridientsDB.errorMessage;
                return;
            }
            Services.UIControllerService.Instance.Messenger.NotifyColleagues("UpdateAllergen", DisplayedAllergen);
        } //UpdateAllergen()


        private Foundation.RelayCommand deleteCommand;
        public ICommand DeleteCommand
        {
            get { return deleteCommand ?? (deleteCommand = new Foundation.RelayCommand(() => DeleteAllergen(), () => isSelected)); }
        }


        private void DeleteAllergen()
        {
            if (!Services.UIControllerService.Instance.IngridientsDB.DeleteAllergen(DisplayedAllergen.ID))
            {
                stat.Status = Services.UIControllerService.Instance.IngridientsDB.errorMessage;
                return;
            }
            isSelected = false;
            Services.UIControllerService.Instance.Messenger.NotifyColleagues("DeleteAllergen");
        } //DeleteAllergen


        private Foundation.RelayCommand addCommand;
        public ICommand AddCommand
        {
            get { return addCommand ?? (addCommand = new Foundation.RelayCommand(() => AddAllergen(), () => !isSelected)); }
        }


        private void AddAllergen()
        {
            if (!stat.ChkAllergenForAdd(DisplayedAllergen)) return;
            if (!Services.UIControllerService.Instance.IngridientsDB.AddAllergen(DisplayedAllergen))
            {
                stat.Status = Services.UIControllerService.Instance.IngridientsDB.errorMessage;
                return;
            }
            Services.UIControllerService.Instance.Messenger.NotifyColleagues("AddAllergen", DisplayedAllergen);
        } //AddAllergen()


        public ProductInformationModel()
        {
            var messenger = Services.UIControllerService.Instance.Messenger;
            messenger.Register("AllergenViewCreateTemp", (Action)(() => PrepareNewAllergen()));
            messenger.Register("AllergenSelectionChanged", (Action<Allergen>)(param => ProcessAllergen(param)));
            messenger.Register("SetStatus", (Action<String>)(param => stat.Status = param));
        } //ctor

        public void ProcessAllergen(Allergen al)
        {
            if (al == null) { /*DisplayedAllergen = null;*/  isSelected = false; return; }
            var temp = (Allergen)al.Clone();
            DisplayedAllergen = temp;
            isSelected = true;
            stat.NoError();
        } // ProcessAllergen()

        public void PrepareNewAllergen()
        {
            var tmpAllergen = new Allergen();
            tmpAllergen.LocalName = "";
            tmpAllergen.OrdinaryName = "";
            tmpAllergen.LanguageID = Services.UIControllerService.Instance.CurrentLanguageID;
            tmpAllergen.SymbolID = 0;
            tmpAllergen.ToolTip = "";
            DisplayedAllergen = tmpAllergen;
            isSelected = true;
            stat.NoError();
        } // ProcessAllergen()

        private RelayCommand navigate2AllergenSelectionViewCmd;
        public ICommand Navigate2AllergenSelectionViewCmd
        {
            get { return navigate2AllergenSelectionViewCmd ?? (navigate2AllergenSelectionViewCmd = new RelayCommand(() => Navigate2AllergenSelectionView(), () => true)); }
        }

        private void Navigate2AllergenSelectionView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            Services.UIControllerService.Instance.Messenger.NotifyColleagues("Navigate2AllergenSelectionView");
        } //NavigateToAllergenView      

        private RelayCommand saveAndnavigate2AllergenSelectionViewCmd;
        public ICommand SaveAndNavigate2AllergenSelectionViewCmd
        {
            get { return saveAndnavigate2AllergenSelectionViewCmd ?? (saveAndnavigate2AllergenSelectionViewCmd = new RelayCommand(() => SaveAndNavigate2AllergenSelectionView(), () => true)); }
        }

        private void SaveAndNavigate2AllergenSelectionView()
        {
            // TODO: Can switch?
            // TODO: Finish current jobs
            // TODO: Do the switch
            Services.UIControllerService.Instance.Messenger.NotifyColleagues("Navigate2AllergenSelectionView");
        } //NavigateToAllergenView      
    }
}
