Date: Fri, 28 Jun 2019 23:03:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190628210334.GU1097@...1296...>
References: <CAKuzo_j6F2+_JxosdVF3iB4kzWsR7Wq2FT8Vgi9Cg3yvT_A1JQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cyl6hb1YSGs8e3xM"
Content-Disposition: inline
In-Reply-To: <CAKuzo_j6F2+_JxosdVF3iB4kzWsR7Wq2FT8Vgi9Cg3yvT_A1JQ@...278...>
Subject: Re: [Openvpn-devel] Using AllowNonAdmin in the advanced options of
 tap adapter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cyl6hb1YSGs8e3xM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 28, 2019 at 04:51:47PM -0400, Selva Nair wrote:
> Would that mean we can assume that always allowing all users access to
> the tap (say, using the service to open it) would not be a regression?
> Or are there folks who use local builds of the driver and expect
> openvpn.exe to respect that setting?

The whole permission model for openvpn on Windows has been funky at
best "forever" - open tap device and setup IPv4 address by means of
DHCP could be done "by everyone", while installing routes or setting
up IPv6 then failed for non-Admin accounts...

I'm not exactly sure what you are proposing, but aligning this with
wintun and using the service to get access to tap6-windows sounds
like a reasonable plan.  With a registry key to re-enable "full=20
access as today", for compat reasons.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--cyl6hb1YSGs8e3xM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdFoClAAoJEB2Cnv7KVigSQnAL/3UakjFK9vrq9IVBpR7KZAg+
Qy13UDz1FOS+Va3PULrLeybjKY1oIFBVSQJK4xB0bdv4pVUxI/9zXioCxgslOFR/
7N4kE3nWItiSvQo06+8GiM5vP0gxkIol0gglZt3CaaZBkp+xWFV/GWLh2oFPDwsD
07AM6PtKcI6b8x1y8NLxK8M20nR4pV8G6pqYb2ZfoSP0FPpfhOiOHw42jKn/+mWE
5+YxRuERwbMnvd8hvnCU5H//oyzgQI7OCw07mvT6K749FzuAqwdUcCSl/H90bY1X
fI7cvvbyk5a+tHRBh342VBf8aJsyjt4OGBKvZs6zPg0EdC+k35h/Bq2ijzifnvcS
Vv6DuRFz24NZxzdEe9HBNhPe/4EA8EPglBWn3d8qN9P0VZrvb8kcZR1bIbovkB2Q
XQQ9zsyL2KOfAjUx32hUnPLzkqxzLfe4NUb6MJD7lvUYv5GC5cFRk9/r0lChBi54
wegrxhg98TH4mKb+MvWzjFTy3M2sLe4yHDPV6yLOGA==
=BYdX
-----END PGP SIGNATURE-----

--cyl6hb1YSGs8e3xM--

