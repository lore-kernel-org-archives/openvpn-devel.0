Date: Fri, 29 Oct 2010 14:25:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20101029122554.GQ10703@...1296...>
References: <AANLkTiko6XdjTaNL_y5=+mAXUjHE4A22tPQcc14tqu-s@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nd5ezxtHU51lQLUj"
Content-Disposition: inline
In-Reply-To: <AANLkTiko6XdjTaNL_y5=+mAXUjHE4A22tPQcc14tqu-s@...278...>
Subject: Re: [Openvpn-devel] [PATCH] TAP driver for Solaris patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kazuyoshi Aizawa <admin2@...628...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Nd5ezxtHU51lQLUj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Kazuyoshi-San,

On Mon, Sep 06, 2010 at 11:13:09PM +0900, Kazuyoshi Aizawa wrote:
> I attached a patch for OpenVPN 2.1.3 to support TAP driver for Solaris.
> Also, you can find the patch as well as TAP driver here.
>      http://www.whiteboard.ne.jp/~admin2/tuntap/

Thanks for your work.  I am working on integration of your patch into=20
the 2.2 tree in git, so that it can go into OpenVPN 2.2-beta4 and be part
of the regular OpenVPN distribution in future.

I have tested it on OpenSolaris/i386, latest DVD release.

The patch applies without major problems (offset by 11 lines, but no other
problems), "--mode tap" works fine, and "--mode tun" continues to work
(which was important to test for me, as your patch changes bits of the
"tun" code as well).


One oddity remains: "--mode tun" + "--topology subnet" (not using=20
point-to-point but "broadcast" tun interfaces) does not work.  I'm not=20
sure whether this is a known limitation of the Solaris tun drivers, or=20
of the way we currently access the interface - but it would be great=20
if that could made to work - it's part of my set of regression tests...=20=
=20
(this is *not* a problem introduced by your patch, it does not work for=20
stock 2.2-beta3 either).


The failure looks like this in the log:

Fri Oct 29 14:00:02 2010 SENT CONTROL [server-test]: 'PUSH_REQUEST' (status=
=3D1)
Fri Oct 29 14:00:02 2010 PUSH: Received control message: 'PUSH_REPLY,ifconf=
ig-ipv6 2001:608:4:a052::1:0 2001:608:4:a052::1,route 10.100.0.0 255.255.0.=
0,route-ipv6 2001:608:4:a000::/56,tun-ipv6,route-gateway 10.100.52.1,topolo=
gy subnet,ping 10,ping-restart 30,ifconfig 10.100.52.2 255.255.255.0'
Fri Oct 29 14:00:02 2010 ROUTE: default_gateway=3DUNDEF
Fri Oct 29 14:00:02 2010 TUN/TAP device tun0 opened
Fri Oct 29 14:00:02 2010 /usr/sbin/ifconfig tun0 10.100.52.2 netmask 255.25=
5.255.0 broadcast + up
Fri Oct 29 14:00:02 2010 Solaris ifconfig phase-2 failed: external program =
exited with error status: 1
Fri Oct 29 14:00:02 2010 /usr/sbin/ifconfig tun0 unplumb
Fri Oct 29 14:00:02 2010 Can't unlink interface(ip): Invalid argument (errn=
o=3D22)
Fri Oct 29 14:00:02 2010 Solaris ifconfig failed
Fri Oct 29 14:00:02 2010 Exiting

and to trigger it, you basically just add "topology subnet" to your=20
existing server config.  The benefit of "topology subnet" is that you=20
do not need a dedicated /30 per client anymore, but that even windows
clients can share a large subnet, with a single address used per client.

regards,

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Nd5ezxtHU51lQLUj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTMq9UqkuBuNlUUl1AQKmzwQAsl1XVicdpFgXaOXPJ667JL31NUUsAeg4
lEnpVee/c0UQljVNLr/HRn27LeJDNMtpwe/bos4HjHfz170rc8i1/HOdZSIOB0MW
WGcP0pc/RuJ4CafY280AjTYgjS1DFujcHIFxHwRrJE1aQFbr476W+xnAsPvs8iGZ
vY0mtslU4xk=
=YCwd
-----END PGP SIGNATURE-----

--Nd5ezxtHU51lQLUj--

