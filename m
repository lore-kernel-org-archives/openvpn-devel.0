Date: Fri, 24 Jul 2015 10:54:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150724085453.GI382@...1296...>
References: <COL128-W360F356FA6F45FADFFC4D6CA810@...512...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXHbrKsR1QeUrqNY"
Content-Disposition: inline
In-Reply-To: <COL128-W360F356FA6F45FADFFC4D6CA810@...512...>
Subject: Re: [Openvpn-devel] Does Openvpn really support cryptodev hardware
	accelerators
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: li yuqian <liyuqian08@...2047...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--OXHbrKsR1QeUrqNY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

if openssl uses cryptodev, so will openvpn - we don't do our own crypto,
just call the openvpn functions to do so.

(And on FreeBSD, this is the particular reason why we had so much trouble
recently, as our way to do --daemon wasn't compatible with cryptodev...)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--OXHbrKsR1QeUrqNY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVbH9XakuBuNlUUl1AQJcDQQAntlp+5BpDV8axH6h8dYLyQo9h9HvAVdP
amK8XDqXF/RF/WRpAb/H+yli7vHiZw6piiazPEZShhVbfOBI+/b+1Z+9vXKhUe5f
1fq8jjI5Caauepk+mLcd6mGGVxftc3d006KtPo9KjQ7z67r7/8F5rFiqQKeBasFh
56elLXzKPYA=
=ODdf
-----END PGP SIGNATURE-----

--OXHbrKsR1QeUrqNY--

