From: Adriaan de Jong <dejong@...1435...>
Date: Thu, 2 Dec 2010 12:40:02 +0100
Message-ID: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBEE713E7@...1436...>
References: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBEE7137C@...1436...>
	<4CF77A07.5050709@...1114...>
In-Reply-To: <4CF77A07.5050709@...1114...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Documentation and alternative SSL backend
 patches
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Great to hear positive reactions. I'll wait with the rebase to 2.2 until I =
get a signal from you.=20

To answer your question: patch 3 only adds a backend for PolarSSL, adding a=
 configure option to select the SSL library to use.

I'm still working on a few extra features, such as PolarSSL PKCS #11 suppor=
t, and the patches need a little more polish, so I'll hold off posting unti=
l I'm done with that (should take about two weeks or so).

Adriaan

> -----Original Message-----
> From: David Sommerseth [mailto:openvpn.list@...1114...]
> Sent: donderdag 2 december 2010 11:51
> To: Adriaan de Jong
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] Documentation and alternative SSL backend
> patches
>=20
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On 02/12/10 10:05, Adriaan de Jong wrote:
> > Hi List,
> >
> > We've been working on OpenVPN in preparation for a security
> evaluation. This entailed documenting OpenVPN at a relatively high
> level, removing the dependencies on OpenSSL, and adding support for a
> simpler, easier to evaluate library (PolarSSL).
> >
> > This was done in a series of patches:
> > - Patch 1: Adds documentation to OpenVPN through Doxygen.
> > - Patch 2: Splits out OpenSSL-specific code, defining a clean
> "backend" interface for both the crypto and SSL modules. Splits the SSL
> module into channel setup and verification sub-modules.
> > - Patch 3: Adds a backend for PolarSSL.
> >
> > We'd love to release these patches to the community. Unfortunately,
> the patches are now based on 2.1.4, and need to be rebased to a newer
> version. Before we spend time on updating the patches to the current
> revision of OpenVPN, we'd like to know whether there is an interest in
> these patches from the community.
>=20
> Wow, I mean WOW!!  This is quite some work you've done!
>=20
> The first patch is definitely interesting, how I see it.  That is
> something I've been thinking we should do something about for a long
> time.
>=20
> The second patch also sounds very good and is really a step towards the
> needed modularisation which we want.
>=20
> With your third patch, I presume both OpenSSL and PolarSSL are
> available.  If so, the second and third patch is indeed interesting.
>=20
> We are going towards the last rounds of preparing for OpenVPN 2.2.  If
> all goes as we hope and plan for, we will have a RC candidate available
> before Christmas with a full release of OpenVPN 2.2 very early in 2011.
>=20
> The OpenVPN-2.3 beta cycle will hopefully start late February/early
> March, but as that release will implement complete IPv6 support and
> hopefully also a new OpenVPN GUI, I feel we shouldn't add too much more
> stuff to the 2.3 release.
>=20
> So, that means your patches is could be slated for inclusion in the 2.4
> release.  I hope that can work out for you as well.  This would also
> give some time to stabilise the code base as well.
>=20
> To base your patches on 2.1.4 isn't so bad.  But you'll probably find
> it
> better to base them on the beta2.2 git branch.  That branch is now in a
> development freeze state, which means only bugfixes from the coming
> 2.2-beta5 release will be added.  So that should be a pretty stable
> branch to work on for now.
>=20
> I do however plan to clean up the git tree dramatically, and plan to
> release the updated tree with the 2.2 release.  So if you're not in a
> hurry, please "hold your horses" a little bit.  But there's no harm in
> starting with the beta2.2 branch.  Your patches should fit well on top
> of the new tree anyway.
>=20
> Anyhow, thank you for your work!  Please send your patches to this
> mailing list, and we'll get them reviewed.  If you have many smaller
> commits, please ship them separately - as that is easier to review than
> one gigantic patch.
>=20
>=20
> kind regards,
>=20
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>=20
> iEYEARECAAYFAkz3egUACgkQDC186MBRfrovvgCfXsKPKy+tu3H6oiPZIKDNcDea
> 6HUAnR3k8WHCo50bt5GzYRo6tRZoCgEl
> =3D82/k
> -----END PGP SIGNATURE-----

