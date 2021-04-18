Date: Sun, 18 Apr 2021 11:11:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210418091148.GW976@...1296...>
References: <20201215164221.5995-1-arne@...1227...>
 <20210328120241.27605-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hzv8ABo2Qk/lNh3C"
Content-Disposition: inline
In-Reply-To: <20210328120241.27605-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Move context_auth from context_2
 to tls_multi and name it multi_state
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--hzv8ABo2Qk/lNh3C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I would have merged this now, but it breaks ENABLE_ASYNC_PUSH... and
while at it, I have more questions.

On Sun, Mar 28, 2021 at 02:02:40PM +0200, Arne Schwabe wrote:
[..]
> Patch V2: also rename context_auth to multi_state, explain a bit why this
>           change is done.
[..]
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 6f7a50048..e3890f395 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -544,7 +544,7 @@ encrypt_sign(struct context *c, bool comp_frag)
>       * Drop non-TLS outgoing packet if client-connect script/plugin
>       * has not yet succeeded.
>       */
> -    if (c->c2.context_auth !=3D CAS_SUCCEEDED)
> +    if (c->c2.tls_multi && c->c2.tls_multi->multi_state !=3D CAS_SUCCEED=
ED)
>      {
>          c->c2.buf.len =3D 0;
>      }

This code assumes that c2.tls_multi can be NULL, otherwise the check is
not needed.  OTOH, *if* it is NULL, I think we should actually drop the
packet, because then it's certainly not CAS_SUCCEEDED.  So maybe make
this:

> +    if (!c->c2.tls_multi || c->c2.tls_multi->multi_state !=3D CAS_SUCCEE=
DED)

(two instances in forward.c)


>  #if defined(ENABLE_ASYNC_PUSH)
> -            if (is_cas_pending(mi->context.c2.context_auth)
> +            if (is_cas_pending(mi->context.c2.authenticated)
>                  && mi->client_connect_defer_state.deferred_ret_file)
>              {
>                  add_inotify_file_watch(m, mi, m->top.c2.inotify_fd,

This was overlooked, and the second line should be

> +            if (is_cas_pending(mi->context.c2.tls_multi->multi_state)

I think.  But this is a code change, so I'm not doing this on my own.

With this change, the code compiles and passes my server side torture
chamber...

Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2g 2d 2e 2f 2z1 2z2 3 4 4a=
 4b 5 5a 5b 5c 5d 5v1 5v2 5v3 5w1 5w2 5w3 5w4 5x1 5x2 5x3 5x4 6 7 7x 7y 8 8=
a 9 9a.
Test sets failed: 1x 2w 2x 2y.

(The failed tests are all "MTU <-> NCP non-AEAD" related, so "as expected")


> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 18d7c1e00..b43ffa364 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -854,14 +854,14 @@ process_incoming_push_request(struct context *c)
>  {
>      int ret =3D PUSH_MSG_ERROR;
>=20=20
> -    if ((c->c2.tls_multi && tls_authentication_status(c->c2.tls_multi, 0=
) =3D=3D TLS_AUTHENTICATION_FAILED)
> -        || c->c2.context_auth =3D=3D CAS_FAILED)
> +    if (tls_authentication_status(c->c2.tls_multi, 0) =3D=3D TLS_AUTHENT=
ICATION_FAILED
> +        || c->c2.tls_multi->multi_state =3D=3D CAS_FAILED)

I wonder if the removal of the "if ((c->c2.tls_multi &&" part here is
safe.  Is this guaranteed to be non-null even for the p2p-tls case?

I have added a case to the test rig for a "mode tls-server" server,
and client instances that run with "--client" or "--tls-client" - so,
asking for a PUSH or not.  These did not cause a server crash, so it
seems "it is not NULL".  But it would be nice to be sure, though :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--hzv8ABo2Qk/lNh3C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJge/fTAAoJEB2Cnv7KVigSDbsMAJNYN/eNVHOdQEyDwh5K+CUc
NWVt95HA793s96uTgvaE2YzqyPA1KoHm/8nUlpFtyUMOAkOTdDNy7Op11sANRsei
hmh4wJUTsXgKlBtS+Xrpj5aI9zhT5fu+J6xDfGMYxhZ1vB8g06YyKPr/1l0HONsB
ipDS17rkRc3bSSAB2NbA8uPRbWwCAzbi8sfZffcc48wIh8H+as9RYXN5MRM4+QZi
CanHOJLP1x7XQx79S6BqIoFuhZjES4iYREZOKEgkNqFUin5nT2yUZbIbs9rBUPsG
UVr8X6cLoRCrRSCq8WnDJDE8tXiCoH7kMXTXQiDrLCShC5fG0PwGCyDKE51goo1Z
/zEB+ykmX9sfPnmvW7DI/v7Vct2EMZRSgBv42vcm2RliX8rnMwVwyESPmbvXnJsp
dwcok/3Ld/gbhpvzyNull8WHfrW12LdT2lh/CBiq0PaOdvTGnulfVgaBpZBmGXZA
hKdiTJrGowSnf5vlti5VjuzzmIjvgGvqgJ+jhY61hQ==
=Gin8
-----END PGP SIGNATURE-----

--hzv8ABo2Qk/lNh3C--

