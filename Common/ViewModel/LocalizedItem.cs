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
    }
}
