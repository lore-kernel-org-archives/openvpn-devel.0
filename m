Date: Thu, 21 Apr 2022 17:03:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YmFyTcVS+nmzWiuz@...1296...>
References: <20220420233148.2384208-1-heiko@...2662...>
 <866053733.106111.1650528089348@...2642...>
 <YmESwwvWq/IwpMg+@greenie.muc.de> <2899105.Ihd2bCoRom@...2664...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wQiU1PiyqGqfI0u6"
Content-Disposition: inline
In-Reply-To: <2899105.Ihd2bCoRom@...2664...>
Subject: Re: [Openvpn-devel] [PATCH] Add git pre-commit hook script to
 uncrustify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

--wQiU1PiyqGqfI0u6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 21, 2022 at 02:41:18PM +0200, Heiko Hund wrote:
> > Especially this one is something I only noticed after I sent my mail -
> > so this definitely needs to to mktemp-style temp files, or a private
> > tmp directory (in the local repo?)
>=20
> I don't really see the need for secure tmp files here, as there's no chan=
ce to=20
> exploit anything by racing for the file(name). Or am I just not creative=
=20
> enough?

The classic approach is "create a symlink from /tmp/$known_name to
something you want overwritten", and on next "git commit", some file
owned by the committer gets overwritten (or created as empty)

Since an attacker can not control the content *and* the comitter won't
do this as root (at least I hope so) *and* you actually need to have
different users on the machine, the risk is comparatively low, but still,
this is a code construct that should be avoided.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--wQiU1PiyqGqfI0u6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiYXJNAAoJEB2Cnv7KVigSRaIL/jExtQzYccJy+2ruIeWX8KDo
vX5s97X02wO2eGCdi1Ojkxxdss2JCdxJ6ldSW5Y2fEb0wq9J9SOeVwcydqdhW20L
5Mxzsp3zkh8B4p7fINEaSwvv+OZXfhIYF1HRJm7BwoL2EPw6C7dN9uR2Mj1Tfitw
El3M1qf770w4vaqql+B9VLTvWLAfr9wC5CmNsc7clBahpaNBoZz2MGqUySLXPEBm
uNMy9ekKFdnMG+eUDhRY/8JTgC3HkRf1muVYDIS7U/IisAuuMwvOP++D2CnhJ8jR
LQHzm1dtaF7keK9K67kTKKcXawm8/ZkpdKUBKXZHnwstl8JvmuugojEVqCed4xQp
jVzphX59N8p+4UG2d98E+Kbr4SFTajqnbKvck9baqFZ1KNdRjJw4CjVcPw7s/wXz
qgNSnlOOmfylGP855rR4GYwI1oL/+uW05E9xdiOdlEZ9xKI7T/UyTLQNKBqVe/A1
YABOF69bKHG6UvoqEMjPTvb8jOA+Q/R0/SoyRb9I2w==
=VW6h
-----END PGP SIGNATURE-----

--wQiU1PiyqGqfI0u6--

