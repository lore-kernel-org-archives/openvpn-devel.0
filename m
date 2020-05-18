References: <20191109151306.18597-1-arne@...1227...>
 <20191109151306.18597-5-arne@...1227...>
 <6609920b-5fb5-ce31-14fd-ef4743921d42@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e4f846d1-b920-ae08-f9b1-2024c9164d99@...1227...>
Date: Mon, 18 May 2020 16:15:55 +0200
MIME-Version: 1.0
In-Reply-To: <6609920b-5fb5-ce31-14fd-ef4743921d42@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MiReC3Fj0gdCEwSSsvPQDzCjb4L6QksP0"
Subject: Re: [Openvpn-devel] [PATCH v2 5/5] Implement forwarding client
 CR_RESPONSE messages to management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MiReC3Fj0gdCEwSSsvPQDzCjb4L6QksP0
Content-Type: multipart/mixed; boundary="eKmytytKR9IXBKqMl3EENkwd3JVNFcaud"

--eKmytytKR9IXBKqMl3EENkwd3JVNFcaud
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>=20
> This will accept an empty CR_RESPONSE from the client.  Could that be an
> acceptable reply from the client?  My initial thought is: When the server
> sends a challenge to the client, it should have a "meaningful" response. =
 I
> struggle to see where an empty response would be meaningful.

Enter your second TOTP to gain additional privileges. User jsut presses
enter and you then only get bare minimum VPN access.

>=20
> And by "meaningful" I mean in the broadest interpretation.  Invalid
> authentication response, invalid data (not base64 encoded, etc) is meanin=
gful.
>=20
> I'm also wondering if it would make sense to validate the base64 response=
 as well.
>=20
>=20
> To summarize all patches:
>=20
> - They all look reasonable and fine, but there are a few things to improv=
e.
>=20
> - We should avoid the SSO terminology in the implementation; it can be us=
ed
>   for a much broader authentication scope than just SSO.  Patch 2/5 also =
needs
>   to be revisited, despite the ACK I've already given.
>=20
> - Documentation could be a bit better.
>=20
> - It would be nice to have a really simple test "module" for the server s=
ide,
>   which would just give challenges like "How much is X + Y?" where X and =
Y are
>   random numbers (1-10) and doesn't really need to account for multiple
>   clients at the same time.  But I do realize the management interface ca=
n be
>   annoying to work with from simple scripting tools.

I would rather give an example using connect/auth scripts and then a
script hook that can be called on receiving the CR_RESPONSE message. But
I want to wait until the deferred client connect patches are in before
doing that as they might touch the same code.

Implement a small e.g. python based management interface might also be
possible but it would be an example that does a lot more than just that
because you a bit more to have a something working with the management
interface

Arne


--eKmytytKR9IXBKqMl3EENkwd3JVNFcaud--

--MiReC3Fj0gdCEwSSsvPQDzCjb4L6QksP0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7CmJsACgkQFRhsZwKx
RFSLeA//T3b7MW5JRXiCTXEn7s852gtylLxGPukGLPaPeyWtvLObT6RQrSnmcprO
wtnh+JTDEFzdRNvQsS8vi7mj0HJetL+UFPAIDzIr/OYV8WXHuRI4muSjW1Uep6vM
UchE4PzuCcpPhb4eMxG7GvnlZ+3EJGJglYHMGCzGs/jv+iT8OKpOZBQj9/UkYk0Y
ZXxzZkyvSyHHhr/O4tHKHXasqC5jJHunBPAh3nyHn8qO9l7N1Zk8KR9mF6m8BDmC
18wSYc/WYMHhPAb+aDwtz7Q3k1FtGXdjDZdzDK6+gyYB/KX6zef7Wrz2pew0tyfY
83hYUnQVPdUYs01PXTUez5LzYuPwnQgIMIWZiC4j1XkqDbvM3xZs/YTEW+N6XbKs
1VUcqn4lkxljnkJDyeokGDSAL9zdzG7ttCpW0s9xUe4JAuoWh77a6e16W0TelWZk
lTM1dGFtxSYBFo9Jdg4pcRi/y4GU8FzDwRboGro5tzxyjXEpbYb6AIEMT/TOKFEB
j40cHjVBKLJGXvHbEbLkJoQftjiVwV/SLNI033ho67iKL9048RIFVcv5RFuYlXj3
BqP4DIb7S9bMpI3qfBlJUAkxfb51jlgZJzLvNZ3NxIn08iv2lL6b5KUZEKkm+/YK
cqS7UPJkzNjOZHTMRPYPcU4cE3JYwfK0cxxJMzPqLgk4BZlGbCo=
=g+Mi
-----END PGP SIGNATURE-----

--MiReC3Fj0gdCEwSSsvPQDzCjb4L6QksP0--

