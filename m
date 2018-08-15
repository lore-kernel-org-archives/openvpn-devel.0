References: <20180815051540.25118-1-a@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b3f74d10-d20e-9746-a45e-b47bb1664b18@...2181...>
Date: Wed, 15 Aug 2018 13:32:40 +0800
MIME-Version: 1.0
In-Reply-To: <20180815051540.25118-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bXfDBSpV5prS52bjB0rLRb2AGKBJ0y28X"
Subject: Re: [Openvpn-devel] [PATCH] ssl_verify: define label only when
 required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bXfDBSpV5prS52bjB0rLRb2AGKBJ0y28X
Content-Type: multipart/mixed; boundary="ejM3m5DfPjWTXEzC6R5GptRKst4mh7rVb";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <b3f74d10-d20e-9746-a45e-b47bb1664b18@...2181...>
Subject: Re: [PATCH] ssl_verify: define label only when required
References: <20180815051540.25118-1-a@...2181...>
In-Reply-To: <20180815051540.25118-1-a@...2181...>

--ejM3m5DfPjWTXEzC6R5GptRKst4mh7rVb
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 15/08/18 13:15, Antonio Quartulli wrote:
> The "cleanup" label in ssl_verify.c:verify_user_pass_plugin() is used
> only when PLUGIN_DEF_AUTH is defined, therefore make the label
> definition dependent on the same define.
>=20
> At the moment, gcc throws an error for unused label if PLUGIN_DEF_AUTH
> is not defined.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/ssl_verify.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 61872251..9dfe23f8 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -1220,7 +1220,9 @@ verify_user_pass_plugin(struct tls_session *session=
, const struct user_pass *up,
>          msg(D_TLS_ERRORS, "TLS Auth Error (verify_user_pass_plugin): pee=
r provided a blank username");
>      }
>=20=20
> +#ifdef PLUGIN_DEF_AUT
>  cleanup:
> +#endif
>      return retval;
>  }
>=20=20


Not sure which gcc version is being used on Gitlab-CI, but my jobs are
failing with:

ssl_verify.c:1197:13: error: label 'cleanup' used but not defined
             goto cleanup;
             ^~~~
Makefile:680: recipe for target 'ssl_verify.o' failed
make[3]: *** [ssl_verify.o] Error 1

It seems this is not just a warning anymore.


Regards,



--=20
Antonio Quartulli


--ejM3m5DfPjWTXEzC6R5GptRKst4mh7rVb--

--bXfDBSpV5prS52bjB0rLRb2AGKBJ0y28X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltzuvgACgkQB6U8WA7y
zXT3TA/9G/oO6pu/AgjivEr1pd4a6lrYHKGFL8U4uPd+U8Xj74k7Jep7WisUDNSJ
mhXSqTYjYLUrGUT82Lis3ln7HIznTPJ9nHXRFpDojaM/kJFnNr8SCc/AYDAdRvH0
w8z5WzEtJCsQCKMQIrNQWAO5SL/MaUbBhfO3HM2t7UtYj6jSauFeDXqGOO+GerOA
fSnAmptXG7LQvEU2sgUMV5nSEPGEh6S6hbn8MHxi5p4LLGKCURjwZ+cH/5pMY6jj
msVnfBbhN79JuyyfNNS+wQ2EhcdqRtv+xD4sZpEFNCJ+ifqINgcXRmw9fvQcav4X
thQ6RE65iq7eIk/6e927k8P1VkI2xDSPw5E9lOB4BaFsSTaEJtFYnOBM/vvJAtaT
9IvyxJKkLanT1ZD7CX5d9JqXE9Ng/xN5pU6ZkO0QSJJnXawE72M6CPOF9s/QsM/k
z3fZjdVJ3O1SQvLBXEBdMHwlCA4U1DZdzw2yODqbMnX9HURqkHSVRKJS66ydr7FF
+lBKYr43j6JvOyOXdsr4tmZIdc+IYBcBLzjQHouNZVW033WlDt4HIMS6t1BWY07T
SoSoxaC5Wn1KMW2M1He3yETdEUkMJ+676l1s3Su6fIad0MPLLP3TdZDuLwz1bmmE
jRTTuWzcvOtlRKTh6aPODg+bByhIeF47u2oGpivHLZ5co4pHcd0=
=bfLy
-----END PGP SIGNATURE-----

--bXfDBSpV5prS52bjB0rLRb2AGKBJ0y28X--

