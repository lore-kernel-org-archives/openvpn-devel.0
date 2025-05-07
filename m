Date: Wed, 7 May 2025 16:36:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aBtv6BBzznLqhGU0@...1296...>
References: <20250507124439.28161-1-a@...2181...>
 <aBtoDrb9Fjflq52y@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6uAlJ2u0A0m/8Bii"
Content-Disposition: inline
In-Reply-To: <aBtoDrb9Fjflq52y@...1296...>
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: fix ndo_start_xmit
 return value on error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Antonio Quartulli <antonio@...515...>, openvpn-devel@lists.sourceforge.net, sd@...2891...

--6uAlJ2u0A0m/8Bii
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 07, 2025 at 04:02:54PM +0200, Gert Doering wrote:
> Tested, works :-) - so the previous behaviour was "oping was hanging
> due to 'out of buffer space' error not being counted as 'packet sent'"
> and now it's behaving as any regular network interface when there
> is no ARP/IPv6 ND for that neighbour.  Explanation makes sense, too :-)
>=20
> So
>=20
> Acked-By: Gert Doering <gert@...1296...>

Antonio says if I test this, I should state so...

Tested-By: Gert Doering <gert@...1296...>
Acked-By: Gert Doering <gert@...1296...>

here we go :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--6uAlJ2u0A0m/8Bii
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJoG2/oAAoJEB2Cnv7KVigSK3cL/AjX40L9hYFn46wmvKNjGeYB
GV+4JrnL6K9u5yDMv8aTyD3p+nVpMJJq4wQ5gcn+vDfGnmnlwAvJGq5L7Xe9pThN
y8KLffo+lAUuR1WjyNPsMgCtGprZwG3i5myauXsZiZEnGfFMVZjsEpvvYFzQvdn7
DVr/DvyK1+4O3YsHTOWVY3UdOaOerRe8nvTw2IfrwzazMeuGd/j+poVr3/N9vNG4
TBMmlCyin6DrlMzlLmcCYV6B5Zs3zX7BFbjYcJE+0p3NCbpfqHiOx4oz92fUZl6Z
ysAb7QhakwI9dsh518RfAx+mDIiP+iq9obnv6fM3qXN/+3UqULEE3il/04FZnhuw
ZCO1fJJm7vNSUDWD69weI/LzGDaiqfVk09SxpK/vvsnxtJaERBunTJTYeVf9lbPk
1r2tmVxzeS3ePzwCbrbziz6FRSiyJsUyO1+9ef0uSlqj+4WZgKWr1nALGFNn+/7H
RSzXQ0ZP7vGD62ZZI22lD+wKNcix5laPsTiDPtDEiw==
=8Brd
-----END PGP SIGNATURE-----

--6uAlJ2u0A0m/8Bii--

