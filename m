Date: Wed, 16 May 2018 14:16:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180516121616.GO1207@...1296...>
References: <2f575943f32de2328843b3cec3286ca1@...2399...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CVXKxAdNG2kQIXaJ"
Content-Disposition: inline
In-Reply-To: <2f575943f32de2328843b3cec3286ca1@...2399...>
Subject: Re: [Openvpn-devel] Darwin tap ipv6 fix
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Scott Shambarger <devel@...2399...>
Cc: openvpn-devel@lists.sourceforge.net

--CVXKxAdNG2kQIXaJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 15, 2018 at 06:01:41PM -0700, Scott Shambarger via Openvpn-deve=
l wrote:
> -    if (r6->iface !=3D NULL && gateway_needed
> +    if (gateway_needed
>           && IN6_IS_ADDR_LINKLOCAL(&r6->gateway) )        /*=20
> fe80::...%intf */
>       {
> -        int len =3D strlen(gateway) + 1 + strlen(r6->iface)+1;
> +        int len =3D strlen(gateway) + 1 + strlen(device)+1;

This part will break routes that need to go over the LAN interface, not
over the tap interface - namely, the /128 that is installed if you
have overlapping v6-over-v6 setups (... if you have link-local next
hops).

So NAK on the patch "as is" - for the rest, I'll look into it next week.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--CVXKxAdNG2kQIXaJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJa/CEQAAoJEB2Cnv7KVigSYCsL/igrZQrlKJRQ/Swc+8vTUH32
foX9oGCxzu4uF0nullsAkb+5SqVDQAFOJ1eJZCHu8TCSlYYRd2izL/O39dAPNu41
XlfwlGwwQgQaVPnijDl8axX4b729J/X+T8IsiIDtZ+EQa1GB5RkAGngSpVcoJNPx
zcHznIE18TxJ2ZJUpBG14rW2BXg/ePh6muee+eBPDSKiZ7O++5tF3edNSCR+Gb4N
DkYWfib4pI9WQSgCM02FsFsZgxuwAO+bdE+Z2eypwltcVZuHkQStNt5q1ul/hY7x
IVoPgL9jeE5nKmhw6WAvM7jEpDf1qmVQYmCypXZZ41Q0L6F4DQWggvAehnryJkoS
XO+eFtbj6fMLVMqju+xfZyP0F+W4E1x2FJ+as1Wo4eC4TY4P2GdJL19+6brE6t5C
JlmWWjKWJyVjRZl04a2j8tAWPwYZHWw/UM2wz1+pPrZDIMpZVERDqdutWLpVlaPz
+GtDO+2g4dTMjg+7pPBNyCns5XII7J3u+it6aPXnuw==
=2aeM
-----END PGP SIGNATURE-----

--CVXKxAdNG2kQIXaJ--

