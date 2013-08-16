Date: Fri, 16 Aug 2013 18:59:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130816165911.GS16543@...1296...>
References: <alpine.DEB.2.02.1306201400320.10116@...1831...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B8Vg9Vt30SMsjSDh"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1306201400320.10116@...1831...>
Subject: Re: [Openvpn-devel] [PATCH] Always load intermediate certificates
	from a PKCS#12 file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heikki Hannikainen <hessu@...1822...>
Cc: openvpn-devel@lists.sourceforge.net

--B8Vg9Vt30SMsjSDh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 20, 2013 at 02:06:25PM +0300, Heikki Hannikainen wrote:
> >From cec65ff199443c7f95101a7bf4a75644516d7810 Mon Sep 17 00:00:00 2001
> From: Heikki Hannikainen <hessu@...1822...>
> Date: Thu, 20 Jun 2013 13:49:44 +0300
> Subject: [PATCH] Load intermediate certificates from a PKCS#12 file and p=
lace
>   them in the extra certs chain, when trusted CA certs are
>   loaded from an external PEM file with the --ca option, and
>   the CA certs in PKCS#12 are not to be trusted.
[..]

Based on the discussion at the meeting and the ACKs given there, patch
has been applied to the master and release/2.3 branches.

commit 6481f879eb62cafa6ad652801b2b5c45e546ef44 (master)
commit 09a002b7eba6c192393de7a60b5753173d4f400d (release/2.3)

gert


commit 6481f879eb62cafa6ad652801b2b5c45e546ef44
Author: Heikki Hannikainen <hessu@...1822...>
Date:   Thu Jun 20 14:06:25 2013 +0300

    Always load intermediate certificates from a PKCS#12 file
=20=20=20=20
    Load intermediate certificates from a PKCS#12 file and place them in the
    extra certs chain, when trusted CA certs are loaded from an external PEM
    file with the --ca option, and the CA certs in PKCS#12 are not to be tr=
usted.
=20=20=20=20
    Required when client PKCS#12 file is provided by a different CA
    than the server CA, the PKCS#12 file contains intermediate certificates
    required for client auth, but the server CA is not in the PKCS#12 file.
=20=20=20=20
    When --ca is set, the PKCS#12 provided CA certs are not trusted. Without
    this patch, they were ignored completely - with this patch, they're loa=
ded
    in the extra certs chain which makes them available for chain verificat=
ion
    but still does not make them trusted if --ca is set. Unless when, of
    course, a trusted root is found from the --ca file.
=20=20=20=20
    Acked-by: James Yonan <james@...515...>
    Acked-by: Arne Schwabe <arne@...1227...>
    Acked-by: Steffan Karger <steffan.karger@...1435...>
    Message-Id: <alpine.DEB.2.02.1306201400320.10116@...1831...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7721
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--B8Vg9Vt30SMsjSDh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUg5aX6kuBuNlUUl1AQIDGAP9HCzDKI2u2b068hgtgXRm56N4+i11SCAo
rB90citnkAbgJC0kLUfFMGky0YqXT5SkWKCD1ReVjGtgSlhTkhfMPyQ4y2J9mblO
gSlyfSiFusbKcj1RLXrwwPDjbTCGRQBepuYH/AvAhUFrLVRScQyYGZpsa+z0i+n+
EUqr2Y312fA=
=dcVR
-----END PGP SIGNATURE-----

--B8Vg9Vt30SMsjSDh--

