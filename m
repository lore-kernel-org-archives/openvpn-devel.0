References: <20200909153725.1158-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <9020cf9f-6224-95ef-0f6b-0ce6354a5e4f@...1227...>
Date: Thu, 10 Sep 2020 10:19:49 +0200
MIME-Version: 1.0
In-Reply-To: <20200909153725.1158-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SAb8lkGfcKiVNpiHcuEAhhPX0bLGVIIdN"
Subject: Re: [Openvpn-devel] [PATCH] Fix TUNSETGROUP compatibility with very
 old Linux systems.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SAb8lkGfcKiVNpiHcuEAhhPX0bLGVIIdN
Content-Type: multipart/mixed; boundary="SLupYFztZnwtdcGo9oUSDJ5ud5oMdl1hO"

--SLupYFztZnwtdcGo9oUSDJ5ud5oMdl1hO
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 09.09.20 um 17:37 schrieb Gert Doering:
> Our code works on "very old Linux" (Fedora-1), but needs a #define
> for TUNSETGROUP to compile.  Everything else is there.
>=20
> While at it, fix TUNSETGROUP error message.
>=20
> Reported-By: noloader on Trac
> Trac: #1152
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/tun.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 923131ad..651cb871 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -1993,6 +1993,11 @@ open_tun(const char *dev, const char *dev_type, co=
nst char *dev_node, struct tun
>=20=20
>  #ifdef ENABLE_FEATURE_TUN_PERSIST
>=20=20
> +/* TUNSETGROUP appeared in 2.6.23 */
> +#ifndef TUNSETGROUP
> +# define TUNSETGROUP   _IOW('T', 206, int)
> +#endif
> +
>  void
>  tuncfg(const char *dev, const char *dev_type, const char *dev_node,
>         int persist_mode, const char *username, const char *groupname,
> @@ -2032,7 +2037,7 @@ tuncfg(const char *dev, const char *dev_type, const=
 char *dev_node,
>          }
>          else if (ioctl(tt->fd, TUNSETGROUP, platform_state_group.gr->gr_=
gid) < 0)
>          {
> -            msg(M_ERR, "Cannot ioctl TUNSETOWNER(%s) %s", groupname, dev=
);
> +            msg(M_ERR, "Cannot ioctl TUNSETGROUP(%s) %s", groupname, dev=
);
>          }
>      }
>      close_tun(tt, ctx);
>=20

Hm, it does not hurt, so...

Acked-By: Arne Schwabe <arne@...1227...>


--SLupYFztZnwtdcGo9oUSDJ5ud5oMdl1hO--

--SAb8lkGfcKiVNpiHcuEAhhPX0bLGVIIdN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9Z4aUACgkQFRhsZwKx
RFSdyg//WyjvmQSs2xEpKXky+a1j3GtaHdLRQyMU0GXrwKqqfN6Cu8W69krEKvEE
91YTnvEB0aP51AK44xwHmVCyfZQdN3aMs/t84Wtmx91YlYB+MxNpR/hkj7iHnxng
dcYxBImvr4W+vHhYNodUmgIg+7ScZ+NdIl5l5uZsOwxYN9nRB9EjueWaD3Eaw5jh
sE4a1wdvt2p/u/s1pX/kFQcPukMZgnrNgZckf044E0iRsKB2J/mML4+G7y6alimm
jebH4Ek1+ox87jcdDCarAsDoIntMnoA/1EEmYVcCrJVQO0xF3fD3IjfwCC6Symu9
awIuerG18QZJT6PmT5DXqGc7LGIBObWvA8pZhaBNCc1fpPN20jx35YJ5837NEW1j
1m18iNFGUH1mFEvX0UfEZ4QxVvhbwYD070CwdUoFYAoUMaYDi/fcHrtQxHJK/gvH
VPTweQOQF1I99qoi19OkO3JE3fkHlem8vIFz1fmomZSUvgq5xUujrpZwQegJY2zn
qlTcaZHO8SZspB9IMi9x0AzfwN2zBF2U2L56u6nngXtCkYkk80cV74fxdehVh5+T
NiQx0UXL3JdIje7iK7UtJfzqijU4Iaia9tnwQm3wGXqCOr62mrzcnHVl/tu6WSoX
SEiKsLjmiXJ9tembVVWz/muY/1ucRfQZfPQd0hSxQLiaH/fxpnc=
=Denm
-----END PGP SIGNATURE-----

--SAb8lkGfcKiVNpiHcuEAhhPX0bLGVIIdN--

