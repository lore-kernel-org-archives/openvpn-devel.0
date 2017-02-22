Date: Wed, 22 Feb 2017 17:54:47 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170222095447.GJ12961@...2182...>
References: <345db0ac-f6e8-8490-a80a-ffbd81972c07@...1856...>
	<20170221211205.GF93896@...1296...>
	<250998c4-9b20-dcc0-90eb-d432a911e7ba@...2080...>
	<20170222073910.GG93896@...1296...>
	<dc42f147-496f-1ea7-0fb3-a14197a697dd@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SEFvVLxbW/dEDtN8"
Content-Disposition: inline
In-Reply-To: <dc42f147-496f-1ea7-0fb3-a14197a697dd@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Fix segfault when using crypto lib
 without AES-256-CTR or SHA256
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--SEFvVLxbW/dEDtN8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, Feb 22, 2017 at 09:30:39AM +0100, Steffan Karger wrote:
> On 22-02-17 08:39, Gert Doering wrote:
> > On Wed, Feb 22, 2017 at 02:21:35AM +0100, David Sommerseth wrote:
> >>>> >From d97f526a2ddbf2abe60a64260601ebd742fc00cc Mon Sep 17 00:00:00 2=
001
> >>>> From: "Simon (simix)" <via-trac>
> >>>
> >>> Do we have a policy how to handle patches with missing author info?
> >>
> >> I see no reason at all why we should not give proper credit with full
> >> name.=20=20
> >=20
> > That was only half the question - of course I *want* to give full credi=
ts,
> > but is "not having this information available & no SoB line" a reason
> > for rejecting a patch?
> >=20
> > The patch in question is quite obvious, so this is not something to bri=
ng
> > in the lawyers - more a matter of general policy.
>=20
> Same here.
>=20
> For this specific patch:  I asked the reporter on trac for full name and
> email last night.  We can wait for a bit to see if he replies.
>=20
> In general: what do we do when we don't get a full name and email, but
> do want to apply the patch?  Wait forever?  Claim authorship (but refer
> to the trac ticket in the commit msg)?  Apply anyway?  ...?

IMHO somebody has to take ownership of every piece of code release under a =
given
license (just to avoid any future problem). So the patch should not be appl=
ied
as is.

Then ...
in theory, you can't take ownership of somebody else' work, but nothing pre=
vents
you from re-writing a "very similar" patch and sign it yourself. In particu=
lar
if the author did not show any interest in pursuing this any further.


my 2 cents.

Cheers,


--=20
Antonio Quartulli

--SEFvVLxbW/dEDtN8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYrV/nAAoJEJ6F1zG2JyOsptgQAMblnAUdN+R6uHZzagNMiCsb
6UZg80w2nwgh47DoKxPGr4BzjjevD8LsSVcLwyHjif3PUA7bFWSh6ogNnCBbWQ/n
ihQprKjXC+bF6/OpSruWv/jZOfCPwjiQ2v6z+Ig1w4UHeEfR+EA3UHZKjwaOyZ1t
iejO3LG45OF9J0FhJQvp0LDxvMzGT9nNmqkVmQfyf71iNuqwX/SbJVGWuVYr54cQ
bLvAAKsxCE7nWB1XDFFuGGpBlAC0Nyl60pW428TH2cJDKJozzBsFJKaktFC+jl8d
UrhPf4AEV26vXCNFpOaZweYBfkzyRtHf5q2514mieS48ksIdr6mjFb7j/zz+zgA1
4dFADfcHESX5YFS899NtFHcpWX05TJFYtowofhW+d88vsodCrJCn0OBD9THTt1Ll
ffGlAFz03FfB+skHTAsl/HZIbQ848XlWBaiRwVYXWIz+RnuIsQaFdHhxNtkvX6xr
xFy8VPZEDOeRj7d/+vRIB8C6JY8Zzjz+PtZ37eX9QJ4oLy2LWF4C+cA6YmljxhF4
f49RxxOinwuS+jlqJ9pVevH8CgzIFscm7szJPvu7EQZ3as9DvjyftkQ+KAjwMQEI
JiRhSe4StNt47RitePA2d/TCcdLFhlNp6/KKvHWwTPP3uuSXcR8s+eeyjXLsUn0z
U0Pae5qC+E+TIK+xT3wT
=oMzV
-----END PGP SIGNATURE-----

--SEFvVLxbW/dEDtN8--

