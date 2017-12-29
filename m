References: <d19475e8-d4b4-56ac-7899-53b3aec2d4f3@...2181...>
 <1514541191-19471-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <6fa45579-3404-c9ed-8631-25577817cbff@...2181...>
Date: Fri, 29 Dec 2017 17:58:54 +0800
MIME-Version: 1.0
In-Reply-To: <1514541191-19471-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lqkVykvHswtHnRjnycHIYzZcPqvZt7Rrr"
Subject: Re: [Openvpn-devel] [PATCH 3/5 v3]
 buffer_list_aggregate_separator(): don't exceed max_len
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
--lqkVykvHswtHnRjnycHIYzZcPqvZt7Rrr
Content-Type: multipart/mixed; boundary="Gayq3OluHGK5srq2OeylcnZ4rI1jrSl5z";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6fa45579-3404-c9ed-8631-25577817cbff@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 3/5 v3] buffer_list_aggregate_separator():
 don't exceed max_len
References: <d19475e8-d4b4-56ac-7899-53b3aec2d4f3@...2181...>
 <1514541191-19471-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1514541191-19471-1-git-send-email-steffan.karger@...1435...>

--Gayq3OluHGK5srq2OeylcnZ4rI1jrSl5z
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 29/12/17 17:53, Steffan Karger wrote:
> buffer_list_aggregate_separator() would merge buffer_list entries until it
> had exceeded the provided max_len, instead of stopping *before* exceeding
> the max value.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
> v2: rebase on 1/5 v2 (other patches should still apply)
> v3: as suggested by ordex, reorder if contitions and add spaces around '+'

Thanks for that!

Acked-by: Antonio Quartulli <a@...2181...>


--=20
Antonio Quartulli


--Gayq3OluHGK5srq2OeylcnZ4rI1jrSl5z--

--lqkVykvHswtHnRjnycHIYzZcPqvZt7Rrr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlpGEd4ACgkQB6U8WA7y
zXTNyg//YmjHpifpEnK4HlGPag4SWOrRLPIKtVJQ0JaM+f5nlYSYgLwtQjWEqvPU
4MzzmaJRPrey4dX9lIaV3Hrtses3X9xnFq5+ELZYEGfYWQPaA5HdrG0PTatfraS7
NZMnyLdq4gwpRzvK/btBtPEr97mNZnDv6oD38iXu5qhY8y3IOHIn7glrL064X/h8
2Nryu4kWGCYYUNYHGl2w6UuAOIeS7+l6i6nDDUMfHtNyLHlQuoRk/0pCdNBVREM+
O9u9KXvRcRKchkSFs3DmxJANF3sQhFuj9W0UnWMjm2YdPl8n7HU8A1eIAOjqkJ0D
/TYMSC0E7NaEUUctDQO/cw8S8ouPV8j8gLua/7jjXnIEAbAx90STO9VCIqsCOUM7
YVB+N9CJT0YwgYw6hKYTqq81v4/3OXmR7zL1jI55Ld1+oZIqouAuBfLK8HzdY2no
jsCfCYRDP9lebEHgGv/mzWHivDC7SPLwUyGz0IGrgHn8s2V5RdtTyB7mqwQb7z2g
1CdrZSdavh1OuD2vorj5QzX04KuwkfaQO4E9oMPMGlrWiOay/xgrNmXWqviNobM9
HopZ9RsyMhgnCRsAex4XnKfaMcA4Dpr9xOQqMCRMSkDQpiMUwR7MB8TX4HsH1bqA
a5xEhYw9bvqXIgCdlR8y0CqVxbhZG3pUZOvh4Kxij6Tg4sSZsMU=
=aa4L
-----END PGP SIGNATURE-----

--lqkVykvHswtHnRjnycHIYzZcPqvZt7Rrr--

