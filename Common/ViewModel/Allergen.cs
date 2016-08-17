using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;

namespace AllerConnectCommon.ViewModel
{
    public class Allergen : LocalizedItem, ICloneable
    {
        public string OrdinaryName { get; set; }

        public string LocalName { get; set; }

        public string ToolTip { get; set; }

        public int SymbolID { get; set; }

        public Image SymbolImage
        {
            get
            {
                if (_symbolImage == null)
                    return _symbolImage;

                MemoryStream ms = new MemoryStream(_symbolBuffer);
                var returnImage = Image.FromStream(ms);
                _symbolImage = returnImage;
                return _symbolImage;
            }
            set
            {
                if (value == null)
                {
                    _symbolImage = null;
                    _symbolBuffer = null;
                }
                else
                {
                    MemoryStream ms = new MemoryStream();
                    value.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    _symbolBuffer = ms.ToArray();
                    _symbolImage = value;
                }
            }
        }

        public byte[] SymbolBuffer
        {
            get
            {
                return _symbolBuffer;
            }
            set
            {
                if (value == null)
                {
                    _symbolBuffer = null;
                    _symbolImage = null;
                }
                else
                {
                    MemoryStream ms = new MemoryStream(value);
                    var returnImage = Image.FromStream(ms);
                    _symbolImage = returnImage;
                    _symbolBuffer = value;
                }
            }
        }

        private byte[] _symbolBuffer;
        private Image _symbolImage;

        public object Clone()
        {
            return new Allergen()
            {
                ID = this.ID,
                LocalID = this.LocalID,
                OrdinaryName = this.OrdinaryName,
                LocalName = this.LocalName,
                LanguageID = this.LanguageID,
                ToolTip = this.ToolTip,
                SymbolID = this.SymbolID,
                SymbolBuffer = this.SymbolBuffer
            };
        }
    }
}
