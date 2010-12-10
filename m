From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 10 Dec 2010 09:03:02 +0100
Message-ID: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3EFD@...1436...>
References: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3C5F@...1436...>
	<20101210062512.17827.qmail@...1287...>
	<BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E3EF3@...1436...>
	<4D01DD1C.5010506@...1114...>
In-Reply-To: <4D01DD1C.5010506@...1114...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Patch] OpenVPN PolarSSL Support Preview [7/8]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Peter Stuge <peter@...1287...>

> -----Original Message-----
> From: David Sommerseth [mailto:openvpn.list@...1114...]
> Sent: vrijdag 10 december 2010 8:56
> To: Adriaan de Jong
> Cc: Peter Stuge; openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [Patch] OpenVPN PolarSSL Support Preview
> [7/8]
>=20
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On 10/12/10 08:38, Adriaan de Jong wrote:
> > About the whitespace: it's a tad difficult to split the patches now.
> Are you sure it wouldn't be acceptable this way?
>=20
>=20
> If I'm not entirely mistaken, these patches are based against a 2.1.x
> release and not the git tree at all.  Considering that we're in the
> midst of getting the official 2.2 release out-the-door in about a month
> or so, I'd suggest that we primarily do code review now.
>=20
> Adriaan can then rebase these patches against the git tree when I get
> the beta2.2 branch stabilised as a release branch.  In this process,
> I'd
> expect Adriaan to also implement our review comments as well.  I've
> discussed this with Adriaan on IRC already, and this seemed to me that
> this is what he would prefer.
>=20
> Since this is a big round of patches, I do expect merge conflicts
> applying these patches unto the beta2.2 branch.  Which means, Adriaan
> needs to rebase his patches anyway.
>=20
> So, please high-light coding style issues so that he can fix that for
> the final round for the final inclusion into our git tree.  But lets
> first of all this be a code review round so that Adriaan got something
> to work to get the final inclusion go smoother in the end.
>=20
> Adriaan, will this work for you?  Any other comments or thoughts?
>=20
>=20
> kind regards,
>=20
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>=20
> iEYEARECAAYFAk0B3RoACgkQDC186MBRfrp/nACglVEbUxG9n0Bp3Ttz2BDWgxkL
> ywoAnj6uCCeTMKLZ5vfAknS1M7HUWqjI
> =3Dd4Sp
> -----END PGP SIGNATURE-----

That's exactly what I was hoping for. I've tried to stay within any coding =
standards that I could find within the code. I'm making a note of any comme=
nts people have, and will include them in the actual 2.2 git rebase. As soo=
n as that's done I can start making use of the other git commands.

Kind regards,

Adriaan


