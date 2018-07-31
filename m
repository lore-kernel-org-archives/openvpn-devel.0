References: <1494859203-21904-1-git-send-email-selva.nair@...277...>
 <1511228605-23207-1-git-send-email-selva.nair@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <50c2b9c5-4558-1999-83e7-456c1f9bbb5c@...2181...>
Date: Wed, 1 Aug 2018 01:21:35 +0800
MIME-Version: 1.0
In-Reply-To: <1511228605-23207-1-git-send-email-selva.nair@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WwieNrjZrsVcsgCy5CVqI1j9K7H0Z1EM6"
Subject: Re: [Openvpn-devel] [PATCH] Correct the declaration of handle in
 'struct openvpn_plugin_args_open_return'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WwieNrjZrsVcsgCy5CVqI1j9K7H0Z1EM6
Content-Type: multipart/mixed; boundary="ysWVgrFYmLVZldMCUzoJ6QmWe6O0g6Tx5";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <50c2b9c5-4558-1999-83e7-456c1f9bbb5c@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Correct the declaration of handle in
 'struct openvpn_plugin_args_open_return'
References: <1494859203-21904-1-git-send-email-selva.nair@...277...>
 <1511228605-23207-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1511228605-23207-1-git-send-email-selva.nair@...277...>

--ysWVgrFYmLVZldMCUzoJ6QmWe6O0g6Tx5
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 21/11/17 09:43, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> - This is an opaque pointer so the change should not affect
>   existing plugins. But it makes the code consistent and clears up
>   the documentation as the handle pointer is treated as of type
>   "openvpn_plugin_handle_t" in the rest of the code.
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>

Will make some noise during application (git pw patch apply 87), such as:
"Falling back to patching base and 3-way merge..."

But it won't generate any conflict.

Acked-by: Antonio Quartulli <a@...2181...>



--=20
Antonio Quartulli


--ysWVgrFYmLVZldMCUzoJ6QmWe6O0g6Tx5--

--WwieNrjZrsVcsgCy5CVqI1j9K7H0Z1EM6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltgmp8ACgkQB6U8WA7y
zXTKEA//fczNleCHfy6ywFe3LACUCOlQ09EM0ALgRZ4pCwpHl+BNO3fuUXVUVH/k
2HNpZNufIAtY/ZFqAFxlRLJKsEBbxkiAtlZdgyt78Xx5//fBtNwDlHHZEc1bWimA
hoo71hSbRbXKXLr9C/vXMAwCbfgc4FZv1nMDqMVE/+g+FVTtI1Xww06QhpY/kX7N
WCnS1KwjBVyjRBRJjr43OJJzIBve3Zzpy9JlvTtfAjFptb2raH/5obLpP6VnBFlc
e68uRibu2ZzNjEnuSXdprHxBxOKfIgPISWXijnXeOxO/oXXflewYInxE7UXULhDK
VZxHpbAE1ckjnLPa/O6IIbTx8nczxQviP2wy7vkkpN+MR0hNjXVGTDlh103wgTtW
sWeCAFCWbSD/HbH/bKlC5wgIwB3P2l67WyTa0LN83GlTG4EesjYOiQsUmprPt3DA
MxSCWxYC/dwRrl2aggwf74q8vq/NS7LpK8VXpbwcyxYvAqb5WnKgnYnyZv3709q3
qKTJlD7XFwdi7GyEmr8+uCI4+/++McbtjY/JkiU0OMYMo5bqEfRqfrpQXWpJF4cY
g8zvsxts0T3WV8dRJnX5rgHFbLMU2Bb9bJPJiLWUx6GxDVmkW2p6gWEmkohatNYo
Jm6G/apYaEs7Zgf9vdVjXAu2XXGaLTae/DA58CcjZMSMItImHiM=
=jBbg
-----END PGP SIGNATURE-----

--WwieNrjZrsVcsgCy5CVqI1j9K7H0Z1EM6--

