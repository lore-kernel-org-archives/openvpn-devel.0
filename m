MIME-Version: 1.0
References: <20221214164824.172-1-lstipakov@...277...>
 <CAKuzo_iZPLJvSyK53oziTO99ZW6ua-DFvEWMoPAK3MjrjQ5PdA@...278...>
In-Reply-To: <CAKuzo_iZPLJvSyK53oziTO99ZW6ua-DFvEWMoPAK3MjrjQ5PdA@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 14 Dec 2022 21:06:32 +0200
Message-ID: <CAGyAFMV=QqUUPj8-Z8_U3JWG3qoBOZOKpMMVAztpdc-8qT+0HQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Introduce dco_get_peer_stats API and
 Windows implementation
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

Hi,

> Good to see this happening..

Turns out there is a bug in the driver at the moment - it doesn't
update OUT bytes. This particular API hasn't been used in a while.

> Does this data from the driver include both control and data channel  bytes?

Yes, at the moment those are "link" bytes and they include both
control and data channels.

> Right now what the GUI receives as bytecount  is not zero, I suppose the daemon is reporting the control channel traffic.

Yes. I will fix it in the driver so that it reports only data channel
bytes, since control channel bytes are already counted in userspace.

> That would be OVPN_IOCTL_GET_STATS

Let me send v2 with fixed error message text and produce an MSI with
the driver fixes.

-- 
-Lev

