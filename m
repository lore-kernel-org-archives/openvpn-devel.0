Message-ID: <1591973347.7235.3.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Fri, 12 Jun 2020 07:49:07 -0700
In-Reply-To: <20200612062333.GM1431@...1296...>
References: <1590709611.3515.22.camel@...2316...>
 <20200612062333.GM1431@...1296...>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-J6ehxjdB/ZEjob73Bce1"
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [BUG] test_ncp.c failing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--=-J6ehxjdB/ZEjob73Bce1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-06-12 at 08:23 +0200, Gert Doering wrote:
> Hi,
>=20
> On Thu, May 28, 2020 at 04:46:51PM -0700, James Bottomley wrote:
> > diff --git a/tests/unit_tests/openvpn/test_ncp.c
> > b/tests/unit_tests/openvpn/test_ncp.c
> > index 19432410..f58fa2ea 100644
> > --- a/tests/unit_tests/openvpn/test_ncp.c
> > +++ b/tests/unit_tests/openvpn/test_ncp.c
> > @@ -48,7 +48,7 @@ static void
> >  test_check_ncp_ciphers_list(void **state)
> >  {
> >      struct gc_arena gc =3D gc_new();
> > -    bool have_chacha =3D cipher_kt_get("CHACHA20-POLY1305");
> > +    bool have_chacha =3D
> > cipher_kt_get(translate_cipher_name_from_openvpn("CHACHA20-
> > POLY1305"));
>=20
> Am I right in assuming that this patch is no longer needed with the
> two cipher_kt_ translation patches I merged yesterday?

Yes, make check now passes on openSUSE_Leap_15.1

James

--=-J6ehxjdB/ZEjob73Bce1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCXuOV4wAKCRDnQslM7pis
hfrgAQCBmuQKLDBM7egQFhhDbaR9N5wYjD2JDfWfcXhGgOj2jAEA4PjGlSC4loNy
Y5teTVfMZXbaw5meHejVZtv/lJO0DuA=
=vbEi
-----END PGP SIGNATURE-----

--=-J6ehxjdB/ZEjob73Bce1--


