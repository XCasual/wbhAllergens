using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;

namespace AllerConnectCommon.ViewModel
{
    public class Category : LocalizedItem, ICloneable
    {

        public object Clone()
        {
            return new Category()
            {
                ID = this.ID,
                OrdinaryName = this.OrdinaryName,
                LocalName = this.LocalName
            };
        }
    }
}
