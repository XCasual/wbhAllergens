using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;

namespace AllerConnectInfo
{
    class CompositionSelector : DataTemplateSelector
    {
        public override DataTemplate SelectTemplate
            (object item, DependencyObject container)
        {
            if (item == null)
                return null;

            // Determine the resource key to use
            var key = string.Format("{0}DataTemplate", item);
            // Find the resource starting from the container
            var dataTemplate = ((FrameworkElement)container).FindResource(key) as DataTemplate;

            return dataTemplate;
        }
    }
}
