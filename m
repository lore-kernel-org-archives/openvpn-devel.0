Date: Tue, 22 May 2018 22:47:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180522204702.GT79551@...1296...>
References: <CAAF3xa85gmN5GEjguVA6cpUPFZuSOKP39g1FKf1hYfmyoo9X5w@...278...>
 <d42dfd0b-8309-2409-0a21-aa97c8a3b651@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UExESr5xZTMxdOWv"
Content-Disposition: inline
In-Reply-To: <d42dfd0b-8309-2409-0a21-aa97c8a3b651@...2080...>
Subject: Re: [Openvpn-devel] Minimum Linux Version for OpenVPN 2.4.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--UExESr5xZTMxdOWv
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 22, 2018 at 09:10:10PM +0200, David Sommerseth wrote:
> On 22/05/18 19:32, Marvin wrote:
> > Can someone tell me the minimum Linux version that OpenVPN 2.4.x will b=
uild
> > and run on?=A0 We have an older appliance the runs on an older 2.4.31 k=
ernel
> > (cannot be upgraded -- but it's very hardened so really doesn't need to=
 be for
> > our use.)
>=20
> First of all, kernel 2.4.31 is very old - hardened or not.  I might work =
if
> you don't attempt any IPv6 features at all.=20=20

IPv6 has been there since waaay longer, like, "last century" :-) - so
in regards of "is IPv6 there?", 2.4 is fairly young.

Totally off-topic, though, so I shut up now :-)

> But I do know there has been some
> code changes over the years which is strictly 2.6 kernel and newer; but i=
ts
> quite a long time ago so I don't recall exactly what and when.

For OpenVPN 2.4, I think we kicked out some old method to set up Linux
tunnels.  OTOH, that was 2.2.x stuff, if I remember correctly...
(86e2fa5597fd1ad8e010)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--UExESr5xZTMxdOWv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbBIHFAAoJEB2Cnv7KVigS4N0MAJ0K8khDZnAb+t/l10rIs9Rw
sFMiYznToUvF1gvct3yD8q4sFHks0veVrsNnZyUkohJFKaQLDslDGbEMJ9umed4R
rJ+gMDfD5f6n2nL5+8nQ3D97qJ1Ofs/0s0D5v3/h3f7WC678fIfbTx/Svp4GR6qx
qYZiUgCE567xMtxXuDff3HHBa+2W3hjTbQHWXb0ovnNWUlVB0rzU8+xVEoLOVv69
1vbAbx3DNQtWF7Phfdoby4Zr655BtagXW2rQxMqnmq+r1w/4OUt+2bvdhudMK7p8
Df0i/4rxyr2+No9f0odAxqCtQ05xxYIKF7qh2weHgqabkIb6BxvraVf80S5CEoCp
ejVOK0dVQuDJpjtksEFJRUplPg3LWwkSQ5sxtn+d283v5gkBdv8Gw1r8Uk+URSBP
Ygg2HBh8PwTs79xEMXNcymV3wrSXjoTIqqrxENhymcszWTGSoeKDYoqHv4g6R9KO
mYfjw/aLWy3CoSXoHRMAkDeiokM5fkjawTJO5EGSWA==
=HJw/
-----END PGP SIGNATURE-----

--UExESr5xZTMxdOWv--

