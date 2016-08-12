using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using System.Windows.Media;

namespace AllerConnectCommon.ViewModel
{
    //Allergen Error detection, error display and status msg
    //Note, a Delete may be performed without checking any Allergent fields
    public class AllergenDisplayModelStatus : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged(PropertyChangedEventArgs e)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, e);
        }

        //Error status msg and field Brushes to indicate Allergen field errors
        private string status;
        public string Status
        {
            get { return status; }
            set { status = value; OnPropertyChanged(new PropertyChangedEventArgs("Status")); }
        }
        private static SolidColorBrush errorBrush = new SolidColorBrush(Colors.Red);
        private static SolidColorBrush okBrush = new SolidColorBrush(Colors.Black);

        private SolidColorBrush modelOrtinaryNameBrush = okBrush;
        public SolidColorBrush ModelOrdinaryNameBrush
        {
            get { return modelOrtinaryNameBrush; }
            set { modelOrtinaryNameBrush = value; OnPropertyChanged(new PropertyChangedEventArgs("ModelOrdinaryNameBrush")); }
        }

        //set error field brushes to OKBrush and status msg to OK
        public void NoError()
        {
            ModelOrdinaryNameBrush = okBrush;
            Status = "OK";
        } //NoError()


        public AllergenDisplayModelStatus()
        {
            NoError();
        } //ctor

        //check all Allergen fields for validity
        public bool ChkAllergenForAdd(Allergen al)
        {
            int errCnt = 0;
            if (String.IsNullOrEmpty(al.OrdinaryName))
            { errCnt++; ModelOrdinaryNameBrush = errorBrush; }
            else ModelOrdinaryNameBrush = okBrush;

            if (errCnt == 0) { Status = "OK"; return true; }
            else { Status = "ADD, missing or invalid fields."; return false; }
        } //ChkAllergenForAdd()


        //check all Allergen fields for validity
        public bool ChkAllergenForUpdate(Allergen al)
        {
            int errCnt = 0;
            if (String.IsNullOrEmpty(al.OrdinaryName))
            { errCnt++; ModelOrdinaryNameBrush = errorBrush; }
            else ModelOrdinaryNameBrush = okBrush;

            if (errCnt == 0) { Status = "OK"; return true; }
            else { Status = "Update, missing or invalid fields."; return false; }
        } //ChkAllergenForUpdate()

    } //class AllergenDisplayModelStatus
}  //NS: AllerConnectCommon.ViewModel
