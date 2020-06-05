Message-ID: <1591374528.4728.53.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Fri, 05 Jun 2020 09:28:48 -0700
In-Reply-To: <31d467d4-59da-08b2-166b-13f62a59b82f@...1227...>
References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-4-James.Bottomley@...2316...>
 <31d467d4-59da-08b2-166b-13f62a59b82f@...1227...>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-0KDXUHY0ibb18EGd5Bs6"
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v6 3/3] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--=-0KDXUHY0ibb18EGd5Bs6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-06-05 at 13:31 +0200, Arne Schwabe wrote:
[...]
> Somehow this turns into a autoconf/automake nightmare:

Heh, got to say autoconf is a bit of a nightmare for its more esoteric
features because the docs usually don't cover them and you end up
having to take the opinion of the internet, which is somewhat, er,
diverse.

> [testengine_section]
> dynamic_path	=3D $ENV::srcdir/.libs/libtestengine`test .odule =3D
> .yes SHREXTSHREXT echo .so || echo .dylib`
>=20
> is what I end up in the openssl.cnf
>=20
> The generated Makefile already has:
>=20
> $(builddir)/%.cnf: $(srcdir)/%.cnf.in
>  	sed 's/SHREXT/`test .$module =3D .yes && echo .so || echo
> .dylib`/' < $<
> > $@

Hm, so SHREXT is dynamic on MAC platforms.  If I replace the single
quote with double, that should allow the shell expansion.

> Maybe instead of using that use magic useing two different section
> like testengineso and testenginedylib and then makeing the engine
> name in the script dynamic?

I'll investigate, but openssl has a fairly tight binding between the
name of the dynamic object and the name of the engine.  It's very
difficult (but not I perhaps impossible) to have an engine name
different from the DSO name.

> Also for some reason the makefile still builds it now as .so instead
> of .dylib

That's likely a libtool flag issue.  If you update this in Makefile.am:

libtestengine_la_LDFLAGS =3D -rpath /lib -avoid-version -module -shared -ex=
port-dynamic

does it build a .dylib?

>  and if I manually put the  full path in the openssl.cnf the
> test works:
>=20
> dynamic_path	=3D
> /Users/arne/oss/openvpn-ossl/tests/unit_tests/engine-
> key/.libs/libtestengine.so
>=20
> Any idea? I can also help to get this mess resolve but maybe you have
> a quick idea what is wrong.

My money would be on the idea that environment specifiers in openssl
conf files are only supported on UNIX.  I'll get it to do a full path
substitution on build to fix this.

James

--=-0KDXUHY0ibb18EGd5Bs6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCXtpywAAKCRDnQslM7pis
hcfEAP9KiGOGd5U6inN3F9ybwa0vL0pUj32vy7GarnyWZq5gkAEAvME0LPaWLSxM
znoawN5Q0NVjqTZD8d9Ix2DTCt7MDHw=
=gLHW
-----END PGP SIGNATURE-----

--=-0KDXUHY0ibb18EGd5Bs6--


