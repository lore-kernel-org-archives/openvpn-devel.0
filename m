Date: Mon, 6 Aug 2012 22:26:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120806202605.GI2535@...1296...>
References: <1343837470-3923-1-git-send-email-arne@...1227...>
	<1343837470-3923-3-git-send-email-arne@...1227...>
	<20120806173938.GD2535@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YIwHDYD8sUXtBKvt"
Content-Disposition: inline
In-Reply-To: <20120806173938.GD2535@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] Merge getaddr_multi and getaddr6
	into one function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--YIwHDYD8sUXtBKvt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 06, 2012 at 07:39:38PM +0200, Gert Doering wrote:
> Mon Aug  6 19:49:06 2012 Attempting to establish TCP connection with [AF_=
INET6]2607:fc50:1001:5200:::51194 [nonblock]
>=20
> This is buggy already, because "conn-test-server" is "2607:fc50:1001:5200=
::4",
> and the ":4" got lost...

Looking more closely, the last 64 bits seem to be zeroed - connecting to
something that has lots of f's...

src/openvpn/openvpn --comp-lzo --verb 3 --dev tun --proto tcp6-client \
	--remote 2001:608:5:ffff:ffff:ffff:ffff:ffff --port 51194
...
23:27:32.948690 IP6 2001:608:0:814::f000:3.54055 > 2001:608:5:ffff::.51194:=
 S 2476353562:2476353562(0) win 65535 <mss 1440,nop,wscale 3,sackOK,timesta=
mp 1697332759 0>

And it's not related to DNS itself, just to getaddrinfo() (so you don't
need to muck with DNS or setup a tcp6 test server to see this)

If family permits, I'll try to dig into this more tomorrow, it certainly
raised my curiousity :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--YIwHDYD8sUXtBKvt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUCAoXakuBuNlUUl1AQIAZwP/ez8ibEuV5snHIsfyd/dsFH6XI69lbMEq
XtvZsl+7f6SeZoqLBUL1OCbHB5ztSTn4MlYOU14OFXIiwa75DPhjJycoPbkdhxTt
cdgTSchQxVdPK0R3ld7Fbl77SueP+CckhWBzi1jBBQOmLJQ4lKeBg0EqGia8qp5x
UpDQIrXfY9w=
=ZQmF
-----END PGP SIGNATURE-----

--YIwHDYD8sUXtBKvt--

