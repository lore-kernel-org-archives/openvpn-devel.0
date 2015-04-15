Date: Wed, 15 Apr 2015 14:07:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150415120704.GI382@...1296...>
References: <1429036445-17223-1-git-send-email-yegorslists@...1030...>
	<552E1111.6010201@...68...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline
In-Reply-To: <552E1111.6010201@...68...>
Subject: Re: [Openvpn-devel] [PATCH] m4: enable silent build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--dkEUBIird37B8yKS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 15, 2015 at 09:19:45AM +0200, Matthias Andree wrote:
> - it changes policy through the [yes] argument to AM_SILENT_RULES().
> This flips the switch for the default without good reason, and that
> makes debugging harder - this is a policy decision, not mechanism.

Indeed, this we don't want.=20=20

Having "V=3D0" or "--enable-silent-rules" is fine for me, but changing
the defaults to hide even more detail is not (annoying enough that
recent autoconfs hide the detailed results from "make test")

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVS5UaKkuBuNlUUl1AQIEJwQAmr7daRt2081uREYxRU2sSwN7Iu6ccgoM
oyTT+RoOdbJJpT3HgEF5eU1W1vTm7Y2tbC5F4H6ZlHKoJPxMfzmr0h5ITFw+cZV3
MOyZsUid4HHehAuepZ9NofRvfymtxyi3KeD2/0DPTLGGkBqueygnURqM91pNhchX
U3P5FpGiZaE=
=xGFy
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--

