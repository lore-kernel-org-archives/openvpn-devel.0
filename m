Date: Sun, 21 Jun 2020 10:53:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200621085315.GN1431@...1296...>
References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-4-James.Bottomley@...2316...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LXS2t7ZUR2/oZAZn"
Content-Disposition: inline
In-Reply-To: <20200528225920.6983-4-James.Bottomley@...2316...>
Subject: Re: [Openvpn-devel] [PATCH v6 3/3] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: openvpn-devel@lists.sourceforge.net

--LXS2t7ZUR2/oZAZn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 28, 2020 at 03:59:20PM -0700, James Bottomley wrote:
> Testing engines is problematic, so one of the prerequisites built for
> the tests is a simple openssl engine that reads a non-standard PEM
> guarded key.  The test is simply can we run a client/server
> configuration with the usual sample key replaced by an engine key.
> The trivial engine prints out some operations and we check for these
> in the log to make sure the engine was used to load the key and that
> it correctly got the password.
>=20
> Signed-off-by: James Bottomley <James.Bottomley@...2316...>
>=20
> ---
> v5: do not hard code dynamic library extension into openssl.cnf (MacOS)
> v4: add OPENSSL_config(NULL) so debian checks will work
> v3: added this patch
> ---

So, how can we continue with this one?  The engine key code is in, the
unit test code not.

Arne, James, can we converge on something here?

I would like something "as simple as possible", aka "little configure magic"
- if that means "MacOS engine is built and loaded as .so and not .dynlib,
but the test passes" I would prefer it over "more configure.ac magic" -
but if this is what it takes, I'm fine as well.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--LXS2t7ZUR2/oZAZn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe7x/7AAoJEB2Cnv7KVigSa7gL/AqR9X6H+e46VRLseYkfYr6G
lTX2fxMSmpJz84xZS0KzUEPS/lx/sObzpi2UTjlVV23P2E0RF45VfBSvZf0NfShw
tORjFUSO1jV9UcwseBWH3+zj4Y9Sae9kEmC8yB7PaF4cvq7utcQkN0ZRXHKpvJXv
O2PJ3XD3rvwrVLWcms+3p4iPKmQOf3tEQ8GOkXdTXeX+dB2xtBPttddeiYKllIU+
B5tacnFi+3gi3z+DQkLu0KOGnbVpv5drlUUYWx85dqG5d7u0hEuikOYvd6rAX8Kw
ps/vvXNJrDdA4FnXHcBZ/sOWbNCr59eQaEz6nValtGVkghfw3iTKu58jtFU2sTub
CJqw2fyYLqNQggq8hhKYl399hhnXBWKeFTksS8oggpKSRtgBFC4yxVmi82TEJCxX
XV0aIAFaPkYadJDl4wLeQ52vP/MvwwL/rIKVZrV3MireQoF5cDSthPeHQUIzReBN
iM3qYNDIl1i8yqkNpzSQcWt+AXVYwhcNoFU+3oq9iw==
=JrhA
-----END PGP SIGNATURE-----

--LXS2t7ZUR2/oZAZn--

