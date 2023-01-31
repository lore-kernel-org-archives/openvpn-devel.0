Date: Tue, 31 Jan 2023 18:28:36 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y9lPxB+jhdbSnCy3@...1296...>
References: <20230130144112.109560-1-gert@...1296...>
 <20230130161730.110021-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pxY8Kp/QWDaeU0u8"
Content-Disposition: inline
In-Reply-To: <20230130161730.110021-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Get rid of unused 'bool
 tuntap_buffer' arguments.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--pxY8Kp/QWDaeU0u8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 30, 2023 at 04:17:30PM +0000, Gert Doering wrote:
> overlapped_io_init() has a "bool tuntap_buffer" argument which is only
> passed onwards to alloc_buf_sock_tun(), which does nothing with it.
>=20
> Remove from both functions.
>=20
> While at it, move alloc_buf_sock_tun() from mtu.c to win32.c and make
> static.  It's only ever called from win32.c / overlapped_io_init().

NAK this.=20=20

There are more calls in socket.c, in the non-WIN32 code paths, so
v2 breaks Linux compilation (not sure why I overlooked that before).

Need to re-think how I want to clean this up...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--pxY8Kp/QWDaeU0u8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJj2U/EAAoJEB2Cnv7KVigSlyAL+wTCf/QlC5Y7PlesOR99F9KO
CGfN50YPj9wloXWUd6QKsZMY9MLKyTAeP1TqCzXwyGtgWKy+OGNY9sUWovaSTyfW
XQzReKHmlFm/k4ZtOzvMfLODT0Rh2D0BdrZ5svmMo1uGIV8u72DYqw4LAOoo8xeT
JXzSOAoWOx+5ODgk41e9suTFPLZ8cBKEXQjd7QS2piLkreBDf1Tj3vJcZAunmqud
VSpxwo25O/0sjQy5Hn/Qse816fN9ngyIPjLJMkezj04Dut4lZoK5qmSO/4z1tHc4
OesGUuq14fNoBZWotUKyANmnijZrWUBaqQIiRqF+E8ZZK89HBzbq6O1uGOMKbmPd
HdweAnk7A2JttP5xayKeZRZ61dfdWk8YyY+iDDkcHhmU9kJF8E+2kYSrVxnnHxiE
Ivg7ksspF/SUl3UePuWU8pPN3YByC0sypz3yRYHFBf382GDknSfxc0KH0cMYF1nQ
/aAn94Q8SUos05gkRS5u9WbYs4eLghZQmXB54iJugg==
=qBUB
-----END PGP SIGNATURE-----

--pxY8Kp/QWDaeU0u8--

