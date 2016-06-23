Date: Thu, 23 Jun 2016 13:32:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160623113226.GD79504@...1296...>
References: <CAFHpkQHX-m9-Ub0WxgpyDx5uWcjyFf=aRN-cUTYt=fJ7dEXc0w@...278...>
	<CAA1AbxK5OUWtYhszHVpD7nXFu1Yh-PQgraZNDE0XtLcs_2_5dA@...278...>
	<CAFHpkQGFnPgNGXnasM5Tcwbx1yMdYuRes3+cvpNnb=Gq+=obpQ@...278...>
	<CAA1AbxJfdDMHV9PF1Qzpa1FhNBvwKfW-tnnM3w2AO0qh6x9moA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l8yJEXo8J9fv7OFY"
Content-Disposition: inline
In-Reply-To: <CAA1AbxJfdDMHV9PF1Qzpa1FhNBvwKfW-tnnM3w2AO0qh6x9moA@...278...>
Subject: Re: [Openvpn-devel] what is the best way of skipping tests when
 openvpn configured --disable-crypto ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--l8yJEXo8J9fv7OFY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 22, 2016 at 10:41:48PM +0200, Steffan Karger wrote:
> > -test_scripts =3D t_client.sh t_lpback.sh t_cltsrv.sh
> > +test_scripts =3D t_client.sh
> > +if ENABLE_CRYPTO
> > +test_scripts +=3D t_lpback.sh t_cltsrv.sh
> > +endif
> >
> >  TESTS_ENVIRONMENT =3D top_srcdir=3D"$(top_srcdir)"
> >  TESTS =3D $(test_scripts)
>=20
> Ah, this is even cleaner than AC_SUBST.  But this matches what I had
> in mind, yes.  (I didn't test, but I assume this simply doesn't run
> these tests?)

make will not even know that these tests exist, so "doesn't run these=20
tests", yes :-)

I *am* wondering if there is a clever way to print out "not running self
tests due to lack of --disable-crypto", so people are made aware that
this is less well tested...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--l8yJEXo8J9fv7OFY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV2vIyqkuBuNlUUl1AQKn7gP/SYy2C/yl5yZojweOY3iUS0Be+xTY23Lv
wgdFA4WQPyyycGQtndCms/N86NKrzt8JqN/37LsMk/hHtu4njWeXSGQtEXbx0h89
mcq1tdo67pWbSfhijeTR31U8w8PJ8wNevQ2Zl1uWbmwoNxDn8lmr3FvbGmt+Rbtv
CMxfyKJJXrg=
=hNsy
-----END PGP SIGNATURE-----

--l8yJEXo8J9fv7OFY--

