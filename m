Date: Tue, 15 Jun 2021 13:55:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210615115532.GX976@...1296...>
References: <20210615104331.210-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5MyLFQdPHvZjGJU9"
Content-Disposition: inline
In-Reply-To: <20210615104331.210-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] vcpkg-ports: restore trailing
 whitespaces in .patch files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--5MyLFQdPHvZjGJU9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 15, 2021 at 01:43:31PM +0300, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
>=20
> Commit 36b9aa "contrib/vcpkg-ports: add pkcs11-helper port"
> has trimmed trailing white space in .patch files and thus corrupted them.
>=20
> Restore trailing whitespaces to "uncorrupt" patches.

Sorry on that.  My git defaults to "git am --whitespace=3Dfix", because
half the patches I get have trailing whitespace somewhere - in your case,
it messed up the embedded patch.

Applying this one without my usual scripts, with "git am --whitespace=3Dnow=
arn",
and verifying that "git format-patch" really shows "trailing whitespace".

Also, Lev verified that the resulting commit *really* works, before
I push out another broken copy :-)

Acked-By: Gert Doering <gert@...1296...>

commit 742123498253e9a8aa0cbe12752e0e4a09b46f21 (master)
commit 1601f79bc2c771976a68a708abd11fd024adc4dc (release/2.5)
Author: Lev Stipakov <lev@...515...>
Date:   Tue Jun 15 13:43:31 2021 +0300

    vcpkg-ports: restore trailing whitespaces in .patch files
=20=20=20=20
    Signed-off-by: Lev Stipakov <lev@...515...>
    Acked-By: Gert Doering <gert@...1296...>
    Message-Id: <20210615104331.210-1-lstipakov@...277...>
    URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/m=
sg22553.html
    Signed-off-by: Gert Doering <gert@...1296...>

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--5MyLFQdPHvZjGJU9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgyJUtAAoJEB2Cnv7KVigSl10L/itWrjphQ3sHjY4SzOyAi7ks
+4x27WZ73ISCpxguNvUh+jdnSOIaDMSLllM0e2scOEsD410sjUq149+rTK03eiNu
Dkfyvbhq7wY5GZq6kBjDM7/8veKC0trdwC/4Lhx5y1iRC7U6XBicrtAvOmYUqcB5
DY7JMQmOjExw87ZWIIjpmHwIc+9GZJi/7Gs1qj/VRe3yw5prMZcTwHLgxtfwGNEX
7ki+8GfWsnr1DH4/CoWHp4e7IMD8ts2vodhfN5R15oC9w4kpofl3Gl4dMmqkExpC
Y/WKh24eFdSSQUxkI40w1F/2vIsSGUtY8qf0Q/wxF/md0B6JDk1EIbVtiw6/Vb94
o1rMn6IE8BBCFN5B+NimpLUGNNn981YKd+lAgmWdeZK5PIbs2YCX8fZ10i4v7WVG
KqCtgimA2gcwWUAA5uLr5LUg+SsQy4xcNQu52Q2kN2isri0OhKqgFg3Jr3liqTad
sxE8BgPo8qOXxn8tpq4CPTtCvpb+1MR/bruHPaA8Qw==
=e3bP
-----END PGP SIGNATURE-----

--5MyLFQdPHvZjGJU9--

