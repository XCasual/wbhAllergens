using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AllerConnectCommon.ViewModel
{
    public abstract class LocalizedItem
    {
        public int ID { get; set; }

        public int LanguageID { get; set; }

        public int LocalisationID { get; set; }

        public string OrdinaryName { get; set; }

        public string LocalName { get; set; }

        public string ToolTip { get; set; }

        public bool IsSelected { get; set; }

        public bool IsChecked { get; set; }
    }
}
