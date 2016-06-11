References: <1442309019-7586-9-git-send-email-arne@...1227...>
	<1444919912-4432-1-git-send-email-arne@...1227...>
	<20160611121010.GR62247@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <0d1ed9a2-71f4-f791-3633-9937b3764de1@...1227...>
Date: Sat, 11 Jun 2016 16:29:27 +0200
MIME-Version: 1.0
In-Reply-To: <20160611121010.GR62247@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="0THfS7snABWF685tw20HvLLWWHPRE81o7"
Subject: Re: [Openvpn-devel] [PATCH V2] Remove http-proxy-timeout,
 socks timeout and set default of server-poll-timeout to 120s
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0THfS7snABWF685tw20HvLLWWHPRE81o7
Content-Type: multipart/mixed; boundary="H0xMMhoKsXwfnAp0MPwqVwEA2ooXEruW2"
From: Arne Schwabe <arne@...1227...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <0d1ed9a2-71f4-f791-3633-9937b3764de1@...1227...>
Subject: Re: [Openvpn-devel] [PATCH V2] Remove http-proxy-timeout, socks
	timeout and set default of server-poll-timeout to 120s
References: <1442309019-7586-9-git-send-email-arne@...1227...>
	<1444919912-4432-1-git-send-email-arne@...1227...>
	<20160611121010.GR62247@...1296...>
In-Reply-To: <20160611121010.GR62247@...1296...>

--H0xMMhoKsXwfnAp0MPwqVwEA2ooXEruW2
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 11.06.16 um 14:10 schrieb Gert Doering:
> This check "c2.tls_multi" - is this a short form for "we're not a=20
> peer-to-peer session"?=20=20
>=20
> Other parts of the code seem to check "we have --pull or we have=20
> --mode server", so I wonder if we should make this somewhat more
> uninform.  Eventually... :-)

Actually tls session server session. Aka everything but server in p2mp
mode.

>=20
>=20
> Besides these, the patch looks reasonable - and I assume it has been very
> very thoroughly tested in those last 8 months, no?=20

Yeah, it is in the ics-openvpn code base for ages.

I will send a v3 shortly.

Arne


--H0xMMhoKsXwfnAp0MPwqVwEA2ooXEruW2--

--0THfS7snABWF685tw20HvLLWWHPRE81o7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAldcIFEACgkQe8+cMNS4zRdl9gCgyz5Y2Kjdz2VAyQwq6E7Gbmhj
CiQAmQFDuPCTkLJZzhe/w7lquMHqry26
=ov8N
-----END PGP SIGNATURE-----

--0THfS7snABWF685tw20HvLLWWHPRE81o7--

