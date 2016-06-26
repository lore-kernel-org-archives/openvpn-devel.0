Date: Sun, 26 Jun 2016 11:33:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160626093352.GA74152@...1296...>
References: <1385728360-32127-1-git-send-email-arne@...1227...>
	<201311292000.rATK06t1017910@...1729...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <201311292000.rATK06t1017910@...1729...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Move ASSERT so external-key
 with OpenSSL works again
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

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 29, 2013 at 09:00:06PM +0100, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> commit 68793f40e1d04409264d21dd24453d959828a306
> Author: Arne Schwabe
> Date:   Fri Nov 29 13:32:40 2013 +0100
>=20
>      Move ASSERT so external-key with OpenSSL works again
>=20
>      Acked-by: Steffan Karger <steffan.karger@...1435...>
>      Message-Id: <1385728360-32127-1-git-send-email-arne@...1227...>
>      URL: http://article.gmane.org/gmane.network.openvpn.devel/8069
>      Signed-off-by: Gert Doering <gert@...1296...>

And as discussed today, and in trac#693, also applied to release/2.3
(bugfix)

commit 5f3d28b374d4058a08753d06c675cbc589675e24
Author: Arne Schwabe <arne@...1227...>
Date:   Fri Nov 29 13:32:40 2013 +0100

    Move ASSERT so external-key with OpenSSL works again
=20=20=20=20
    Acked-by: Steffan Karger <steffan.karger@...1435...>
    Message-Id: <1385728360-32127-1-git-send-email-arne@...1227...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/8069
=20=20=20=20
    trac #693
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>
    (cherry picked from commit 68793f40e1d04409264d21dd24453d959828a306)


(got an Ack from Steffan in the ticket)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV2gr6akuBuNlUUl1AQKvHwP/dIMLJ0VVLanrYbPXr+jBQ8HqYnOxys8a
VjBdwXpWRc4PoBXHJJfUk80xg6sdux6jfbpwieRwWmxjaUadrfq2nugSNzVelc0a
EUzI/TspZ+3PMe3pVixFFpxDzttGm2bZOdyUM5JD6+DxfZsWIaWyduE2R0CU/Icv
hL0ksARLREE=
=bxI+
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--

