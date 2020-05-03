Date: Sun, 3 May 2020 22:19:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200503201932.GN1431@...1296...>
References: <CAFHpkQEvQkC0NokWG-16x-R_zq9qG=2MyO2JV8m1nvNUhwU3Vw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="alczVCU1+W3UsZN8"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEvQkC0NokWG-16x-R_zq9qG=2MyO2JV8m1nvNUhwU3Vw@...278...>
Subject: Re: [Openvpn-devel] is anybody running tests on Fedora ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--alczVCU1+W3UsZN8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 04, 2020 at 01:02:41AM +0500, ???????? ?????????????? wrote:
> t_client.sh requires "fping6" binary, which is not available on Fedora.
> on Fedora "fping" is capable of running ipv6 pings.
>=20
> shall we adopt test ?

just do a symlink fping6 -> fping :-)

A real check is more complicated because "fping -6" is only a substitute
for fping6 if the version is new enough - older versions needed two=20
separate packages installed.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--alczVCU1+W3UsZN8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJerydUAAoJEB2Cnv7KVigS1lIL/RlYKXAeO7/zBqCvS84UFa8H
mQEc/oi2fwcAZASyc56aqHMyb/32BmyK3m4sr+DMHW/LToOMrc8NfQbWgk/ttqAG
1YEJolzIFb22vGeG8Mck012fPxHuv/92WuMfswluQ+S03iD9gh04pRGsgZ+WhdNK
pjVU3nkjd5RQ5V5RzsZT3iucuz7tNWQl5+bpxHtSjfDW8EEvMLIi8URGlQZHFfSl
sYPPMT8dFmlVZ6rXFIZSOon04GVzOWqdU1sfS/bnQYmgdsmiJaGYpV4SxCwZtv86
gtCawKi8x7+kNZ+8vkW7rctvDIhCPvrbdJ0QksWTphvGS/rgLcA1mb6zqQ/tLBmy
TAZP8safEPmRe1SiCEU/pKXDdOxciIaD4UANFjtTrZQFUt405/ufOak2M9pGBYEB
61FKmK39cpfFG6p6HBsub9My5bTmdjzSUXpBZvvmfXJJ6hXlDtlnhqt7crX5p4Wf
nZeuEOp2W/Je81lSUGfzqC9oP/gvVaESBlwfv2TYlA==
=q1Vm
-----END PGP SIGNATURE-----

--alczVCU1+W3UsZN8--

