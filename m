Date: Fri, 4 Mar 2016 07:57:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160304065713.GJ24952@...1296...>
References: <1456993146-63968-1-git-send-email-james@...515...>
	<1456993146-63968-3-git-send-email-james@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UnethLbBSDNDuU+2"
Content-Disposition: inline
In-Reply-To: <1456993146-63968-3-git-send-email-james@...515...>
Subject: Re: [Openvpn-devel] [PATCH 03/10] tls_serial_{n} value should be
 distinguishable as hex or decimal.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <james@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--UnethLbBSDNDuU+2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 03, 2016 at 01:18:59AM -0700, James Yonan wrote:
> To accomplish this, prepend 'x' before hex serial numbers, so they
> can be distinguished from decimal serial numbers.  For example:
>=20
>   tls_serial_1 =3D "x4D:9B:7C:94"
>=20
> is equivalent to:
>=20
>   tls_serial_1 =3D "1302035604"
>=20
> Currently, only PolarSSL generates hex serial numbers while
> OpenSSL returns decimal serial numbers.

we have this one in the community tree today:

commit f80a52b09eed8e5e0cad990c56ec99256d6cc2d0 (master)
commit 142d4dd2e98317a03ca9827f03fc4643fe922834 (release/2.3)

Author: Steffan Karger <steffan@...1856...>
Date:   Sun Apr 27 10:49:20 2014 +0200

    Make serial env exporting consistent amongst OpenSSL and PolarSSL build=
s.
=20=20=20=20
    This changes the representation of the tls_serial_{n} environment varia=
ble
    from hex to decimal for PolarSSL builds, to match OpenSSL build behavio=
ur.
=20=20=20=20
    Because hex representation for serials makes sense too, and to ease
    transition for PolarSSL users, added tls_serial_hex_{n} that exports the
    serial in hex represenation for both crypto library backends.


so I think the intention of your patch has been achieved already.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--UnethLbBSDNDuU+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVtkxyakuBuNlUUl1AQJGkwQAsJbKsWkSpI1z0JJjAgpZ4vWSoTjipnWy
+SlBrDH2ralkynV9ljmjS8byvcbYdxIFJDcJG7neQbnHlwPjNDyoGPiQb6PKkUx4
X97S7XP6w2vCKJ0i0Ia9rbN0nQZP25TKlxm7YBbZHbVmMmn0B0SM42kuvpmM99tw
qfzDiaJMac8=
=uRAk
-----END PGP SIGNATURE-----

--UnethLbBSDNDuU+2--

