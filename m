Date: Mon, 21 Apr 2014 12:42:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140421104211.GT16637@...1296...>
References: <1398064204-26476-1-git-send-email-james@...515...>
	<1398064204-26476-4-git-send-email-james@...515...>
	<5354F1DE.8050604@...1856...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HxsxUUve8i+TuXFZ"
Content-Disposition: inline
In-Reply-To: <5354F1DE.8050604@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] When tls-version-min is unspecified,
	revert to original versioning approach.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--HxsxUUve8i+TuXFZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 21, 2014 at 12:24:30PM +0200, Steffan Karger wrote:
> On 21-04-14 09:10, James Yonan wrote:
> > For OpenSSL, this means to use TLSv1_(client|server)_method rather
> > than SSLv23_(client|server)_method combined with SSL_OP_NO_x flags
> > for specific TLS versions to disable.
>=20
> I'm not sure I understand the rationale behind this. If I don't specify
> a minimum version, my maximum version changes to TLS 1.0? Could you
> maybe explain the "why" for this patch?

"turn it off!", without introducing yet another config directive (or,
more precisely, "do not turn it on by default" if I read the patch right).

There seem to be some not-yet-fully-understood combinations of OpenSSL
library versions/library builds that will break 2.3.3 clients <-> git-master
servers if the TLS version negotiation patch is active, so having a way
to turn it off at run-time (if only to see if that is the problem) is
certainly useful.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--HxsxUUve8i+TuXFZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU1T2AqkuBuNlUUl1AQIc0AQAmsdRm/rhoN356lWd7xxBAatiwNCgSKPV
aYxCF4Oh1jGMuS/5XSh2xgm/8b+hZthCRgZlhWaG1s6LNc2THuLaBP5/RxksYg0v
KyRxWmC6jkm/tVdF95UyrMCru67t5t1ouO0hhpE+ZKWnawRwEc7uPVBuhbvPw/+r
jo9ys/298wc=
=3v0b
-----END PGP SIGNATURE-----

--HxsxUUve8i+TuXFZ--

