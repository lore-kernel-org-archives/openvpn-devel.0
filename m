Date: Mon, 27 Mar 2017 20:35:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170327183502.GJ93896@...1296...>
References: <ec21d010-67a3-0ff1-3c2a-d5db08039e45@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ubSmDk4JQLoqi+H8"
Content-Disposition: inline
In-Reply-To: <ec21d010-67a3-0ff1-3c2a-d5db08039e45@...277...>
Subject: Re: [Openvpn-devel] building HEAD + openssl 1.1 api fails @
 "crypto.c:823:32: error: invalid application of ???sizeof??? to incomplete
 type ???cipher_ctx_t"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: PGNet Dev <pgnet.dev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--ubSmDk4JQLoqi+H8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 27, 2017 at 11:25:50AM -0700, PGNet Dev wrote:
> noting
>=20
> 	openvpn fails to build with openssl 1.1
> 		https://community.openvpn.net/openvpn/ticket/759

Guess why that ticket is still open?

> 	[Openvpn-devel] [RFC PATCH v1 00/15] Add support for OpenSSL 1.1.x
> 		https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg140=
75.html

... because that is a patch *series*, and only half of it has been
merged yet.

So it is perfectly known that it will not build with 1.1 yet.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ubSmDk4JQLoqi+H8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY2VtVAAoJEB2Cnv7KVigSt2IMAJcsUWgQFXDTM21RaCXHX4nI
IIWfPl6zJUtiALif830L7XEkhGHq6TzkOtu82jZP0BVbWXeYbung1Xn4N5kF+vm/
/V+AK5Y8cwT4S8ULQwLPP7EKLbqPvtjBmaMx9mC/K+5DZatUbq8LzVtzyecBduNM
4u8iW7b5QVlEKwvxcBCRVz7jzDrG6hbLn5kqD1ySzNgU84SozJpirQdYkAHQi4f3
YXhvJvKCXu6v+ABjIFa0mCEvpiJ/F0K6rakknllcA8UKhRifIdKSh57AshXrS25v
ad+4wK5vKTVEzOz8fc42M1SNT0m8+0zHFg8m4v0SLdv+vUHPiKVHYkADbR3h3YYp
E7mmMvcM4VJj8hZtbZvsxnJX97bOPjnc1qccLuq4/7oRyFz+DTZlakvwX9B9rl65
JXAXgXabW4teWzaakVmnMuLQ3Q6n1qjXgVBZ44jox7kngIGIQKk/8rQZY1kThRHV
y0k8gVuXb/Zf3l94PxJGg//RkNpcu4BIvIq2meRKUg==
=CPAG
-----END PGP SIGNATURE-----

--ubSmDk4JQLoqi+H8--

