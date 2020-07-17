Date: Fri, 17 Jul 2020 11:35:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200717093505.GP1431@...1296...>
References: <20200716225338.611-5-davids@...515...>
 <202007170822.06H8MPCx006942@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="m8FnBvq0c+aoDiDa"
Content-Disposition: inline
In-Reply-To: <202007170822.06H8MPCx006942@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: doc/man: Complete
 openvpn.8.rst splitting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--m8FnBvq0c+aoDiDa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 17, 2020 at 10:22:25AM +0200, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> "And then all the new and huge file is gone again".  I'd really like to=20
> squash 01, 03 and 04 - no good to have 230k openvpn.rst file in our git=20
> repo forever (even if compression helps) if we never actually need or
> want it as "one single file".  So make this "introduce split-up files
> right away".

This is what I've done now, as agreed on IRC.

Due to conflicts and general laziness on my side, I've squashed 01...04=20
into one big "remove openvpn.8, introduce small .rst fragments included=20
by openvpn.rst" patch, which has just been pushed.  Out with it!

commit f500c49c8e0a77ce665b11f6adbea4029cf3b85f
Author: David Sommerseth <davids@...515...>
Date:   Fri Jul 17 00:53:31 2020 +0200

    doc/man: convert openvpn.8 to split-up .rst files
=20=20=20=20
    To avoid keeping around a full-size openvpn.rst file which is never
    needed but will take space in the repo forever, patches 01...04
    of the big documentation overhaul projects were squashed togehter,
    keeping the individual commit logs and URL references below.
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>
=20=20=20=20
    * This is a combination of 4 commits.
    * This is the 1st commit message:
...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--m8FnBvq0c+aoDiDa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfEXDJAAoJEB2Cnv7KVigS+xQL/0EhgsceJX4UCqWyn2qi0/qm
4XFSX+VldJNNTFPDE2X65CU6kmZgdRn+QH1t2j5uvvRLffkb2hG4vEJtgU4cE/2l
7q6MbD58saCIY+TP3/TkaI9qY50aqUlgjK82301xmF8FOTySTkIPwFvtEO+wvQZ2
OPZ26xUoaZmj4FUObsCWTgXrFUw/kLabbqONqo1GxWUNs1IF6qJruacbx92kouIn
idrfcACcfLsAhe7mYCPSAf68M5iJMB//6LR0OLZDGVHrjeRHdODlHQTuwbRH51b/
ebAakTSTO+ZdSpkBFi7q0qnoHco83DAZOC4dyNe/XBBu/hkbjVR7s257PivyjY8X
wsz4egrqIdSXs0PIrvhZAQk89gfz0tqh8onInt840MkE5U7+X7La8XRRLd5C/tE8
mU+WN8I/upWaZrBsrkq2tdu+iKmLpj0tELoHQrXZypRpFhGLhH70oCjIgwXi9Ceh
nLm/a2GrhpZbI3ETSz2rhWE4v26HZxMCA1aFL4xeaQ==
=3udm
-----END PGP SIGNATURE-----

--m8FnBvq0c+aoDiDa--

