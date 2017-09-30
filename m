References: <cda9d511-43b5-cc6f-ead0-017f0f869e61@...2181...>
 <20170929162458.16514-1-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <23b4e635-04ac-42c9-d47d-42a80171ec76@...2181...>
Date: Sat, 30 Sep 2017 09:00:16 +0800
MIME-Version: 1.0
In-Reply-To: <20170929162458.16514-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1esoSINMqwjp6whwpGoT48OmhRmqI8MaI"
Subject: Re: [Openvpn-devel] [PATCH 0/2] Reject client if PF plugin is
 configured, but init fails
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1esoSINMqwjp6whwpGoT48OmhRmqI8MaI
Content-Type: multipart/mixed; boundary="Wr5QDsqkS3d7pADNpQNtuVfWHHmDSfND4";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <23b4e635-04ac-42c9-d47d-42a80171ec76@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 0/2] Reject client if PF plugin is
 configured, but init fails
References: <cda9d511-43b5-cc6f-ead0-017f0f869e61@...2181...>
 <20170929162458.16514-1-steffan@...1856...>
In-Reply-To: <20170929162458.16514-1-steffan@...1856...>

--Wr5QDsqkS3d7pADNpQNtuVfWHHmDSfND4
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 30/09/17 00:24, Steffan Karger wrote:
> This changes the behavior for pf plugins: instead of just not initializing
> the firewall rules and happily continuing, this now rejects the client in
> the case of an (unlikely) failure to initialize the pf.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  src/openvpn/pf.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
> index 5cb002bf..29231b67 100644
> --- a/src/openvpn/pf.c
> +++ b/src/openvpn/pf.c
> @@ -639,10 +639,11 @@ pf_init_context(struct context *c)
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
> +            msg(M_WARN, "WARNING: failed to init PF plugin, rejecting cl=
ient.");
> +            register_signal(c, SIGUSR1, "plugin-pf-init-failed");
>          }

after this part there is some code dealing with the management
interface: wouldn't it be better to have a return after registering the
signal so that we don't attempt any interaction with the management
interface? If the plugin initialization failed, we should exit right
away no?

(although this PF thing with the plugin being optional makes everything
more complicated every time :/)

Another thought: if we abort every time we can't initialize the pf
context, do you think we need the c->c2.pf.enabled member at all?

It looks to me that after this patch if PF is enabled, either a client
is connected and has a PF context, or its connection was rejected
entirely. Thus a overall state should be enough rather than a per-client
one. (Can probably be adjusted with another patch if you don't feel like
doing all this in here?)

Cheers,

>      }
>  #endif /* ifdef PLUGIN_PF */
>=20

--=20
Antonio Quartulli


--Wr5QDsqkS3d7pADNpQNtuVfWHHmDSfND4--

--1esoSINMqwjp6whwpGoT48OmhRmqI8MaI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlnO7KAACgkQB6U8WA7y
zXTReQ//YZUXhGZQKpkgg4sZwwIuJPXRx8gG8nlOPcOx2KkrUTxBo0pGytHbOVuQ
5/CnJ3J3sH0BrirnVuD+Yv+MuJ1dcSTh1W+hdJKZjo0JwY2tLdmnC9LtDEeBg15R
SOnFcx0e0bwQQUvq/wCWsu9OTkVgai7utU5eMyrt6lv0fMnL86qIrEAPC3UIfUPu
t0L+GIDp714T9JZGh4Lk2Rkc9Lkg+Fu2+l8alM3Uz7TuNWkJxmBnWQ1ScXt0IB4+
S6LhAjMElwgezXL7v/etvAvdS0zhpZDqX+v4e/o1Ez6TzYlDV32hpUkWIyNyo4fF
4/PGYyjSswVHbe75KwfDqDTVmlPRDp6HWzjgD3xc7bHVnbRSif+EQpbe2bRx6iml
Ahdm+MDGYPF3KVE6Skt9oeExH424WDglgIOccvcVf1W2OqHYMKkOMRlIYPPnLC6h
5E7/g5Gqb8iZoZS7vwTapLMtQ0XgA17+H1H/WFz7BfiArFZxMaue3XppK1xyIP+z
6mV6H5Fv7HNBiuffHlMBaj2cAfaP6mimCJdHAtDTvb0ORE+jusi9SKhCHibqKWTG
Jw2K+3rGzTGzOpApMMxSw1meoebOKkUnWcL3dNC/MrCvSBn9AN0qC8gRI5aXpQKE
+RBBRp/6xH8cjeJ8YBmE1Lu/GmPDe7NWchSmBGMFuz02Kr2gg+s=
=2cwQ
-----END PGP SIGNATURE-----

--1esoSINMqwjp6whwpGoT48OmhRmqI8MaI--

