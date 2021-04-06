Date: Tue, 6 Apr 2021 22:51:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210406205120.GG976@...1296...>
References: <20210406162518.4075-1-arne@...1227...>
 <20210406162518.4075-2-arne@...1227...>
 <f16a3c68-89c0-c9a9-5a36-272979b8e95e@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LtBqofRM8b8w4YeW"
Content-Disposition: inline
In-Reply-To: <f16a3c68-89c0-c9a9-5a36-272979b8e95e@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 2/5] Remove checks for uint* types that
 are part of C99
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--LtBqofRM8b8w4YeW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 06, 2021 at 10:39:59PM +0200, Antonio Quartulli wrote:
> Gert should be able to test on *more ancient things* that we still suppor=
t.

Hardly :-) - David maintains the software museum.

My oldest machine is FreeBSD 7.4, which has been EOLed since like
ages, and even that one has <inttypes.h> and <stdint.h>...

(I'm fairly sure it breaks Solaris 2.5, but I so do not care :-) - we
do support OpenSolaris 11, and that can do C99 fine)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--LtBqofRM8b8w4YeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgbMnHAAoJEB2Cnv7KVigSAdoL/3r78o6snKc72qp6Y8GQgdaA
2mdGpGEYqe+SrN+8cWVXMGuo8ck0fkCavM5EmD7HGK5c5NgSe0vtFFYA4hKgUbIm
85cUJ5U1dkKX9tBn2wZ7YR3b9WH74c7rwe8DKu127kpTfb28AQPfnUkSekmN6lCL
XplX7HG5ivXiRw9cMaTIW+Lhsx98G2UmVY4VffopR9fJk+Pio+jBanfy4Q/08Oyv
hwpn39rpPfpWyrZJfHLMFlNVhjlK+hn7qjSJHCK0b5K2LKzRckTnG1A0S8KjXitX
cV1VG2uhM6mn04RyMxbmMQbc64ooauAbfW1EGaIM2/nwYOoyk132Z1VqEoKS2cuD
cJ6pld7s1+FISrdIc1evB0igRX+oWUgVSBCzaSyxvJKW8Et23q+YjMsGMM+i4AQP
iPHEfR0uSDBu9b7CqOCXd2iOO3jiiDfYshkWNJxZ4YaF32Ld2y+lEVDHx8BzLKH/
WHLOqQxw2ym6bmbW425Z8/0JXRfnmgRRd78rUqOYUg==
=Uq/6
-----END PGP SIGNATURE-----

--LtBqofRM8b8w4YeW--

