using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AllerConnectCommon.Model
{
    public class DBObservableCollection<T> : ObservableCollection<T>
    {
        public void UpdateCollection()
        {
            OnCollectionChanged(new NotifyCollectionChangedEventArgs(
                                NotifyCollectionChangedAction.Reset));
        }

        public void ReplaceItem(int index, T item)
        {
            base.SetItem(index, item);
        }
    } // class DBObservableCollection
}
