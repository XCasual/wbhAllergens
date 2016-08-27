using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.Data.Linq;
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
                            where ad.AllergenLanguageID == languageId
                            select new ViewModel.Allergen
                            {
                                ID = ad.AllergenID,
                                OrdinaryName = ad.AllergenOrdinaryName.Replace("\r\n",""),
                                LocalisationID = ad.AllergenLocalD.HasValue ? ad.AllergenLocalD.Value : -100,
                                LanguageID = ad.AllergenLanguageID.HasValue ? ad.AllergenLanguageID.Value : -101,
                                LocalName = ad.AllergenLocalName != null ? ad.AllergenLocalName.Trim() : "(ERR:102)",
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

        public DBObservableCollection<ViewModel.Category> GetCategories(int languageId)
        {
            hasError = false;
            var categoryCollection = new DBObservableCollection<ViewModel.Category>();
            try
            {
                var dc = new LinqDataContext();
                var query = from cd in dc.CategoryDatas
                            where cd.CategoryLanguageID == languageId
                            select new ViewModel.Category
                            {
                                ID = cd.CategoryID,
                                OrdinaryName = cd.CategoryOrdinaryName.Replace("\r\n",""),
                                LanguageID = cd.CategoryLanguageID,
                                LocalName = cd.CategoryLocalName != null ? cd.CategoryLocalName.Trim() : "(ERR:102)"
                            };
                foreach (var sp in query)
                {
                    categoryCollection.Add(sp);
                }
            } //try
            catch (Exception ex)
            {
                errorMessage = "GetCategories() error, " + ex.Message;
                hasError = true;
            }
            return categoryCollection;
        } //GetCategories()

        public DBObservableCollection<ViewModel.Product> GetProducts(int languageId, int categoryId, int localId)
        {
            hasError = false;
            var productCollection = new DBObservableCollection<ViewModel.Product>();
            try
            {
                var dc = new LinqDataContext();
                var query = from pd in dc.ProductDatas
                            where pd.ProductLanguageID == languageId && pd.ProductCategoryID == categoryId && pd.LocationID == localId
                            select new ViewModel.Product
                            {
                                ID = pd.ProductID,
                                OrdinaryName = pd.ProductOdrinaryName.Replace("\r\n",""),
                                LanguageID = pd.ProductLanguageID,
                                CategoryID = pd.ProductCategoryID,
                                LocalID = pd.LocationID,
                                LocalName = pd.ProductName != null ? pd.ProductName.Trim() : "(ERR:102)"
                            };
                foreach (var sp in query)
                {
                    productCollection.Add(sp);
                }
            } //try
            catch (Exception ex)
            {
                errorMessage = "GetProducts() error, " + ex.Message;
                hasError = true;
            }
            return productCollection;
        } //GetProducts()

        public DBObservableCollection<ViewModel.Product> GetProducts(int languageId, int localId)
        {
            hasError = false;
            var productCollection = new DBObservableCollection<ViewModel.Product>();
            try
            {
                var dc = new LinqDataContext();
                var query = from pd in dc.ProductDatas
                            where pd.ProductLanguageID == languageId && pd.LocationID == localId
                            select new ViewModel.Product
                            {
                                ID = pd.ProductID,
                                OrdinaryName = pd.ProductOdrinaryName.Replace("\r\n",""),
                                LanguageID = pd.ProductLanguageID,
                                CategoryID = pd.ProductCategoryID,
                                LocalID = pd.LocationID,
                                LocalName = pd.ProductName != null ? pd.ProductName.Trim() : "(ERR:102)"
                            };
                foreach (var sp in query)
                {
                    productCollection.Add(sp);
                }
            } //try
            catch (Exception ex)
            {
                errorMessage = "GetProducts() error, " + ex.Message;
                hasError = true;
            }
            return productCollection;
        } //GetProducts()


        public DBObservableCollection<ViewModel.Product> GetPartproduct(int parentProductID)
        {
            hasError = false;
            var partproductCollection = new DBObservableCollection<ViewModel.Product>();
            try
            {
                var dc = new LinqDataContext();
                var partproducts = dc.ProductProductRead().Where(row => row.ProductParentID == parentProductID);
                var query = from pp in partproducts
                            join pd in dc.ProductDatas on  pp.ProductParentID equals pd.ProductID
                            select new ViewModel.Product
                            {
                                ID = pd.ProductID,
                                OrdinaryName = pd.ProductOdrinaryName.Replace("\r\n",""),
                                LanguageID = pd.ProductLanguageID,
                                CategoryID = pd.ProductCategoryID,
                                LocalID = pd.LocationID,
                                LocalName = pd.ProductName != null ? pd.ProductName.Trim() : "(ERR:102)"
                            };
                foreach (var sp in query)
                {
                    partproductCollection.Add(sp);
                }
            } //try
            catch (Exception ex)
            {
                errorMessage = "GetPartproduct() error, " + ex.Message;
                hasError = true;
            }
            return partproductCollection;
        } //GetPartproduct()

        public DBObservableCollection<ViewModel.Ingridient> GetIngridients(bool ignoreConservantFlag, int parentProductID = -1,  bool conservantsOnly = false)
        {
            hasError = false;
            var ingridientCollection = new DBObservableCollection<ViewModel.Ingridient>();
            try
            {
                var dc = new LinqDataContext();
                if (ignoreConservantFlag)
                {
                    var query = from id in dc.IngridientDatas
                                join pd in dc.ProductsIngridients on id.IngridientID equals pd.IngridientID
                                where pd.ProductID == parentProductID || parentProductID == -1
                                select new ViewModel.Ingridient
                                {
                                    ID = pd.ProductID,
                                    OrdinaryName = id.IngridientOrdinaryName.Replace("\r\n",""),
                                    IsConservant = id.IngridientClass != null,
                                    ClassName = id.IngridientClass,
                                    ClassType = id.IngridientTyp,
                                    LanguageID = id.IngridientLanguageID.HasValue ? id.IngridientLanguageID.Value : -1,
                                    LocalName = id.IngridientName != null ? id.IngridientName : "(ERR:102)"
                                };
                    foreach (var sp in query)
                    {
                        ingridientCollection.Add(sp);
                    }
                }
                else
                {
                    var query = from id in dc.IngridientDatas
                                join pd in dc.ProductsIngridients on id.IngridientID equals pd.IngridientID
                                where ((id.IngridientClass != null) == conservantsOnly) && (pd.ProductID == parentProductID || parentProductID == -1)
                                select new ViewModel.Ingridient
                                {
                                    ID = pd.ProductID,
                                    OrdinaryName = id.IngridientOrdinaryName.Replace("\r\n",""),
                                    IsConservant = id.IngridientClass != null,
                                    ClassName = id.IngridientClass,
                                    ClassType = id.IngridientTyp,
                                    LanguageID = id.IngridientLanguageID.HasValue ? id.IngridientLanguageID.Value : -1,
                                    LocalName = id.IngridientName != null ? id.IngridientName.Trim() : "(ERR:102)"
                                };
                    foreach (var sp in query)
                    {
                        ingridientCollection.Add(sp);
                    }
                }
            } //try
            catch (Exception ex)
            {
                errorMessage = "GetPartproduct() error, " + ex.Message;
                hasError = true;
            }
            return ingridientCollection;
        } //GetPartproduct()

        public DBObservableCollection<v_ProductAllergensResult> GetProductAllergenInfo(ViewModel.Product parentProduct)
        {
            hasError = false;
            var productAllergenCollection = new DBObservableCollection<v_ProductAllergensResult>();
            try
            {
                var dc = new LinqDataContext();
                var query = from pa in dc.v_ProductAllergens(parentProduct.ID, parentProduct.LocalID, parentProduct.CategoryID, parentProduct.LanguageID)
                            select pa;
                foreach (var sp in query)
                {
                    productAllergenCollection.Add(sp);
                }
            } //try
            catch (Exception ex)
            {
                errorMessage = "GetPartproduct() error, " + ex.Message;
                hasError = true;
            }
            return productAllergenCollection;
        } //GetPartproduct()


        public int GetLanguageID(string cultureName)
        {
            hasError = false;
            int resultID = -1;
            try
            {
                var dc = new LinqDataContext();
                var resultRow = dc.Languages.Where(p => p.LanguageShortCode == cultureName).FirstOrDefault();
                resultID = resultRow.LanguageID;
            } //try
            catch (Exception ex)
            {
                errorMessage = "GetPartproduct() error, " + ex.Message;
                hasError = true;
            }
            return resultID;
        } //GetPartproduct()

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
                var aldm = dc.AllergensLocals.Where(ad => ad.AllergenLocalD == da.LocalisationID).First();
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

                var rowToDelete = dc.Allergens.Where(param => param.AllergenID == allergenID).First();
                dc.Allergens.DeleteOnSubmit(rowToDelete);
                dc.SubmitChanges(ConflictMode.FailOnFirstConflict);
            }
            catch (Exception ex)
            {
                errorMessage = "Delete error, " + ex.Message;
                hasError = true;
            }
            return !hasError;
        }// DeleteAllergen()


        public bool AddIngriedient(ViewModel.Ingridient ig)
        {
            try
            {
                var dc = new LinqDataContext();
            }
            catch (Exception ex)
            {
                errorMessage = "Update error, " + ex.Message;
                hasError = true;
            }
            return (!hasError);
        } //AddAllergen()

        public bool UpdateIngriedient(ViewModel.Ingridient ig)
        {
            try
            {
                var dc = new LinqDataContext();

                // Automaticly via constrains
            }
            catch (Exception ex)
            {
                errorMessage = "Update error, " + ex.Message;
                hasError = true;
            }
            return (!hasError);
        } //UpdateAllergen()

        public bool DeleteIngriedient(int ingriedientID)
        {
            hasError = false;
            try
            {
                var dc = new LinqDataContext();

                var rowToDelete = dc.Allergens.Where(param => param.AllergenID == ingriedientID).First();
                dc.Allergens.DeleteOnSubmit(rowToDelete);
                dc.SubmitChanges(ConflictMode.FailOnFirstConflict);
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
