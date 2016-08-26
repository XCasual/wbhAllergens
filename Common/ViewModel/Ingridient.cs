using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;

namespace AllerConnectCommon.ViewModel
{
    public class Ingridient : LocalizedItem, ICloneable
    {
        public bool IsConservant { get; set; }

        public object Clone()
        {
            return new Ingridient()
            {
                ID = this.ID,
                OrdinaryName = this.OrdinaryName,
                LocalName = this.LocalName,
                IsConservant = this.IsConservant
            };
        }
    }
}
