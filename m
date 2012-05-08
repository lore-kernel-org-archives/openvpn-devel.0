Date: Tue, 8 May 2012 09:37:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120508073716.GM1359@...1296...>
References: <CAArKS8hPVLQSNrX4HtB+6UA+UU-63PmyN0BNmFuPdu4W0ZFEMw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yiU5WHAT7YGjDXCE"
Content-Disposition: inline
In-Reply-To: <CAArKS8hPVLQSNrX4HtB+6UA+UU-63PmyN0BNmFuPdu4W0ZFEMw@...278...>
Subject: Re: [Openvpn-devel] OpenVPN in the Hypervisor
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tom Kent <lists@...1718...>
Cc: openvpn-devel@lists.sourceforge.net

--yiU5WHAT7YGjDXCE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 07, 2012 at 09:03:17PM -0400, Tom Kent wrote:
> The idea I had, and wanted to run by, was if it would be possible to
> integrate an openvpn client into the hypervisor's virtual network card.
> This would make it so that from the moment the VM boots up, it is only
> connected to the private LAN served by the OpenVPN server. The VM would s=
ee
> just another NIC, but instead of routing the data directly to the
> Hypervisor's NIC (tap) or NATing it or whatever, it would go to an OpenVPN
> client library (that wouldn't need a tun/tap device on the hypervisor)
> which sends the data to the server over the udp connection.

If your hypervisor uses a tap interface, you can just have openvpn use
that tap interface "right away".  So don't bridge tap0 to eth0 on the
Hypervisor, but just have tap0 available for the VMs, and run OpenVPN
with "--dev tap0".

This might be somewhat more expensive performance-wise - but it will
be much cheaper programmer-time-wise, as all you need is already there
and well-tested :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--yiU5WHAT7YGjDXCE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT6jNLKkuBuNlUUl1AQIUcwP/dj37XqEkVpCHEXH5woLEanx63va54skF
ydtlpB5sNUZUikPN9H+5MvoV4tndaMj2s+O3PLgCRiNkyiiaWH3iQ2VHayKPBF5O
rXT43/B5mKWGplwcrW/z26xznI7dV+5AgcvwWstYCiY0dOpkZjpr4oHoTVWxbyZI
ocBjStaMvzI=
=2OHQ
-----END PGP SIGNATURE-----

--yiU5WHAT7YGjDXCE--

