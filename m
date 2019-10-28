Date: Mon, 28 Oct 2019 19:19:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191028181937.GA78610@...1296...>
References: <20191009095200.9337-2-gert@...1296...>
 <201910091144.x99Bi8NQ038152@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <201910091144.x99Bi8NQ038152@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix IPv6 routes on tap
 interfaces on OpenSolaris/OpenIndiana
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 09, 2019 at 01:44:08PM +0200, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> commit 01b3a48c29df6dc4bade3d8fb7903346a3f77887
> Author: Gert Doering
> Date:   Wed Oct 9 11:52:00 2019 +0200

I have also pulled this to release/2.4, as it's needed to unbreak
tap on OpenIndiana.

(This is the "route metric 0" confusion - the "do not mix addif and mtu"
patch is not needed because the offending refactoring is not in 2.4
either)

commit 0b2b25dfa3a19aba9c99e9a55a082fe85c4ccd59 (HEAD -> release/2.4, vweb1=
/release/2.4)
Author: Gert Doering <gert@...1296...>
Date:   Wed Oct 9 11:52:00 2019 +0200

    Fix IPv6 routes on tap interfaces on OpenSolaris/OpenIndiana

    (cherry picked from commit 01b3a48c29df6dc4bade3d8fb7903346a3f77887)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdtzE4AAoJEB2Cnv7KVigS2dEL/RZhl5zUtv27ix8y7K+tVnVz
XyaAKcq783v8ARdDQJNfHl/1D/a9Q8SoY3z3SutuVKdBde+mkkmiYtq4y5p3dPIL
AuDs1tEbG+0s5CAFju4ghIkRpGRf59fX6lM1Hb77RjXH7EwD1BimH91pB+cGJK+L
RsT4oPVSXlaMlomuPjvB3vQKPtDU1ANgTEq5h+v47s/GZcWKJVnUoxc/l5LbG1KI
HltFqvt0vWFAAU+fdfX8meT6lDl1ntMbNmUyeonQOwxEQ2B2RqRZjevYlzzrXQMO
lYSoLw2vD2bDxVzFi6C0pmZW9ZQ8tspnNvyRnU9KRwYkAAJfUTHscnvro90h0J4d
ahNr5lQsin+FJq/RfTdtOyXJ0CBK6S/3ChNWnA2vjEJJOWBa/HgiXN7cMgtBbaU/
QkZNh90kZqE3+qkc4uC0/IuGPQO6OodqhiSnWL7qaGSsbYeI0wICQo5jgPFCeT6R
FH8TTwHVq0A9G9yEk73zmJLhTloq4Af7COrxobwIxQ==
=VJCS
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

