Date: Sat, 13 Aug 2016 11:58:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160813095824.GR78279@...1296...>
References: <1451908945-12244-1-git-send-email-lstipakov@...277...>
	<1451911424-12970-1-git-send-email-lstipakov@...277...>
	<b80eb9b2-1ce0-1f9d-7b76-a877087e10fe@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IsIRZ4DwzP0DcleK"
Content-Disposition: inline
In-Reply-To: <b80eb9b2-1ce0-1f9d-7b76-a877087e10fe@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Drop recursively routed packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--IsIRZ4DwzP0DcleK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 12, 2016 at 08:24:35PM +0200, David Sommerseth wrote:
> On 04/01/16 13:43, Lev Stipakov wrote:
> > v2: better method naming
> >=20
> > On certain OSes (Windows, OS X) when network adapter is disabled
> > (ethernet cable pulled off, Wi-Fi hardware switch disabled),=20
> > operating system starts to use tun as an external interface.=20
> > Outgoing packets are routed to tun, UDP encapsulated, given to=20
> > routing table and sent to.. tun.
>=20
> Can this happen on Linux or *BSD?  Could this recursive routing
> actually happen at all?

Of course :-) - the moment you lose your external interface, for
example, because you unplug the network cable and network manager
deconfigures ip address plus all routes via that interface...

What is left is "routes into the tunnel", so you send the tunneled
packets into the tunnel again.  Without that patch, this leads to
"openvpn eats 100% cpu, your VPN is down, and until ping-timeout
fires, it won't recover and the user has no idea why it is broken".

Very typical problem with routing and tunnels :-)

>=20
> > + +      /* skip ipv4 packets for ipv6 tun */ +      if
> > (tun_sa.addr.sa.sa_family !=3D AF_INET) +	   return;
>=20
> [...snip...]
>=20
> > + +      /* skip ipv6 packets for ipv4 tun */ +      if
> > (tun_sa.addr.sa.sa_family !=3D AF_INET6) +	  return;
>=20
> How likely is it that these two checks will hit?  Do we truly need
> them?=20=20

It's quite likely for IPv6 packets to be transported over an IPv4
tunnel, and vice versa, and will be even *more* likely for the next
10 years to come.

So comparing "inside IPv6 address" to "outside IPv4 address" needs
to be avoided (at best, the code might misfire, at worst, you might
overrun comparing an IPv6 address to something that has not allocated
enough bytes) - maybe it can be written more efficient, but in the end
you always have the "is it the same protocol inside and outside?"
check, before you go on comparing addresses.

Right now, the code is nicely readable by using the is_ipv4() macro
etc., but sacrificing this by having a check very early on that
is the unrolled form of the macro, and basically does

  if ( outside_address_family !=3D inside_address_family ) { return; }

would indeed be more efficient for the mixed-family case.=20=20

OTOH, you need another comparison then for "is it IPv4?  is it IPv6?",=20
so the overall amount of code for the same-family case might be even
higher.

OTOH again, is_ipv4() boils down to an amazing amount of code...  so
moving *that* from proto.c to proto.h and make it an inline function
(and hope that the compiler will be smart enough to keep track of all
the then-duplicate checks for is_ipv4() vs. is_ipv6() and just optimize
it properly) might produce more efficient *and* more readable code :-)
(and since it's only called in two places ever, the extra code size
due to inlining isn't big)


> I'm basically concerned of the potential cost an extra check
> adds.  As the link speed increases, such checks will have an impact
> later on if now.  If truly needed, is it worth looking into providing
> some branch prediction hints to the compiler?  (unlikely/likely hints)

For the "protocol variants", you can't, because it depends on what
users do with their tunnels.  Today, they might be predominantly
IPv4-over-IPv4, while my personal sessions are mostly IPv6-over-IPv4
already...

> > if (c->c2.buf.len > 0) { +      drop_if_recursive_routing (c,
> > &c->c2.buf);
>=20
> If this is truly only an issue on Windows and OSX, can we consider to
> #ifdef the drop_if_recursive_routing() call?

It can happen on all platforms where "inside" and "outside" routing=20
(wrt openvpn) happens in the same routing context / namespace / ... and
"some external entity" can modify the "outside" routing table without
OpenVPN knowing.  In other words: on all platforms we support today.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--IsIRZ4DwzP0DcleK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV67vP6kuBuNlUUl1AQKvfgP+P7MmO0TXSwMRshhj/upiJhNBeZlcxV/4
mldpsybPGhm4vWACGeZVwNOd8/aV5w1rMjN22D4T14OJtxqs/HKIKtsBFY9jkyva
9QgZHwzdnw0qz7e9EVlJgjWDWxMHMJrHCC4APBKThBurDTabCTSY0W8NadP3cGD9
oKb/P/p2fAM=
=qc/U
-----END PGP SIGNATURE-----

--IsIRZ4DwzP0DcleK--

