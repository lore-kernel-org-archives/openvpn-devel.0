Date: Mon, 29 Jun 2020 22:58:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200629205810.GS1431@...1296...>
References: <202006101601.05AG1i8K031513@...2054...>
 <20200629190930.1360-1-cschenk@...2502...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VmwO+pUmMNy9G8Cw"
Content-Disposition: inline
In-Reply-To: <20200629190930.1360-1-cschenk@...2502...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Unified success messages for
 setting mtu
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christopher Schenk <cschenk@...2502...>
Cc: openvpn-devel@lists.sourceforge.net

--VmwO+pUmMNy9G8Cw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 29, 2020 at 09:09:29PM +0200, Christopher Schenk wrote:
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 18cdf38d..3ef79b2f 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -251,7 +251,7 @@ do_set_mtu_service(const struct tuntap *tt, const sho=
rt family, const int mtu)
>      }
>      else
>      {
> -        msg(M_INFO, "%s MTU set to %d on interface %d using service", fa=
mily_name, mtu, mtu_msg.iface.index);
> +        msg(M_INFO, "%s MTU set to %d on interface %d using SetIpInterfa=
ceEntry()", family_name, mtu, mtu_msg.iface.index);
>          ret =3D true;
>      }

While I do like unified messages, this is not exactly what I had in mind
- the "using service" bit should stay, if using the service :-) - too
much unification.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--VmwO+pUmMNy9G8Cw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe+lXhAAoJEB2Cnv7KVigSKlwL/2jhXjCxrknsmGsJdi3fNVU2
Z73Ip3ecko0rUnnASBkp+63SDBPFG3rXh7rKU0s4u0rXsllokZi/cqUaEQXgijIT
jK0KPdDBgFen+t1qtjbGyjkmVX2R51anfUQX2HoNOlhDTHT51Hf5tL1MSsG5nuLq
3pUotDQeBB1El4stvpRC8AOQuwiP60ksT3fYF4RQ+UNhhGFuTMvLeW/dPq/eYfSr
Naz/4ONSVWpJPvP+Z5d+TsWabsivz3wWAjlLprcIWH/xuT7sa6oqRw9rEviAHH0C
MrgeRZj+Cb5pWLV04QeS2s+RA+JFgcaEbv3NQ1iWxG7vKteI1VPWLIj1Y161Scl3
hZlPfAKfcuvM4ruy4dcsZ5JSGLDOe2E1XIxmY0qLW+LyTrPzq7r2sDQIRYTPlSWT
g3qq1t7MjihBn1YU6ekVwqwaFibfly4h1/VEflILkqnJh+gsFzjhouiY39ONoNp3
PoM6EwRGZspVM52bvetjE9nZ86r3KjY5ewwY4R34xQ==
=ERHx
-----END PGP SIGNATURE-----

--VmwO+pUmMNy9G8Cw--

