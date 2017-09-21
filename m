Reply-To: openvpn-devel@lists.sourceforge.net
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f0113abb-0008-4666-a60c-62e69d327bef@...2080...>
Date: Thu, 21 Sep 2017 22:55:08 +0200
MIME-Version: 1.0
In-Reply-To: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1S0dGNAwnFAEPxIeksCJnWvWJJixO6wfl"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Don't throw fatal errors from
 create_temp_file()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1S0dGNAwnFAEPxIeksCJnWvWJJixO6wfl
Content-Type: multipart/mixed; boundary="MoXis9gtuLgma7IIpttTigv5Hh3PWSV6U";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f0113abb-0008-4666-a60c-62e69d327bef@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Don't throw fatal errors from
 create_temp_file()
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>

--MoXis9gtuLgma7IIpttTigv5Hh3PWSV6U
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 14/09/17 23:34, Steffan Karger wrote:
> This function is called in response to connecting clients, and can fail
> when I/O fails for some (possibly temporary) reason.  In such cases we
> should not exit the process, but just reject the connecting client.
>=20
> This commit changes the function to actually return NULL on errors, and
> (where needed) changes the callers to check for and handle errors.
>=20
> Note that this changes the behavior for pf plugins: instead of just not
> initializing the firewall rules and happily continuing, this now rejects
> the client in the case of an (unlikely) failure to initialize the pf.
>=20
> Since the tls-crypt-v2 metadata code also calls create_temp_file() when
> clients connect, I consider this a prerequisite for tls-crypt-v2.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  src/openvpn/misc.c       |  6 +++---
>  src/openvpn/pf.c         |  8 ++++----
>  src/openvpn/ssl_verify.c | 32 +++++++++++++++++++++-----------
>  3 files changed, 28 insertions(+), 18 deletions(-)
>=20
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 8c7f611..25f3800 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -740,7 +740,7 @@ create_temp_file(const char *directory, const char *p=
refix, struct gc_arena *gc)
>          retfname =3D gen_path(directory, BSTR(&fname), gc);
>          if (!retfname)
>          {
> -            msg(M_FATAL, "Failed to create temporary filename and path");
> +            msg(M_WARN, "Failed to create temporary filename and path");
>              return NULL;

All these changes to create_temp_file() are good.  The use of M_FATAL
must have been an oversight when this part was overhauled approx 8 years
ago.  M_WARN is the proper log tag.  And all places calling
create_temp_file() have proper checks if this function returns NULL.  So
this part of the patch gets an ACK.

[...snip...]

> diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
> index 5cb002b..5fe1734 100644
> --- a/src/openvpn/pf.c
> +++ b/src/openvpn/pf.c
> @@ -639,10 +639,10 @@ pf_init_context(struct context *c)
>                  }
>  #endif
>              }
> -            else
> -            {
> -                msg(M_WARN, "WARNING: OPENVPN_PLUGIN_ENABLE_PF disabled"=
);
> -            }
> +        }
> +        if (!c->c2.pf.enabled)
> +        {
> +            register_signal(c, SIGUSR1, "plugin-pf-init-failed");
>          }

This change scares me.  Unless I overlooked something, pf_init_context()
is called on each new connection happens on the server side, through
multi_create_instance().  Is it truly safe to call SIGUSR1 on the server
process, considering other clients may be connected at the same time?
On a client process, this would be fine though.

Just noticed Antonio are thinking along the same paths, so either we're
missing some details ... or this is risky.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--MoXis9gtuLgma7IIpttTigv5Hh3PWSV6U--

--1S0dGNAwnFAEPxIeksCJnWvWJJixO6wfl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZxCcsAAoJEIbPlEyWcf3yUtcQAIcTRYRl00P7HiTJBk2w1ECj
J1Civ2wLqk/SM5ayu/PhBVhgdAhEM6z92apY9jFMNyDypGlcD33IbDIR+EXaHTKd
oXO/9vsCxcINjMg1Bsqp1FXU0d+lf/0qHfrmYWFXYp63/VmJvLAM6ipBKAyCRt3a
4oAQ48vXsmk7q+TpXcMIhyeAS7JyRjlkSZjKR96SQpd9TsKO6zHD68gejJwRRpNf
T/0ZBZFKw0Eva+T+89qn7vRKEmzYyiSVrhjPGI1AWulBfBFq+tMaNUliaoNYpkjs
aN1iOaZ1eXnSJ73DM/T/LWp6dG9IdF7Ff3Ggr8YNMv3pYZUW0b1y9CfKgsER8wyN
lprG9x+5w8WOoIZNoL+rwiBO6E1ieV6R8DGGgwKNw4NE2+nRHl39O+eAiHDiOugV
VYsQ4yKUUTiunwvo4GZU1LFfwhjcTw7GRtwb67RC73HkacQe9nuBkUrkyF4p6tI5
YETp8zXxcBuG8zNd3jwNZfDHJbgPGOhSzybNaOk28SpTm4n3IyAUFKfYGzawuz69
45L8fS/W/TznZkBRedgSz2mtwInljVTBCoMZYm7skan+1AC5ARp2RHB0TCfW3MhC
P3aWEER7wtjDIoaWK4Oq7iHiOk3dTwRapQaepXXJVf+lRoH9hYCuxl6rE/4OtR5y
SbWBbMZ3M4WiKooEhSQ4
=ldyh
-----END PGP SIGNATURE-----

--1S0dGNAwnFAEPxIeksCJnWvWJJixO6wfl--

