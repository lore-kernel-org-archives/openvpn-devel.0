MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <1341089443-2287-1-git-send-email-gert@...1296...>
References: <1341089443-2287-1-git-send-email-gert@...1296...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Sun, 1 Jul 2012 14:43:23 +0200
Message-ID: <CAP+U6tLzrGuqCny+zRctk2taDbTnfX1+w4GRcvioi5i1CmXR0w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Repair "tap server" mode brokenness
 caused by <stdbool.h> fallout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi everyone,

2012/6/30 Gert Doering <gert@...1296...>:
> diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
> index aecb702..850e336 100644
> --- a/src/openvpn/mroute.c
> +++ b/src/openvpn/mroute.c
> @@ -52,7 +52,7 @@ mroute_addr_init (struct mroute_addr *addr)
> =C2=A0static inline bool
> =C2=A0is_mac_mcast_addr (const uint8_t *mac)
> =C2=A0{
> - =C2=A0return (bool) mac[0] & 1;
> + =C2=A0return (bool) (mac[0] & 1);
> =C2=A0}
>
> =C2=A0static inline bool

ACK. In the context of is_mac_mcast_addr, the check now looks obviously cor=
rect.

Cheers
Fabian

