Date: Thu, 20 Jul 2017 08:11:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170720061143.GI70062@...1296...>
References: <20170719213923.18843-1-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Content-Disposition: inline
In-Reply-To: <20170719213923.18843-1-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Move strerror_ts() to error.h/c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 19, 2017 at 11:39:23PM +0200, Steffan Karger wrote:
> Move strerror_ts() to error.c, which is a more suitable location than the
> random collection of unrelated stuff called misc.c.  While doing so,
> simplify the implementation.
>=20
> (I think we should find a better place for everything currently in misc.c,
> and get rid of it all together.  This patch is part of that effort.)

While I do like the patch, parts of it do not make sense :-)

> +#ifdef HAVE_STRERROR
> +const char *
> +strerror_ts(int errnum, struct gc_arena *gc)
> +{
> +    return string_alloc(openvpn_strerror(errnum, gc), gc);
> +}
> +#endif
> +

... so where's the "#else" here?

OTOH, the old code was a bit weird - #ifndef HAVE_STRERROR, the function
itself would return a static string, but the *prototype* would disappear
from the header file.

I think we can safely assume that strerror() is available on all the
platforms (so, kick out the test from configure.ac as well :) ) - but it=20
might be worthwile to have a look at strerror_r() or strerror_s(), if we=20
really are concerned about eventual threading OpenVPN and making this=20
properly reentrant.


As a side note, why anyone would implement strerror() in a non-thread-
safe way ("it's only returning a pointer to a static string table, isn't
it?") - reading through=20

  https://stackoverflow.com/questions/900338/why-cant-i-use-strerror

has the answer: NLS, and "string tables dynamically loaded at run-time",
so the string isn't actually static inside strerror().

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZcEmfAAoJEB2Cnv7KVigSYJwMAIH1blY2rZCk14EXNjA9roP2
YkuvDTDA8gjHoVBSx94KF3BmsXj1GSA6QGGBchA4eWSysh+KphgSkC8SEMkZg3kN
253RLvCwp9hB78uGeg0Of1Gba4U0CRboJ9RX2zfeN0wmgKpL4Df8mr4qdU0hSEyg
yEvloO7qjUnkwHBGqEf9FVzUo6s363s8CCvQDvhvPM19yBDlGMZUQa5I8U3ad3Ig
IHejmJFIPv1F6yLPKhtr1tuBdaA+eljwuEK8N8CG8Ac310kWEORc+pKpTGNP9kN5
/+pXVW1BF9oERcEG6XA6lYghY/3VPUGS0qlKPrUsuwM8QLVOT8Edtvqn/TSxatfm
7K8EE+HJmCiV1DVguPniCXtiIaBpQhcGcpWshWmAEkf0tV84vkHqc6j7pcyPBMrs
LIn8FJFwfx+eljTPw7EzcvZRdQ1iji3nAjcyXTgtaf+IOKLP7vWr60S6m5pJq6nN
XCNr/EzPh+Jv26wfqFKYMz+rebQcWheUZgfIbqpxyA==
=SoA+
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--

