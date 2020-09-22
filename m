Date: Tue, 22 Sep 2020 17:55:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200922155521.GC976@...1296...>
References: <b1352a58-c9a1-ab2d-f85d-c419c8887ef0@...515...>
 <1759346.tdWV9SEqCh@...2258...> <4591348.31r3eYUQgx@...2258...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="acOuGx3oQeOcSZJu"
Content-Disposition: inline
In-Reply-To: <4591348.31r3eYUQgx@...2258...>
Subject: Re: [Openvpn-devel] OpenVPN 2.5-rc1 released unable to redirect
 IPv4 default gateway under Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Thomas =?iso-8859-1?Q?Sch=E4fer?= <tschaefer@...75...>
Cc: openvpn-devel@lists.sourceforge.net

--acOuGx3oQeOcSZJu
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Sep 22, 2020 at 04:57:48PM +0200, Thomas Sch=E4fer wrote:
> same problem, different message:=20
> with 2.5rc
> NOTE: unable to redirect IPv4 default gateway -- Cannot obtain current re=
mote host address
>=20
> with 2.4.3 (version of my linux distributor) it still works in that envir=
onment / configuration
>=20
> both are compiled  with --enable-iproute2

And indeed, I find this in our tree...

commit 5340f56b62c9fe7ad892e815029321f378660714
Author: Antonio Quartulli <a@...2181...>
Date:   Fri Jan 20 00:25:18 2017 +0800

    fix redirect-gateway behaviour when an IPv4 default route does not exist
=20=20=20=20
    When no IPv4 default route exists, the "redirect-gateway" routine
    aborts even if the sub-option "local" was specified or if we are
    connecting to the remote host using IPv6.


I blaim Antonio for breaking it as part of the IPv6-only patchset
(which changed redirect-gateway flags handling)...  but if that is
at fault, it was me for ACKing it.

Yeah, thanks for re-testing, and re-reporting.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--acOuGx3oQeOcSZJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfah5pAAoJEB2Cnv7KVigSZy0MAI4P7r+ZDDQB5O8zd0/p1yye
u++PUcAxItN3aTYzQglFVl/5MPwd1unCoTdwOvpVYNNz5UShUgOo73yqoBbSCNeZ
igmPWjGjnNuseEh0ckXgcrmrTG9oLexOtOIzwvBr+o0Ab12bUze9A/z0h6Mbu1L5
59V+Bdc23T3dgU/Wuy8g4zaHvcCi4q1i0jeZqjZ2P5xhBw9kqQ5oZchZx3eSM4Fg
AnL7V4i7+TnTOxT4jexWOkC93H6WbC6xk9zjziE1lhUr1bFtgCCXHcI3V9bbCTts
6cr8ckTsZS44E2U6h7LZBGToxHp3ENYcI+nAz7604pju9TvXRTmugp/IbKYO97T7
N+Oq+S1hW9DuNgYFqgeYh1Elak143cCDBffJW6NyL3R6q7UcgNZ7K6OMtWLkkp5M
+bc/a/e4Waoilquysp7kLR9ePm/yrQD9KH8XS+Ncfk3u6+HjB8KJscXggMZdrKOi
1jrkqKupLoaby36pdJx7nc4YQ7WxugeC3fyJXN8EPw==
=AL6k
-----END PGP SIGNATURE-----

--acOuGx3oQeOcSZJu--

