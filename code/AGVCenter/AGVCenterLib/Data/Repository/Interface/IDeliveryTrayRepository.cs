﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AGVCenterLib.Model;

namespace AGVCenterLib.Data.Repository.Interface
{
    public interface IDeliveryTrayRepository
    {
        void Create(DeliveryTray entity);

        void Creates(List<DeliveryTray> entities);
    }
}