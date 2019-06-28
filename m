MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Fri, 28 Jun 2019 16:51:47 -0400
Message-ID: <CAKuzo_j6F2+_JxosdVF3iB4kzWsR7Wq2FT8Vgi9Cg3yvT_A1JQ@...278...>
Subject: [Openvpn-devel] Using AllowNonAdmin in the advanced options of tap
 adapter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

While testing a patch, I failed to toggle AllowNonAdmin access to the
tap-adapter.
Looking at the sources it seems we do not respect that setting.

From adapter.c ~line
#if ENABLE_NONADMIN
            NdisReadConfiguration (
                &localStatus,
                &configParameter,
                configHandle,
                &allowNonAdminKey,
                NdisParameterInteger
                );

            if (localStatus == NDIS_STATUS_SUCCESS)
            {
                if (configParameter->ParameterType == NdisParameterInteger)
                {
                    Adapter->AllowNonAdmin = TRUE;
                }
            }
#endif

The code does not appear to check the actual value read from registry
which will be in configParameter->ParameterData.IntegerData, but
enables AllowNonAdmin in any case.

Would that mean we can assume that always allowing all users access to
the tap (say, using the service to open it) would not be a regression?
Or are there folks who use local builds of the driver and expect
openvpn.exe to respect that setting?

Thanks,

Selva

