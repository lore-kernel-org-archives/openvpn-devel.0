MIME-Version: 1.0
References: <20221214164824.172-1-lstipakov@...277...>
 <CAKuzo_iZPLJvSyK53oziTO99ZW6ua-DFvEWMoPAK3MjrjQ5PdA@...278...>
 <CAGyAFMV=QqUUPj8-Z8_U3JWG3qoBOZOKpMMVAztpdc-8qT+0HQ@...278...>
 <CAKuzo_g6Pc6djBCu05-k5oJFWYuTYBFa60Ucay+z1BebJK=9Gg@...278...>
 <CAGyAFMUTjZuN+W8FagK+F=4P+iuUAEYS0qmieb3kNQYKN-z=gg@...278...>
 <Y5pEEhAGyKzbNn8u@...1296...>
 <CAGyAFMUQUx_oL_Qi6SBcAdB94VCW+1tmTQVkoCh5B0BnYThkLg@...278...>
 <CAKuzo_imcQLV60uJN9mXTR8ti7gctgR=iZVpi+2AvDvSTJ_x0g@...278...>
 <CAKuzo_jVnAUeKM9=x1vU_DztqPrwYJfHe=YTy5AS8PKF2_Tv1g@...278...>
In-Reply-To: <CAKuzo_jVnAUeKM9=x1vU_DztqPrwYJfHe=YTy5AS8PKF2_Tv1g@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 15 Dec 2022 11:31:41 +0200
Message-ID: <CAGyAFMVkMAUmiNZCbp3xwognY-5d7-ZGEH9v=S17YBogfx2vnA@...278...>
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
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, Lev Stipakov <lev@...515...>, openvpn-devel@lists.sourceforge.net

Hi,

> In non-dco use, the stats as persisted by the management interface are no=
t reset throughout the lifetime of the process. With dco, what the driver p=
rovides is "Peer Stats" which is reset in OvpnPeerNew()  (linux appears to =
do the same). A quick option > would be to move the zero-ing to OvpnEvtFile=
Cleanup() which, I guess, would work at least when persist-tun is in use.

Yeah, without persist-tun client closes the handle, which triggers
OvpnEvtFileCleanup(), which would reset stats.

> Or in a new callback that gets called on tun-open. But then it wont be st=
rictly "Peer Stats".

Yeah that might be an option, to have RESET_STATS ioctl.

Also I wonder if the driver could remember, say, the last pid, and
then reset stats on NEW_PEER if pid !=3D last pid. Since pids are
recycled, we might "leak" stats in unfortunate cases, but that's okay
I guess?

--=20
-Lev

