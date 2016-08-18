using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AllerConnectCommon.Services
{
    public class UIControllerService
    {
        private static UIControllerService _instance = new UIControllerService();

        public static UIControllerService Instance
        {
            get
            {
                return _instance;
            }
        }

        public int CurrentLanguageID { get; set; }
        public int CurrentLocalID { get; set; }


        private static Model.IngridientsDB _ingridientsDB = new Model.IngridientsDB();
        readonly static Foundation.Messenger _messenger = new Foundation.Messenger();

        public Model.IngridientsDB IngridientsDB
        {
            get { return _ingridientsDB; }
        }

        public Foundation.Messenger Messenger
        {
            get { return _messenger; }
        }
    }
}
