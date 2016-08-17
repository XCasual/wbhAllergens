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
                var query = from ad in dc.AllergenDatas
                            select new ViewModel.Allergen
                            {
                                ID = ad.AllergenID,
                                LocalID = ad.AllergenLanguageID.HasValue ? ad.AllergenLanguageID.Value : -100,
                                OrdinaryName = ad.AllergenOrdinaryName,
                                LanguageID = ad.AllergenLanguageID.HasValue ? ad.AllergenLanguageID.Value : -101,
                                LocalName = ad.AllergenLocalName != null ? ad.AllergenLocalName : "(ERR:102)",
                                ToolTip = ad.AllergenLocalToolTip != null ? ad.AllergenLocalToolTip : "(ERR:103)",
                                SymbolID = ad.AllergenSymbolID,
                                SymbolBuffer = ad.SymbolImage.ToArray(),
                                SymbolArt = ad.SymbolArt
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

        public bool AddAllergen(ViewModel.Allergen da)
        {
            try
            {
                var dc = new LinqDataContext();

                // Symbol
                var resSymbol = dc.SymbolCreate(da.SymbolBuffer, da.SymbolArt).First();
                // Allergen
                var resAllergen = dc.AllergenCreate(da.OrdinaryName).First();
                // Localised description
                var resAllergenLocal = dc.AllergenLocalCreate(da.LocalName, da.ToolTip, resAllergen.AllergenID, da.LanguageID).First();
                // Symbol <-> Allergen
                var resAllergenSymbol = dc.AllergenSymbolCreate(resAllergen.AllergenID, resSymbol.SymbolID).First();

                da.ID = resAllergen.AllergenID;
                da.SymbolID = resSymbol.SymbolID;
            }
            catch (Exception ex)
            {
                errorMessage = "Update error, " + ex.Message;
                hasError = true;
            }
            return (!hasError);
        } //AddAllergen()

        public bool UpdateAllergen(ViewModel.Allergen da)
        {
            try
            {
                var dc = new LinqDataContext();

                // Symbol
                var sdm = dc.SymbolDatas.Where(sd => sd.SymbolID == da.SymbolID).First();
                var resSymbol = dc.SymbolUpdate(da.SymbolBuffer, sdm.SymbolArt, da.SymbolID, sdm.SymbolArt, da.SymbolID).First(); 
                // Allergen
                var adm = dc.AllergenDatas.Where(ad => ad.AllergenID == da.ID).First();
                var resAllergen = dc.AllergenUpdate(da.OrdinaryName, adm.AllergenID, adm.AllergenOrdinaryName, da.ID).First();
                // Localised description
                var aldm = dc.AllergensLocals.Where(ad => ad.AllergenLocalD == da.LocalID).First();
                var resAllergenLocal = dc.AllergenLocalUpdate(da.LocalName, da.ToolTip, da.ID, da.LanguageID, aldm.AllergenID, aldm.AllergenLocalName, aldm.AllergenLocalToolTip,
                    da.ID, aldm.AllergenLanguageID, aldm.AllergenLocalD).First();
                // Symbol <-> Allergen
                // Automaticly via constrains
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
                var adm = dc.AllergenDatas.Where(ad => ad.AllergenID == allergenID).First();
                var rowResult = dc.AllergenDelete(adm.AllergenID, adm.AllergenOrdinaryName);
                System.Diagnostics.Debug.Assert(rowResult != 1);
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
