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
        public string OrdinaryName { get; set; }

        public string LocalName { get; set; }

        public string ToolTip { get; set; }

        public List<int> AllergenID { get; set; }

        public object Clone()
        {
            return new Ingridient()
            {
                ID = this.ID,
                LocalID = this.LocalID,
                OrdinaryName = this.OrdinaryName,
                LocalName = this.LocalName,
                LanguageID = this.LanguageID,
                ToolTip = this.ToolTip,
                AllergenID = new List<int>(this.AllergenID.ToArray())
            };
        }
    }
}
