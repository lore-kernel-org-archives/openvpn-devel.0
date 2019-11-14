References: <20191114102205.22429-1-juliusz@...2525...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <fb18ba3c-7ee6-46ba-04e0-5a9a14b955d0@...2080...>
Date: Thu, 14 Nov 2019 12:25:58 +0100
MIME-Version: 1.0
In-Reply-To: <20191114102205.22429-1-juliusz@...2525...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hEujMykVhU0mBKwIVEIG0rd1kjlZzRJ52"
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL with OpenVPN v2.4.8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net
Cc: David Garske <david@...2525...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hEujMykVhU0mBKwIVEIG0rd1kjlZzRJ52
Content-Type: multipart/mixed; boundary="d0JcyIqCSwIvQ3dEs5wHiZ0pSZLJT7QBN";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Juliusz Sosinowicz <juliusz@...2525...>,
 openvpn-devel@lists.sourceforge.net
Cc: David Garske <david@...2525...>
Message-ID: <fb18ba3c-7ee6-46ba-04e0-5a9a14b955d0@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL with OpenVPN v2.4.8
References: <20191114102205.22429-1-juliusz@...2525...>
In-Reply-To: <20191114102205.22429-1-juliusz@...2525...>

--d0JcyIqCSwIvQ3dEs5wHiZ0pSZLJT7QBN
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 14/11/2019 11:22, Juliusz Sosinowicz wrote:
> From: David Garske <david@...2525...>
>=20
> wolfSSL:
>=20
> Support added in: https://github.com/wolfSSL/wolfssl/pull/2503
>=20
> ```sh
> git clone https://github.com/wolfSSL/wolfssl.git
> cd wolfssl
> ./autogen.sh
> ./configure --enable-opensslall --enable-des3 --enable-crl --enable-certg=
en --enable-certext --enable-aesctr --enable-sessioncerts CFLAGS=3D"-DWOLFS=
SL_DES_ECB -DHAVE_EX_DATA"
> make
> sudo make install
> ```
>=20
> OpenVPN:
>=20
> ```sh
> autoreconf -i -v -f
> ./configure --with-crypto-library=3Dwolfssl
> make
> make check
> sudo make install
> ```

NAK.

This patch adds a new feature to the 2.4 branch.  We don't really want to do
that, especially if the change is intrusive (13 files changed, 108 insertio=
ns
<< that is intrusive).  WolfSSL support will at best see the light in the
coming 2.5 release (At the hackathon we aim for late 2020Q1 or 2020Q2)

In previous rounds we have asked a lot of questions; there has been no real
responses to those.  This has not even been touched in the relation to this=
 patch.

One good thing I do see, is that it seems to try to use an OpenSSL support
layer in WolfSSL - which is good.  But then I wonder why we see additions l=
ike
this all over.

+#ifdef ENABLE_CRYPTO_WOLFSSL
+#include <wolfssl/options.h>
+#endif

In addition, the change in configure.ac with all the AC_DEFINE lines, tagged
with "Emulate XXXXX since these are defined as macros" is also making a lot=
 of
mess.

And then comes the most critical point to all of this:  Who will maintain
WolfSSL support in OpenVPN once this has been applied?  What kind of
commitment will we see from the WolfSSL organization?

The OpenVPN developers community will have an IRC meeting next Thursday (Nov
21 @ 20:00 CET, #openvpn-meeting on FreeNode [1]).  I strongly recommend you
to attend this meeting to follow up your request.


[1] You need to have your nick registered to join
    <https://freenode.net/kb/answer/registration>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--d0JcyIqCSwIvQ3dEs5wHiZ0pSZLJT7QBN--

--hEujMykVhU0mBKwIVEIG0rd1kjlZzRJ52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJdzTnNAAoJEIbPlEyWcf3yVOgP/2orw5WG/2jbCGxCHQWjZMTS
rPNgP0IQ0RNuR6AOhAOVNY3vURzkay+hxgyrgGOHV5FIXkwOGO0bcLMpmaAPd8vo
ga6v8Hbqqwm/oHUd1JcmxwFz166DaSwxmztEr3TfUQkAYQBRlmauhuCjBz4tZ56s
MZari1uuUWlC5WCX80cf9p3uWBHoc0kEyuwQJWBAdJ0d0so3H20Vk/jJqzkV34eE
MAgXb3Pjgqv3lSERQNXxCgZez+l/nAkDBYD53XgcR4UHFkJ7z86F5gzefwC1lgVT
8FOIWz8W8Lj3w6Y7rRd+5jmcORcW/Kc3uQ5lixg3+0Q/g5uYTMq03MnfougXjvFJ
gbo1kUE3L044WGu+uAyA9HW58n7RlJvZ7u6J6pgcZdEwgsLbwmDPAFa8z/am4o6W
hPDlsqUujBX6bJT5pu1wdYBGXuHVA9gENGtoPpZzMa04uV3wrgwMJV56mRqy/ljE
hRUIIyXcuUFwov7hI5luak1B8+62PRby0ALF9WQIXC+TbSM+WEqTkILGzGnQZ+D0
YwOR9veZVGoRyOEVJTq+KClRoCUbQeQWfnR/1JRSIYfoMkQECv4+hk/jGW8OsrOU
6RNLrJdskiyU0fUjo/YxKLp5U8K2c8evsKg/vYIjX31bGcHrdMTnz3QxCtX+zVw3
TJtk67ul33/AUxFP+Zlc
=nr7r
-----END PGP SIGNATURE-----

--hEujMykVhU0mBKwIVEIG0rd1kjlZzRJ52--

