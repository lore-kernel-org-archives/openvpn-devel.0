References: <20170225020229.17287-1-davids@...515...>
	<CAFHpkQHRADXhPuPXMtyM0_yj76O9_4vnUCd1CFYKZhdk5M+iTA@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <40e4d3cd-68a8-8f0e-ce1e-c9d56400da6b@...2080...>
Date: Sat, 25 Feb 2017 12:49:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHRADXhPuPXMtyM0_yj76O9_4vnUCd1CFYKZhdk5M+iTA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="I9t2jbtEtFP4dcmTlrB3jfLhHO8c67kUN"
Subject: Re: [Openvpn-devel] [PATCH] cleanup: Remove faulty env processing
 functions
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I9t2jbtEtFP4dcmTlrB3jfLhHO8c67kUN
Content-Type: multipart/mixed; boundary="JHx83qsLGqO8ncGCaNjW1B8wM9KMOoIUb";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
	"openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <40e4d3cd-68a8-8f0e-ce1e-c9d56400da6b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup: Remove faulty env processing
	functions
References: <20170225020229.17287-1-davids@...515...>
	<CAFHpkQHRADXhPuPXMtyM0_yj76O9_4vnUCd1CFYKZhdk5M+iTA@...278...>
In-Reply-To: <CAFHpkQHRADXhPuPXMtyM0_yj76O9_4vnUCd1CFYKZhdk5M+iTA@...278...>

--JHx83qsLGqO8ncGCaNjW1B8wM9KMOoIUb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 25/02/17 10:42, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> there are two another unused functions in misc.c
>=20
> [src/openvpn/misc.c:661]: (style) The function 'env_set_print' is never
> used.

This one is useful for debugging purposes, so I let this one stay.  I
did consider an #if 0 around it, to make it more explicit.  But I
thought we have enough of those.  It could make some compiler warnings
go away though disabling it.

> [src/openvpn/misc.c:895]: (style) The function 'setenv_int_i' is never us=
ed.

Ahh, that one I didn't check for.  I'll have a closer look if that is
something we should let it survive or take that one out too.

The most troubling issue with those two functions in the patch is that
if they were to be used, it would actually make OpenVPN halt and exit
due to the ASSERT() check not being fulfilled later on in the call
chain.  setenv_str() calls setenv_str_ex() which checks if the pointer
to a struct set_env is NULL or not.  If it is NULL, it stops.  And these
two functions ends up calling setenv_str_ex() with
struct env_set *es =3D NULL;


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc


