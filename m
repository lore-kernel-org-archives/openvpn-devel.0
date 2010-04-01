Message-ID: <4BB4D8B0.1050101@...1338...>
Date: Thu, 01 Apr 2010 19:32:32 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <cover.1270060247.git.fabian.knittel@...1338...>	<4BB3D6A3.7020207@...1114...>	<4BB45A07.5060300@...1338...>	<4BB45E4B.1000106@...1114...>
	<4BB48A89.3090608@...1338...>
	<4BB48DD2.9070200@...384...>
In-Reply-To: <4BB48DD2.9070200@...384...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFB078BEC630D065A26AE1D71"
Subject: Re: [Openvpn-devel] [RFC][PATCH 0/9] VLAN tagging on TAP devices
 in	OpenVPN server mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFB078BEC630D065A26AE1D71
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

David Sommerseth schrieb:
> If you have a public git tree available, I could pull that as well.  (I
> tried the git URL the webUI gave me yesterday, without luck).

Ah, thanks for noticing ... the non-ssh path apparently doesn't get used
often. I forgot to fix the URLs since switching to gitosis. I've now
verified that

  git://fsmi-dev.fsmi.uni-karlsruhe.de/openvpn.git

definitely works. Anyway, I'll mail again when there's something new to
pull.

Cheers
Fabian


--------------enigFB078BEC630D065A26AE1D71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAku02LYACgkQARH1aMTipzMfaACfaEUjgOd9TRsT21rB/3W4nB5E
hoUAnAmP3tkC8ZX994+4lN1B3QxSPGea
=rh3v
-----END PGP SIGNATURE-----

--------------enigFB078BEC630D065A26AE1D71--

