References: <20200720070802.18819-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <45ad7a49-fcf1-74ed-a082-c952fbb61246@...1227...>
Date: Mon, 20 Jul 2020 11:21:18 +0200
MIME-Version: 1.0
In-Reply-To: <20200720070802.18819-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JjI217AJxOQYxAsNlbETIdoZp2Y2JxjCT"
Subject: Re: [Openvpn-devel] [PATCH] Separate handling of non-deferred
 return values for client-connect-scripts.
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
--JjI217AJxOQYxAsNlbETIdoZp2Y2JxjCT
Content-Type: multipart/mixed; boundary="no5ZJ3CvmVvvogqsYIYk7jB1Yvy5TBSIE"

--no5ZJ3CvmVvvogqsYIYk7jB1Yvy5TBSIE
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 20.07.20 um 09:08 schrieb Gert Doering:
> (Only) on "CC_RET_SUCCESS", run multi_client_connect_post().
>=20
> On "CC_RET_FAILURE", add missing log line, do not call ..._post().
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/multi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 08112c98..e99de713 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2139,13 +2139,19 @@ multi_client_connect_script_deferred(struct multi=
_context *m,
>          ret =3D CC_RET_DEFERRED;
>      }
>=20=20
> -    if (ret !=3D CC_RET_DEFERRED)
> +    if (ret =3D=3D CC_RET_SUCCEEDED)
>      {
>          ccs_delete_deferred_ret_file(mi);
>          multi_client_connect_post(m, mi, ccs->config_file,
>                                    option_types_found);
>          ccs_delete_config_file(mi);
>      }
> +    if (ret =3D=3D CC_RET_FAILED)
> +    {
> +	msg(M_INFO, "MULTI: deferred --client-connect script returned CC_RET_FA=
ILED");
> +        ccs_delete_deferred_ret_file(mi);
> +        ccs_delete_config_file(mi);
> +    }
>      return ret;
>  }

Looks good to me. Reading the config file on failed should not hurt but
is a very weird thing to do.

Acked-By: Arne Schwabe <arne@...1227...>


--no5ZJ3CvmVvvogqsYIYk7jB1Yvy5TBSIE--

--JjI217AJxOQYxAsNlbETIdoZp2Y2JxjCT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8VYg4ACgkQFRhsZwKx
RFRodg//QKB8DbpftDX4FQ6JxcHPiW2n6L/AjB/2YrWOhLtMTvAbLQ0htEVBwGkf
Xat6jH4Mz46duZ2Oeqe+0Yb/x/lguu6dEYIJ8jAz8WKDP7fCZUbzVMIvikVZt+t/
pToYYkZ+AIkv9yNsaThnPpjOvUnFBVEjWMECm/9SYDZANUVqG8Ka2VqMby2+zUAa
1x5qk8ObfK008h86tC22SAbgBuKqmN6LewmPCBr0Bn43ni3PorBpmqnJ6Nj677O4
FLqNlCVWf01GJYopAdkraILIKSlb58uP4zSpFZrmDX/nzpWY9ZVApymwX/mi7GPJ
fSjjuatZTrKjV1wQRcjQDpcAWJD/0VXWLtzBMCf8adxZ0CYb3lea6CVGRpPFklWS
1xtnUnlvSwMVST1LFfJI35NoSH7HBctM/5Fy2XiB2mXHslDfTUrcLYSEt+Aeeqae
W1BrHrklLGZWuqJL9GWkTghFi06M0Lp7jvv+9HncIVNnpeGMIUzTsliAhNDfPzPM
CVWsoWdVx9ELCt1Js1eX/9cgMLvxcAnFUvLvVVBoXa9ueI5Xlg4qMddqL4n2vXCM
R2ed3XB+caXjfcVZS1w+vHs7XJbNTnp0Jv3J3Wi7tS3GM+3yd1160Eaunc09yNk9
JFz5MdvCHXRyMv7K+EgToFBcL3uahZxN1aaLtXtg0kimQdgZBN4=
=Qu3A
-----END PGP SIGNATURE-----

--JjI217AJxOQYxAsNlbETIdoZp2Y2JxjCT--

