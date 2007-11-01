Date: Thu, 1 Nov 2007 11:44:59 +0100
From: Michele Baldessari <michele-lists@...1016...>
Message-ID: <20071101104459.GA4699@...1017...>
References: <20071101101408.GA3572@...1017...>
	<469588034.20071101133206@...1022...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <469588034.20071101133206@...1022...>
Subject: Re: [Openvpn-devel] DHCP Renew failing on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--DocE+STaALJfprDB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Alexey,

* Alexey Vdovin (admin@...1022...) wrote:
> Most probably it happens when DHCP lase is expires and client trys
> renew DHCP address.
>=20
> Check DHCP lease lifetime, try decrease it to reproduce the issue.

I've sniffed the network (although not in a problematic case) and I
sometimes I'm able to see the DHCP NACK message, but then the client
correctly asks for the new lease and receives the subsequent ACK.

I'll toy with the lease time option (the default lease time is a year
per default). I'll see if that helps.

thanks,
Michele

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHKa4rofbulCQLTD0RAjudAJ0XrIVBzwcJjABts8XiesspHZDU2QCbBQTP
u1+cNAf3p2Gffhlkbk6L8OU=
=Nhfr
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

