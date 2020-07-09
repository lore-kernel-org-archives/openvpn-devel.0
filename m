Date: Thu, 9 Jul 2020 20:35:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200709183502.GC1431@...1296...>
References: <20200709101603.11941-1-arne@...1227...>
 <20200709101603.11941-4-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bNHXGDLlhej9H5lU"
Content-Disposition: inline
In-Reply-To: <20200709101603.11941-4-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 4/8] Move protocol option negotiation
 from push_prepare to new function
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

--bNHXGDLlhej9H5lU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 09, 2020 at 12:15:59PM +0200, Arne Schwabe wrote:
> This clean ups the code and removes the surprising side effects
> of preparing a push reply to also select protocol options.
>=20
> We also remember if we have seen a push request without async
> push. This improves reaction time if deferred auth is involved
> like managment interface deferred auth.  The other benefit is
> removing a number of ifdefs.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>

I have tested this on the server side test torture program, and it=20
reproduceably fails async-auth (with NCP, if that is relevant)

Jul  9 20:24:55 gentoo tun-udp-p2mp-global-authpam[9557]: cron2-freebsd-tc-=
amd64/2001:608:0:814::f000:21 Key [AF_INET6]2001:608:0:814::f000:21:28650 [=
0] not initialized (yet), dropping packet.

All other tests succeed.


Applying 5/8 on top of this makes the async auth test succeed again
(and normal connections as well, from a quick glance - the full test
is still running).

Let's discuss tomorrow how to proceed here.

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--bNHXGDLlhej9H5lU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfB2NWAAoJEB2Cnv7KVigSC4cL/jicch5AshER+B43nImK5jnn
2XVVncPlEx7N7Dw6SprnXOrQqixegMIeUSWVJDIh0y41HiWpffOQR1n3Q76xleQO
CdVKbeK1vJhMkBTo3k8TO+Q66iZK1e2u5zw/R91wNxCzHv8LmmHOCjO+QNQYZD/l
0//g3uf1yf2+lfTr025c54+MqH/VWQE9l9+UHWVRYRFSuePyyrtDn1vSr0HeMLTL
Heg2+qT2P7CFhC/4A7roQgZXcf2YceDi1fqcVw2TqvkffhjnY+zJa/zHygX1ARH/
/IRO6BMppHr8OJCeU2d+Pb5qDtzCLKI8B8jfAWI0jwWH/YoUmhd8Q/t1MkZjxSKU
R6zymJHsBTlnsBZPynC9MTT7DHffHxfilXRwmEbJSeRjpOJIqLn8eKpZnl1xGBhH
Spoy5oG3iIYctF3LRTo56yehZeRx+t/I1J+91BOQChtzuohZmEM4W96cCjvds1oX
LSx8XEDfsljqkdct0g+bZh086uklvCiYbU8zCCjDaA==
=N1qk
-----END PGP SIGNATURE-----

--bNHXGDLlhej9H5lU--

