Date: Mon, 15 Nov 2021 12:42:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YZJHrZ2s3gTTIvyA@...1296...>
References: <20210930113308.815777-1-mkh199740@...450...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0wHV+s/pGXFo0sMw"
Content-Disposition: inline
In-Reply-To: <20210930113308.815777-1-mkh199740@...450...>
Subject: Re: [Openvpn-devel] [PATCH] Add ability to specify initialize flags
 for pkcs11 provider
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Petr Mikhalicin <mkh199740@...450...>
Cc: openvpn-devel@lists.sourceforge.net

--0wHV+s/pGXFo0sMw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 30, 2021 at 02:33:08PM +0300, Petr Mikhalicin via Openvpn-devel=
 wrote:
> New pkcs11-helper interface allows to setup pkcs11 provider via
> properties: https://github.com/alonbl/pkcs11-helper/commit/b78d21c7e26041=
746aa4ae3d08b95469e1714a85
>=20
> Also pkcs11-helper added ability to setup init args for pkcs11 provider:
> https://github.com/alonbl/pkcs11-helper/commit/133f893e30856eba1de715ecd6=
fe176722eb3097

I can't comment on the PKCS#11 feature (not my field), but I have a few=20
comments about required coding style changes:

> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -664,6 +664,11 @@ static const char usage_message[] =3D
>      "                              8       : Use Unwrap.\n"
>      "--pkcs11-cert-private [0|1] ... : Set if login should be performed =
before\n"
>      "                                  certificate can be accessed. Set =
for each provider.\n"
> +    "--pkcs11-init-flags hex ...     : PKCS#11 init flags.\n"
> +    "                              It's bitwise OR of some PKCS#11 initi=
alize flags.\n"
> +    "                              Most popular of them is:\n"
> +    "                              1       : CKF_LIBRARY_CANT_CREATE_OS_=
THREADS\n"
> +    "                              2       : CKF_OS_LOCKING_OK\n"

The indent here is not right - did you use TABs here?  Please don't, they
get usually messed up by mail clients.

> @@ -1838,6 +1843,13 @@ show_settings(const struct options *o)
>              SHOW_PARM(pkcs11_cert_private, o->pkcs11_cert_private[i] ? "=
ENABLED" : "DISABLED", "%s");
>          }
>      }
> +    {
> +        int i;
> +        for (i =3D 0; i<MAX_PARMS; i++)
> +        {
> +            SHOW_PARM(pkcs11_init_flags, o->pkcs11_init_flags[i], "%08x"=
);
> +        }
> +    }

This, we do C99 style nowadays:

> +    for (int i=3D0; i<MAX_PARMS; i++)
> +    {
> +        SHOW_PARM(pkcs11_init_flags, o->pkcs11_init_flags[i], "%08x");
> +    }

(so, no extra brackets, and the "int i" can go right into the for()
clause)

>      SHOW_INT(pkcs11_pin_cache_period);
>      SHOW_STR(pkcs11_id);
>      SHOW_BOOL(pkcs11_id_management);
> @@ -8778,6 +8790,17 @@ add_option(struct options *options,
>              options->pkcs11_cert_private[j-1] =3D atoi(p[j]) !=3D 0 ? 1 =
: 0;
>          }
>      }
> +    else if (streq(p[0], "pkcs11-init-flags"))
> +    {
> +        int j;
> +
> +        VERIFY_PERMISSION(OPT_P_GENERAL);
> +
> +        for (j =3D 1; j < MAX_PARMS && p[j] !=3D NULL; ++j)

Same here: "int j" goes into the loop.

> diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
> index 02d0f51f..29db7ea4 100644
> --- a/src/openvpn/pkcs11.c
> +++ b/src/openvpn/pkcs11.c
> @@ -374,12 +374,17 @@ pkcs11_terminate(void)
> +    if ((rv =3D pkcs11h_registerProvider(provider)) !=3D CKR_OK) {
> +        msg(M_WARN, "PKCS#11: Cannot register provider '%s' %ld-'%s'", p=
rovider, rv, pkcs11h_getMessage(rv));
> +	success =3D false;
> +	goto exit;
> +    }

The "{" always goes to the next line, and indenting is never done with
tabs (the lines above look like a mixture of tabs and spaces, and the
tab being messed up by the mail client).

> +    // pkcs11-helper take ownership over this pointer

No C++ comments, please.

> +    // pkcs11-helper take ownership over this pointer
> +    if ((p_init_args =3D malloc(sizeof(*p_init_args))) =3D=3D NULL) {
> +        msg(M_FATAL, "PKCS#11: Cannot allocate memory");
> +	success =3D false;
> +	goto cleanup;
> +    }
> +
> +    memset(p_init_args, 0, sizeof(*p_init_args));

Please use calloc() and check_malloc_return() instead.

msg(M_FATAL) never returns, so the "success =3D false, goto cleanup" bit
is not needed - and all that is done by check_malloc_return() for you :-)


For our coding style guidelines, see also here:

  https://community.openvpn.net/openvpn/wiki/CodeStyle

and in the openvpn repo there is a "dev-tools/uncrustify.conf" config
which can be used with the "uncrustify" program to format your code
according to the whitespace rules.  Won't do the "for (int i=3D0; ...)"
C99 changes, though.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--0wHV+s/pGXFo0sMw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhkketAAoJEB2Cnv7KVigSmCIL/2VGK6O8H8WLUtPgTqzhYNvU
iyO7Ka5Hig6+lcUXDOXjiUESTwT7GwoAPlwBjx1g7RdWP2wr3FT9s8KI+cncAarH
vk+ytVMBciFZCkOZ/2umLehejWV2npJMhquDZwubUwLKtqTseYso2SWVAng6CrcT
B0/RhnUIVmHcvnuin9v5y0btkj5bYzTEw1kpOZ7O3gtdOacIY8TrDzjJGE7t5ndQ
RNiFdj1CX0wyuNAWGwMQ+bkZlmGisLN4KkytYkK04q0wqvd7FmihQczX2vYDCew9
os/DtKDMEH25Eww4oLSHYbdX49204myrgb1BSlTjT8mN6TUxPHiuUF4tqR24sFoX
MSs8n25yfzolnc9onfGFCcT5FeOPrVnJBgw8RPNYcHBf8JFrwcx/3lB9LVZZwpBQ
BRI0wtn/vUBaLTNMWpOKqw9ZesXomI6i7EWbOOW3dYqRt7fpE0KtQRmrg+yUG+yp
VywA03vlEYEezqONao6gWoN1sf+RvXPbo3kIkn0w1A==
=zUCH
-----END PGP SIGNATURE-----

--0wHV+s/pGXFo0sMw--

