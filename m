References: <57016640.1060208@...277...>
	<CAEsd45QUmZu35zushUaRF+OgnqQo7925Uc9e3X7dBFLBr-XDNg@...278...>
From: Mike Auty <mike.auty@...277...>
Message-ID: <57018DBA.4080302@...277...>
Date: Sun, 3 Apr 2016 22:40:10 +0100
MIME-Version: 1.0
In-Reply-To: <CAEsd45QUmZu35zushUaRF+OgnqQo7925Uc9e3X7dBFLBr-XDNg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="iR7mrISdxonMVu1tX3l5CFm6B87hhmTBs"
Subject: Re: [Openvpn-devel] [PATCH 3/7] vlan: Add global,
 per-client 802.1q-based options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iR7mrISdxonMVu1tX3l5CFm6B87hhmTBs
Content-Type: multipart/mixed; boundary="owhMn9E9jSA18o9SB891pnV15nA06as2D"
From: Mike Auty <mike.auty@...277...>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <57018DBA.4080302@...277...>
Subject: Re: [Openvpn-devel] [PATCH 3/7] vlan: Add global, per-client
	802.1q-based options
References: <57016640.1060208@...277...>
	<CAEsd45QUmZu35zushUaRF+OgnqQo7925Uc9e3X7dBFLBr-XDNg@...278...>
In-Reply-To: <CAEsd45QUmZu35zushUaRF+OgnqQo7925Uc9e3X7dBFLBr-XDNg@...278...>

--owhMn9E9jSA18o9SB891pnV15nA06as2D
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 03/04/16 22:10, Jonathan K. Bullard wrote:
>=20
> NAK. This should include testing for extra parameters supplied in
> error with the options, as the rest of the option-handling code does.
> Something like the following (for each of the three new options):
>=20
> +  else if (streq (p[0], "vlan-tagging") && !p[1])
>=20

Thanks for reviewing the patches!  5:)

That should be reasonable to add in, I'll try and do that in the next
couple of days (and try and change round my git repo so that I can keep
the patch versions in separate branches).

Could you let me know if I should be resending all the patches for the
next version, or just the ones that have changed?

Mike  5:)


--owhMn9E9jSA18o9SB891pnV15nA06as2D--

--iR7mrISdxonMVu1tX3l5CFm6B87hhmTBs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1

iKYEARECAGYFAlcBjb9fFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3Bl
bnBncC5maWZ0aGhvcnNlbWFuLm5ldEZGQjEyM0ZDRDBCRjcwREE1MzA0MjNBREJC
QkFENkEyNkMyMDE1N0EACgkQu7rWomwgFXpaJwCfUQxWzuFMzNL8SyiFdXmNRyWh
YigAn14IOaHiRehrL/Zjh8bBF6ccAeHM
=x4wu
-----END PGP SIGNATURE-----

--iR7mrISdxonMVu1tX3l5CFm6B87hhmTBs--

