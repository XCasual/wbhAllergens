﻿using AllerConnectCommon.ViewModel;

namespace AllerConnectManager.ViewModel
{
    public class TreePartproductRootViewModel : TreeViewItemViewModel
    {
        readonly Product product;

        public TreePartproductRootViewModel(Product productElement, TreeProductViewModel parent)
            : base(parent, true)
        {
            product = productElement;
        }

        public override string ElementName
        {
            get { return WPFLocalizeExtension.Engine.LocalizeDictionary.Instance.GetLocalizedObject("TreePartproducts", null, System.Threading.Thread.CurrentThread.CurrentUICulture).ToString(); }
        }

        internal int ID
        {
            get { return product.ID; }
        }

        protected override void LoadChildren()
        {
            var parentModel = base.Parent as TreeProductViewModel;
            foreach (Product productElement in App.UIController.IngridientsDB.GetPartproduct(parentModel.ID, App.UIController.CurrentLanguageID, product.LocalID))
                    base.Children.Add(new TreePartproductViewModel(productElement, parentModel));
        }

        public override App.ProductCompositeViewStates ElementComposit
        {
            get
            {
                return App.ProductCompositeViewStates.TreePartproductSelectionView;
            }
        }
    }
}