> 2017-02-25 7:02 GMT+05:00 David Sommerseth <davids@...515...
> <mailto:davids@...515...>>:
>=20
>     The env_set_add_to_environmenti() and env_set_remove_from_environment=
()
>     functions where not used in the code at all and they would cause an
>     ASSERT() in setenv_str_ex() later on, as it would not allow the
>     struct env_set *es pointer to be NULL (misc.c:807).
>=20
>     Signed-off-by: David Sommerseth <davids@...515...
>     <mailto:davids@...515...>>
>     ---
>      src/openvpn/misc.c | 51
>     ---------------------------------------------------
>      src/openvpn/misc.h |  4 ----
>      2 files changed, 55 deletions(-)
>=20
>     diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
>     index a2f45b6..68d0687 100644
>     --- a/src/openvpn/misc.c
>     +++ b/src/openvpn/misc.c
>     @@ -701,57 +701,6 @@ env_set_inherit(struct env_set *es, const
>     struct env_set *src)
>          }
>      }
>=20
>     -void
>     -env_set_add_to_environment(const struct env_set *es)
>     -{
>     -    if (es)
>     -    {
>     -        struct gc_arena gc =3D gc_new();
>     -        const struct env_item *e;
>     -
>     -        e =3D es->list;
>     -
>     -        while (e)
>     -        {
>     -            const char *name;
>     -            const char *value;
>     -
>     -            if (deconstruct_name_value(e->string, &name, &value, &gc=
))
>     -            {
>     -                setenv_str(NULL, name, value);
>     -            }
>     -
>     -            e =3D e->next;
>     -        }
>     -        gc_free(&gc);
>     -    }
>     -}
>     -
>     -void
>     -env_set_remove_from_environment(const struct env_set *es)
>     -{
>     -    if (es)
>     -    {
>     -        struct gc_arena gc =3D gc_new();
>     -        const struct env_item *e;
>     -
>     -        e =3D es->list;
>     -
>     -        while (e)
>     -        {
>     -            const char *name;
>     -            const char *value;
>     -
>     -            if (deconstruct_name_value(e->string, &name, &value, &gc=
))
>     -            {
>     -                setenv_del(NULL, name);
>     -            }
>     -
>     -            e =3D e->next;
>     -        }
>     -        gc_free(&gc);
>     -    }
>     -}
>=20
>      /* add/modify/delete environmental strings */
>=20
>     diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
>     index 16be621..009767f 100644
>     --- a/src/openvpn/misc.h
>     +++ b/src/openvpn/misc.h
>     @@ -161,10 +161,6 @@ void env_set_print(int msglevel, const struct
>     env_set *es);
>=20
>      void env_set_inherit(struct env_set *es, const struct env_set *src);
>=20
>     -void env_set_add_to_environment(const struct env_set *es);
>     -
>     -void env_set_remove_from_environment(const struct env_set *es);
>     -
>      /* Make arrays of strings */
>=20
>      const char **make_env_array(const struct env_set *es,
>     --
>     2.11.0
>=20
>=20
>     ---------------------------------------------------------------------=
---------
>     Check out the vibrant tech community on one of the world's most
>     engaging tech sites, SlashDot.org! http://sdm.link/slashdot
>     _______________________________________________
>     Openvpn-devel mailing list
>     Openvpn-devel@lists.sourceforge.net
>     <mailto:Openvpn-devel@lists.sourceforge.net>
>     https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>     <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>
>=20
>=20
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20





--JHx83qsLGqO8ncGCaNjW1B8wM9KMOoIUb--

--I9t2jbtEtFP4dcmTlrB3jfLhHO8c67kUN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJYsW9uAAoJEIbPlEyWcf3y5t0P/R79GjtIHYjGGucJASbqZGc9
BnilP4bCUMgzBtFSTYwLaTP7riFw4NPH8edbzqupvMa35w5Gwkj2Tzq3MicGxDTH
WpRl8VBB+ZTALXV8gplAuXmRXSG7g1C5fOd1tTnrio3/v2ApUe8b5cO8F4viThzr
+fh/ywYveo9ez4twPZsgopSDZU6Jet/6Ajas6yDUZz6Qs3/eBNyJxtpSl6AfqCV1
pCVSoWZhr/BBuuzbHtNbtwJCbyckHBAzwao2vww8uDTno6VMHdS0OAz04l8FTYLG
oXpFLy0Ljd7rdkRKe2gnM4lBaGgSvV9MjPMF2x6//0cv8cULaCVywoFI7ye9uPnG
EsADfH0VU/LDLfYMCfnoJ/gH/z4a8PiOLcAHfJCUwHXZlSHLzyfCGhxee5zJaeGI
AZ0FyLixTTB+S6m1CQ3Ui6/hdAw8bqeiyHrMGUTyOCfYHeswY7/DaUE0tyIVpoKU
l9oVRA+sx7YyutM/DHkhUGU5zXfsOmRUKlAFpJX4wDVHUHFXZY73ckMTdheRY7GQ
+eg6Iu4U06lvT2eIQ8XP+t6Qs3Pj99xVGFC821RTwXEhX3cb0UsSGNkmnobsiqer
ywrJzQEtggY4gLe+5wr3l9z0pt64NP5V7MSw1shCnFUXF9vCBjb9jJL2voNc8SEA
NBTYxW5bmSyChDfnPP/0
=NYZZ
-----END PGP SIGNATURE-----

--I9t2jbtEtFP4dcmTlrB3jfLhHO8c67kUN--

