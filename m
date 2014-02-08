Date: Sat, 8 Feb 2014 18:45:29 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140208174529.GS16637@...1296...>
References: <1391873629-14388-1-git-send-email-dt@...1411...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/dFl7e5Y0zcWrcPL"
Content-Disposition: inline
In-Reply-To: <1391873629-14388-1-git-send-email-dt@...1411...>
Subject: Re: [Openvpn-devel] [PATCH] Fix is_ipv6 in case of tap interface.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Dmitrij Tejblum <dt@...1411...>
Cc: openvpn-devel@lists.sourceforge.net

--/dFl7e5Y0zcWrcPL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 08, 2014 at 07:33:49PM +0400, Dmitrij Tejblum wrote:
> While checking a packet on a TAP interface, is_ipv_X() in proto.c
> insist that the ethertype must be OPENVPN_ETH_P_IPV4, even if
> the protocol is IPv6. So the protocol never match, and, thus,
> mssfix doesn't work for IPv6 on TAP interface. Fix that.

Yeah.  Thanks, it certainly looks like an oversight on my side when
implementing mssfix for IPv6 (I don't use TAP and our test framework
for TAP isn't doing anything yet that would be affected by mssfix).

Will test & integrate.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--/dFl7e5Y0zcWrcPL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUvZtOakuBuNlUUl1AQKltQP+IwddEfDHA3thfNTKxzoHK3D/lKvKxslp
WfEYsxFgyKZ50BIfwkUdeY+fcUFE0OHNkPZCuAeKD5iXRJ7gagtRdXhrEmoI/O9K
jAtSbAmUXUoP2ujeckGHm7kzuSSTEuBa8ZFu++GsPjhpba1fTEMHj1zNkm77IxId
3OFHOfGruSA=
=E0DO
-----END PGP SIGNATURE-----

--/dFl7e5Y0zcWrcPL--

