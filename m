Date: Sun, 22 Nov 2015 14:19:39 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151122131939.GF24952@...1296...>
References: <CAN-X3HSXj9a1kiKGBJ1eHgoTeA97WmpqQJPCYf5esKYQa8fLjA@...278...>
	<20151121200637.GD24952@...1296...>
	<5650E04B.2020002@...1227...>
	<CAG9MbtJGp9h6TwJAzqqZfai+gNvS5Li+aM4g5vZNrdjxcD5Rgg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tR2cvQ13k2aMxNOa"
Content-Disposition: inline
In-Reply-To: <CAG9MbtJGp9h6TwJAzqqZfai+gNvS5Li+aM4g5vZNrdjxcD5Rgg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix info.af == AF_UNSPEC case after
 commit 2bed089d31a12c2d0277e36a64964ebab6640f75
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: christian pellegrin <chripell@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--tR2cvQ13k2aMxNOa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 22, 2015 at 01:09:48PM +0000, christian pellegrin wrote:
> Huh, sorry the segfault.=20

Nothing to be sorry about - that code is complicated ("has grown over
10+ years, too many options and platforms") and refactoring it for
proper dual-stack support still sees some fallout...

> To solve this specific problem it's enough to
> test for AF_UNSPEC in
> https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/mtu.c#L163,
> I will prepare the patch tomorrow.

I'm not sure what the "right" fix would be at this place - all you can
do is either "do nothing" or "try IPv4 and IPv6 both", which both does
not ring right to me.  If we reach this spot, we should know which AF
our socket has...

> I don't think the configuration is too strange. It uses proto udp,
> mode server and sets local address because of LB/HA setup.
> mtu-discovery is set to maybe. What is really strange (and will check
> what is the code flow in this case) is that if I enable multihome and
> IPv6 I don't see the problem.

If you use "proto udp6", you're forcing AF_INET6.

Could you test the patch suggestion I sent yesterday?  I think your log
*should* (before the ASSERT) show the "Could not determine IPv4/IPv6
protocol. Using..." message...

thanks,

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tR2cvQ13k2aMxNOa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlHA6qkuBuNlUUl1AQLz7gP/R+Lg1q+EAIHCMKOBhysWDD2vTz2CMkiF
9vBFhshmW8U206UZU2A9VUam7McXBq2vM8d4DiVN+IssFZyPqBo87K0IsrdiUn6y
gHN/qB6RKfHchxforQVQvxi02jR4EBWnc54dJvq+xevzWlVJd3Hbxrae+ON6rFJI
VKCWqF7Uuf8=
=o/bj
-----END PGP SIGNATURE-----

--tR2cvQ13k2aMxNOa--

