Date: Wed, 25 Aug 2021 14:36:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YSY5a/eqVste+ZB4@...1296...>
References: <20210825040122.14244-1-selva.nair@...277...>
 <20210825040122.14244-2-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Kp8GZ2T6JkXtIc0N"
Content-Disposition: inline
In-Reply-To: <20210825040122.14244-2-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Permit unlimited connection entries
 and remotes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--Kp8GZ2T6JkXtIc0N
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 25, 2021 at 12:01:22AM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> Currently we allow a max of 64 connection entries and remotes.
> A larger number would allow users with 100's of independent
> config files for different end points of same provider to
> consolidate them to connection entries.
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>

The combination of this with the previous patch sounds quite useful
(=3D no longer distribute multiple different .ovpn for tcp/udp/... but
have them all in the same file).=20=20

I assume support in the UI is also already brewing :-)

There is one catch: I assume that this conflicts heavily with the=20
SRV patch (due to that one also changing connection entry handling),
and the SRV patch is overdue for final review and merging - thus, when
coming back to *this* patch, it might need a rebase.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Kp8GZ2T6JkXtIc0N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhJjlrAAoJEB2Cnv7KVigSboYL/1AMKvlU9pGWN5bXd9sJedrZ
tTxsQTXX+tJHOIrrYNQknkJYNQk/hdxdDFBCP9sDXz5RCAkkl/P589a+UK+ADxyc
WpEzpUXxlI+jT/8/axFCAQQ58+iy4Vxo7VcPZf5YoNBvUQ3N1S8WVA88BI53pEgI
FY0kMzc4M2KL7ZUhiRuNSEvUr063HGywBiLGd8wssw3+oWeFjdCz85Dm5FMN6DE+
d5erqTc8c8C076TVc+OfN9xfuzzyQPjUmIrv7FMu0KbSjAl7QaJYP/Pqx3qqcC0j
B1B+ebSUxRomYUyloWBeg6OSdaHAjyF8tuh0R30qqZcDbtb6ND7oKjZmtXq7gwWq
poM6lZMHlZaG4BcWnnDh2WxB8ZhXP/o0TP8YWduJVdCt9Dk88ILqUoT7XwHaHU5Q
lUBigCHXtYR8WFqdXhUgl/NTs0PiNJgAa/YkWVxnh8Q/fa+PTaRcr7CNFodI5inP
Kj2g+VguK+EPGRteGa5Sw3QUQdL+I73lzFIlDhVKQg==
=TS1R
-----END PGP SIGNATURE-----

--Kp8GZ2T6JkXtIc0N--

