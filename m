Date: Wed, 20 May 2020 07:28:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200520052822.GD1431@...1296...>
References: <20191109151306.18597-1-arne@...1227...>
 <20191109151306.18597-5-arne@...1227...>
 <6609920b-5fb5-ce31-14fd-ef4743921d42@...2080...>
 <e4f846d1-b920-ae08-f9b1-2024c9164d99@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ROahZPZStIPlZxrz"
Content-Disposition: inline
In-Reply-To: <e4f846d1-b920-ae08-f9b1-2024c9164d99@...1227...>
Subject: Re: [Openvpn-devel] SSO patchset / testing server side mgmt if
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

--ROahZPZStIPlZxrz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 18, 2020 at 04:15:55PM +0200, Arne Schwabe wrote:
> Implement a small e.g. python based management interface might also be
> possible but it would be an example that does a lot more than just that
> because you a bit more to have a something working with the management
> interface

It would be extremely cool to have something simple to drive the
management interface on the "test server" side.  There's so many code
paths related to management that we currently do not test in an=20
automated way, or hardly at all.

(Of course it would have to be perl, not python :-) - seriously: as long
as it works and is readable, whoever implements something gets to choose,
just don't expect me to maintain anything pythonish)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ROahZPZStIPlZxrz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJexL/2AAoJEB2Cnv7KVigSLjQMAIIyDtM4MrlvmMRPncB+BlMi
rIpAx3cezzXXrBDFsL/o7P7dH0JZzOJHucEKD1HL7VVxSGFkMwEGudqrHEFwVdXg
y+FWrUccXC+ln8NQSnUep2wpjIAdaqTynk1L6pPQAaaKQbuOQzJ1EaKt90aGpfsb
cg9Zge0eqBZQbJxvMR6Lq9nwjYmE0KvaMmH1PKVjqvrmzG/v2uH5gk1gC7GL1SI4
K6UTnbermjmZpLEMuZ3bTzyvxNEohRxigY8FbY5Gjj02f7uub7to9Whv2Z43wlbZ
8QzrumeLZgx8IDIFkeqG5x1ZxBQl0seRRLAG7CFmQy0HnT6YemALlzZvbxD8Sz6m
XTJWqjW45q71GyeYfjM5hMza2Afhl/LeQ6oWTrC5cCBO/vuceIaVQ2ByfRG7CuVQ
Ah4gnTZ0YxiGzIWS+S9ltxDQQKwwaX8ZrtzOybhm0mkyPqhIqyFdZqMhikmy958s
TUIW6RvovRRuL9nyOOpoQ4XxCK1xiTQvbWPVZw/DEQ==
=957a
-----END PGP SIGNATURE-----

--ROahZPZStIPlZxrz--

