Date: Wed, 17 Nov 2021 12:45:07 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YZTrQ/YBrCznIiIh@...1296...>
References: <20211109144811.3426928-1-arne@...1227...>
 <202111101347.1AADl4hR038291@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qPZr8NJq7l8Npuhp"
Content-Disposition: inline
In-Reply-To: <202111101347.1AADl4hR038291@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Use TYPE_do_all_provided
 function for listing cipher/digest
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--qPZr8NJq7l8Npuhp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 10, 2021 at 02:47:04PM +0100, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> This is "v3 with the SIZE() change", and this change looks good.  Max
> has already stated "looks good and works", but wanted the sizeof()=20
> change which is now in - so taking his pre-review, adding my own testing
> (makes the "cipher" part of "make check" finally succeed with 3.0,=20
> yay :-) )
>=20
> The "load providers" part is not in, so I couldn't test
>=20
>   openvpn --provider legacy:default --show-ciphers
>=20
> yet... will come back.

As promised, I'm back.  "It works".

For giggles, look at "openvpn --providers legacy --show-cipher"...=20
(on a 3.0 build, of course) :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--qPZr8NJq7l8Npuhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhlOtDAAoJEB2Cnv7KVigSjTgL/3u32OtJzp4f93/Z/pBfq6Ut
q0ho1N2zRKMVOxQpmrXPAv+h9KHh94B5j4wp8/PZBbyGwHt238qQCVDireGNysr6
hR68XvompYbfyd4CR0GaVQopOl062Ins6ZZYV6/5BvfNzhJHHfFqLLOCI8l4jvW9
DEu2F2PGVGMv5Cl1yPcIe6RQnoNk9IxElKQTV4S4XKuPW2x9UVhabb1Ua3hdTCOY
eKMJtTyqDDZlQJ4iQuH/dsz2MvGwNW9B9oWzg8ApPKtLgMajFHWbX4D3Gh9kUjEa
0ssYtY3eoNCUFoCRqxtiMGaiC7tzY/xkoz2j9e25+WDos+/O/hC6mhkhAJZRvhSA
rcIBPEWfoeJtMhxiRzJC4PgGdZQzkAzsN4k7rqlI9cR4GKbOdmMm7jJnUB0iS1TD
7HP87RgGBPShD9sJqhaSObfoNtOMtY7OsWuJ1Wa0eiIutxj+HFdVxJvyWbPh3JIf
sQmv8B0FbdUIL4e/7lcrZvi77SZyKR8eLibJWJylPw==
=Uwee
-----END PGP SIGNATURE-----

--qPZr8NJq7l8Npuhp--

