Date: Tue, 26 Jan 2016 20:19:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160126191913.GV24952@...1296...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NyH3Oi951yN+tEPm"
Content-Disposition: inline
In-Reply-To: <1453835508-26119-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--NyH3Oi951yN+tEPm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

so, this took quite a while - barely 2.5 years, but we're getting
there.  v3 of the patch has been rebased to git master, and all comments
from Steffan and my earlier review have been integrated into the build
stuff and the openvpn side of the code - so, as far as openvpn goes, I'm
fine with merging that but would welcome an independent ACK (given that
I modified quite a bit of Heiko's code).

The service part has been *tested* - as in:

 - compiles (mingw)
 - runs on Win7  (openvpnserv -remove, copy in new binary, run
   "openvpnvserv -install", "openvpnserv -start interactive" [or reboot])
 - does what it says on the tin:
    - run openvpn.exe as the user executing the GUI
    - handles adding and removing of ipv6 address config and v4/v6 routing
    - enables use of openvpn gui without [X] admin checkbox as a totally
      unprivileged user
    - openvpn log makes it clear whether netsh.exe is used or service

what I have not done is a full review of the resulting code - the changes
are large and intrusive, and given the amount of code *removal* it looks
like "massive cleanup" happened as well.  I do not know Windows well enough
to understand the intricacies, so a review from someone with a stronger
Windows background would be welcome - Selva, are you still around?

There are some caveats that need to be tested better in combination with
a full reinstall, like "where does the openvpn log go to, and is the
destination writeable?" - that seems to relate to registry entries that
my system did not have, so there will be extra work for Samuli and Heiko
as well...

gert
=20

On Tue, Jan 26, 2016 at 08:11:48PM +0100, Gert Doering wrote:
> From: Heiko Hund <heiko.hund@...1489...>
>=20
> v1: Heiko Hund
>  - Message-ID: <2215306.x9ci9DhAZ9@...2001...>
>  - extend openvpn service to provide "automatic service" and "interactive
>    service" (which is used by GUI and OpenVPN to run openvpn non-privileg=
ed
>    and still be able to install routes and configure IPv6 addresses)
>  - add --msg-channel <n> option to openvpn to tell it which pipe to use
>    to talk to the interactive service (used in tun.c for ifconfig + ARP f=
lush,
>    and route.c for routing)
>  - add openvpn-msg.h with message definitions for talking to interactive =
service
>  - routing in openvpn uses message-pipe automatically if --msg-channel <n=
> is
>    configured, no other option needed
>  - today, the integration in route.c and tun.c is windows-only, but could=
 be adapted
>    to other platforms
>=20
> v2: Steffan Karger
>  - Message-ID: <548D9046.5000600@...1856...>
>  - include "openvpn-msg.h" not "include/openvpn-msg.h"
>  - add $(top_srcdir)/include to openvpnsrv build for out-of-tree builds
>=20
> v3: Gert Doering, rebasing and integrating review feedback
>  - rebased to 417fe4a72c
>  - r->metric_defined is now r->flags & RT_METRIC_DEFINED (c3ef2d2333fb)
>  - move "openvpn-msg.h" include inside #ifdef WIN32 (windows-only right n=
ow)
>  - hide "msg_channel" extra option inside tt->tuntap_options, so we do not
>    need an extra argument to all the add/del_route...() functions
>  - do_route_ipv6_service(): use r->adapter index (if set) for RGI6 routes
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> Signed-off-by: Gert Doering <gert@...1296...>

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--NyH3Oi951yN+tEPm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVqfGsakuBuNlUUl1AQKpvQQAgyzHGuwtkxa6uZw+Q7BryGEMo7Rh9M3B
lVLlP2PEZuyGuobR90X/o20pLkLO6cCt5X7lv40wjhYV3XSR2IF464TX+t/GkbYJ
FZaJyGQ0VXYPc/TrCHzn5UiE1sVAXADpvDu0t7b7gldjV3NWnI9tDHXzzJRuedvh
aU9NtWyFZY4=
=D/K3
-----END PGP SIGNATURE-----

--NyH3Oi951yN+tEPm--

