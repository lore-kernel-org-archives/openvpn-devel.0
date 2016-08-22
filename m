Date: Mon, 22 Aug 2016 21:18:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160822191828.GT78279@...1296...>
References: <1451908945-12244-1-git-send-email-lstipakov@...277...>
	<1451911424-12970-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zd5GkkQQtETumrwc"
Content-Disposition: inline
In-Reply-To: <1451911424-12970-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Drop recursively routed packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--zd5GkkQQtETumrwc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 04, 2016 at 02:43:44PM +0200, Lev Stipakov wrote:
> v2: better method naming
>=20
> On certain OSes (Windows, OS X) when network adapter is
> disabled (ethernet cable pulled off, Wi-Fi hardware switch disabled),
> operating system starts to use tun as an external interface.
> Outgoing packets are routed to tun, UDP encapsulated, given to
> routing table and sent to.. tun.
>=20
> As a consequence, system starts talking to itself on full power,
> traffic counters skyrocket and user is not happy.
>=20
> To prevent that, drop packets which have gateway IP as
> destination address.
>=20
> Tested on Win7/10, OS X.
>=20
> Trac #642
>=20
> Signed-off-by: Lev Stipakov <lstipakov@...277...>

ACK.

Thanks for coding this, thanks to Valdikss for testing (David, can
you include the tested-by: in the commit?).

Code still looks good, as in "does what is advertised, and safely does so".


Per discussion with David, we're not totally happy with the performance
implications - but that's not your fault, our is_ipv4() and is_ipv6()
functions are really doing their job in a very non-optimized way (read:
all the work is done twice, once to find out whether it's v4, then=20
again to find out whether it's v6).

I volunteer to refactor the two places where is_ipv*() are called today
(thinking along the lines of "ip_version =3D get_ip_version(...)" and then
compare ip_version to "4" or "6" - plus, making this an inline function)

For now, we stick to "fixes the issue in a easy to read and non-intrusive
way", so it can go into 2.3.12.

thanks again :)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--zd5GkkQQtETumrwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV7tP8qkuBuNlUUl1AQIP2AQAupkCHyUlKN+JjoNcQF5CV7Or/VnkWNaJ
OOukiXWdSvsemH++TzCUtXIcTMBgQhCO9PTqamipPwCMjhaAWenz52O8Z4jOWw9s
KQU745Ib9CK+cyvjXCVjqkkkPdi6A3Byn/GZvAe5rHXRtbqEihduPpw50rRe84fj
1EUc/7OD6Ag=
=McV+
-----END PGP SIGNATURE-----

--zd5GkkQQtETumrwc--

