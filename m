Date: Wed, 30 Jul 2014 07:42:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140730054253.GC1118@...1296...>
References: <1406654929-6079-1-git-send-email-jm@...1926...>
	<20140729185713.GX1118@...1296...>
	<53D803BE.1040500@...1926...>
	<20140729210527.GY1118@...1296...>
	<53D84749.6060601@...1926...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqxQD8BitiDnVYzv"
Content-Disposition: inline
In-Reply-To: <53D84749.6060601@...1926...>
Subject: Re: [Openvpn-devel] [PATCH] Fix --mtu-disc option with IPv6
	transport
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Julien Muchembled <jm@...1926...>
Cc: openvpn-devel@lists.sourceforge.net

--tqxQD8BitiDnVYzv
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 30, 2014 at 03:15:53AM +0200, Julien Muchembled wrote:
> Le 07/29/14 23:05, Gert Doering a =E9crit :
> >> For example:
> >>   A --[mtu=3D1500]-- B --[mtu=3D1400]-- C
> >>
> >> Given a UDP6 socket on A with IPV6_MTU_DISCOVER=3DIP_PMTUDISC_DO,
> >>     sendto(1452 bytes, B) will succeed
> >> but sendto(1452 bytes, C) will return EMSGSIZE (except for the first s=
end to C)
> >> Yes, at some point, there are icmp packets.
> >=20
> > So (being lazy again, sorry) how is the maximum message size communicat=
ed
> > back to OpenVPN?  Ancilliary data again?
>=20
> ICMP packets contains the size and ping/ping6 even reports it (this is re=
al example with mtu=3D1433 between B & C):

I know that part, but the ICMP packets are seen by the kernel, not by
OpenVPN.  So how does the information arrive in OpenVPN?  sendto() fails,
but how does OpenVPN know which max message size will be acceptable?

[..]
> What I've experienced is that fragmentation is bad for perf and that some=
 routers on the internet don't route fragmented UDP packets properly, which=
 is why I've switched to TCP-only for the moment:
>   http://git.erp5.org/gitweb/re6stnet.git/commit/cd653523a1474ff9f8956a33=
1c42235454887f65

Of course.  Having that functionality for IPv6 is a good thing.  I was
just trying to understand code that I've not yet had to look into :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tqxQD8BitiDnVYzv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU9iF3akuBuNlUUl1AQLDfQP/bNTMNYok4Dj4Pw7W9aQ73fc2OO7j1lj0
9GddVLMYJ7HWXETeGnlFF3D2Xtcd7h1SHc4EcbFD/PeiPm2LsQdKoDqSGUOThoT6
pGrOyAdKRixVlR63en2ik2BlierSblXvOJgCLNSAFd3O8sJ/LyHYYhr6NH2mPYsC
sQCQuhARBBk=
=umq4
-----END PGP SIGNATURE-----

--tqxQD8BitiDnVYzv--

