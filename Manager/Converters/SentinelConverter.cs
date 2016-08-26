using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Data;

namespace AllerConnectManager.Converters
{
    public class SentinelConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            return value;
        }

        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (value != null && string.Equals("{NewItemPlaceholder}", value.ToString(), StringComparison.Ordinal))
            {
                return null;
            }

            return value;
        }
    }
}
