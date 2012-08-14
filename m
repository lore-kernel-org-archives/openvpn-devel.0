Date: Tue, 14 Aug 2012 21:47:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120814194736.GU2535@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xPLL5cPndR2UZ7Mw"
Content-Disposition: inline
Subject: [Openvpn-devel] RFC: tun/tap cleanup at program end
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--xPLL5cPndR2UZ7Mw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

background: I spent quite some time in the 2.3 development cycle in
ensuring that OpenVPN quits nicely, leaving nothing behind - specifically,
this meant "make sure that all tun/tap interfaces we have created are
destroyed as well" - which is now breaking some people's setups :-/

On FreeBSD, the interaction between /dev/tap<X> device nodes and the
"ifconfig" devices is as follows (same for tunX):

Case A: no tapX in the system yet, --dev tapX

 - we open the /dev/tunX device, get a file descriptor
 - the operating system auto-instanciates tunX
 - we call ifconfig tunX
 - at the end of the program, we close the file descriptor
 - to remove the tunX device again, we call "ifconfig tunX destroy"

Case B: there is an pre-existing tapX device, bound to a bridge

 - we do everything as in case A
 - at the end of the program, the tapX device is destroyed
 - on the next start of openvpn, tapX is recreated, and no longer part of
   the bridge

(the other BSDs are slightly different, of course, but the underlying
issue is the same)


In OpenVPN 2.2, "case A" used to leak devices - that is, the tapX device=20
stuck behind after OpenVPN exited, which I consider bad behaviour.  OTOH,=20
"case B" worked (somewhat by accident, as *OpenBSD* used to have the=20
same issue of lingering devices, and OpenVPN worked around it by always=20
calling "ifconfig tapX destroy" on startup...)

In OpenVPN 2.3, "case A" is fixed up, but now "case B" is broken, and I'm=20
not exactly sure how to fix it - obviously, fixed it must be, as starting
and stopping should not permanently alter the system state unless it's
asked for (--mktun / --rmtun).


I can see two options how to solve this:

1 - set a flag if a device has been opened using a dynamic number=20
    ("--dev tap", which hunts for the first-free tapN device), and=20
    if yes, destroy the device on tun_close().=20=20

    This would leave devices lingering around if you call openvpn with=20
    "--dev tap3" and there has not been a "tap3" before - but this could=20
    be documented as "intended behaviour", and it would be fairly=20
    straightforward to implement.

2 - actually check for "--dev tap3" whether it exists before (by calling
    "ifconfig tap3" and checking the error return code - accessing /dev/tap3
    will not work, as that *always* springs the device to life), and=20
    destroy devices that we newly created, while leaving alone devices that
    have been there before.

    This will have the most nice user experience ("always leave the system
    as it was before"), but the implementation would mess up tun.c somewhat
    more.

So I'd opt for variant 1...

(As this needs to go into 2.3, "rewrite all of tun.c" or "use RT_NETLINK"
is out)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--xPLL5cPndR2UZ7Mw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUCqrWKkuBuNlUUl1AQK5xgP8D91fgBF61v8c+kznT2oLrZdvgOSWyxC2
JgQF9qIbeB5muicZDpzFynmPZciF+rBxNT3/2RNzbOC4C7eprrB+afYI5+gWLZu7
/kQ8C/DjEvxGIdkjQcYW/7SmP7m4/M5KUMDZkddO8u2KzI3R64TEtJs6zg2fkCmY
dzXCiMjXWM0=
=yGBq
-----END PGP SIGNATURE-----

--xPLL5cPndR2UZ7Mw--

