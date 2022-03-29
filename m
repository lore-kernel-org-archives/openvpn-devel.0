Date: Tue, 29 Mar 2022 22:09:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YkNnhL9xa3muEUPk@...1296...>
References: <CAAUX2SXb8MStU98ZEsswLkLDUM74zL6MapZC+=xc0_eYXwyEbw@...278...>
 <YkLkGj7WrC6ej0yR@...1296...>
 <CAAYFXLk10kF11t=C-V0RQCJ_4ttm80BspZ2ErWoCwqMZQa3GMg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="h6TBX7LzPTaVS/Eq"
Content-Disposition: inline
In-Reply-To: <CAAYFXLk10kF11t=C-V0RQCJ_4ttm80BspZ2ErWoCwqMZQa3GMg@...278...>
Subject: Re: [Openvpn-devel] [ovpn-dco] can not delete tun interface
 automatically if option "user nobody" is used
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Pete Nelson <petiepooo@...277...>
Cc: Gert Doering <gert@...1296...>, Tony He <huangya90@...277...>, Antonio Quartulli <antonio@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--h6TBX7LzPTaVS/Eq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 29, 2022 at 06:33:14PM +0000, Pete Nelson wrote:
> Couldn't the down-root plugin be used?  It's biggest drawback for this is
> that it's Linux-only, I suppose.

Yes, you could use down-root (and that's more portable than "DCO", which
is "Linux and FreeBSD only"), but that's not a particularily nice solution,
given that it has no information about "what openvpn wants to undo" - so
you practically need to write your own scripts to do all that.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--h6TBX7LzPTaVS/Eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiQ2eEAAoJEB2Cnv7KVigSpRcL/18FD/dahehuk6vfU9XOdly9
IqpNLrlncwpWYUtU6R1KQWu7vLvhlxtfwbi6oSbB5Bk4xzTqSaaMU6aqiig4vZ7n
plkHn1rCkexV54m3nO89Iv+DhHlDvX8qLbLEDbf/Z72KoCcuSY+pg78Eyw0X8WSg
VnRtdmAbC2IAmXBO8Z5oCf48H8ar81DWywybpbTC9rKIFrW8nq/U79eA/lv5jNJR
VBv7NP2PG5xeLdPDGybUvOG/K48ua4qeLiptgcndee63iZbS6R9+CxBlw+8SHOpX
jOIihFlyYng8esz0Oh1orX3iB62cIq1HmUp6VbW4KM9qriJ8cEU2hNE68RbRKu+8
mn/sUytt0vRJTNhcbsV4CIsanxnIqYCfQzrphi/skJ4buE4olUyNUzVOgz2PqS4+
Ni3kbTw6NP2Oeu46L1GC1pk9WBLs6sTZwsV7xku3T6kHKvlJarrHjfCI8BtumH9G
L612pcxisWVoPAsxnin/9UkM6qzj09OSii3k52mz0w==
=0wcg
-----END PGP SIGNATURE-----

--h6TBX7LzPTaVS/Eq--

