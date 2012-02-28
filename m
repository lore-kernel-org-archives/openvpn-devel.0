Date: Tue, 28 Feb 2012 14:15:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120228131502.GP7024@...1296...>
References: <1329512690-18831-1-git-send-email-debrabander@...277...>
	<20120217215816.GW7024@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v4FgCkd4vT7RadTR"
Content-Disposition: inline
In-Reply-To: <20120217215816.GW7024@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Bogus check for negative values on an
	unsigned number.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank de Brabander <debrabander@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--v4FgCkd4vT7RadTR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 17, 2012 at 10:58:16PM +0100, Gert Doering wrote:
> [ on ir->netbits and ir6->netbits, signed int vs. unsigned int ]
>=20
> Thanks for reporting this.  I'll look into it.

I've dug a bit further into the code, and the IPv4 and IPv6 code differ
here - IPv4 flags "a host iroute" with ir->netbits =3D -1, while for IPv6,
a "host iroute" is just a /128.

The difference shows up in=20

 - options.c, option_iroute() vs. option_iroute_ipv6()
 - push.c in checking "if < 0 then make it a /32":

    if (network =3D=3D ir->network && netmask =3D=3D netbits_to_netmask (ir=
->netbits >=3D 0 ? ir->netbits : 32))

 - multi.c, in pretty-printing host routes "without the /32":

          if (ir->netbits >=3D 0)
            msg (D_MULTI_LOW, "MULTI: internal route %s/%d -> %s",
...
          else
            msg (D_MULTI_LOW, "MULTI: internal route %s -> %s",

   (which I blindly copied for IPv6, not noticing that ir6->netbits cannot
    be negative anyway)

 - mroute.c, in the mroute_helper_{add,del}_iroute[6]() helpers that you've
   found


Now I'm wondering which way forward is cleaner - make ip->netbits an=20
"unsigned" as well, changing all the places where "<0 =3D=3D host route" to=
=20
be "/32 =3D host" (mostly prettyprinting I think, but need to understand
the mroute stuff better), or live with artificial IPv4/IPv6 asymmetry=20
here...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--v4FgCkd4vT7RadTR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT0zTVakuBuNlUUl1AQLWeAQAhLFFutvQlFfwGWdDdIIuNDuK4m8IKoEC
QNLWFFxqp0E1QETIpgMErpbyYchMsXTeOtSgYclIPKfW8yrs2PEBRxrGnJ1ub9ad
aXc7l7ncI9ztKYzdbzgE6E9z+JGHbZSaoVnBXWP4ylyIrMXJl8q6vVMAh+UPf8My
SxAnKpwvSf4=
=44lE
-----END PGP SIGNATURE-----

--v4FgCkd4vT7RadTR--

