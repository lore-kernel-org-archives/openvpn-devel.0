Date: Wed, 14 Dec 2022 22:45:54 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y5pEEhAGyKzbNn8u@...1296...>
References: <20221214164824.172-1-lstipakov@...277...>
 <CAKuzo_iZPLJvSyK53oziTO99ZW6ua-DFvEWMoPAK3MjrjQ5PdA@...278...>
 <CAGyAFMV=QqUUPj8-Z8_U3JWG3qoBOZOKpMMVAztpdc-8qT+0HQ@...278...>
 <CAKuzo_g6Pc6djBCu05-k5oJFWYuTYBFa60Ucay+z1BebJK=9Gg@...278...>
 <CAGyAFMUTjZuN+W8FagK+F=4P+iuUAEYS0qmieb3kNQYKN-z=gg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Pmo2ufRvV+DEWhJi"
Content-Disposition: inline
In-Reply-To: <CAGyAFMUTjZuN+W8FagK+F=4P+iuUAEYS0qmieb3kNQYKN-z=gg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Introduce dco_get_peer_stats API and
 Windows implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Selva Nair <selva.nair@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel@lists.sourceforge.net

--Pmo2ufRvV+DEWhJi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 14, 2022 at 10:50:19PM +0200, Lev Stipakov wrote:
> On Windows control packets are handled by userspace via link
> read/write routines (which use device handle from CreateFile). Both
> FreeBSD and Linux implementations use additional, netlink-based (or
> FreeBSD analogue) channel to send/receive control packets,
> so existing link read/write routines are not called (except initial
> handshake, before socket handover to kernel) and therefore stats for
> control packets are not duplicated.

FreeBSD uses standard socket read/write calls for control packets.

The "tunnel control packets through the ioctl() interface" method was
never used by the kernel and will be removed from OpenVPN in kp's 4/4
patch (to be merged soon).

But since the FreeBSD kernel does not count control packets (I've
been told that it "sniffs" the socket and only removes "interesting"
packets, the rest is passed through to userland - so control packets are
not handled by kernel), there is no duplication.

No idea about the Linux details... Antonio?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Pmo2ufRvV+DEWhJi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjmkQSAAoJEB2Cnv7KVigSRrcMAIb+r39XcoaZeW4upZXEe1Jv
SljOYoLW8EFhD8p0GNdaqATFCEDhe9VBfif+SCEWu3etim5S6wi+UkqQHOyRF13l
YxeC65WF7u8bHWpafE0hLOOj94/x7KYhCwTe+6q1xt0PqJdvbpISiSXrgMmkhl4i
edfWfzgM3KfhwFNEvQI1GynewtMmR46RBIwJwEiScKw9iHkB3q+EJI/l1a/JnyB5
3OBmniqhqbOS+3VbxvkIwQLGOXk5ejLoQeZ3oQmFqmEsF4NbwH3JHtOfh6uf4Qk5
OVI3G/Jk6yK/cSH9Tr/gXovQc11H+lkNY+5xeRMcpsd3Gtd631XMXvbrAVU1dU5n
DNz+0Z4e9fUyBfgIjiJPr/vleN6zGpQqMvnf8WDTXvzFmyHEWTFOBgW4ILAfqh97
7Q17/8eYRiDcXepoMF1IOdrfJi36dvNyP5DUmhhiYmHvYORiCKdxAAkhNszA2+JR
dntgLNP3ehG2Hlvxqg2Axw6cjnCVn0OOxIdXlLLk5Q==
=LWko
-----END PGP SIGNATURE-----

--Pmo2ufRvV+DEWhJi--

