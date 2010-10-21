Date: Thu, 21 Oct 2010 07:56:56 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20101021055656.GJ10703@...1296...>
References: <AANLkTik2EpA-JAS=q6bmHrvw1qHRQp5D2rLPpbvy+NTE@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8bKSIdaynI1BetAx"
Content-Disposition: inline
In-Reply-To: <AANLkTik2EpA-JAS=q6bmHrvw1qHRQp5D2rLPpbvy+NTE@...278...>
Subject: Re: [Openvpn-devel] With route-noexec openvpn still adds routes
	automatically
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ansis Atteka <ansisatteka.dev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--8bKSIdaynI1BetAx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 20, 2010 at 02:58:47PM -0700, Ansis Atteka wrote:
> 1. Is it by design that OpenVPN still adds routes automatically with
> topology p2p and route-noexec set? I guess that openvpn has limited
> visibility over what ifconfig command does, so maybe this is the reason...

This depends on platform used.  On a number of systems, "ifconfig" alone
will not produce a working tun interface, you need to explicitely add
the interface route to make it work.

This happens pretty far "under the hood", and doesn't go through the normal
"setup a list of routes, then decide what to do with it" mechanics
(which would honour route-noexec).

> 2. Should one use topology Subnet instead of P2P in such cases, to get pu=
re
> control over what routes are being added?

On some platforms, this will also need an explicit route command (MacOS,
for example).  So you'll always have some routes directly executed.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8bKSIdaynI1BetAx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTL/WJ6kuBuNlUUl1AQJARwQAv7dUt2JZaDGLFfoA6DZAUn+u6cnZO2lR
gOfPwpYWOK+AsPLzZqlNVZdfzelDAobwyCAtDvmZLKsoizGl7DZlJOEkGfFvpv0L
U6k++vC6fSR73mKouzfwnoKef8L/8GtEwsC7g+saXpb27iFJVwHouyTaSprCD0Br
+nsU+04K77o=
=2XUu
-----END PGP SIGNATURE-----

--8bKSIdaynI1BetAx--

