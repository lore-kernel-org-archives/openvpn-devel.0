Date: Thu, 3 Mar 2011 09:20:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20110303082015.GR9835@...1296...>
References: <4D4208C9.6000206@...1449...>
	<201101280951.40901.dave_br@...1278...>
	<AANLkTimxnodRxe_mdeFxw=-eB9uQ8EebxLq6=cJNvYWM@...278...>
	<201101281209.29673.dave_br@...1278...>
	<4D46FEAB.3010804@...1449...>
	<4D4702C9.6000801@...1114...>
	<4D6EBFAE.1000304@...1449...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uMPAU7A2Er6+wvsD"
Content-Disposition: inline
In-Reply-To: <4D6EBFAE.1000304@...1449...>
Subject: Re: [Openvpn-devel] [Openvpn-users] udp6 source-address wrong with
	more than one ipv6-address on server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Stefan Hellermann <stefan@...1449...>
Cc: openvpn-devel@lists.sourceforge.net

--uMPAU7A2Er6+wvsD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 02, 2011 at 11:07:42PM +0100, Stefan Hellermann wrote:
> Am 31.01.2011 19:43, schrieb David Sommerseth:
> >>
> >> https://community.openvpn.net/openvpn/ticket/84
> >=20
> > Thank you very much for your report!  I've sent a notification to the
> > developer of the IPv6 transport patch, and I hope he chimes in soon.
>=20
> I've tested the proposed patch and it works! Could this patch get into
> the 2.2 Release?

There's neither IPv6 transport nor IPv6 payload in 2.2 - so this patch
would go into 2.3, not 2.2

But thanks for testing and for noting the results in the ticket, so David
can now merge this into "however the git will look like for 2.3" :-)#

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--uMPAU7A2Er6+wvsD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTW9PPqkuBuNlUUl1AQI2YgQAiSqiOdEpSnSHm+grJyK9N+na6mQnoG3n
LaAUt67YjFclsqHlOCo4o36OArPXO4xzlM/er7kWKZ3vpaw6//YYGO0nNE28PcjS
GeKXmi6tHTL6OPtEdrjTXR8QLpBVZNUs/nxZ1kdVsWy9Pe+iUyHNqYl66N65MpiV
E9qQGyQNWGY=
=GWnQ
-----END PGP SIGNATURE-----

--uMPAU7A2Er6+wvsD--

