References: <1494327032-3035-1-git-send-email-steffan.karger@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b2e1af67-2b5c-44ba-e8db-4d325d6e1e0b@...2080...>
Date: Tue, 9 May 2017 19:47:48 +0200
MIME-Version: 1.0
In-Reply-To: <1494327032-3035-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5D31ml9xgTv820MTgqcvFigwh4lChUcX1"
Subject: Re: [Openvpn-devel] [PATCH] Always clear username/password from
 memory on error
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5D31ml9xgTv820MTgqcvFigwh4lChUcX1
Content-Type: multipart/mixed; boundary="00RqPVjvVeNtf3kAUIeSNpf3wU3SrA3R4";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
	openvpn-devel@lists.sourceforge.net
Message-ID: <b2e1af67-2b5c-44ba-e8db-4d325d6e1e0b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Always clear username/password from
	memory on error
References: <1494327032-3035-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1494327032-3035-1-git-send-email-steffan.karger@...1435...>

--00RqPVjvVeNtf3kAUIeSNpf3wU3SrA3R4
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 09/05/17 12:50, Steffan Karger wrote:
> This issue was found by Quarkslab during the OSTIF-founded security audit
> (issue 5.4), we agree with their analysis:
>=20
> "There=E2=80=99s a special case where the client username and password ar=
e not
> erased when the server is launched without an external script or
> authentication plugin. While being invalid, this configuration does not
> raise any error. If the client transmits its credentials and the session
> is not established (for instance if the certificates chain has not been
> verified), these credentials are not erased from memory by the server.
>=20
> The likelihood of an occurrence of this issue in real life is exceptional=
ly low since an attacker
> needs elevated privileges on the server to exploit this kind of informati=
on leak. The severity of
> this issue is rated as very low."
>=20
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  src/openvpn/ssl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 1033e58..abf5786 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -2661,6 +2661,7 @@ key_method_2_read(struct buffer *buf, struct tls_mu=
lti *multi, struct tls_sessio
>=20=20
>  error:
>      secure_memzero(ks->key_src, sizeof(*ks->key_src));
> +    secure_memzero(up, sizeof(*up));
>      buf_clear(buf);
>      gc_free(&gc);
>      return false;
>=20

Feature-ACK, but code-NAK.

In key_method_2_read() there are a few places where `goto error;` can be
used before `up` is allocated.  This will make secure_memzero()
segfault, as it does not handle NULL pointers.  Or even worse (if the
compiler let this pointer point at a random address), which leads to an
unpredictable behaviour.

That said, I think we should fix secure_memzero() to just return if the
input pointer is NULL.  And even though most compilers do initialize
variables, I think it's good to be defensive here and initialize `up` too.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--00RqPVjvVeNtf3kAUIeSNpf3wU3SrA3R4--

--5D31ml9xgTv820MTgqcvFigwh4lChUcX1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZEgDEAAoJEIbPlEyWcf3yM9wQAMNK/mUaC243JnXurj3N4Pwn
Y1je1FTzRwCuzc8/pMF835zzjb1v/7S+nFVGelyDYEYwwDI7nD5zQ2Dy3qGGv6OD
0BbYC7BtUIZFkLEb1gUvpRHRFI7AjKXZSQszXluQWm42LnduUxd5UVf9vyBreILb
3t4+uGEghs3vXqF1ktT5G0WpHAHQ6A+bLsWCLqUeCn60s3/z1AMnS/hMlY0xdCVO
ADOIunmLuj8xkOi7uuTIJMVaXQA4NZ9UG2b7eyGeHHfsqXJn9fX0fGM3cCP/FC06
LM1rsyio388NQ1ff+ruGrKAtIYvzp3UJPy04o7bpZYktaTpw77+GeThhn7boIOQD
l1nQIftzi0QdEUzhwQOM0oaK2RRQ1rj3gv1hZxLpQ9n3PrcVngqMeFAG02Dr4Tlk
T6N7elPO+AmWQme/n0kVRqJ8yiHzUzNsfVCnfNIrSkyHC46AQeXUYJW9ZqB8RGAN
t7GXtPyuW2GnEifh1ZZfTV4I6TfHxd1eaDNbX58t0Bv/tEOtJDXCn1MuRwLiwWyj
8TFu1IQIEmaqiCC/ESvrlhGaa1zKCPdsfivyNu5XPKbL2O4uBoG/TYqKk1xBtNHz
iiUbdCZ/zBPlgci7fCbT2FwcQDFN6wU8VSEJ3Rs4wgAjiMtc6QkJSq2pHWwHno4g
naX6vKQku0crcnlfhdXf
=E5F2
-----END PGP SIGNATURE-----

--5D31ml9xgTv820MTgqcvFigwh4lChUcX1--

