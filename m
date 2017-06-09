Date: Fri, 9 Jun 2017 22:20:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170609202038.GE97029@...1296...>
References: <CAO5O-EL11jDxO+c1Gu0FvunqwUTW2uxjy910+A-s63Nr5O3NWw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eKyXGFlFQFfUV5cK"
Content-Disposition: inline
In-Reply-To: <CAO5O-EL11jDxO+c1Gu0FvunqwUTW2uxjy910+A-s63Nr5O3NWw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix 2 memory leaks in proxy
 authentication routine
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Guido Vranken <guidovranken@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--eKyXGFlFQFfUV5cK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, Jun 08, 2017 at 04:36:54PM +0200, Guido Vranken wrote:
> Signed-off-by: Guido Vranken <guidovranken@...277...>
> ---
>  src/openvpn/proxy.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
> index b0ed327..8ff09ba 100644
> --- a/src/openvpn/proxy.c
> +++ b/src/openvpn/proxy.c
> @@ -318,6 +318,7 @@ get_proxy_authenticate(socket_descriptor_t sd,
>      {
>          if (!recv_line(sd, buf, sizeof(buf), timeout, true, NULL,
> signal_received))
>          {
> +            free(*data);
>              *data =3D NULL;
>              return HTTP_AUTH_NONE;
>          }
> @@ -991,6 +992,7 @@ establish_http_proxy_passthru(struct http_proxy_info =
*p,
>                  if (p->options.auth_retry =3D=3D PAR_NCT && method =3D=3D
> HTTP_AUTH_BASIC)
>                  {
>                      msg(D_PROXY, "HTTP proxy: support for basic auth
> and other cleartext proxy auth methods is disabled");
> +                    free(pa);
>                      goto error;
>                  }
>                  p->auth_method =3D method;


Boy, this is complicated code...

I *think* your patch is correct, so will merge it later.

It took me about an hour to really understand what is going on - the=20
code in get_proxy_authenticate() is extremely ugly, because it calls=20
string_alloc() with a "gc" parameter, which normally implies "put
this in the gc_arena, and do not(!) free() manually".=20=20

Interestingly enough, the single caller always puts NULL here, signalling=20
"no, use normal calloc() instead!", so you *do* have to use free() - and=20
you cannot just change it to use the existing gc_arena instead, as the
code will just store the result in p->proxy_authenticate, returns(!),
to be called again and use the data in the next connection attempt,
with authentication...


As a first step in refactoring, the "gc" parameter to get_proxy_authenticat=
()
needs to be thrown out, and string_alloc() needs to be called with "NULL"
there, so it's immediately clear "real malloc() is used" - but that's
"master only", while your patch applies to all active branches... (and
I need test infrastructure with the different proxy auth variants)

*phew*

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--eKyXGFlFQFfUV5cK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZOwMWAAoJEB2Cnv7KVigSKucL/A4CQu+uSWV1/6mpfUlRUIQG
AbE9+F//boH1eF3ME4xeTXU0SMaQ9OIcAo3+TFN3/MxmNEz/rSYp2szR4ShPaGkW
/FlPHZMomVZoVrNfRZdFhBJjsR8fAa9UAy78+GMCXnzU4RHifgY3do7i19zZErSd
SzcRhS+h2r2iCSj6kCw8OM98WOx88wIZm7W8R077MBlcxKobfXjLH8o/k+hAUajr
7DufvoYepz4LLwz0d2sFK1OKiQB2uJKzBrpDBCchI0MPyAhMw3GDzEEH3UTslHtI
4eu+zHOJDXIiaorgyGxz8pph6XTIJWPCjxEPVPBdTyffxbW2320NAzXlEfL+Jwe3
Mwl7XJC3+wr33tnGpi+0/fF4E80Y6/z0ygad6exl4cqlbHFSM+Fe04h1xPfeH+Dk
VpTVrxdszxJffENQZqoSAri1fz/aSV+zrJ680Qpzh1Gi11cQ2L6WJMGPIBCJdTMi
673+rjv6FgCLSZn58d88J/NE21IkMG7bOK+KbC+k0A==
=EAKv
-----END PGP SIGNATURE-----

--eKyXGFlFQFfUV5cK--

