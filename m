Date: Sun, 18 Oct 2015 14:36:07 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151018123607.GC22054@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JeySm3848e6KficE"
Content-Disposition: inline
In-Reply-To: <20151018103446.5fed9f97.movrax-dev@...2061...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix privilege drop if first
 connection attempt fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lukasz Kutyla <movrax-dev@...2061...>
Cc: openvpn-devel@lists.sourceforge.net

--JeySm3848e6KficE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

wooops...  "this is what I meant with 'please use git send-email'..." -=20
I had to hand-massage the mail a bit, and then it picked up the message
ID twice...

gert


On Sun, Oct 18, 2015 at 02:30:50PM +0200, Gert Doering wrote:
> 20151018103446.5fed9f97.movrax-dev@...2061...>
> References: <20151018103446.5fed9f97.movrax-dev@...2061...
> 20151018103446.5fed9f97.movrax-dev@...2061...>
>=20
> Thanks.
>=20
> Your patch has been applied to the master and release/2.3 branch.
>=20
> commit 825b3272acb353e04b37f38299d4df7e63e87d9e (master)
> commit 6c6280ae1672ba10aa009ba8d3bf923f68272de4 (release/2.3)
>=20
> Author: Lukasz Kutyla
> Date:   Sat Oct 17 21:15:15 2015 +0200
>=20
>      Fix privilege drop if first connection attempt fails
>=20
>      Signed-off-by: Lukasz Kutyla <movrax-dev@...2061...>
>      Acked-by: Steffan Karger <steffan.karger@...1435...>
>      Message-Id: <20151018103446.5fed9f97.movrax-dev@...2061...>
>      URL: http://article.gmane.org/gmane.network.openvpn.devel/10301
>      Acked-by: Steffan Karger <steffan.karger@...1435...>
>      Message-Id: <20151018103446.5fed9f97.movrax-dev@...2061...
>      URL: http://article.gmane.org/gmane.network.openvpn.devel/10301
>      Signed-off-by: Gert Doering <gert@...1296...>
>=20
>=20
> --
> kind regards,
>=20
> Gert Doering
>=20
>=20
> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--JeySm3848e6KficE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBViOSNqkuBuNlUUl1AQLt4AQAgrKrjODM+hLo6ACsRSstXroEehL4Wj67
XB8RtkYlitCqoTampU/MkLtYwOSL96NE01fD0slzRt7LxcvM1KxNf6BeIrzlbaYk
TrUVng03V0K/StXRooZsXkOtJ1y4k1mg+jxbpeTvqHXwcbmftdYBEI9eOpe4qxKo
ZDbmm14qZdY=
=7RLT
-----END PGP SIGNATURE-----

--JeySm3848e6KficE--

