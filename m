Date: Fri, 8 Feb 2019 20:45:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20190208194553.GX962@...1296...>
References: <20190208194018.20325-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6T7DWS4/yLjK1QR+"
Content-Disposition: inline
In-Reply-To: <20190208194018.20325-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Add unknown-unicast flooding to p2mp
 tap bridge.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--6T7DWS4/yLjK1QR+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 08, 2019 at 08:40:18PM +0100, Gert Doering wrote:
> Enable flooding of "unknown-unicast" packets from the server to
> all connected clients (+tap).

Hrmph, this is incomplete.

While it enables flooding of UU-Packets "from client 1 to client 2",
packets coming in from the TAP interface towards an UU MAC will still
be dropped.

"More code paths in multi.c".

But I still like feedback on this patch.  As I said, normal switches
behave like this (UU is flooded, as is broad- and multicast) but it
seems James was afraid of flooding clients with "stuff they do not=20
want".

So, we could have an option here.  Options!  We need more options! :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--6T7DWS4/yLjK1QR+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcXdxvAAoJEB2Cnv7KVigSCXcL/jEpz0zora4RYKti/XZQnFjY
CG2VyxA7Nk6BTnHbAGmzSpxswjiJlDWa6r5YwnkAVf98PbEl3mdvkrW+6y03nXDv
weSVz8wmnfgA+MpTkUssHPyVOPREazFnvKAg9a4vOkBwQ4O4UiPlYTWnTWj3KXWZ
JT9jFyOcBmPcA475TkAtdK1BdNIDbFkXnYmnWI+HYq1SGgdT1ShlnPSAGlAgvomv
16I+3Ek0s8nfSWd0c1rAFZR6C5Lb50PnjSBsWBB71k0J6ylPKEY8qp9PSNXZ/ctQ
Z6IEwoyQA1Dic3rM+kQp8W1+scZHztcRGO/nEdOyXLsumsDCba6osVOo66aoIqWb
TAM88SSnLUieAUSfhy4GCx0g+2x6i6cDmSVR2XGzqTk3ggAN0KneSFKNQZmgTXo8
SK1CyAB2Q+ztK/JDPIy0RjKf27/UdIrIi8zJybJftoq1ePFsj6hy6ZtGZExVfKnA
/yeO3/n9UIRDm3eNw1JSvpm2Et4EfS6GfCYoryb/uw==
=FDhM
-----END PGP SIGNATURE-----

--6T7DWS4/yLjK1QR+--

