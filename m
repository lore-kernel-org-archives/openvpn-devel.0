Date: Sun, 9 Oct 2022 09:54:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Y0J+TKLvwri5dioo@...1296...>
References: <0M5MIN-1VhSEh1NZH-00zUTO@...1825...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fw8uR5uKXTUcUCFr"
Content-Disposition: inline
In-Reply-To: <0M5MIN-1VhSEh1NZH-00zUTO@...1825...>
Subject: Re: [Openvpn-devel] [PATCHv2] Allow inlining of --auth-user-pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

--fw8uR5uKXTUcUCFr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Oct 12, 2013 at 06:30:36PM +0200, Davide Brini wrote:
> This patch allows inlining of the --auth-user-pass directive, so it is now
> possible to do
>=20
> <auth-user-pass>
> myusername
> mypassword
> </auth-user-pass>

So, after close to 9 years, we finally managed to get that functionality
in, hooray :-)

commit 7d48d31b8226d5e
Author: Antonio Quartulli <a@...2181...>

    auth-user-pass: add support for inline credentials

commit 39619b7fab213e9
Author: Antonio Quartulli <a@...2181...>

    get_user_pass_cr: get password from stdin if missing inline

this will be in 2.6.0, to be released "this year".

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fw8uR5uKXTUcUCFr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjQn5LAAoJEB2Cnv7KVigSh0sMAJr5p5rXQbiq4j/r8XMFPnY3
3TKM0qWNzIHKH0mNLYcGviSUUXLnH5TTKVvUs6RPKrqYu6NwDRENTXjtd4k4Q8mr
XhRieoBLBxc9cwzsUKnr6M8oHSYBs4GAVXbxCJ4IqmZ9AzzTmYzS3bD2Cx8HGtEX
jZ99A8gRD4WDUJbeDAjxbL52oKFF/ikUbamZRb2mrYTexyI6ewKZeGpkSq4U1Rqp
RyZFZCrV2lto0BTLWgjuaCcFrPSDBQ87w5DU5eiDAcJSX8UxP90l5vKziICj8UNC
01ylNGbAfje7QJHVahJ+vR2RlG9JTiT/P5ieGqhkIlxE2zGIhvGpZ8W2qm/O6vZ3
4Uhyfte+XOg4pj6F348HDSQFCKiJmWiuL+bxP6ijG+/sFi5OyuYDwEO/FvfaKseB
b/EdioFhZDqTF9QleXMW0hMNaxAG2gARrkm/9nzVjuqegGjMf6Gc6B1hhWdNXToC
06YXYhTB8J8sMEzO9jVDlvoK78V+/My4liiPcG+u8g==
=vBzl
-----END PGP SIGNATURE-----

--fw8uR5uKXTUcUCFr--

