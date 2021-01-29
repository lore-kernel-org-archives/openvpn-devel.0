References: <20210125125628.30364-1-arne@...1227...>
 <20210125125628.30364-10-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a4ad13e6-dfbe-2b1f-c818-10f2c87218a6@...2080...>
Date: Sat, 30 Jan 2021 00:16:52 +0100
MIME-Version: 1.0
In-Reply-To: <20210125125628.30364-10-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="umsqknBJX2uAhyg9ZnAmkHRWkOcrLgqCP"
Subject: Re: [Openvpn-devel] [PATCH v2 09/11] Implement deferred auth for
 scripts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--umsqknBJX2uAhyg9ZnAmkHRWkOcrLgqCP
Content-Type: multipart/mixed; boundary="BPt6XckEHCyxMmeuMBrMrxOPhv4nadTNE";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <a4ad13e6-dfbe-2b1f-c818-10f2c87218a6@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2 09/11] Implement deferred auth for
 scripts
References: <20210125125628.30364-1-arne@...1227...>
 <20210125125628.30364-10-arne@...1227...>
In-Reply-To: <20210125125628.30364-10-arne@...1227...>

--BPt6XckEHCyxMmeuMBrMrxOPhv4nadTNE
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 25/01/2021 13:56, Arne Schwabe wrote:
> This patch also refactors the if condition that checks the result of
> the authentication since that has become quite unreadable. It renames
> s1/s2 and extracts some parts of the condition into individual variables
> to make the condition better understandle
>=20
> Patch V2: add refactoring of the if condition
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   Changes.rst                         | 12 ++++
>   doc/man-sections/script-options.rst | 14 ++++-
>   src/openvpn/ssl.c                   |  2 -
>   src/openvpn/ssl_verify.c            | 86 +++++++++++++++++++++--------
>   4 files changed, 89 insertions(+), 25 deletions(-)
>=20
> diff --git a/Changes.rst b/Changes.rst
> index 2a2829e7..188bd8ab 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -9,6 +9,18 @@ Keying Material Exporters (RFC 5705) based key generation
>       the RFC5705 based key material generation to the current custom
>       OpenVPN PRF. This feature requires OpenSSL or mbed TLS 2.18+.
>=20=20=20
> +Deferred auth support for scripts
> +    The ``--auth-user-pass-verify`` script supports now deferred authent=
ication.
> +
> +Pending auth support for plugins and scripts
> +    Both auth plugin and script can now signal pending authentication to
> +    the client when using deferred authentication. The new ``client-crre=
sponse``
> +    script option and ``OPENVPN_PLUGIN_CLIENT_CRRESPONSE`` plugin functi=
on can
> +    be used to parse a client response to a ``CR_TEXT`` two factor chall=
enge.
> +
> +    See ``sample/sample-scripts/totpauth.py`` for an example.

This sample script is not yet added; but I don't think it matter much at=20
this stage and in this file.

> +
> +
>   Overview of changes in 2.5
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>=20=20=20
> diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/scrip=
t-options.rst
> index 03b3dd77..50edd986 100644
> --- a/doc/man-sections/script-options.rst
> +++ b/doc/man-sections/script-options.rst
> @@ -90,7 +90,19 @@ SCRIPT HOOKS
>=20=20=20
>     The script should examine the username and password, returning a succ=
ess
>     exit code (:code:`0`) if the client's authentication request is to be
> -  accepted, or a failure code (:code:`1`) to reject the client.
> +  accepted, a failure code (:code:`1`) to reject the client, or a that
> +  the authentication is deferred (:code:`2`). If the authentication is
> +  deferred, the script must fork/start a background or another non-block=
ing
> +  operation to continue the authentication in the background. When finsh=
ing
> +  the authentication, a :code:`1` or :code:`0` must be written to the
> +  file specified by the :code:`auth_control_file`.
> +
> +  When deferred authentication is in use, the script can also request
> +  pending authentication by writing to the file specified by the
> +  :code:`auth_pending_file`. The first line must be the timeout in
> +  seconds and the second line the EXTRA as documented in the
> +  ``client-pending-auth`` section of `doc/management.txt`.

Doesn't the auth_pending_file need to be 3 lines?

--------
$timeout
$method
$extra
-------

This is what the plug-in is required to write to the file, which the=20
write_auth_pending() Python function in the totp example in patch 11/11=20
also does.


> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index b9647c1a..fc9f1d2e 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
[...snip...]
> @@ -1223,25 +1223,61 @@ verify_user_pass_script(struct tls_session *sessi=
on, struct tls_multi *multi,
[...snip...]+#ifdef ENABLE_DEF_AUTH
+    if (retval =3D=3D OPENVPN_PLUGIN_FUNC_DEFERRED)
+    {

Didn't you kill ENABLE_DEF_AUTH in commit 99d217b20064e7fef9 ?  I had to=20
remove this #ifdef to be able to test it with the totpauth.py script in=20
patch 11/11 (with patch 10/11 applied as well).

Otherwise looking good and works when removing this #ifdef.  But needs a=20
bit more polish.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--BPt6XckEHCyxMmeuMBrMrxOPhv4nadTNE--

--umsqknBJX2uAhyg9ZnAmkHRWkOcrLgqCP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmAUl2QACgkQhs+UTJZx
/fJBLA/+LrlYQQd7h0UBvSuYnyXDyPu+RmlbXq9CfJBR9/5i9Q0V9v2mgBC4p4tc
xE92yGAtG4ssfHE5M8SIe1Uaz5edsS9UJqSoOlPsdtqtwrwCTtBag9VSBi2eqoeI
i90I9cnruCmbHqEgwne4kvULIgCxWz9jTIGtRxObiPynYFf2qE0Eb91TRpb8kpJ8
C1tmJFRcDjfvUHbXmwNjfl5I71vnhkUBts+Jq6cIlFR8Ap2uDoL7qNK1eVNQ641E
9UhY4ceMdUMFS+LxZBYVVubbVJanH48qWQ3NobdiDm+eqNT65vTJ8EBNc9TMM5l/
usZDdPkGR+28ntRaBS4Y51ad65AKhimTGfeQBGwOSyKpJ0rbKwPmhBMOpNTEIqLc
3jXgqSXRJFn8Jk59NnALwI4k7bhnMZcXUJN/z7BFitfXnFuOwgM/y8ZOBDZhiKU2
ErmCWyTvGkcNpsjXfoxPfY7f7EYycboAHOaoU8jS3X3+0nbCG9JvMlZ/GC8MX5JK
cY84TQqV09bMk8wtVUyi8Snr85R0AI4nvVpKjEav1G3Ru2dutGMWIeSrmssrdBY+
XrnjluZfBmqqLwrgdbtOw3nkTfUSON59MUZkQHj/M3ddTzjDcY0H0CIqAu65ZQQf
LE6ZR2SCOhP+FLAu+RL5D1UPwapabv+5auLfzQM5WAKfH+L5bOE=
=/rLu
-----END PGP SIGNATURE-----

--umsqknBJX2uAhyg9ZnAmkHRWkOcrLgqCP--

