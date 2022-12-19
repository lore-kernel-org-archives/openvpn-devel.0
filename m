Date: Mon, 19 Dec 2022 14:05:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y6Bhhjs4J7rDukOl@...1296...>
References: <20221218192203.1214943-1-selva.nair@...277...>
 <Y6BXURT8t2+o++1O@...2685...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WkVE/fQpkoRlEd23"
Content-Disposition: inline
In-Reply-To: <Y6BXURT8t2+o++1O@...2685...>
Subject: Re: [Openvpn-devel] [PATCH] Do not include auth-token in pulled
 option digest
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

--WkVE/fQpkoRlEd23
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 19, 2022 at 01:21:37PM +0100, Frank Lichtenheld wrote:
> > +        /* peer-id and auth-token might change on restart and this sho=
uld not trigger reopening tun */
> > +        if (strprefix(line, "peer-id ") || strprefix(line, "auth-token=
"))
>=20
> If I interpret this correctly, this will also exclude auth-token-user, be=
cause you didn't
> add the space after the option name like for peer-id. This should either =
be reflected
> in the comment above or changed.

Well spotted.  For "less magic, easier understanding" reasons I'd actually
include it explicitly

 +        if (strprefix(line, "peer-id ")
              || strprefix(line, "auth-token ")
              || strprefix(line, "auth-token-user "))

(with blank) - yes, Selva's original code does that, but more magically.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--WkVE/fQpkoRlEd23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjoGGGAAoJEB2Cnv7KVigSqMAL/Aj1Wkuu45rPwO3TRTLzF594
rWyzowrryfDmMoFuhmuYYlJ1dXGszcJTHd02U6XmO+ontxrML7+hyttrz6cg4xuB
D6FT9B1Jq3S+OIEFNwOyzYFc3E5PepQI5n8llNoiJZ6z3aJlFZLDWED9c7O/bWp7
NDiLHifCR1Bx59OQRfVMRNfUcTfYjPjCOf3D+mFDCc4zNVGzwl66kprmXoTiihPm
sVNOil2mrbF6uXBQ7/OJhL3XdimevYq9muNUHQ9w7v92Zezt/QXpuGE2Q9k6daTh
mtdoeh9RwewcPm/y5PbuI76pQ1Vttp1GXMQYDmGBPYLUA8UKcZTXiI9quA8JoMXG
Mow4dT2Zp0cJyhI5rj0JljYVNEMnkuT1lhMlT2dZ+n3FAmb+y55ZiD8OZnPCUUmr
7kltAVfY4gQS/a4uE7Zmb0mmv8HyqpHD8k2TMQFRi4egPwlr+523VyEXLPP2L+Db
lWaEe2pcxXYP5ZYB/Mydy/gdqeTo6Hk4EXeyBgesZQ==
=uYzy
-----END PGP SIGNATURE-----

--WkVE/fQpkoRlEd23--

