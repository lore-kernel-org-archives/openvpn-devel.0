From: Peter Sagerson <psagers@...1829...>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_6F5D9F4F-B9CB-4937-9661-E3C4C9DB2860";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <5C629764-6A77-4E0D-8B27-AF0AE8B29025@...1829...>
Date: Sat, 15 Jun 2013 14:13:09 -0700
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: [Openvpn-devel] Native OS X tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_6F5D9F4F-B9CB-4937-9661-E3C4C9DB2860
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Running openvpn on Mac OS X has always been a bit cumbersome, on account of=
 the lack of native tun/tap devices. A third-party kernel extension exists,=
 but, in addition to being a barrier in itself, it can only be installed on=
ce, leading to a collection of mutually incompatible OS X apps competing to=
 have their version installed. Also it occasionally gets broken by OS X upg=
rades. It's kind of a big hairball of despair.

As it happens, Apple quietly introduced native user tunnels (utun) for thei=
r own purposes in OS X 10.6. The APIs are public, although not what you wou=
ld call documented. Thanks to some scraps on the wide Internet and a nudge =
from an Apple engineer at WWDC, I've been able to add utun support to openv=
pn. I have a fork on Github with a complete working implementation: https:/=
/github.com/bbits/openvpn/tree/utun.

What I would love now is to find some more intrepid OS X users to take it f=
or a whirl. I've been testing it in the context of the OS X Cloak client wi=
thout so much as a hiccup. Of course, that still leaves plenty of scenarios=
 to test, especially covering IPv6 and non-default topologies. Use "--dev t=
unX --dev-impl-osx utun" to switch to the utun implementation.

In terms of the code, the only significant addition is a version of open_tu=
n that creates a utun device. This is accomplished through a mystical socke=
t incantation rather than opening a character device, but after that it's t=
he same deal. Not surprisingly, read/write behavior matches the Free/OpenBS=
D implementations, so that code is the same. The only other addition is a n=
ew option to activate it; the default behavior is unchanged.

I've been working primarily on 10.8, but I'm also able to build and run on =
10.7 and 10.6, which is as far back as my archive currently goes. The chang=
es will definitely break the build on 10.5 and earlier. I don't know what y=
our deprecation policy is, but if anyone cares about supporting such old sy=
stems, I'm sure utun support could be turned into a configure-time option.

Looking forward to feedback and next steps.

Thanks,
Peter
Founder, GetCloak.com=

--Apple-Mail=_6F5D9F4F-B9CB-4937-9661-E3C4C9DB2860
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)

iQIcBAEBAgAGBQJRvNjnAAoJENfXJ2LQ+g52RoUQAI9vp1CujKLdKwexrCSGDcyl
kxyQMdq4FzpSQGCwV5UDbjZ954KdvmwkElLLzAWagTkoMGcXnJ97VpMDScBLWgd8
/iI+icTj53w2+EB4vfVdwO4Vl9ziCsVxgJGmchUXwj4oUg7YUIb0u4UJjFJgeSCX
G5RqhBmgocn888K3TRWK9/PNnnP8KV/XJcuAvM5f6a2C1rUeDtFl3IsEPCk5Eg1y
x/agbExuVCO2wbmJRFG9TC8PWEXytGobfGdZpT9snaC1AkpAburSjMkwkGihueFR
4N8WLY/m685UUGuBtA2I9bHNJOrml4DV38/pVNVBrE9Qhno1x421b2yGBnbSpjnH
vrKmh0plqpSfkltlziz/cPDwj4RpMqJea7J13Wd/I8nLffOQ87HPbWFBzmTFtTvE
bSuTkNSdd6AUI/5yruSC1ZOOXesVShWDkmW38rGd8YkHo8yPrg50bgR/oiYd9oaN
RKN/cFithPNBOI7aKyXKGfWlFL7Gow/5d1yvXhp/GnBdX6yif5SIaS489WY6hcEF
sqMyQWZXHH++7DH3pAfNzitWuJ3QL4nFGZV8kzaN6VCyzRA8ztaqC27QuprSG0u4
BU2u2lqdhvU7xkovHNYrfFqsyUhBGieLynDf0ZgcEVHzr4gSMr4tCrfUWQMR5Odx
YBZRkMzezlEl1hIeD4FD
=2yGC
-----END PGP SIGNATURE-----

--Apple-Mail=_6F5D9F4F-B9CB-4937-9661-E3C4C9DB2860--

