Date: Thu, 24 Nov 2016 15:50:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161124145044.GO28918@...1296...>
References: <1479958527-29491-1-git-send-email-selva.nair@...277...>
	<201611241100.uAOB0o0r069804@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e7adlFz35CZD+pd2"
Content-Disposition: inline
In-Reply-To: <201611241100.uAOB0o0r069804@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Set IPv6 DNS servers using
 interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--e7adlFz35CZD+pd2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 24, 2016 at 12:00:50PM +0100, Gert Doering wrote:
> ACK.  Code looks reasonable, and it passes compilation.
>=20
> I have not been able to actually TEST it due to scheduling conflicts
> today, but I'm taking that risk, based on "it looks good, it affects
> windows only, and unless the code is activated by *pushing* a DNS6
> option, it will not affect existing setups at all".

Tested!

It was a bit more work than expected as my test machine was in an... uh...
"slightly messy" state, with a gui that crashed when trying to talk to the
service pipe, and stuff... but tested both "netsh.exe direct" and "via
service", and both produced the expected output in "ipconfig /all".

Yay :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--e7adlFz35CZD+pd2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWDb+RKkuBuNlUUl1AQI4hwP9Fj318Kqmpam/GvqI9/YLB74sGwmsovdj
zh6mP5nUmLGk5AaAlltfYMFrf0x13l7xt5UbMS+e5l499/2bljPzBR+lZM3HZJHF
fwtXTgaqkXdyawdid8pQg/hdgmtz7WijgbJdQI5S1S7PbP1zpuxMo5CyGXhJcJCU
U2/tHz3+4ic=
=D1Mc
-----END PGP SIGNATURE-----

--e7adlFz35CZD+pd2--

