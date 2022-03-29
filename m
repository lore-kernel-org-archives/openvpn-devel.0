Date: Tue, 29 Mar 2022 13:05:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YkLn9u3YVo5cuiVn@...1296...>
References: <CAAUX2SXb8MStU98ZEsswLkLDUM74zL6MapZC+=xc0_eYXwyEbw@...278...>
 <046f2279-a275-aa18-40d9-9808512a6651@...2669...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Ybdmw1uInW5WQeW9"
Content-Disposition: inline
In-Reply-To: <046f2279-a275-aa18-40d9-9808512a6651@...2669...>
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
To: Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel@lists.sourceforge.net

--Ybdmw1uInW5WQeW9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 29, 2022 at 12:29:14PM +0200, Timo Rothenpieler wrote:
> I think the dco only working if openvpn is running as root is a general=20
> issue right now.
> Like, clients can't connect either, because it fails to communicate with=
=20
> the interface after dropping privileges.

Indeed, on a server, you need privileges for the iroute handling.

@Antonio, we should really investigate that capability stuff :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Ybdmw1uInW5WQeW9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiQuf2AAoJEB2Cnv7KVigSYYkL/1IYip3avvh6bcMlb26flX7g
FFXDLJH9YXYpXJC+EFQvRGHnMeDaZpgVu+Bj+epAdy44vY8xuXm6L2tKmBfI225u
hMWGEfyyVGvwAaPkutB+OK5QxEsw8DbDdpJ99ejEgqkpkKciGieC2pZuGymj5sBU
59EAdg0GnooxUv55H8J8y0p9md+r+ba0r3HvBKQ7/jYbAiKy9fi2r4uBzV4nIQJ2
WYrUVpgsa3wzzScasTXIoIkKOsALUq0Jw0GoW39zhy/MZJoJYPrFfznyF8S+DpSM
i7AlMFTd/4MhyFEl42jGopxda4omR/SbkY/FhH265DGnm9YCukoOA1dmf43D7xEX
CoogGr2UX+9uU9E5kSROS+AtxBNTDhMyY5XSxSmQVp/nKtkNa7VEsBH2WRTR/jiz
SN1vw4s3pokm609l5lnz4UTDmR67/vUBPRRfRKUeAqbDTpq/hwuTIMuElLVb7HlV
VxoFAoQaVb/tSueBXWGR/Ucj3ZG/Au2N33bAG8YBTw==
=l966
-----END PGP SIGNATURE-----

--Ybdmw1uInW5WQeW9--

