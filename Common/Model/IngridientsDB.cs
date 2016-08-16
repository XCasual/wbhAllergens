using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AllerConnectCommon.Model
{
    public class IngridientsDB
    {
        public bool hasError = false;
        public string errorMessage;

        public IngridientsDB()
        {

        }

        public DBObservableCollection<ViewModel.Allergen> GetAllergens(int languageId)
        {
            hasError = false;
            var allergenCollection = new DBObservableCollection<ViewModel.Allergen>();
            try
            {
                var dc = new LinqDataContext();
                var query = from ta in dc.Allergens
                            join talLOJ in dc.AllergensLocals on ta.AllergenID equals talLOJ.AllergenID into talLOJList
                            from talLOJ in talLOJList.DefaultIfEmpty()
                            where talLOJ.AllergenLanguageID == languageId
                            join tsLOJ in dc.AllergensSymbols on ta.AllergenID equals tsLOJ.AllergenID into tsLOJList
                            from tsLOJ in tsLOJList.DefaultIfEmpty()
                            select new ViewModel.Allergen
                            {
                                ID = ta.AllergenID,
                                OrdinaryName = ta.AllergenOrdinaryName,
                                LanguageID = talLOJ.AllergenLanguageID == 0 ? -100 : talLOJ.AllergenLanguageID,
                                LocalName = talLOJ.AllergenLocalName == null ? "(ERR:101)" : talLOJ.AllergenLocalName,
                                ToolTip = talLOJ.AllergenLocalToolTip == null ? "(ERR:102)" : talLOJ.AllergenLocalToolTip,
                                SymbolID = tsLOJ.AllergenSymbolID,
                                SymbolBuffer = tsLOJ.Symbol.SymbolImage.ToArray()
                            };
                foreach (var sp in query)
                {
                    allergenCollection.Add(sp);
                }
            } //try
            catch (Exception ex)
            {
                errorMessage = "GetAllergens() error, " + ex.Message;
                hasError = true;
            }
            return allergenCollection;
        } //GetAllergens()

        public bool AddAllergen(ViewModel.Allergen displayAllergen)
        {
            try
            {
                var dc = new LinqDataContext();
                int? allergenID = -1;
                dc.AddAllergen(displayAllergen.OrdinaryName, ref allergenID);
                displayAllergen.ID = allergenID.Value;
            }
            catch (Exception ex)
            {
                errorMessage = "Update error, " + ex.Message;
                hasError = true;
            }
            return (!hasError);
        } //AddAllergen()

        public bool UpdateAllergen(ViewModel.Allergen displayAllergen)
        {
            try
            {
                var dc = new LinqDataContext();
                dc.UpdateAllergen(displayAllergen.OrdinaryName, displayAllergen.ID);
            }
            catch (Exception ex)
            {
                errorMessage = "Update error, " + ex.Message;
                hasError = true;
            }
            return (!hasError);
        } //UpdateAllergen()

        public bool DeleteAllergen(int allergenID)
        {
            hasError = false;
            try
            {
                var dc = new LinqDataContext();
                dc.DeleteAllergen(allergenID);
            }
            catch (Exception ex)
            {
                errorMessage = "Delete error, " + ex.Message;
                hasError = true;
            }
            return !hasError;
        }// DeleteAllergen()
    }
}
