Message-ID: <4CF77A07.5050709@...1114...>
Date: Thu, 02 Dec 2010 11:50:47 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBEE7137C@...1436...>
In-Reply-To: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBEE7137C@...1436...>
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/12/10 10:05, Adriaan de Jong wrote:
> Hi List, 
> 
> We've been working on OpenVPN in preparation for a security evaluation. This entailed documenting OpenVPN at a relatively high level, removing the dependencies on OpenSSL, and adding support for a simpler, easier to evaluate library (PolarSSL).
> 
> This was done in a series of patches:
> - Patch 1: Adds documentation to OpenVPN through Doxygen.
> - Patch 2: Splits out OpenSSL-specific code, defining a clean "backend" interface for both the crypto and SSL modules. Splits the SSL module into channel setup and verification sub-modules.
> - Patch 3: Adds a backend for PolarSSL.
> 
> We'd love to release these patches to the community. Unfortunately, the patches are now based on 2.1.4, and need to be rebased to a newer version. Before we spend time on updating the patches to the current revision of OpenVPN, we'd like to know whether there is an interest in these patches from the community.

Wow, I mean WOW!!  This is quite some work you've done!

The first patch is definitely interesting, how I see it.  That is
something I've been thinking we should do something about for a long time.

The second patch also sounds very good and is really a step towards the
needed modularisation which we want.

With your third patch, I presume both OpenSSL and PolarSSL are
available.  If so, the second and third patch is indeed interesting.

We are going towards the last rounds of preparing for OpenVPN 2.2.  If
all goes as we hope and plan for, we will have a RC candidate available
before Christmas with a full release of OpenVPN 2.2 very early in 2011.

The OpenVPN-2.3 beta cycle will hopefully start late February/early
March, but as that release will implement complete IPv6 support and
hopefully also a new OpenVPN GUI, I feel we shouldn't add too much more
stuff to the 2.3 release.

So, that means your patches is could be slated for inclusion in the 2.4
release.  I hope that can work out for you as well.  This would also
give some time to stabilise the code base as well.

To base your patches on 2.1.4 isn't so bad.  But you'll probably find it
better to base them on the beta2.2 git branch.  That branch is now in a
development freeze state, which means only bugfixes from the coming
2.2-beta5 release will be added.  So that should be a pretty stable
branch to work on for now.

I do however plan to clean up the git tree dramatically, and plan to
release the updated tree with the 2.2 release.  So if you're not in a
hurry, please "hold your horses" a little bit.  But there's no harm in
starting with the beta2.2 branch.  Your patches should fit well on top
of the new tree anyway.

Anyhow, thank you for your work!  Please send your patches to this
mailing list, and we'll get them reviewed.  If you have many smaller
commits, please ship them separately - as that is easier to review than
one gigantic patch.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkz3egUACgkQDC186MBRfrovvgCfXsKPKy+tu3H6oiPZIKDNcDea
6HUAnR3k8WHCo50bt5GzYRo6tRZoCgEl
=82/k
-----END PGP SIGNATURE-----

