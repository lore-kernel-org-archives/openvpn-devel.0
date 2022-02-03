Date: Thu, 3 Feb 2022 17:54:45 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YfwI1Wjv2H6GZB3Y@...1296...>
References: <20220101162532.2251835-1-arne@...1227...>
 <20220101162532.2251835-13-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aWsYjI6Mj8YI4pEj"
Content-Disposition: inline
In-Reply-To: <20220101162532.2251835-13-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 12/14] Replace TUN_MTU_SIZE with
 frame->tun_mtu
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--aWsYjI6Mj8YI4pEj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jan 01, 2022 at 05:25:30PM +0100, Arne Schwabe wrote:
> This always uses the configured MTU size instead relying on the calculated
> MTU size.

This one, applied on top of "everything up to 11/14 v3" does not
compile.  It removes the TUN_MTU_SIZE() macro, but there is still
"frame_finalize()", which uses it.

frame_finalize() goes away in 13/14.

So maybe I'll squash these two together...  discuss tomorrow.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--aWsYjI6Mj8YI4pEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJh/AjVAAoJEB2Cnv7KVigSvGEL/0RP8PoxGrWsxalgrmxNhhJ5
x+mQ+p4kABJ2Tj4v0RTxNX0VjXmcESd/OKTB+Fb0WSdF+NudoR3qmLsdwB2dLzxr
VXe+B3d4uNNiM7SGQ3pPYSWtVwuqCSEY07uGyII9UyCzE5RmuCIT+wwd5SxtAEOe
GaFI12yjfH6iPegIqxFaA+LBdemSVIVqMb8betlXmGC9dfthZItKfU4O0Cupqt3w
TX4MZn45PC3MngivL6kv7UYPTrPFRabTz0OqrgSbk/KC0fcaTp4zY1eRGtIIOkBK
rudl+kROZipQoDG7JfnWGwvCHaBOxvymWDLI/eEyggXGZtQud23RoPLFKt75xovY
ZmPqHgQdzR0RRHIfLpBonHxaO22C7H/HeCFzUvASMMfU8+FuVuHv81/Ff1mdsXg3
09tLiy9uk4HhB3t4XqNJmv97qVOBktRrMgOHmtmTMpFZ7b+QOgSDWrmYgzYNC2uZ
LZ+N1qGv4FRhx+KTTuFk6fgDjrfCS4j68lx2EjtQ5w==
=OnWi
-----END PGP SIGNATURE-----

--aWsYjI6Mj8YI4pEj--

