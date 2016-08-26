using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;

namespace AllerConnectCommon.ViewModel
{
    public class Product : LocalizedItem, ICloneable
    {
        public int LocalID { get; set; }

        public int CategoryID { get; set; }

        public object Clone()
        {
            return new Product()
            {
                ID = this.ID,
                OrdinaryName = this.OrdinaryName,
                LocalName = this.LocalName,
                LanguageID = this.LanguageID,
                ToolTip = this.ToolTip,
                LocalID = this.LocalID,
                CategoryID = this.CategoryID
            };
        }
    }
}
