Date: Tue, 31 Mar 2015 16:23:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150331142352.GI21893@...1296...>
References: <5519B242.2020009@...1856...>
	<20150330210636.GF21893@...1296...>
	<551AA3A2.5000300@...1800...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1X1uH+Y+uHyMJls4"
Content-Disposition: inline
In-Reply-To: <551AA3A2.5000300@...1800...>
Subject: Re: [Openvpn-devel] [Openvpn-users] FreeBSD+cryptodev testers wanted
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mike Tancsa <mike@...1800...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

--1X1uH+Y+uHyMJls4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 31, 2015 at 09:39:46AM -0400, Mike Tancsa wrote:
> I am not able to reproduce this.=20

You need to use --daemon to make openvpn fork().  Otherwise, it will
"just work", but after forking, the cryptodev file descriptor is no
longer valid -> boom.  Steffan's patch should fix that.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1X1uH+Y+uHyMJls4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVRqt+KkuBuNlUUl1AQINoAP9FnOm8I7xhg/AaTx+0CoUrJ4qUiOPV8Kj
F0MEywRm2R69w1/ctv+KpMXoRYpFeyapLVqK+fe1EzOWtg07VCNPw5Yt5TQHGR4h
ZuAGoM5dierOz2F0xqDwdjxcLZoDk6ijNWUg5cg2ko7mxfx+pR7hvuoIYtiOtcc0
Id00GwyyDIo=
=ADns
-----END PGP SIGNATURE-----

--1X1uH+Y+uHyMJls4--

