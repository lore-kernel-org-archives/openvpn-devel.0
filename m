Date: Wed, 23 Oct 2024 16:50:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZxkNPBAus8JGMehg@...1296...>
References: <20241023134903.66485-1-rzvncj@...277...>
 <ZxkG_T7Jw7fI-C1I@...1296...>
 <4bf82643-74b0-4034-a4e1-67d0ac3ce51b@...277...>
 <ZxkLm_LadCi16JTV@...1296...>
 <b2c9b370-43b8-40c3-843b-adeabef79891@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="61cpfyEkWT6pqXBz"
Content-Disposition: inline
In-Reply-To: <b2c9b370-43b8-40c3-843b-adeabef79891@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Allow setting an empty auth-token in
 push replies
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Razvan Cojocaru <rzvncj@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--61cpfyEkWT6pqXBz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 23, 2024 at 05:47:51PM +0300, Razvan Cojocaru wrote:
> > AUTH_FAILED should do this automatically - invalidate the token, that i=
s.
> > Can you show a log where this is (not) happening?
>=20
> Of course:
>=20
> 2024-10-23 14:52:06 us=3D368754 PUSH: Received control message:
> 'PUSH_REPLY,auth-token'
> 2024-10-23 14:52:06 us=3D368851 UDPv4 WRITE [90] to
> [AF_INET]69.162.107.71:1194: P_ACK_V1 kid=3D0 pid=3D[ #13 ] [ 8 7 6 5 4 3=
 2 1 ]
> DATA len=3D0
> 2024-10-23 14:52:06 us=3D368936 UDPv4 READ [163] from
> [AF_INET]69.162.107.71:1194: P_CONTROL_V1 kid=3D0 pid=3D[ #12 ] [ 2 3 4 5=
 ]
> pid=3D9 DATA len=3D85
> 2024-10-23 14:52:06 us=3D368972 AUTH: Received control message: AUTH_FAIL=
ED,No
> Stairway to Heaven allowed in this guitar store
> 2024-10-23 14:52:06 us=3D369228 TCP/UDP: Closing socket
> 2024-10-23 14:52:06 us=3D369287 SIGUSR1[soft,auth-failure (auth-token)]
> received, process restarting
> 2024-10-23 14:52:06 us=3D369346 Restart pause, 1 second(s)

OK, so I see what is happening - you're sending an AUTH_FAILED "out of
the blue", not in response to a client handshake, right?

OpenVPN 2 *should* invalidate the token upon the reconnect (and then
getting an AUTH_FAILED)... so what happens in this case if you let it
reconnect?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--61cpfyEkWT6pqXBz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnGQ08AAoJEB2Cnv7KVigSmrIL/2ZM8phMXPxOzHcokShxj1aw
zOgV7TrtSR4sAFMCi7Jys2ed45669sf5+4eyv7hALw85ExJrIvqp9HP30/NBrH1y
y4C+qPN5mpGvAsvWMmFRqkyI8enz+AwA0qSSDjWClUmpGHPlTDXV9m3krKjGEEzq
CToZKkeJEEkgqD+mRnT/s5l1gq5h9ZE6aRSoxflqC+eY8aDzeFGv/PUq0qHqspqO
tWcF29jxc/q/SyR/UaBf9Ecz39R5xzvrUvCEl/m6pvwsDsdB6vnSoIXhQO3CyFzY
qwyZ/lWvGMKKO0IQRi6le+YB9SwzDccUZxefmY8+RiWWzNxFV4blyjAVRrdK1mu8
J4BYU0Nx7Tbj+62ympo2rp9b1Zki/Tt04rfFWT5vTAfZhhcxvISKjyyJj4+4JkDq
fDHajmpVtJ9uPOmkpbok2FdToOtgy2ysgb7d71G0FCr9xxxupTgywcnISKKpfVQz
NVBOqrhIQz/J+48VNArmWY9nUkwqiUyLlrrVWChf0g==
=r8fi
-----END PGP SIGNATURE-----

--61cpfyEkWT6pqXBz--

