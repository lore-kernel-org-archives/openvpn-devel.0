Date: Thu, 20 Feb 2025 10:52:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Z7b7dW__4SFXN5FC@...1296...>
References: <eac80c73-e702-4d5c-b90a-fdaf4edd74f1@...68...>
 <202502200950.51K9oVo6002589@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FfHAnJOmIYL7VlGl"
Content-Disposition: inline
In-Reply-To: <202502200950.51K9oVo6002589@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Document
 x509-username-fields oid usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: corubba via Openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FfHAnJOmIYL7VlGl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 20, 2025 at 10:50:31AM +0100, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> This is an interesting find :-) - if we can do this, we can as well
> document it.  Thanks.
>=20
> (I have not actually tested this, but "man OBJ_txt2obj" confirms)
>=20
> Your patch has been applied to the master branch.
>=20
> commit 9f17ad7c281360ec0e970af23f9ba0dc892665c6
> Author: corubba via Openvpn-devel
> Date:   Sat Feb 15 20:01:44 2025 +0100

Ooops.  My script merged this with the list-mangled From:, which my
pre-push-hook refused, so I had to fix the commit and the new ID is
now

commit 680ad840bda4f869d16dac38fd9fa6a643dc10c0
Author: Corubba Smith <corubba@...68...>
Date:   Sat Feb 15 20:01:44 2025 +0100

    Document x509-username-fields oid usage

(same content, of course)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--FfHAnJOmIYL7VlGl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJntvt1AAoJEB2Cnv7KVigSX/0L/185xmjcIWX44F7NgqgNyFEf
r1OFQ0ETvgnSS+3UiNg9f306CF3aoRIFFcU0mXCkalECikLLeJE713+LUUDBnHf9
UCkhHEdSr2apIHZ280CHzv6vlv+BUCyiM0o9DclAlZ9C4Veoef/cq/9Av8MyEW1V
2j2N7+i1hKPUU4OdrKFlPXutb5GV7XCv7TbHBbMDEjmq1JLdO/gvupEG78U663Eg
ci36Orj1GtivCka7iwWiWGDi+DN15WDqwRveKlDWCLyeds2tCmXdKUQndynGYyLO
f5y9+jNUzeustzvWtmWjhFh9/lwuH85ADtDoUL24knnwinEut9loV9Z+efoDT5jM
js0OlCrW0HU53Tvc8FOl9D+/zzlsCjPgoVvVI/13Sm9NwtZba5x/lHmeSKruHKjP
IvS8/qo2Zf4id3q0pbdNKeCU5wlB4ktW8PUwwv1+MiuEL7KzArJ4gvi4GpZxj44/
xneJOAca/CtqEPaFWYn4qtzsriS0JuhcKPsedK0UaA==
=NnuM
-----END PGP SIGNATURE-----

--FfHAnJOmIYL7VlGl--

